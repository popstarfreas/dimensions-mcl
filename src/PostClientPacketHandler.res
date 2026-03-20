@get external getClientVersion: Dimensions.Client.t => option<int> = "clVersion"
@set external setClientVersion: (Dimensions.Client.t, int) => unit = "clVersion"
@set external setClientDimVersion: (Dimensions.Client.t, string) => unit = "version"

let handleConnectRequest = (
  compatibilityLayer: CompatibilityLayer.t,
  client,
  connectRequest: TerrariaPacket.Packet.ConnectRequest.t,
) => {
  if getClientVersion(client)->Option.isNone {
    let versionNumber =
      connectRequest.version
      ->String.substring(~start=String.length("Terraria"))
      ->Int.fromString

    switch versionNumber {
    | Some(versionNumber) => {
        setClientVersion(client, versionNumber)
        Console.log2("Version number", versionNumber)
      }
    | None =>
      compatibilityLayer.logging->Dimensions.WinstonLogger.error(
        `Failed to parse version number from client-sent ConnectRequest. Contents: { version: ${connectRequest.version} }`,
      )
    }
  }
}

let tryHandleVersion = (
  compatibilityLayer: CompatibilityLayer.t,
  client: Dimensions.Client.t,
  rawPacket: Dimensions.RawPacket.t,
) => {
  let packet = TerrariaPacket.Parser.parseLazy(~buffer=rawPacket.data, ~fromServer=false)
  switch packet {
  | Ok(TerrariaPacket.Packet.LazyPacket.ConnectRequest(connectRequest)) =>
    switch Lazy.get(connectRequest) {
    | Ok(connectRequest) => handleConnectRequest(compatibilityLayer, client, connectRequest)
    | Error({context, error}) => {
        let err = `context: ${context}, error: ${JsExn.message(error)->Option.getOr("unknown")}`
        compatibilityLayer.logging->Dimensions.WinstonLogger.error(
          `Failed to parse client-sent ConnectRequest packet. Error: ${err}. Packet: ${NodeJs.Buffer.toStringWithEncoding(
              rawPacket.data,
              NodeJs.StringEncoding.hex,
            )}`,
        )
      }
    }
  | _ => ()
  }
}

let unlockAllItems = (client: Dimensions.Client.t) => {
  module WinstonLogger = Dimensions.WinstonLogger
  module Client = Dimensions.Client
  module Packet = TerrariaPacket.Packet
  let localPlayerId = client.player.id
  let spoofSenderId = if localPlayerId == 255 { 254 } else { localPlayerId + 1 }

  let sendTeamUpdate = (playerId, team) => {
    let teamPacket = Packet.PlayerTeamUpdate.toBuffer({
      playerId,
      team,
    })
    switch teamPacket {
    | Ok(teamPacket) => client->Client.sendDirect(teamPacket)
    | Error({context, error}) =>
      let error = JsExn.message(error)->Option.getOr("unknown")
      client.logging->WinstonLogger.error(`Error creating team packet: ${context}: ${error}`)
    }
  }

  sendTeamUpdate(localPlayerId, 1)
  sendTeamUpdate(spoofSenderId, 1)

  for i in 1 to 6144 {
    let unlock = Packet.NetModuleLoad.toBuffer({
      CreativeUnlocksPlayerReport({
        userId: spoofSenderId,
        itemId: i,
        researchedCount: 9999,
      })
    })
    switch unlock {
    | Ok(unlock) => client->Client.sendDirect(unlock)
    | Error({context, error}) =>
      let error = JsExn.message(error)->Option.getOr("unknown")
      client.logging->WinstonLogger.error(`Error creating unlock packet: ${context}: ${error}`)
    }
  }

  sendTeamUpdate(localPlayerId, 0)
  sendTeamUpdate(spoofSenderId, 0)
  Dimensions.Client.sendChatMessage(client, "Unlocked all items")
}

type command = {
  name: string,
  arguments: array<string>,
}

let parseCommandFromClientText = (commandId, message) => {
  let message = switch commandId {
  | "Say" => message
  | command => `/${String.toLowerCase(command)} ${message}`
  }

  let isCommand = message->String.startsWith("/")
  if isCommand {
    let parts = message->String.split(" ")
    let name = parts->Array.getUnsafe(0)->String.substring(~start=1)->String.toLowerCase
    let arguments = parts->Array.slice(~start=1)
    Some({name, arguments})
  } else {
    None
  }
}

