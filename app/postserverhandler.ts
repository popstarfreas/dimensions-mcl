import TerrariaServerPacketHandler from "dimensions/extension/terrariaserverpackethandler";
import Packet from "dimensions/packet";
import PacketReader from "dimensions/packets/packetreader";
import PacketWriter from "dimensions/packets/packetwriter";
import PacketTypes from "dimensions/packettypes";
import TerrariaServer from "dimensions/terrariaserver";
import MCL, { FAKED_CLIENT_ID, MAX_CLIENT_ID, PC_SERVER_ID, MOBILE_SERVER_ID, PACKET_HEADER_BYTES } from ".";
import ClientState from "dimensions/clientstate";
import * as zlib from "zlib";
import BufferReader from "dimensions/packets/bufferreader";
import BitsByte from "dimensions/datatypes/bitsbyte";
import PlayerDeathReason from "dimensions/datatypes/playerdeathreason";
import TileFrameImportant from "./tileframeimportant";
import Point from "dimensions/point";

function fromBitFlags(flags: [boolean, boolean, boolean, boolean, boolean, boolean, boolean, boolean]): number {
    return (flags[0] ? 1 : 0)
         | (flags[1] ? 2 : 0)
         | (flags[2] ? 4 : 0)
         | (flags[3] ? 8 : 0)
         | (flags[4] ? 16 : 0)
         | (flags[5] ? 32 : 0)
         | (flags[6] ? 64 : 0)
         | (flags[7] ? 128 : 0)
}

/**
 * 
 * @param playerId The player id given in the packet
 * @param realId The real id of the current client
 * @returns true if either it is the client id we're faking to the mobile client because theirs is too large on the server, or
 *          if the id is out of the mobile client range
 */
function playerIdNotMobileCompatible(playerId: number, realId: number | undefined) {
    // If id used is the fake id, we need to use it if realId exists
    if (playerId === FAKED_CLIENT_ID && typeof realId !== "undefined") {
        return true;
    }

    return playerId > MAX_CLIENT_ID && realId !== playerId && playerId !== PC_SERVER_ID;
}

/**
 * 
 * @param playerId 
 * @param realId 
 * @returns true if it is for the mobile client, but their assigned id is outside the mobile compatible range
 */
function shouldFakeId(playerId: number, realId: number | undefined) {
    return playerId === realId;
}

/**
 * 
 * @param playerId Assumed to be mobile compatible
 * @param realId 
 * @returns the mobile client's local player id
 */
function getPlayerId(playerId: number) {
    if (playerId < FAKED_CLIENT_ID) {
        return playerId;
    }

    if (playerId === PC_SERVER_ID) {
        return MOBILE_SERVER_ID;
    }

    // Assuming that playerId is compatible, this means it won't be >= FAKED_CLIENT_ID unless it is for the mobile client
    return FAKED_CLIENT_ID;
}

class PriorServerHandler extends TerrariaServerPacketHandler {
    protected _mcl: MCL;

    constructor(mcl: MCL) {
        super();
        this._mcl = mcl;
    }

    public handlePacket(server: TerrariaServer, packet: Packet) {
        if (!this._mcl.clients.has(server.client)) {
            return false;
        }
        let handled = false;
        switch (packet.packetType) {
            case PacketTypes.ContinueConnecting:
                this.handleContinueConnecting(server, packet);
                break;
            /*case PacketTypes.SendSection:
                this.handleSendSection(server, packet);
                break;*/
            /*case PacketTypes.SendTileSquare:
                this.handleSendTileSquare(server, packet);
                break;*/
            case PacketTypes.NPCUpdate:
                this.handleNpcUpdate(server, packet);
                break;
        }
        return handled;
    }

    private handleContinueConnecting(server: TerrariaServer, packet: Packet): boolean {
        const reader = new PacketReader(packet.data);
        const playerId = reader.readByte();
        if (playerId > MAX_CLIENT_ID) {
            this._mcl.realId.set(server.client, playerId);
            packet.data.writeUInt8(FAKED_CLIENT_ID, 3); // Overwrite player id byte
        }

        return false;
    }

