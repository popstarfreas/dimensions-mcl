// This module fixes being kicked by the server for Adding a debuff to npc abnormally
type combatCorrelation = {
  mutable selectedItemSlot: option<int>,
  inventoryItemBySlot: array<option<int>>,
  projectileTypeLastSeenAtMs: array<option<float>>,
}

type npcBuffBlockMatch = {
  matchedItemType: option<int>,
  matchedProjectileType: option<int>,
}

@get
external getCombatCorrelation: Dimensions.Client.t => option<combatCorrelation> =
  "clCombatCorrelation"
@set
external setCombatCorrelation: (Dimensions.Client.t, combatCorrelation) => unit =
  "clCombatCorrelation"

let bleedingBuffId = 30
let brokenArmorBuffId = 36
let hemorrhageBuffId = 375

let harpoonItemId = 160
let possessedHatchetItemId = 1122
let piranhaGunItemId = 1156
let paladinsHammerItemId = 1513
let bloodyMacheteItemId = 1825
let stylishScissorsItemId = 3352

let harpoonProjectileId = 23
let possessedHatchetProjectileId = 182
let mechanicalPiranhaProjectileId = 190
let paladinsHammerHostileProjectileId = 300
let paladinsHammerFriendlyProjectileId = 301
let bloodyMacheteProjectileId = 320
let stylishScissorsProjectileId = 1083

let projectileCorrelationTtlMs = 10000.

let getOrInitCombatCorrelation = (client: Dimensions.Client.t) => {
  switch getCombatCorrelation(client) {
  | Some(state) => state
  | None => {
      let state = {
        selectedItemSlot: None,
        inventoryItemBySlot: [],
        projectileTypeLastSeenAtMs: [],
      }
      setCombatCorrelation(client, state)
      state
    }
  }
}

let recordSelectedItemSlot = (state: combatCorrelation, selectedItemSlot: int) => {
  if selectedItemSlot >= 0 {
    state.selectedItemSlot = Some(selectedItemSlot)
  }
}

let recordInventoryItemType = (state: combatCorrelation, slot: int, itemType: int) => {
  if slot >= 0 {
    state.inventoryItemBySlot[slot] = Some(itemType)
  }
}

let recordProjectileType = (state: combatCorrelation, projectileType: int) => {
  if projectileType >= 0 {
    state.projectileTypeLastSeenAtMs[projectileType] = Some(Date.now())
  }
}

let getSelectedItemType = (state: combatCorrelation) => {
  switch state.selectedItemSlot {
  | Some(slot) if slot >= 0 =>
    switch state.inventoryItemBySlot[slot] {
    | Some(itemType) => itemType
    | None => None
    }
  | _ => None
  }
}

let isRecentProjectileType = (state: combatCorrelation, projectileType: int, ~nowMs: float): bool =>
  if projectileType < 0 {
    false
  } else {
    switch state.projectileTypeLastSeenAtMs[projectileType] {
    | Some(Some(tsMs)) => nowMs -. tsMs <= projectileCorrelationTtlMs
    | Some(None) | None => false
    }
  }

