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
@get
external playerTeamsByPlayerId: Dimensions.TerrariaServer.t => option<array<int>> =
  "clPlayerTeamsByPlayerId"
@set
external setPlayerTeamsByPlayerId: (Dimensions.TerrariaServer.t, array<int>) => unit =
  "clPlayerTeamsByPlayerId"

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

let syncInventorySlotCombatCorrelationFromServer = (
  terrariaServer: Dimensions.TerrariaServer.t,
  playerId: int,
  slot: int,
  itemType: int,
) => {
  let client = terrariaServer.client
  if client.player.id == playerId {
    let state = NpcBuffFilter.getOrInitCombatCorrelation(client)
    NpcBuffFilter.recordInventoryItemType(state, slot, itemType)
  }
}

let getOrInitPlayerTeamsByPlayerId = (terrariaServer: Dimensions.TerrariaServer.t) => {
  switch playerTeamsByPlayerId(terrariaServer) {
  | Some(teams) => teams
  | None => {
      let teams = []
      terrariaServer->setPlayerTeamsByPlayerId(teams)
      teams
    }
  }
}

let recordPlayerTeamFromServer = (
  terrariaServer: Dimensions.TerrariaServer.t,
  playerId: int,
  team: int,
) => {
  if playerId >= 0 && team >= 0 {
    let teams = getOrInitPlayerTeamsByPlayerId(terrariaServer)
    teams[playerId] = team
  }
}

let applyCachedPlayerTeamToSpawn = (
  terrariaServer: Dimensions.TerrariaServer.t,
  packet: TerrariaPacket.Packet.t,
  playerSpawn: TerrariaPacket.Packet.PlayerSpawn.t,
) => {
  switch getOrInitPlayerTeamsByPlayerId(terrariaServer)[playerSpawn.playerId] {
  | Some(team) => TerrariaPacket.Packet.PlayerSpawn({...playerSpawn, team})
  | None => packet
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
  | Ok(TerrariaPacket.PacketV1449.LazyPacket.PlayerTeam(playerTeam)) =>
    switch Lazy.get(playerTeam) {
    | Ok(playerTeam) =>
      recordPlayerTeamFromServer(terrariaServer, playerTeam.playerId, playerTeam.team)
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
    switch packet {
    | PlayerInventorySlot(playerInventorySlot) =>
      syncInventorySlotCombatCorrelationFromServer(
        terrariaServer,
        playerInventorySlot.playerId,
        playerInventorySlot.slot,
        playerInventorySlot.itemType,
      )
    | PlayerTeamUpdate(playerTeamUpdate) =>
      recordPlayerTeamFromServer(terrariaServer, playerTeamUpdate.playerId, playerTeamUpdate.team)
    | _ => ()
    }
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
    | PlayerSpawn(playerSpawn) => applyCachedPlayerTeamToSpawn(terrariaServer, packet, playerSpawn)
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
