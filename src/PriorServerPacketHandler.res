let handlePacket = (
  compatibilityLayer: CompatibilityLayer.t,
  rawPacket: Dimensions.RawPacket.t,
): Dimensions.Extension.packetHandlerResult => {
  let packet = TerrariaPacket.Parser.convertFromV1449IfNeeded(
    ~buffer=rawPacket.data,
    ~fromServer=true,
  )
  switch packet {
  | Ok(PacketStructureIsSame) => AllowPacket
  | Ok(ConvertedToLatestVersion(packet)) =>
    switch TerrariaPacket.Packet.toBuffer(packet, true) {
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

let serverPacketHandler = Dimensions.Extension.TerrariaServerPacketHandler.make((
  compatibilityLayer: CompatibilityLayer.t,
  _: Dimensions.Extension.t,
  terrariaServer,
  rawPacket,
) => {
  switch compatibilityLayer.config {
  | Loaded(config) =>
    if Config.shouldConvertToFromServer(config, terrariaServer.name) {
      handlePacket(compatibilityLayer, rawPacket)
    } else {
      AllowPacket
    }
  | Loading => AllowPacket
  }
})