    private handleNpcUpdate(server: TerrariaServer, packet: Packet): boolean {
        const reader: PacketReader = new PacketReader(packet.data);
        const npcSlotId: number = reader.readInt16();
        const position: Point = {
            x: reader.readSingle(),
            y: reader.readSingle()
        };
        const velocity: Point = {
            x: reader.readSingle(),
            y: reader.readSingle()
        };
        const target: number = reader.readUInt16();
        const npcFlags1 = new BitsByte(reader.readByte());
        const npcFlags2 = new BitsByte(reader.readByte());
        const ai: [
            number | null,
            number | null,
            number | null,
            number | null
        ] = [null, null, null, null];
        if (npcFlags1[2]) {
            ai[0] = reader.readSingle();
        }
        if (npcFlags1[3]) {
            ai[1] = reader.readSingle();
        }
        if (npcFlags1[4]) {
            ai[2] = reader.readSingle();
        }
        if (npcFlags1[5]) {
            ai[3] = reader.readSingle();
        }

        const npcNetId: number = reader.readInt16();
        if (npcNetId > 662) { // 662 is the last supported mobile npc id
            packet.data = Buffer.allocUnsafe(0);
            return true;
        }

        let playerCountForMultiplayerDifficultyOverride: number | null = null;
        if (npcFlags2[0]) {
            playerCountForMultiplayerDifficultyOverride = reader.readByte();
        }
        let strengthMultiplier: number | null = null;
        if (npcFlags2[2]) {
            strengthMultiplier = reader.readSingle();
        }
        let life: number | null = null;
        let lifeBytes: number | null = null;
        if (!npcFlags1[7]) {
            lifeBytes = reader.readByte();
            if (lifeBytes == 2) {
                life = reader.readInt16();
            } else if (lifeBytes == 4) {
                life = reader.readInt32();
            } else {
                life = reader.readSByte();
            }
        }

        let releaseOwner: number | null = null;
        if (reader.head < packet.data.length) {
            releaseOwner = reader.readByte();
        }

        return false;
    }

    private handleAddPlayerBuff(server: TerrariaServer, packet: Packet): boolean {
        const reader = new PacketReader(packet.data);
        const playerId = reader.readByte();
        const buff = reader.readUInt16();
        const time = reader.readInt32();

        const realId = this._mcl.realId.get(server.client);
        if (buff > 190 || playerIdNotMobileCompatible(playerId, realId)) {
            packet.data = Buffer.allocUnsafe(0);
        } else {
            packet.data = new PacketWriter()
                .setType(PacketTypes.AddPlayerBuff)
                .packByte(typeof realId === "undefined" ? playerId : FAKED_CLIENT_ID)
                .packUInt16(buff)
                .packInt32(time / 60)
                .data;
        }

        return false;
    }

    private handleProjectileUpdate(server: TerrariaServer, packet: Packet): boolean {
        const reader = new PacketReader(packet.data);
        const ident = reader.readInt16();
        const positionX = reader.readSingle();
        const positionY = reader.readSingle();
        const velocityX = reader.readSingle();
        const velocityY = reader.readSingle();
        const owner = reader.readByte();
        const projType = reader.readInt16();
        const ai = reader.readByte();
        const hasDamage = (ai & 16) === 16;
        const hasKnockback = (ai & 32) === 32;
        const needsUuid = (ai & 128) === 128;
        const hasOriginalDamage = (ai & 64) === 64;
        const hasAi0 = (ai & 1) === 1;
        const hasAi1 = (ai & 2) === 2;

        let ai0 = 0;
        if (hasAi0) {
            ai0 = reader.readSingle();
        }

        let ai1 = 0;
        if (hasAi1) {
            ai1 = reader.readSingle();
        }

        let damage = 0;
        if (hasDamage) {
            damage = reader.readInt16();
        }

        let knockback = 0;
        if (hasKnockback) {
            knockback = reader.readSingle();
        }

        let originalDamage = 0;
        if (hasOriginalDamage) {
            originalDamage = reader.readInt16();
        }

        let uuid = 0;
        if (needsUuid) {
            uuid = reader.readInt16();
        }

        let aiFixed = 0;
        aiFixed |= hasAi0 ? 1 : 0;
        aiFixed |= hasAi1 ? 2 : 0;
        aiFixed |= needsUuid ? 4 : 0;
        const writer = new PacketWriter()
            .setType(PacketTypes.ProjectileUpdate)
            .packInt16(ident)
            .packSingle(positionX)
            .packSingle(positionY)
            .packSingle(velocityX)
            .packSingle(velocityY)
            .packSingle(knockback)
            .packInt16(damage)
            .packByte(getPlayerId(owner))
            .packInt16(projType)
            .packByte(aiFixed);

        if (hasAi0) {
            writer.packSingle(ai0);
        }

        if (hasAi1) {
            writer.packSingle(ai1);
        }

        if (needsUuid) {
            writer.packSingle(uuid);
        }

        const realId = this._mcl.realId.get(server.client);
        // 650 is last supported projectile type on mobile (from wiki)
        if (projType > 650 || playerIdNotMobileCompatible(owner, realId)) {
            packet.data = Buffer.allocUnsafe(0);
            return true;
        }

        return false;
    }

