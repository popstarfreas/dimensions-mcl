type entry = {
  mutable projectileKey: TerrariaPacket.ProjectileKey.t,
  mutable active: bool,
}

type t = Dict.t<entry>

@get external getTracker: Dimensions.TerrariaServer.t => option<t> = "clProjectileKeyTracker"
@set external setTracker: (Dimensions.TerrariaServer.t, t) => unit = "clProjectileKeyTracker"

let make = () => Dict.make()

let forServer = server =>
  switch getTracker(server) {
  | Some(tracker) => tracker
  | None => {
      let tracker = make()
      setTracker(server, tracker)
      tracker
    }
  }

let legacyKey = (~spawner, ~index) => `${spawner->Int.toString}:${index->Int.toString}`

let keysEqual = (a: TerrariaPacket.ProjectileKey.t, b: TerrariaPacket.ProjectileKey.t) =>
  a.spawner == b.spawner && a.index == b.index && a.generation == b.generation

let nextGeneration = generation => {
  let generation = Int.bitwiseAnd(generation + 1, 0x3fff)
  generation == 0 ? 1 : generation
}

let normalizedGeneration = generation => {
  let generation = Int.bitwiseAnd(generation, 0x3fff)
  generation == 0 ? 1 : generation
}

let rememberClientKey = (self, projectileKey: TerrariaPacket.ProjectileKey.t) => {
  self->Dict.set(
    legacyKey(~spawner=projectileKey.spawner, ~index=projectileKey.index),
    {projectileKey, active: true},
  )
}

let keyForSync = (self, ~spawner, ~index, ~preferredGeneration) => {
  let legacyKey = legacyKey(~spawner, ~index)
  switch self->Dict.get(legacyKey) {
  | Some(entry) if entry.active => entry.projectileKey
  | previous => {
      let generation = switch previous {
      | Some(entry) => nextGeneration(entry.projectileKey.generation)
      | None => normalizedGeneration(preferredGeneration)
      }
      let projectileKey: TerrariaPacket.ProjectileKey.t = {spawner, index, generation}
      self->Dict.set(legacyKey, {projectileKey, active: true})
      projectileKey
    }
  }
}

let keyForDestroy = (self, ~spawner, ~index, ~preferredGeneration) => {
  let legacyKey = legacyKey(~spawner, ~index)
  switch self->Dict.get(legacyKey) {
  | Some(entry) => {
      entry.active = false
      entry.projectileKey
    }
  | None => {
      let projectileKey: TerrariaPacket.ProjectileKey.t = {
        spawner,
        index,
        generation: normalizedGeneration(preferredGeneration),
      }
      self->Dict.set(legacyKey, {projectileKey, active: false})
      projectileKey
    }
  }
}

let markClientKeyDestroyed = (self, projectileKey: TerrariaPacket.ProjectileKey.t) => {
  let legacyKey = legacyKey(~spawner=projectileKey.spawner, ~index=projectileKey.index)
  switch self->Dict.get(legacyKey) {
  | Some(entry) if keysEqual(entry.projectileKey, projectileKey) => entry.active = false
  | Some(_) => ()
  | None => self->Dict.set(legacyKey, {projectileKey, active: false})
  }
}
