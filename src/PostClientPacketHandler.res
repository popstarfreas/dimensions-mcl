@get external getClientVersion: Dimensions.Client.t => option<int> = "version"
@set external setClientVersion: (Dimensions.Client.t, int) => unit = "version"

let handleConnectRequest = (
  compatibilityLayer: CompatibilityLayer.t,
  client,
  connectRequest: TerrariaPacket.Packet.ConnectRequest.t,
) => {
  let versionNumber =
    connectRequest.version
    ->String.substring(~start=String.length("Terraria"))
    ->Int.fromString

  switch versionNumber {
  | Some(versionNumber) => setClientVersion(client, versionNumber)
  | None =>
    compatibilityLayer.logging->Dimensions.WinstonLogger.error(
      `Failed to parse version number from ConnectRequest. Contents: { version: ${connectRequest.version} }`,
    )
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
          `Failed to convert packet to latest version. Error: ${err}. Packet: ${NodeJs.Buffer.toStringWithEncoding(
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
  rawPacket: Dimensions.RawPacket.t,
): Dimensions.Extension.packetHandlerResult => {
  let result = TerrariaPacket.Parser.convertToV1449IfNeeded(
    ~buffer=rawPacket.data,
    ~fromServer=false,
  )
  switch result {
  | Ok(PacketStructureIsSame) => AllowPacket
  | Ok(ConvertedToV1449(packet)) =>
    switch TerrariaPacket.PacketV1449.toBuffer(packet, false) {
    | Ok(buffer) => {
        rawPacket.data = buffer
        AllowPacket
      }
    | NotImplemented => {
        compatibilityLayer.logging->Dimensions.WinstonLogger.error(
          `Failed to convert packet to latest version. Packet: ${NodeJs.Buffer.toStringWithEncoding(
              rawPacket.data,
              NodeJs.StringEncoding.hex,
            )}`,
        )
        BlockPacket
      }
    | Error({context, error}) => {
        let err = `context: ${context}, error: ${JsExn.message(error)->Option.getOr("unknown")}`
        compatibilityLayer.logging->Dimensions.WinstonLogger.error(
          `Failed to convert packet to latest version. Error: ${err}. Packet: ${NodeJs.Buffer.toStringWithEncoding(
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
        `Failed to convert packet to latest version. Error: ${err}. Packet: ${NodeJs.Buffer.toStringWithEncoding(
            rawPacket.data,
            NodeJs.StringEncoding.hex,
          )}`,
      )
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
      if Config.shouldConvertToFromClient(config, version) {
        handlePacket(compatibilityLayer, rawPacket)
      } else {
        AllowPacket
      }
    | None => BlockPacket
    }
  | Loading => AllowPacket
  }
})
