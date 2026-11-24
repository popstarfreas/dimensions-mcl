module Buffer = NodeJs.Buffer
module Fs = NodeJs.Fs

type t = {
  oldVersion: int,
  oldServers: Dict.t<string>,
  allAreOldServers: bool,
  hotReloadEnabled: bool,
}

let schema = S.object(s => {
  oldVersion: s.field("oldVersion", S.int),
  oldServers: s.field("oldServers", S.dict(S.string)),
  allAreOldServers: s.field("allAreOldServers", S.bool),
  hotReloadEnabled: s.field("hotReloadEnabled", S.bool),
})

let relativeLocation = "../configuration/cl.yaml"

type readResult = result<t, S.error>

module Yaml = {
  @module("yaml") external parse: string => JSON.t = "parse"
  @module("yaml") external stringify: JSON.t => string = "stringify"
}

module PromiseExt = {
  @send external catchWith: (Promise.t<'a>, JsExn.t => 'a) => Promise.t<'a> = "catch"
}

module FsWatch = {
  type t
  type eventType
  type filename

  @module("node:fs") external watch: (
    string,
    ~listener: (eventType, filename) => unit,
    unit,
  ) => t = "watch"
  @send external close: t => unit = "close"
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

let shouldConvert = (config, clientVersion, serverName) =>
  clientVersion == "Terraria329" &&
  (config.oldVersion == 326 || config.oldVersion == 319) &&
  (config.allAreOldServers || config.oldServers->Dict.get(String.toLowerCase(serverName))->Option.isSome)

let setupHotReload = (~onConfigReload) => {
  let hotReloadTimeout = ref(None)
  let currentPromise = ref(None)
  let watcher = FsWatch.watch(
    "../configuration",
    ~listener=(_eventType, _filename) => {
      switch hotReloadTimeout.contents {
      | Some(timeout) => clearTimeout(timeout)
      | None => ()
      }
      hotReloadTimeout := Some(setTimeout(() => {
            Console.log("Config file changed, reloading CompatibilityLayer config...")
            let after = switch currentPromise.contents {
            | Some(promise) => promise
            | None => Promise.resolve()
            }
            currentPromise :=
              Some(
                after
                ->Promise.then(readFromFile)
                ->Promise.thenResolve(result => {
                  switch result {
                  | Ok(config) => {
                      Console.log("CompatibilityLayer config reloaded")
                      onConfigReload(config)
                    }
                  | Error(error) => Console.error(error)
                  }
                })
                ->PromiseExt.catchWith(error => {
                  Console.error("Failed to reload CompatibilityLayer config")
                  Console.error(error)
                }),
              )
          }, 100))
    },
    (),
  )

  // Cleanup
  () => {
    switch hotReloadTimeout.contents {
    | Some(timeout) => clearTimeout(timeout)
    | None => ()
    }
    hotReloadTimeout.contents = None
    FsWatch.close(watcher)
  }
}
