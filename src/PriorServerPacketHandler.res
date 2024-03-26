let handlePacket = (
  compatibilityLayer: CompatibilityLayer.t,
  terrariaServer: Dimensions.TerrariaServer.t,
  rawPacket: Dimensions.RawPacket.t,
  config: Config.t,
) => {
  let packet = TerrariaPacket.Parserv1405.parseAsLatestLazy(
    ~buffer=rawPacket.data,
    ~fromServer=true,
  )
  switch packet {
  | Some(WorldInfo(lazy Some(worldInfo))) =>
    rawPacket.data = TerrariaPacket.Packet.WorldInfo.toBuffer(worldInfo)

    // If server is SSC then we should switch to loadout 0 and clear any loadout items
    // because the server won't support them
    if (
      worldInfo.eventInfo.serverSidedCharacters &&
      terrariaServer.client.state == Dimensions.ClientState.FinalisingSwitch
    ) {
      // These packets must be sent after world info
      let _: NodeJs.Timers.Immediate.t = NodeJs.Timers.setImmediate(() => {
        let loadoutSwitch = TerrariaPacket.Packet.LoadoutSwitch.toBuffer({
          playerId: terrariaServer.client.player.id,
          loadout: 0,
        })
        terrariaServer.client.socket->NodeJs.Net.Socket.write(loadoutSwitch)->ignore
        for i in 260 to 349 {
          let inventorySlot = TerrariaPacket.Packet.PlayerInventorySlot.toBuffer({
            playerId: terrariaServer.client.player.id,
            slot: i,
            stack: 0,
            prefix: 0,
            itemId: 0,
          })
          terrariaServer.client.socket->NodeJs.Net.Socket.write(inventorySlot)->ignore
        }
      })
      false
    } else {
      false
    }
  | Some(TileSquareSend(lazy Some(tileSquareSend))) =>
    rawPacket.data = TerrariaPacket.Packet.TileSquareSend.toBuffer(tileSquareSend)
    false
  | Some(TileSectionSend(_)) => {
      let {setType, packBuffer, data} = module(PacketFactory.ManagedPacketWriter)
      let {readBuffer} = module(PacketFactory.PacketReader)
      let reader = PacketFactory.PacketReader.make(rawPacket.data)
      let payload = reader->readBuffer(rawPacket.data->NodeJs.Buffer.length - 3)
      let correctedPayload = payload->NodeJs.Buffer.sliceToEnd(~start=1)
      rawPacket.data =
        PacketFactory.ManagedPacketWriter.make()
        ->setType(rawPacket.packetType)
        ->packBuffer(correctedPayload)
        ->data
      false
    }
  | Some(PlayerInfo(lazy Some(playerInfo))) => {
      rawPacket.data = TerrariaPacket.Packet.PlayerInfo.toBuffer(playerInfo)
      false
    }
  | Some(PlayerSpawn(lazy Some(playerSpawn))) => {
      rawPacket.data = TerrariaPacket.Packet.PlayerSpawn.toBuffer(playerSpawn)
      false
    }
  | Some(PlayerBuffsSet(lazy Some(playerBuffsSet))) => {
      rawPacket.data = TerrariaPacket.Packet.PlayerBuffsSet.toBuffer(playerBuffsSet)
      false
    }
  | Some(NpcBuffUpdate(lazy Some(npcBuffUpdate))) => {
      rawPacket.data = TerrariaPacket.Packet.NpcBuffUpdate.toBuffer(npcBuffUpdate)
      false
    }
  | Some(PlayerLuckFactorsUpdate(lazy Some(playerLuckFactorsUpdate))) => {
      rawPacket.data = TerrariaPacket.Packet.PlayerLuckFactorsUpdate.toBuffer(
        playerLuckFactorsUpdate,
      )
      false
    }
  | Some(MoonLordCountdown(lazy Some(moonLordCountdown))) => {
      rawPacket.data = TerrariaPacket.Packet.MoonLordCountdown.toBuffer(moonLordCountdown)
      false
    }
  | Some(_)
  | None => false
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
    let serverName = String.toLowerCase(terrariaServer.name)
    if config.oldServers->Dict.get(serverName)->Option.isSome {
      handlePacket(compatibilityLayer, terrariaServer, rawPacket, config)
    } else {
      false
    }
  | Loading => false
  }
})
