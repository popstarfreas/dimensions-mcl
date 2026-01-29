module Buffer = NodeJs.Buffer
module Fs = NodeJs.Fs

type t = {
  oldVersion: int,
  oldServers: Dict.t<string>,
  allAreOldServers: bool,
}

let schema = S.object(s => {
  oldVersion: s.field("oldVersion", S.int),
  oldServers: s.field("oldServers", S.dict(S.string)),
  allAreOldServers: s.field("allAreOldServers", S.bool),
})

let relativeLocation = "../configuration/cl.yaml"

type readResult = result<t, S.error>

module Yaml = {
  @module("yaml") external parse: string => JSON.t = "parse"
  @module("yaml") external stringify: JSON.t => string = "stringify"
}

let readFromFile = (): Promise.t<readResult> => {
  Fs.readFile(relativeLocation, ())->Promise.then(buffer => {
    try {
      let config = S.parseJsonOrThrow(Buffer.toString(buffer)->Yaml.parse, schema)
      Ok({
        ...config,
        oldServers: config.oldServers
        ->Dict.toArray
        ->Array.map(((k, v)) => {
          (String.toLowerCase(k), v)
        })
        ->Dict.fromArray,
      })->Promise.resolve
    } catch {
    | S.Error(error) => {
        Console.error(error)
        Promise.resolve(Error(error))
      }
    }
  })
}

let readFromFileSync = (): readResult => {
  let buffer = Fs.readFileSync(relativeLocation)
  try {
    let config = S.parseJsonOrThrow(Buffer.toString(buffer)->Yaml.parse, schema)
    Ok({
      ...config,
      oldServers: config.oldServers
      ->Dict.toArray
      ->Array.map(((k, v)) => {
        (String.toLowerCase(k), v)
      })
      ->Dict.fromArray,
    })
  } catch {
  | S.Error(error) => {
      Console.error(error)
      Error(error)
    }
  }
}

let shouldConvertToFromServer = (
  config,
  serverName,
  source: Dimensions.Extension.PacketSource.t,
) => {
  switch source {
  | TerrariaServer =>
    config.oldServers->Dict.get(String.toLowerCase(serverName))->Option.isSome ||
      config.allAreOldServers
  | Dimensions => false
  }
}

let shouldConvertToFromClient = (config, version) => {
  config.oldVersion < version
}
