type configState =
  | Loading
  | Loaded(Config.t)

type t = {
  mutable config: configState,
  logging: Dimensions.WinstonLogger.t,
  mutable cleanupFsWatcher: unit => unit,
}

let make = (logging: Dimensions.WinstonLogger.t): t => {
  config: Loading,
  logging,
  cleanupFsWatcher: () => (),
}
