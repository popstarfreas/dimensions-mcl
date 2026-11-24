let rememberProjectile = (client: Dimensions.Client.t, key) =>
  ProjectileKeyTracker.forServer(client.server)->ProjectileKeyTracker.rememberClientKey(key)

let convertFor1456 = (client: Dimensions.Client.t, rawPacket: Dimensions.RawPacket.t) => {
  open TerrariaPacket
  let? Ok(result) = ParserConverterV1456.convertFromLatestIfNeeded(
    ~buffer=rawPacket.data,
    ~fromServer=false,
  )
  switch result {
  | PacketStructureIsSame => Ok(Dimensions.Extension.AllowPacket)
  | DiscardAsNotExists => Ok(BlockPacket)
  | ConvertedFromLatest(packet) =>
    let? Ok(action) = CompatibilityLayer.replacePacket(
      rawPacket,
      PacketV1456.toBuffer(packet, false),
    )
    switch packet {
    | NpcStrike(_) =>
      switch Packet.DamageNPCAck.toBuffer() {
      | Ok(buffer) => client->Dimensions.Client.sendDirect(buffer)
      | Error(err) => client.logging->Dimensions.WinstonLogger.error(err.context)
      }
    | _ => ()
    }
    Ok(action)
  }
}

let convertFor1458 = (rawPacket: Dimensions.RawPacket.t) => {
  open TerrariaPacket
  let? Ok(result) = ParserConverterV1458.convertFromLatestIfNeeded(
    ~buffer=rawPacket.data,
    ~fromServer=false,
  )
  switch result {
  | PacketStructureIsSame => Ok(Dimensions.Extension.AllowPacket)
  | DiscardAsNotExists => Ok(BlockPacket)
  | ConvertedFromLatest(packet) =>
    CompatibilityLayer.replacePacket(rawPacket, PacketV1458.toBuffer(packet, false))
  }
}

let handlePacket = (oldVersion, client: Dimensions.Client.t, rawPacket: Dimensions.RawPacket.t) => {
  open TerrariaPacket
  let forward = () =>
    oldVersion == 319 ? convertFor1456(client, rawPacket) : convertFor1458(rawPacket)
  switch PacketType.fromInt(rawPacket.packetType) {
  | Some(ConnectRequest) =>
    switch Packet.ConnectRequest.toBuffer({version: "Terraria" ++ Int.toString(oldVersion)}) {
    | Ok(buffer) => {
        rawPacket.data = buffer
        Ok(Dimensions.Extension.AllowPacket)
      }
    | Error(err) => Error(IParser.ParseError.ReaderError({context: err.context, error: err.error}))
    }
  | Some(ProjectileSync) =>
    let? Ok(packet) = Parser.parse(~buffer=rawPacket.data, ~fromServer=false)
    switch packet {
    // TrapBomb was added in 329. ProjectileID.Count is 1136 in 326.
    | ProjectileSync({projectileType}) if projectileType >= 1136 => Ok(BlockPacket)
    | ProjectileSync({projectileKey}) if oldVersion == 319 =>
      let? Ok(action) = forward()
      if action == AllowPacket {
        rememberProjectile(client, projectileKey)
      }
      Ok(action)
    | _ => forward()
    }
  | Some(ProjectileDestroy) if oldVersion == 319 =>
    let? Ok(packet) = Parser.parse(~buffer=rawPacket.data, ~fromServer=false)
    let? Ok(action) = forward()
    switch packet {
    | ProjectileDestroy({projectileKey}) if action == AllowPacket =>
      ProjectileKeyTracker.forServer(client.server)->ProjectileKeyTracker.markClientKeyDestroyed(
        projectileKey,
      )
    | _ => ()
    }
    Ok(action)
  | Some(NpcBuffAdd) if oldVersion == 319 =>
    let? Ok(packet) = Parser.parse(~buffer=rawPacket.data, ~fromServer=false)
    switch packet {
    | NpcBuffAdd({buffType}) if buffType >= 389 => Ok(BlockPacket)
    | _ => forward()
    }
  | _ => forward()
  }
}

let clientPacketHandler = Dimensions.Extension.ClientPacketHandler.make((
  layer: CompatibilityLayer.t,
  _: Dimensions.Extension.t,
  client,
  rawPacket,
) => {
  if Config.shouldConvert(layer.config, client.version, client.server.name) {
    handlePacket(layer.config.oldVersion, client, rawPacket)->CompatibilityLayer.finish(
      layer.logging,
    )
  } else {
    AllowPacket
  }
})
