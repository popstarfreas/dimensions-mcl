@get external getClientVersion: Dimensions.Client.t => option<int> = "clVersion"

let handlePacket = (
  compatibilityLayer: CompatibilityLayer.t,
  rawPacket: Dimensions.RawPacket.t,
): Dimensions.Extension.packetHandlerResult => {
  let packet = TerrariaPacket.ParserConverterV1456.convertToLatestIfNeeded(
    ~buffer=rawPacket.data,
    ~fromServer=true,
  )
  switch packet {
  | Ok(PacketStructureIsSame) =>
    /* let packetType =
        TerrariaPacket.PacketType.fromInt(Obj.magic(rawPacket.packetType))
        ->Option.map(p => TerrariaPacket.PacketType.packetName(p))
        ->Option.getOr("Unknown")*/
    AllowPacket
  | Ok(DiscardAsNotExists) => BlockPacket
  | Ok(ConvertedToLatest(packet)) =>
    switch TerrariaPacket.Packet.toBuffer(packet, true) {
    | Ok(buffer) => {
        rawPacket.data = buffer
        AllowPacket
      }
    | NotImplemented => {
        compatibilityLayer.logging->Dimensions.WinstonLogger.error(
          `Failed to encode converted server-sent packet for v1.4.5.7. Packet: ${NodeJs.Buffer.toStringWithEncoding(
              rawPacket.data,
              NodeJs.StringEncoding.hex,
            )}`,
        )
        BlockPacket
      }
    | Error({context, error}) => {
        let err = `context: ${context}, error: ${JsExn.message(error)->Option.getOr("unknown")}`
        compatibilityLayer.logging->Dimensions.WinstonLogger.error(
          `Failed to encode converted server-sent packet for v1.4.5.7. Error: ${err}. Packet: ${NodeJs.Buffer.toStringWithEncoding(
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
        `Failed to convert server-sent packet from v1.4.5.6 to v1.4.5.7. Error: ${err}. Packet: ${NodeJs.Buffer.toStringWithEncoding(
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
  source,
) => {
  switch compatibilityLayer.config {
  | Loaded(config) =>
    if Config.shouldConvertToFromServer(
      config,
      terrariaServer.name,
      source,
      getClientVersion(terrariaServer.client),
    ) {
      handlePacket(compatibilityLayer, rawPacket)
    } else {
      AllowPacket
    }
  | Loading => AllowPacket
  }
})
