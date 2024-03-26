let handleConnectRequest = (
  compatibilityLayer: CompatibilityLayer.t,
  config: Config.t,
  client,
  connectRequest: TerrariaPacket.Packet.ConnectRequest.t,
  rawPacket: Dimensions.RawPacket.t,
) => {
  let versionNumber =
    connectRequest.version
    ->String.substringToEnd(~start=String.length("Terraria"))
    ->Int.fromString

  switch versionNumber {
  | Some(versionNumber) =>
    if versionNumber > config.oldVersion {
      rawPacket.data = TerrariaPacket.Packet.ConnectRequest.toBuffer({
        version: "Terraria" ++ Int.toString(config.oldVersion),
      })
      false
    } else {
      false
    }
  | None => {
      compatibilityLayer.logging->Dimensions.WinstonLogger.error(
        `Failed to parse version number from ConnectRequest. Contents: { version: ${connectRequest.version} }`,
      )
      false
    }
  }
}

let handlePacket = (
  compatibilityLayer: CompatibilityLayer.t,
  client: Dimensions.Client.t,
  rawPacket: Dimensions.RawPacket.t,
  config: Config.t,
) => {
  let packet = TerrariaPacket.Parser.parseLazy(~buffer=rawPacket.data, ~fromServer=false)
  switch packet {
  | Some(ConnectRequest(lazy Some(connectRequest))) =>
    handleConnectRequest(compatibilityLayer, config, client, connectRequest, rawPacket)
  | Some(ProjectileSync(lazy Some(projectileSync))) => {
      switch ProjectileType.fromInt(projectileSync.projectileType) {
      | Some(WandOfSparkingSpark) =>
        rawPacket.data
        ->NodeJs.Buffer.writeInt16LE(ProjectileType.toInt(Spark), ~offset=19)
        ->ignore
      | Some(StarCannonStar) =>
        rawPacket.data
        ->NodeJs.Buffer.writeInt16LE(ProjectileType.toInt(FallingStar), ~offset=19)
        ->ignore
      | Some(_) | None => ()
      }
      false
    }
  | Some(TileSquareSend(lazy Some(tileSquareSend))) =>
    let converted =
      TerrariaPacket.Packetv1405.TileSquareSend.fromLatest(tileSquareSend)->Option.map(
        TerrariaPacket.Packetv1405.TileSquareSend.toBuffer,
      )
    switch converted {
    | Some(converted) => {
        rawPacket.data = converted
        false
      }
    | None => true
    }
  | Some(PlayerInventorySlot(lazy Some(playerInventorySlot))) =>
    if playerInventorySlot.slot > 259 {
      if client.server.isSsc {
        let buffer = TerrariaPacket.Packet.PlayerInventorySlot.toBuffer({
          slot: 0,
          stack: 0,
          prefix: 0,
          itemId: 0,
          playerId: client.player.id,
        })
        client.socket->NodeJs.Net.Socket.write(buffer)->ignore
      }
      rawPacket.data = NodeJs.Buffer.allocUnsafe(0)
      true
    } else {
      false
    }
  | Some(LoadoutSwitch(lazy Some(loadoutSwitch))) =>
    if loadoutSwitch.loadout > 0 && client.server.isSsc {
      let buffer = TerrariaPacket.Packet.LoadoutSwitch.toBuffer({
        loadout: 0,
        playerId: client.player.id,
      })
      client.socket->NodeJs.Net.Socket.write(buffer)->ignore
      true
    } else {
      false
    }
  | Some(_)
  | None => false
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
    if config.oldServers->Dict.get(String.toLowerCase(client.server.name))->Option.isSome {
      handlePacket(compatibilityLayer, client, rawPacket, config)
    } else {
      false
    }
  | Loading => false
  }
})
