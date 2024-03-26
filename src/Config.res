module Buffer = NodeJs.Buffer
module Fs = NodeJs.Fs

@spice.decode
type t = {
  oldVersion: int,
  oldServers: Js.Dict.t<string>,
}

let relativeLocation = "./configuration/cl.hjson"

type readResult = result<t, Spice.decodeError>

module Hjson = {
  @module("hjson") external parseExn: string => Js.Json.t = "parse"
}

let readFromFile = (): Js.Promise.t<readResult> => {
  Fs.readFile(relativeLocation, ())->(
    Js.Promise.then_(
      buffer => {
        t_decode(buffer->Buffer.toString->Hjson.parseExn)
        ->Result.map(config => {
          {
            ...config,
            oldServers: config.oldServers
            ->Dict.toArray
            ->Array.map(
              ((k, v)) => {
                (String.toLowerCase(k), v)
              },
            )
            ->Dict.fromArray,
          }
        })
        ->Promise.resolve
      },
      // Make sure all keys are lowercase

      _,
    )
  )
}

let readFromFileSync = (): readResult => {
  let buffer = Fs.readFileSync(relativeLocation)
  t_decode(buffer->Buffer.toString->Hjson.parseExn)
}
