# Dimensions v1.4.5.7 Compatibility Layer
## Current State
Considered stable but does not provide complete patching.

## How to install
Go to releases, download the js file (its a bundle of this extension) and copy into your dimensions folder under this directory: `./build/extensions/dimensions-cl/index.mjs`

## How does it work?
When a 1.4.5.7 client connects to a configured 1.4.5.6 server, the extension rewrites the handshake from protocol 325 to protocol 319 and converts changed packets in both directions.

Set `oldVersion` to `319` in `configuration/cl.yaml`, then select the 1.4.5.6 servers with `oldServers` or `allAreOldServers`.

## How to build this extension
**This repo is currently not fully buildable due to some missing deps**

1. Clone repo
2. Run ``pnpm install`` in the root directory of the cloned repo
3. Run ``pnpm rescript``
4. Run ``pnpm esbuild``
5. Extension File is in dist/index.mjs
