let formatDecodeError = (error: Spice.decodeError) => {
  `DecodeError ${error.message}. Path: ${error.path}.`
}

let formatException = (exn: Js.Exn.t) => {
  exn->Js.Exn.message->Option.getOr("") ++
  ": " ++
  exn->Js.Exn.stack->Option.getOr("(no stack available)")
}

let constructor = (_extension: Dimensions.Extension.t, logging: Dimensions.WinstonLogger.t) => {
  let compatibilityLayer = CompatibilityLayer.make(logging)
  Config.readFromFile()
  ->Promise.thenResolve(config => {
    switch config {
    | Ok(config) => compatibilityLayer.config = Loaded(config)
    | Error(e) => {
        logging->Dimensions.WinstonLogger.error(formatDecodeError(e))
        NodeJs.Process.process->NodeJs.Process.exit()
      }
    }
  })
  ->ignore
  compatibilityLayer
}

type command = {
  name: string,
  arguments: array<string>,
}

let parseCommandFromClientText = (commandId, message) => {
  let message = switch commandId {
  | "Say" => message
  | command => `/${String.toLowerCase(command)} ${message}`
  }

  let isCommand = message->String.startsWith("/")
  if isCommand {
    let parts = message->String.split(" ")
    let name = parts->Array.getUnsafe(0)->String.substringToEnd(~start=1)->String.toLowerCase
    let arguments = parts->Array.sliceToEnd(~start=1)
    Some({name, arguments})
  } else {
    None
  }
}

let default: Dimensions.Extension.clsOfT<CompatibilityLayer.t> = Dimensions.Extension.make(
  ~name="Compatibility Layer 1.4.4.9 (client) and above -> 1.4.1.1 (server) ",
  ~author="popstarfreas",
  ~version="v3.0",
  ~constructor,
  ~priorPacketHandler={
    serverHandler: PriorServerPacketHandler.serverPacketHandler,
  },
  ~postPacketHandler={
    clientHandler: PostClientPacketHandler.clientPacketHandler,
  },
)
