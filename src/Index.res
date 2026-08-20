let formatDecodeError = (error: S.error) => {
  `DecodeError ${error.message}.`
}

let formatException = (exn: JsExn.t) => {
  exn->JsExn.message->Option.getOr("") ++
  ": " ++
  exn->JsExn.stack->Option.getOr("(no stack available)")
}

let constructor = (_extension: Dimensions.Extension.t, logging: Dimensions.WinstonLogger.t) => {
  let compatibilityLayer = CompatibilityLayer.make(logging)
  Config.readFromFile()
  ->Promise.thenResolve(config => {
    switch config {
    | Ok(config) => {
        compatibilityLayer.config = Loaded(config)
        if config.hotReloadEnabled {
          Console.log("CompatibilityLayer: Hot reloading enabled")
          compatibilityLayer.cleanupFsWatcher = Config.setupHotReload(~onConfigReload=config => {
            compatibilityLayer.config = Loaded(config)
          })
        }
      }
    | Error(e) => {
        logging->Dimensions.WinstonLogger.error(formatDecodeError(e))
        NodeJs.Process.process->NodeJs.Process.exit()
      }
    }
  })
  ->ignore
  compatibilityLayer
}

let default: Dimensions.Extension.clsOfT<CompatibilityLayer.t> = Dimensions.Extension.make(
  ~name="Compatibility Layer 1.4.5.7 (client) -> 1.4.5.6 (server)",
  ~author="popstarfreas",
  ~version="v6.0",
  ~constructor,
  ~priorPacketHandler={
    serverHandler: PriorServerPacketHandler.serverPacketHandler,
  },
  ~postPacketHandler={
    clientHandler: PostClientPacketHandler.clientPacketHandler,
  },
)
