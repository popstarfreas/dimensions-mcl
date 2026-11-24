# Dimensions Terraria 1.4.6 compatibility layer

MCL connects Terraria 1.4.6 clients (protocol 329) to selected 1.4.5.8 backend servers (protocol 326). Dimensions uses the 1.4.6 packet format internally.

## Installation

Copy `dist/index.mjs` to `build/extensions/dimensions-cl/index.mjs` in the 1.4.6 Dimensions installation. Leave Dimensions’ `fakeVersion.enabled` set to `false`. Create `configuration/cl.yaml` with the names of the 1.4.5.8 routing servers.

```yaml
oldVersion: 326
oldServers:
  lobby: ""
allAreOldServers: false
hotReloadEnabled: true
```

Set `allAreOldServers: true` if every backend runs 1.4.5.8. Other routes use native protocol 329. The existing 1.4.5.6 bridge can be selected with `oldVersion: 319`. One configuration selects one legacy backend version.

The 326 bridge preserves NPC and projectile generations and forwards native damage acknowledgements. It uses the remaining animation time as the maximum when the backend supplies only one duration. Dropped-item width and height overrides have no equivalent in 329. MCL skips projectile-slot emotes and NPC head emotes without a matching 1.4.6 face. The new Trap Bomb projectile and protocol-329 discovery, platform, and acknowledgement packets are filtered on legacy routes.

## Building

With `dimensions-core` and `rescript-dimensions` in sibling directories, run `pnpm install`, `pnpm run build`, and `pnpm run esbuild`. The extension bundle is written to `dist/index.mjs`. Run `pnpm test` with Dimensions built to exercise the bundled extension.
