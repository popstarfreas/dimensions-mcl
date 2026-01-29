# Dimensions v1.4.5.x Compatibility Layer
## Current State
Considered stable but does not provide complete patching.

## How to install
Go to releases, download the js file (its a bundle of this extension) and copy and rename it to `./build/extensions/dimensions-cl/index.mjs`

## How does it work?
When a player first connects, their version is checked. If it matches v1.4.5.0 or above the extension will translate their packets to v1.4.4.9. For servers it will translate v1.4.4.9 packets to v1.4.5.x when sending to the client.

## How to build this extension
**This repo is currently not fully buildable due to some missing deps**

1. Clone repo
2. Run ``pnpm install`` in the root directory of the cloned repo
3. Run ``pnpm rescript``
4. Run ``pnpm esbuild``
5. Extension File is in dist/index.mjs
