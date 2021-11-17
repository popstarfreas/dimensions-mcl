# Dimensions 1412 Compatibility Layer (Dimensions 1412CL)
## Current State
Considered stable but does not provide complete patching.
## How to install
The release zip contains a folder, put this folder into your dimensions ``build/extensions`` folder and either use the cli to reloadextensions or restart your dimensions server. The extension currently does not support reloading the extension while live, as it will cause currently connected pc clients to stop being considered as pc.

## How does it work?
When a player first connects, their version is checked. If it matches the pc version, the player is flagged as a pc user and will be subject to packet rewriting by this extension. The extension intercepts incoming client packets and outgoing server packets.

## How to build this extension
1. Clone repo
2. Run ``yarn install`` in the root directory of the cloned repo
3. Run ``yarn build``
4. Run ``yarn build:packed``
5. Copy packed folder to your extensions directory of dimensions and then rename the packed folder to whatever you want to call it (e.g. 1412cl)
