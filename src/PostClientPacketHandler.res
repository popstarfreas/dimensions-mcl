@get external getClientVersion: Dimensions.Client.t => option<int> = "clVersion"
@set external setClientVersion: (Dimensions.Client.t, int) => unit = "clVersion"

let serverProtocolVersion = 319
let serverProtocolName = `Terraria${serverProtocolVersion->Int.toString}`
// Terraria 1.4.5.6 BuffID.Count. Its NPC.AddBuff indexes buffImmune before any range check.
let serverBuffTypeCount = 389

let blockUnsupportedNpcBuff = (rawPacket: Dimensions.RawPacket.t) => {
  let result = TerrariaPacket.Parser.parseLazy(~buffer=rawPacket.data, ~fromServer=false)
  switch result {
  | Ok(NpcBuffAdd(npcBuffAdd)) =>
    switch Lazy.get(npcBuffAdd) {
    | Ok(npcBuffAdd) if npcBuffAdd.buffType >= serverBuffTypeCount =>
      Dimensions.Extension.BlockPacket
    | Ok(_) | Error(_) => Dimensions.Extension.AllowPacket
    }
  | _ => Dimensions.Extension.AllowPacket
  }
}

let sendNpcDamageAck = (
  compatibilityLayer: CompatibilityLayer.t,
  client: Dimensions.Client.t,
) => {
  switch TerrariaPacket.Packet.DamageNPCAck.toBuffer() {
  | Ok(buffer) => client->Dimensions.Client.sendDirect(buffer)
  | Error({context, error}) => {
      let err = `context: ${context}, error: ${JsExn.message(error)->Option.getOr("unknown")}`
      compatibilityLayer.logging->Dimensions.WinstonLogger.error(
        `Failed to encode NPC damage acknowledgement for v1.4.5.7. Error: ${err}`,
      )
    }
  }
}

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

let handlePacket = (
  compatibilityLayer: CompatibilityLayer.t,
  client: Dimensions.Client.t,
  rawPacket: Dimensions.RawPacket.t,
): Dimensions.Extension.packetHandlerResult => {
  try {
    {
      let result = TerrariaPacket.Parser.parseLazy(~buffer=rawPacket.data, ~fromServer=false)
      switch result {
      | Ok(ConnectRequest(connectRequest)) =>
        switch Lazy.get(connectRequest) {
        | Ok({version: _}) =>
          Console.log2("Patching client protocol version to", serverProtocolVersion)
          let buf = TerrariaPacket.Packet.ConnectRequest.toBuffer({
            version: serverProtocolName,
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

    switch blockUnsupportedNpcBuff(rawPacket) {
    | BlockPacket => BlockPacket
    | AllowPacket =>
      let result = TerrariaPacket.ParserConverterV1456.convertFromLatestIfNeeded(
        ~buffer=rawPacket.data,
        ~fromServer=false,
      )
      switch result {
      | Ok(PacketStructureIsSame) => Dimensions.Extension.AllowPacket
      | Ok(DiscardAsNotExists) => BlockPacket
      | Ok(ConvertedFromLatest(packet)) =>
        switch TerrariaPacket.PacketV1456.toBuffer(packet, false) {
        | Ok(buffer) => {
            rawPacket.data = buffer
            switch packet {
            | NpcStrike(_) => sendNpcDamageAck(compatibilityLayer, client)
            | _ => ()
            }
            AllowPacket
          }
        | NotImplemented => {
            compatibilityLayer.logging->Dimensions.WinstonLogger.error(
              `Failed to encode converted client-sent packet for v1.4.5.6. Packet: ${NodeJs.Buffer.toStringWithEncoding(
                  rawPacket.data,
                  NodeJs.StringEncoding.hex,
                )}`,
            )
            BlockPacket
          }
        | Error({context, error}) => {
            let err = `context: ${context}, error: ${JsExn.message(error)->Option.getOr("unknown")}`
            compatibilityLayer.logging->Dimensions.WinstonLogger.error(
              `Failed to encode converted client-sent packet for v1.4.5.6. Error: ${err}. Packet: ${NodeJs.Buffer.toStringWithEncoding(
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
            `Failed to convert client-sent packet from v1.4.5.7 to v1.4.5.6. Error: ${err}. Packet: ${NodeJs.Buffer.toStringWithEncoding(
                rawPacket.data,
                NodeJs.StringEncoding.hex,
              )}`,
          )
          BlockPacket
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
        handlePacket(compatibilityLayer, client, rawPacket)
      } else {
        AllowPacket
      }
    | None => handlePacket(compatibilityLayer, client, rawPacket)
    }
  | Loading => AllowPacket
  }
})
