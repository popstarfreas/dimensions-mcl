type configState =
  | Loading
  | Loaded(Config.t)

type t = {mutable config: configState, logging: Dimensions.WinstonLogger.t}

let make = (logging: Dimensions.WinstonLogger.t): t => {
  config: Loading,
  logging,
}
