type t = {
  mutable config: Config.t,
  logging: Dimensions.WinstonLogger.t,
  mutable cleanupFsWatcher: unit => unit,
}

let replacePacket = (
  rawPacket: Dimensions.RawPacket.t,
  result: TerrariaPacket.ISerializer.toBufferResult,
) =>
  switch result {
  | Ok(buffer) =>
    rawPacket.data = buffer
    Ok(Dimensions.Extension.AllowPacket)
  | NotImplemented => Error(TerrariaPacket.IParser.ParseError.NotImplemented)
  | Error(err) =>
    Error(TerrariaPacket.IParser.ParseError.ReaderError({context: err.context, error: err.error}))
  }

let finish = (result, logging) =>
  switch result {
  | Ok(action) => action
  | Error(err) =>
    logging->Dimensions.WinstonLogger.error(TerrariaPacket.IParser.ParseError.toDisplayString(err))
    Dimensions.Extension.BlockPacket
  }
