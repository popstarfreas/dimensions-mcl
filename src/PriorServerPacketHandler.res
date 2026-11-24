@get
external getNpcGenerationTracker: Dimensions.TerrariaServer.t => option<NpcGenerationTracker.t> =
  "clNpcGenerationTracker"
@set
external setNpcGenerationTracker: (Dimensions.TerrariaServer.t, NpcGenerationTracker.t) => unit =
  "clNpcGenerationTracker"

let npcGenerationTrackerForServer = server =>
  switch getNpcGenerationTracker(server) {
  | Some(tracker) => tracker
  | None => {
      let tracker = NpcGenerationTracker.make()
      setNpcGenerationTracker(server, tracker)
      tracker
    }
  }

let npcIsActive = (npcUpdate: TerrariaPacket.Packet.NpcUpdate.t) =>
  npcUpdate.npcTypeId != 0 &&
    switch npcUpdate.life {
    | Max => true
    | Byte(life) | Int16(life) | Int32(life) => life > 0
    }

let translateNpcGeneration = (terrariaServer, packet: TerrariaPacket.Packet.t) => {
  let tracker = npcGenerationTrackerForServer(terrariaServer)
  switch packet {
  | NpcUpdate(npcUpdate) => {
      let generation =
        tracker->NpcGenerationTracker.generationForUpdate(
          ~slotId=npcUpdate.npcSlotId,
          ~active=npcIsActive(npcUpdate),
          ~forceNew=npcUpdate.spawnNeedsSyncing,
        )
      TerrariaPacket.Packet.NpcUpdate({...npcUpdate, generation})
    }
  | NpcStrike(npcStrike) =>
    TerrariaPacket.Packet.NpcStrike({
      ...npcStrike,
      generation: tracker->NpcGenerationTracker.generationForSlot(npcStrike.npcSlotId),
    })
  | packet => packet
  }
}

let translateProjectileKey = (terrariaServer, packet: TerrariaPacket.Packet.t) => {
  let tracker = ProjectileKeyTracker.forServer(terrariaServer)
  switch packet {
  | ProjectileSync(projectileSync) => {
      let convertedKey = projectileSync.projectileKey
      let projectileKey =
        tracker->ProjectileKeyTracker.keyForSync(
          ~spawner=convertedKey.spawner,
          ~index=convertedKey.index,
          ~preferredGeneration=convertedKey.generation,
        )
      TerrariaPacket.Packet.ProjectileSync({...projectileSync, projectileKey})
    }
  | ProjectileDestroy(projectileDestroy) => {
      let convertedKey = projectileDestroy.projectileKey
      let projectileKey =
        tracker->ProjectileKeyTracker.keyForDestroy(
          ~spawner=convertedKey.spawner,
          ~index=convertedKey.index,
          ~preferredGeneration=convertedKey.generation,
        )
      TerrariaPacket.Packet.ProjectileDestroy({...projectileDestroy, projectileKey})
    }
  | packet => packet
  }
}

let handlePacket = (oldVersion, server, rawPacket: Dimensions.RawPacket.t) => {
  open TerrariaPacket
  if oldVersion == 319 {
    let? Ok(result) = ParserConverterV1456.convertToLatestIfNeeded(
      ~buffer=rawPacket.data,
      ~fromServer=true,
    )
    switch result {
    | PacketStructureIsSame => Ok(Dimensions.Extension.AllowPacket)
    | DiscardAsNotExists => Ok(BlockPacket)
    | ConvertedToLatest(packet) =>
      let packet = translateProjectileKey(server, translateNpcGeneration(server, packet))
      CompatibilityLayer.replacePacket(rawPacket, Packet.toBuffer(packet, true))
    }
  } else {
    let? Ok(result) = ParserConverterV1458.convertToLatestIfNeeded(
      ~buffer=rawPacket.data,
      ~fromServer=true,
    )
    switch result {
    | PacketStructureIsSame => Ok(Dimensions.Extension.AllowPacket)
    | DiscardAsNotExists => Ok(BlockPacket)
    | ConvertedToLatest(packet) =>
      CompatibilityLayer.replacePacket(rawPacket, Packet.toBuffer(packet, true))
    }
  }
}

let serverPacketHandler = Dimensions.Extension.TerrariaServerPacketHandler.make((
  layer: CompatibilityLayer.t,
  _: Dimensions.Extension.t,
  server,
  rawPacket,
  source,
) => {
  if (
    source == TerrariaServer &&
      Config.shouldConvert(layer.config, server.client.version, server.name)
  ) {
    handlePacket(layer.config.oldVersion, server, rawPacket)->CompatibilityLayer.finish(
      layer.logging,
    )
  } else {
    AllowPacket
  }
})