    private handlePlayerInventorySlot(server: TerrariaServer, packet: Packet): boolean {
        const reader = new PacketReader(packet.data);
        const playerId = reader.readByte();
        const slotId = reader.readByte();
        const stack = reader.readInt16();
        const prefix = reader.readByte();
        const netId = reader.readInt16();

        const realId = this._mcl.realId.get(server.client);
        // 3601 is last netId on mobile (prob, I didn't check the code, just the wiki)
        if (playerIdNotMobileCompatible(playerId, realId)) {
            packet.data = Buffer.allocUnsafe(0);
        } else if (shouldFakeId(playerId, realId)) {
            packet.data.writeUInt8(FAKED_CLIENT_ID, PACKET_HEADER_BYTES);
        }

        return false;
    }

    private handleUpdateItemOwner(server: TerrariaServer, packet: Packet) {
        const reader = new PacketReader(packet.data);
        const itemId = reader.readInt16();
        const playerId = reader.readByte();
        const realId = this._mcl.realId.get(server.client);

        if (playerIdNotMobileCompatible(playerId, realId)) {
            packet.data = Buffer.allocUnsafe(0);
        } else if (shouldFakeId(playerId, realId)) {
            packet.data.writeUInt8(FAKED_CLIENT_ID, PACKET_HEADER_BYTES + 2);
        } else if (playerId === PC_SERVER_ID) {
            packet.data.writeUInt8(MOBILE_SERVER_ID, PACKET_HEADER_BYTES + 2);
        }
    }

    private handlePlayerPacket(server: TerrariaServer, packet: Packet): boolean {
        const reader = new PacketReader(packet.data);
        const playerId = reader.readByte();
        const realId = this._mcl.realId.get(server.client);
        if (playerIdNotMobileCompatible(playerId, realId)) {
            packet.data = Buffer.allocUnsafe(0);
        } else if (shouldFakeId(playerId, realId)) {
            packet.data.writeUInt8(FAKED_CLIENT_ID, PACKET_HEADER_BYTES);
        }

        return false;
    }

    private handleCompleteConnectionAndSpawn(server: TerrariaServer, packet: Packet): boolean {
        // This is a patch for TShock SSC that ensures it sets args.Player.IgnoreSSCPackets as false,
        // this allows mobile clients to send inventory changes without them getting reverted
        server.socket.write(new PacketWriter()
            .setType(PacketTypes.UpdateItemOwner)
            .packInt16(400)
            .packByte(PC_SERVER_ID)
            .data
        );

        return false;
    }

    private handleSpawnPlayer(server: TerrariaServer, packet: Packet): boolean {
        const reader = new PacketReader(packet.data);
        const playerId = reader.readByte();
        const location = {
            x: reader.readInt16(),
            y: reader.readInt16(),
        };
        const respawnTimeRemaining = reader.readInt32()
        const context = reader.readByte();
        const realId = this._mcl.realId.get(server.client);
        if (playerIdNotMobileCompatible(playerId, realId)) {
            packet.data = Buffer.allocUnsafe(0);
            return true;
        } else {
            packet.data = new PacketWriter()
                .setType(PacketTypes.SpawnPlayer)
                .packByte(getPlayerId(playerId))
                .packInt16(location.x)
                .packInt16(location.y)
                .data;

            return false;
        }
    }

