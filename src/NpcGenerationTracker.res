type slotState = {
  mutable generation: int,
  mutable active: bool,
}

type t = array<slotState>

let make = () => Array.fromInitializer(~length=256, _ => {generation: 0, active: false})

let nextGeneration = generation => {
  let generation = Int.bitwiseAnd(generation + 1, 0xff)
  generation == 0 ? 1 : generation
}

let generationForUpdate = (self, ~slotId, ~active, ~forceNew) => {
  switch self->Array.get(slotId) {
  | Some(slot) => {
      if active && (forceNew || !slot.active) {
        slot.generation = nextGeneration(slot.generation)
      }
      slot.active = active
      slot.generation
    }
  | None => 0
  }
}

let generationForSlot = (self, slotId) =>
  self->Array.get(slotId)->Option.mapOr(0, slot => slot.generation)