let getNpcBuffBlockMatch = (
  state: combatCorrelation,
  npcBuffAdd: TerrariaPacket.Packet.NpcBuffAdd.t,
): option<npcBuffBlockMatch> => {
  let selectedItemType = getSelectedItemType(state)
  let nowMs = Date.now()

  switch npcBuffAdd.buffType {
  | buffType if buffType == bleedingBuffId => {
      let matchedItemType = switch selectedItemType {
      | Some(itemType)
        if itemType == bloodyMacheteItemId ||
        itemType == harpoonItemId ||
        itemType == stylishScissorsItemId =>
        Some(itemType)
      | _ => None
      }
      let matchedProjectileType = if (
        isRecentProjectileType(state, bloodyMacheteProjectileId, ~nowMs)
      ) {
        Some(bloodyMacheteProjectileId)
      } else if isRecentProjectileType(state, harpoonProjectileId, ~nowMs) {
        Some(harpoonProjectileId)
      } else if isRecentProjectileType(state, stylishScissorsProjectileId, ~nowMs) {
        Some(stylishScissorsProjectileId)
      } else {
        None
      }
      switch (matchedItemType, matchedProjectileType) {
      | (None, None) => None
      | _ => Some({matchedItemType, matchedProjectileType})
      }
    }
  | buffType if buffType == brokenArmorBuffId => {
      let matchedItemType = switch selectedItemType {
      | Some(itemType) if itemType == paladinsHammerItemId => Some(itemType)
      | _ => None
      }
      let matchedProjectileType = if (
        isRecentProjectileType(state, paladinsHammerFriendlyProjectileId, ~nowMs)
      ) {
        Some(paladinsHammerFriendlyProjectileId)
      } else if isRecentProjectileType(state, paladinsHammerHostileProjectileId, ~nowMs) {
        Some(paladinsHammerHostileProjectileId)
      } else {
        None
      }
      switch (matchedItemType, matchedProjectileType) {
      | (None, None) => None
      | _ => Some({matchedItemType, matchedProjectileType})
      }
    }
  | buffType if buffType == hemorrhageBuffId => {
      let matchedItemType = switch selectedItemType {
      | Some(itemType) if itemType == piranhaGunItemId || itemType == possessedHatchetItemId =>
        Some(itemType)
      | _ => None
      }
      let matchedProjectileType = if (
        isRecentProjectileType(state, mechanicalPiranhaProjectileId, ~nowMs)
      ) {
        Some(mechanicalPiranhaProjectileId)
      } else if isRecentProjectileType(state, possessedHatchetProjectileId, ~nowMs) {
        Some(possessedHatchetProjectileId)
      } else {
        None
      }
      switch (matchedItemType, matchedProjectileType) {
      | (None, None) => None
      | _ => Some({matchedItemType, matchedProjectileType})
      }
    }
  | _ => None
  }
}

let showOptionInt = (value: option<int>) =>
  switch value {
  | Some(value) => value->Int.toString
  | None => "None"
  }

let inspectClientPacket = (
  rawPacket: Dimensions.RawPacket.t,
  client: Dimensions.Client.t,
): Dimensions.Extension.packetHandlerResult => {
  let state = getOrInitCombatCorrelation(client)
  let result = TerrariaPacket.Parser.parseLazy(~buffer=rawPacket.data, ~fromServer=false)

  switch result {
  | Ok(PlayerUpdate(playerUpdate)) =>
    switch Lazy.get(playerUpdate) {
    | Ok(playerUpdate) =>
      if playerUpdate.playerId == client.player.id {
        recordSelectedItemSlot(state, playerUpdate.selectedItem)
      }
      AllowPacket
    | Error(_) => AllowPacket
    }
  | Ok(PlayerInventorySlot(playerInventorySlot)) =>
    switch Lazy.get(playerInventorySlot) {
    | Ok(playerInventorySlot) =>
      if playerInventorySlot.playerId == client.player.id {
        recordInventoryItemType(state, playerInventorySlot.slot, playerInventorySlot.itemType)
      }
      AllowPacket
    | Error(_) => AllowPacket
    }
  | Ok(ProjectileSync(projectileSync)) =>
    switch Lazy.get(projectileSync) {
    | Ok(projectileSync) =>
      if projectileSync.owner == client.player.id {
        recordProjectileType(state, projectileSync.projectileType)
      }
      AllowPacket
    | Error(_) => AllowPacket
    }
  | Ok(NpcBuffAdd(npcBuffAdd)) =>
    switch Lazy.get(npcBuffAdd) {
    | Ok(npcBuffAdd) =>
      switch getNpcBuffBlockMatch(state, npcBuffAdd) {
      | Some(_) => BlockPacket
      | None => AllowPacket
      }
    | Error(_) => AllowPacket
    }
  | _ => AllowPacket
  }
}
