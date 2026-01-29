type position = {
  x: float,
  y: float,
}
@get
external itemDropPositions: Dimensions.TerrariaServer.t => option<array<position>> =
  "clItemDropPositions"
@set
external setItemDropPositions: (Dimensions.TerrariaServer.t, array<position>) => unit =
  "clItemDropPositions"

let getOrInitItemDropPositions = (terrariaServer: Dimensions.TerrariaServer.t) => {
  switch itemDropPositions(terrariaServer) {
  | Some(positions) => positions
  | None => {
      let arr = []
      terrariaServer->setItemDropPositions(arr)
      arr
    }
  }
}

let handlePacket = (
  compatibilityLayer: CompatibilityLayer.t,
  rawPacket: Dimensions.RawPacket.t,
  terrariaServer: Dimensions.TerrariaServer.t,
): Dimensions.Extension.packetHandlerResult => {
  let result = TerrariaPacket.Parserv1449.parseLazy(~buffer=rawPacket.data, ~fromServer=true)
  switch result {
  // This is needed for TShock SSC to work (turns off IgnoreSSCPackets)
  | Ok(TerrariaPacket.PacketV1449.LazyPacket.PlayerInventorySlot(_)) => {
      let buf = TerrariaPacket.PacketV1449.ItemOwner.toBuffer({
        itemDropId: 400,
        owner: 255,
      })
      switch buf {
      | Ok(buf) => terrariaServer->Dimensions.TerrariaServer.sendDirect(buf)
      | Error(err) => Console.error(err)
      }
    }
  | Ok(TerrariaPacket.PacketV1449.LazyPacket.PlayerSlotSet(playerSlotSet)) =>
    switch Lazy.get(playerSlotSet) {
    | Ok(playerSlotSet) =>
      let buf = TerrariaPacket.Packet.PlayerSlotSet.toBuffer({
        playerSlotId: playerSlotSet.playerSlotId,
        serverWantsToRunCheckBytesInClientLoopThread: false,
      })
      switch buf {
      | Ok(buf) => rawPacket.data = buf
      | Error(err) => Console.error(err)
      }
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
  | Ok(TerrariaPacket.PacketV1449.LazyPacket.ItemDropInstancedUpdate(itemDropUpdate)) =>
    switch Lazy.get(itemDropUpdate) {
    | Ok(itemDropUpdate) =>
      let itemPositions = getOrInitItemDropPositions(terrariaServer)
      itemPositions[itemDropUpdate.itemDropId] = {x: itemDropUpdate.x, y: itemDropUpdate.y}
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
  | Ok(TerrariaPacket.PacketV1449.LazyPacket.ItemDropUpdate(itemDropUpdate)) =>
    switch Lazy.get(itemDropUpdate) {
    | Ok(itemDropUpdate) =>
      let itemPositions = getOrInitItemDropPositions(terrariaServer)
      itemPositions[itemDropUpdate.itemDropId] = {x: itemDropUpdate.x, y: itemDropUpdate.y}
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
  | Ok(_) => ()
  | Error(err) => Console.error(err)
  }

  let packet = TerrariaPacket.ParserConverter.convertFromV1449IfNeeded(
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
  | Ok(ConvertedToLatestVersion(packet)) =>
    let packet = switch packet {
    | ItemOwner(itemOwner) =>
      let position = getOrInitItemDropPositions(terrariaServer)[itemOwner.itemDropId]
      switch position {
      | Some(position) =>
        TerrariaPacket.Packet.ItemOwner({
          ...itemOwner,
          position: {
            x: position.x,
            y: position.y,
          },
        })
      | None => packet
      }
    | _ => packet
    }
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
  source,
) => {
  switch compatibilityLayer.config {
  | Loaded(config) =>
    if Config.shouldConvertToFromServer(config, terrariaServer.name, source) {
      handlePacket(compatibilityLayer, rawPacket, terrariaServer)
    } else {
      AllowPacket
    }
  | Loading => AllowPacket
  }
})