    private handleUpdatePlayer(server: TerrariaServer, packet: Packet): boolean {
        const reader = new PacketReader(packet.data);
        const playerId = reader.readByte();
        const control = new BitsByte(reader.readByte());
        const pulley = new BitsByte(reader.readByte());
        const misc = new BitsByte(reader.readByte());
        const sleeping = new BitsByte(reader.readByte());
        const selectedItem = reader.readByte();
        const position = {
            x: reader.readSingle(),
            y: reader.readSingle(),
        };

        let velocity: Point | null = null;
        if (pulley[2]) {
            velocity = {
                x: reader.readSingle(),
                y: reader.readSingle(),
            };
        }

        let originalPosition: Point | null = null;
        let homePosition: Point | null = null;
        if (misc[6]) {
            originalPosition = {
                x: reader.readSingle(),
                y: reader.readSingle(),
            };
            homePosition = {
                x: reader.readSingle(),
                y: reader.readSingle(),
            };
        }

        const realId = this._mcl.realId.get(server.client);
        if (playerIdNotMobileCompatible(playerId, realId)) {
            packet.data = Buffer.allocUnsafe(0);
            return true;
        } else {
            const buffer = new PacketWriter()
                .setType(PacketTypes.UpdatePlayer)
                .packByte(getPlayerId(playerId))
                .packByte(control.value)
                .packByte(pulley.value)
                .packByte(selectedItem)
                .packSingle(position.x)
                .packSingle(position.y);

            if (velocity !== null) {
                buffer
                    .packSingle(velocity.x)
                    .packSingle(velocity.y)
            }

            packet.data = buffer.data
            return false;
        }
    }

    private handleUpdatePlayerBuff(server: TerrariaServer, packet: Packet): boolean {
        const reader = new PacketReader(packet.data);
        const playerId = reader.readByte();

        const realId = this._mcl.realId.get(server.client);
        if (playerIdNotMobileCompatible(playerId, realId)) {
            packet.data = Buffer.allocUnsafe(0);
            return true;
        } else {
            const writer = new PacketWriter()
                .setType(PacketTypes.UpdatePlayerBuff)
                .packByte(getPlayerId(playerId));
            for (let i = 0; i < 22; i++ ) {
                const buffType = reader.readUInt16();
                if (buffType <= 255) { // byte type supported by server goes up to 255
                    writer.packByte(buffType);
                } else {
                    writer.packByte(0); // default to just no buff here because server cannot store/read the buff types > 255
                }
            }

            packet.data = writer.data;
            return false;
        }
    }

    private handlePlayerInfo(server: TerrariaServer, packet: Packet): boolean {
        const reader = new PacketReader(packet.data);
        const playerId = reader.readByte(); // Player ID
        const skinVariant = reader.readByte();
        const hair = reader.readByte();
        const name = reader.readString();
        const hairDye = reader.readByte();
        const hideVisuals = reader.readByte();
        const hideVisuals2 = reader.readByte();
        const hideMisc = reader.readByte();
        const hairColor = reader.readColor();
        const skinColor = reader.readColor();
        const eyeColor = reader.readColor();
        const shirtColor = reader.readColor();
        const underShirtColor = reader.readColor();
        const pantsColor = reader.readColor();
        const shoeColor = reader.readColor();
        const difficulty = reader.readByte();
        try {
        const torchInfo = reader.readByte();
        } catch(e) { } // DG not yet updated to always have this

        const realId = this._mcl.realId.get(server.client);
        if (playerIdNotMobileCompatible(playerId, realId)) {
            packet.data = Buffer.allocUnsafe(0);
            return true;
        } else {
            packet.data = new PacketWriter()
                .setType(PacketTypes.PlayerInfo)
                .packByte(playerId)
                .packByte(skinVariant)
                .packByte(hair)
                .packString(name)
                .packByte(hairDye)
                .packByte(hideVisuals)
                .packByte(hideVisuals2)
                .packByte(hideMisc)
                .packColor(hairColor)
                .packColor(skinColor)
                .packColor(eyeColor)
                .packColor(shirtColor)
                .packColor(underShirtColor)
                .packColor(pantsColor)
                .packColor(shoeColor)
                .packByte(difficulty)
                .data;

            return false;
        }
    }

    private handleAddNpcBuff(server: TerrariaServer, packet: Packet) {
        const reader = new PacketReader(packet.data);
        const npcId = reader.readInt16();
        const buff = reader.readUInt16();
        const time = reader.readInt16();

        packet.data = new PacketWriter()
            .setType(PacketTypes.AddNPCBuff)
            .packInt16(npcId)
            .packByte(buff)
            .packInt16(time)
            .data;

        return false;
    }
}

export default PriorServerHandler;