let handlePacket = (
  compatibilityLayer: CompatibilityLayer.t,
  rawPacket: Dimensions.RawPacket.t,
  client: Dimensions.Client.t,
): Dimensions.Extension.packetHandlerResult => {
  try {
    {
      let result = TerrariaPacket.Parser.parseLazy(~buffer=rawPacket.data, ~fromServer=false)
      switch result {
      | Ok(ConnectRequest(connectRequest)) =>
        switch Lazy.get(connectRequest) {
        | Ok({version: _}) =>
          Console.log("Patching version to 279")
          let buf = TerrariaPacket.Packet.ConnectRequest.toBuffer({
            version: "Terraria279",
          })
          switch buf {
          | Ok(buf) => rawPacket.data = buf
          | Error(err) => Console.error(err)
          }
        | Error({context, error}) => {
            let err = `context: ${context}, error: ${JsExn.message(error)->Option.getOr("unknown")}`
            compatibilityLayer.logging->Dimensions.WinstonLogger.error(
              `Failed to parse client-sent ConnectRequest packet. Error: ${err}. Packet: ${NodeJs.Buffer.toStringWithEncoding(
                  rawPacket.data,
                  NodeJs.StringEncoding.hex,
                )}`,
            )
          }
        }
      | _ => ()
      }
    }

    if NpcBuffFilter.inspectClientPacket(rawPacket, client) == BlockPacket {
      BlockPacket
    } else {
      let result = TerrariaPacket.ParserConverter.convertToV1449IfNeeded(
        ~buffer=rawPacket.data,
        ~fromServer=false,
      )
      let handled = switch result {
      | Ok(PacketStructureIsSame) => Dimensions.Extension.AllowPacket
      | Ok(DiscardAsNotExists) => BlockPacket
      | Ok(ConvertedToV1449(packet)) =>
        switch TerrariaPacket.PacketV1449.toBuffer(packet, false) {
        | Ok(buffer) => {
            rawPacket.data = buffer
            AllowPacket
          }
        | NotImplemented => {
            compatibilityLayer.logging->Dimensions.WinstonLogger.error(
              `Failed to encode converted client-sent packet to v1449. Packet: ${NodeJs.Buffer.toStringWithEncoding(
                  rawPacket.data,
                  NodeJs.StringEncoding.hex,
                )}`,
            )
            BlockPacket
          }
        | Error({context, error}) => {
            let err = `context: ${context}, error: ${JsExn.message(error)->Option.getOr("unknown")}`
            compatibilityLayer.logging->Dimensions.WinstonLogger.error(
              `Failed to encode converted client-sent packet to v1449. Error: ${err}. Packet: ${NodeJs.Buffer.toStringWithEncoding(
                  rawPacket.data,
                  NodeJs.StringEncoding.hex,
                )}`,
            )
            BlockPacket
          }
        }
      | Error(err) => {
          let err = TerrariaPacket.IParser.ParseError.toDisplayString(err)
          compatibilityLayer.logging->Dimensions.WinstonLogger.error(
            `Failed to convert client-sent packet to v1449. Error: ${err}. Packet: ${NodeJs.Buffer.toStringWithEncoding(
                rawPacket.data,
                NodeJs.StringEncoding.hex,
              )}`,
          )
          BlockPacket
        }
      }

      switch handled {
      | BlockPacket => BlockPacket
      | AllowPacket => {
          let result = TerrariaPacket.Parser.parseLazy(~buffer=rawPacket.data, ~fromServer=false)
          switch result {
          | Ok(NetModuleLoad(netModuleLoad)) =>
            switch Lazy.get(netModuleLoad) {
            | Ok(ClientText(commandId, message)) =>
              switch parseCommandFromClientText(commandId, message) {
              | Some({name}) =>
                if (
                  String.startsWith(name, "j") ||
                  String.startsWith(name, "un") ||
                  String.startsWith(name, "cr")
                ) {
                  let serverName = client.server.name->String.toLowerCase
                  switch serverName {
                  | "rift" | "items" | "specialitems" | "build" =>
                    unlockAllItems(client)
                    Dimensions.Extension.BlockPacket
                  | _ => Dimensions.Extension.AllowPacket
                  }
                } else {
                  Dimensions.Extension.AllowPacket
                }
              | None => AllowPacket
              }
            | Ok(_) => AllowPacket
            | Error({context, error}) => {
                let err = `context: ${context}, error: ${JsExn.message(error)->Option.getOr(
                    "unknown",
                  )}`
                compatibilityLayer.logging->Dimensions.WinstonLogger.error(
                  `Failed to parse client-sent NetModuleLoad packet. Error: ${err}. Packet: ${NodeJs.Buffer.toStringWithEncoding(
                      rawPacket.data,
                      NodeJs.StringEncoding.hex,
                    )}`,
                )
                BlockPacket
              }
            }
          | _ => AllowPacket
          }
        }
      }
    }
  } catch {
  | e => {
      Console.error(e)
      BlockPacket
    }
  }
}

let clientPacketHandler = Dimensions.Extension.ClientPacketHandler.make((
  compatibilityLayer: CompatibilityLayer.t,
  _: Dimensions.Extension.t,
  client,
  rawPacket,
) => {
  switch compatibilityLayer.config {
  | Loaded(config) =>
    tryHandleVersion(compatibilityLayer, client, rawPacket)
    switch getClientVersion(client) {
    | Some(version) =>
      if Config.shouldConvertToFromClient(config, version, client.server.name) {
        handlePacket(compatibilityLayer, rawPacket, client)
      } else {
        AllowPacket
      }
    | None => handlePacket(compatibilityLayer, rawPacket, client)
    }
  | Loading => AllowPacket
  }
})
