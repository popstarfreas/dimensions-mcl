let constructor = (_extension: Dimensions.Extension.t, logging: Dimensions.WinstonLogger.t) => {
  let config = switch Config.readFromFileSync() {
  | Ok(config) => config
  | Error(err) => JsError.throwWithMessage(err.message)
  }
  let layer: CompatibilityLayer.t = {config, logging, cleanupFsWatcher: () => ()}
  if config.hotReloadEnabled {
    layer.cleanupFsWatcher = Config.setupHotReload(~onConfigReload=config => {
      layer.config = config
    })
  }
  layer
}

let default: Dimensions.Extension.clsOfT<CompatibilityLayer.t> = Dimensions.Extension.make(
  ~name="Terraria 1.4.6 Compatibility Layer",
  ~author="popstarfreas",
  ~version="v7.0",
  ~constructor,
  ~unloadEvent=(layer, _) => layer.cleanupFsWatcher(),
  ~priorPacketHandler={serverHandler: PriorServerPacketHandler.serverPacketHandler},
  ~postPacketHandler={clientHandler: PostClientPacketHandler.clientPacketHandler},
)
