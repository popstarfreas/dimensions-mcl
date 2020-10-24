# Dimensions Mobile Compatibility Layer (Dimensions MCL)
## Current State
1.4.0.5 and 1.4.1.1 are very similar. Right now we just patch NPC and Projectile packets so that they are discarded if they contain a net Id not in the mobile vesrion.

There are no patches for tiles, so it's possible mobile clients will crash if they try to load a chunk with a 1.4.1 tile in it.

## How to install
The release zip contains a folder, put this folder into your dimensions ``build/extensions`` folder and either use the cli to reloadextensions or restart your dimensions server. The extension currently does not support reloading the extension while live, as it will cause currently connected mobile clients to stop being considered as mobile.

## How does it work?
When a player first connects, their version is checked. If it matches the mobile version, the player is flagged as a mobile user and will be subject to packet rewriting by this extension. The extension intercepts incoming client packets and outgoing server packets.

## How to build this extension
1. Clone repo
2. Run ``npm install`` in the root directory of the cloned repo
3. Run ``npm build``
4. Copy files from the build directory to a folder in your extensions directory of dimensions
