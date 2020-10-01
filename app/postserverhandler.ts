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
            case PacketTypes.Disconnect:
                this.handleDisconnect(server, packet);
                break;
            case PacketTypes.ContinueConnecting:
                this.handleContinueConnecting(server, packet);
                break;
            case PacketTypes.WorldInfo:
                this.handleWorldInfo(server, packet);
                break;
            case PacketTypes.Status:
                this.handleStatus(server, packet);
                break;
            case PacketTypes.LoadNetModule:
                this.handleLoadNetModule(server, packet);
                break;
            case PacketTypes.SendSection:
                this.handleSendSection(server, packet);
                break;
            case PacketTypes.SendTileSquare:
                this.handleSendTileSquare(server, packet);
                break;
            case PacketTypes.NPCUpdate:
                this.handleNpcUpdate(server, packet);
                break;
            case PacketTypes.PlayerHurtV2:
                this.handlePlayerHurt(server, packet);
                break;
            case PacketTypes.PlayerDeathV2:
                this.handlePlayerDeath(server, packet);
                break;
            case PacketTypes.SmartChatMessage:
                this.handleSmartChatMessage(server, packet);
                break;
            case PacketTypes.AddPlayerBuff:
                this.handleAddPlayerBuff(server, packet);
                break;
            case 119:
                this.handleCreateCombatTextString(server, packet);
                break;
            case PacketTypes.ProjectileUpdate:
                this.handleProjectileUpdate(server, packet);
                break;
            case PacketTypes.PlayerInventorySlot:
                this.handlePlayerInventorySlot(server, packet);
                break;
            case PacketTypes.UpdateItemDrop:
            case PacketTypes.UpdateItemDrop_Instanced:
                handled = this.handleUpdateItemDrop(server, packet);
                break;
            case PacketTypes.UpdateItemOwner:
                this.handleUpdateItemOwner(server, packet);
                break;
            case PacketTypes.CompleteConnectionAndSpawn:
                handled = this.handleCompleteConnectionAndSpawn(server, packet);
                break;
            case PacketTypes.SpawnPlayer:
                handled = this.handleSpawnPlayer(server, packet);
                break;
            case PacketTypes.UpdatePlayer:
                handled = this.handleUpdatePlayer(server, packet);
                break;
            case PacketTypes.PlayerInfo:
                handled = this.handlePlayerInfo(server, packet);
                break;
            case PacketTypes.PlayerActive:
            case PacketTypes.PlayerHP:
            case PacketTypes.TogglePVP:
            case PacketTypes.PlayerItemAnimation:
                handled = this.handlePlayerPacket(server, packet);
                break;

            case PacketTypes.UpdatePlayerBuff:
                handled = this.handleUpdatePlayerBuff(server, packet);
                break;
            case PacketTypes.HealEffect:
            case PacketTypes.PlayerMana:
            case PacketTypes.ManaEffect:
            case PacketTypes.PlayerTeam:
            case PacketTypes.SpecialNPCEffect:
            case PacketTypes.PlayMusicItem:
            case PacketTypes.PlayerDodge:
            case PacketTypes.HealOtherPlayer:
            case PacketTypes.PlayerTeleportThroughPortal:
            case PacketTypes.UpdateMinionTarget:
            case PacketTypes.NebulaLevelUpRequest:
            case PacketTypes.MinionAttackTargetUpdate:
                packet.data = Buffer.allocUnsafe(0);
                handled = true;
                break;
            case PacketTypes.AddNPCBuff:
                handled = this.handleAddNpcBuff(server, packet);
                break;
        }
        return handled;
    }

    private handleDisconnect(server: TerrariaServer, packet: Packet): boolean {
        const reader = new PacketReader(packet.data);
        const netText = reader.readNetworkText();
        packet.data = new PacketWriter()
            .setType(PacketTypes.Disconnect)
            .packString(netText.text)
            .data;
        return false;
    }

    private handleContinueConnecting(server: TerrariaServer, packet: Packet): boolean {
        const reader = new PacketReader(packet.data);
        const playerId = reader.readByte();
        if (playerId > MAX_CLIENT_ID) {
            this._mcl.realId.set(server.client, playerId);
            packet.data.writeUInt8(FAKED_CLIENT_ID, 3); // Overwrite player id byte
        }

        const packetData = new PacketWriter()
            .setType(PacketTypes.DimensionsUpdate)
            .packInt16(4)
            .packString("Terraria155")
            .data;

        server.socket.write(packetData);

        return false;
    }

    private handleWorldInfo(server: TerrariaServer, packet: Packet): boolean {
        const reader = new PacketReader(packet.data);
        const time = reader.readInt32(); // Time
        const dayAndMoon = reader.readByte(); // Day&MoonInfo
        const moonPhase = reader.readByte(); // Moon Phase
        const maxTiles: Point = {
            x: reader.readInt16(),
            y: reader.readInt16(),
        };
        const spawn: Point = {
            x: reader.readInt16(),
            y: reader.readInt16()
        };
        const worldSurface = reader.readInt16(); // WorldSurface
        const rockLayer = reader.readInt16(); // RockLayer
        const worldId = reader.readInt32(); // WorldID
        const worldName = reader.readString(); // World Name
        const gamemode = reader.readByte(); // Gamemode
        const worldUid = reader.readBytes(16); // World Unique ID
        const worldGenVersion = reader.readUInt64(); // World Generator Version
        const moonType = reader.readByte(); // Moon Type
        const treeBackgroud1 = reader.readByte(); // Tree Background
        const treeBackgroud2 = reader.readByte(); // Tree Background 2
        const treeBackgroud3 = reader.readByte(); // Tree Background 3
        const treeBackgroud4 = reader.readByte(); // Tree Background 4
        const corruptionBackground = reader.readByte(); // Corruption Background
        const jungleBackground = reader.readByte(); // Jungle Background
        const snowBackground = reader.readByte(); // Snow Background
        const hallowBackground = reader.readByte(); // Hallow Background
        const crimsonBackground = reader.readByte(); // Crimson Background
        const desertBackground = reader.readByte(); // Desert Background
        const oceanBackground = reader.readByte(); // Ocean Background
        const mushroomBackground = reader.readByte(); // Mushroom Background
        const underworldBackground = reader.readByte(); // Underworld Background
        const iceBackStyle = reader.readByte(); // Ice Back Style
        const jungleBackStyle = reader.readByte(); // Jungle Back Style
        const hellBackStyle = reader.readByte(); // Hell Back Style
        const windSpeedSet = reader.readSingle(); // Wind Speed Set
        const cloudNum = reader.readByte(); // Cloud Number
        const tree1 = reader.readInt32(); // Tree 1
        const tree2 = reader.readInt32(); // Tree 2
        const tree3 = reader.readInt32(); // Tree 3
        const treeStyle1 = reader.readByte(); // Tree Style 1
        const treeStyle2 = reader.readByte(); // Tree Style 2
        const treeStyle3 = reader.readByte(); // Tree Style 3
        const treeStyle4 = reader.readByte(); // Tree Style 4
        const caveBack1 = reader.readInt32(); // Cave Back 1
        const caveBack2 = reader.readInt32(); // Cave Back 2
        const caveBack3 = reader.readInt32(); // Cave Back 3
        const caveBackStyle1 = reader.readByte(); // Cave Back Style 1
        const caveBackStyle2 = reader.readByte(); // Cave Back Style 2
        const caveBackStyle3 = reader.readByte(); // Cave Back Style 3
        const caveBackStyle4 = reader.readByte(); // Cave Back Style 4
        const treeTopVariation1 = reader.readByte(); // Tree Tops Variation 1
        const treeTopVariation2 = reader.readByte(); // Tree Tops Variation 2
        const treeTopVariation3 = reader.readByte(); // Tree Tops Variation 3
        const treeTopVariation4 = reader.readByte(); // Tree Tops Variation 4
        const treeTopVariation5 = reader.readByte(); // Tree Tops Variation 5
        const treeTopVariation6 = reader.readByte(); // Tree Tops Variation 6
        const treeTopVariation7 = reader.readByte(); // Tree Tops Variation 7
        const treeTopVariation8 = reader.readByte(); // Tree Tops Variation 8
        const treeTopVariation9 = reader.readByte(); // Tree Tops Variation 9
        const treeTopVariation10 = reader.readByte(); // Tree Tops Variation 10
        const treeTopVariation11 = reader.readByte(); // Tree Tops Variation 11
        const treeTopVariation12 = reader.readByte(); // Tree Tops Variation 12
        const treeTopVariation13 = reader.readByte(); // Tree Tops Variation 13
        const rain = reader.readSingle(); // Rain
        const eventInfo = new BitsByte(reader.readByte());
        const eventInfo2 = new BitsByte(reader.readByte());
        const eventInfo3 = new BitsByte(reader.readByte());
        const eventInfo4 = new BitsByte(reader.readByte());
        const eventInfo5 = new BitsByte(reader.readByte());
        const eventInfo6 = new BitsByte(reader.readByte());
        const eventInfo7 = new BitsByte(reader.readByte());
        const copperOreTier = reader.readInt16();
        const ironOreTier = reader.readInt16();
        const silverOreTier = reader.readInt16();
        const goldOreTier = reader.readInt16();
        const cobaltOreTier = reader.readInt16();
        const mythrilOreTier = reader.readInt16();
        const adamantiteOreTier = reader.readInt16();
        const invasionType = reader.readByte();
        const lobbyId = reader.readUInt64();
        const sandstormSeverity = reader.readSingle();
        packet.data = new PacketWriter()
            .setType(PacketTypes.WorldInfo)
            .packInt32(time)
            .packByte(dayAndMoon)
            .packByte(moonPhase)
            .packInt16(maxTiles.x)
            .packInt16(maxTiles.y)
            .packInt16(spawn.x)
            .packInt16(spawn.y)
            .packInt16(worldSurface)
            .packInt16(rockLayer)
            .packInt32(worldId)
            .packString(worldName)
            .packByte(moonType)
            .packByte(treeBackgroud1)
            .packByte(corruptionBackground)
            .packByte(jungleBackground)
            .packByte(snowBackground)
            .packByte(hallowBackground)
            .packByte(crimsonBackground)
            .packByte(desertBackground)
            .packByte(oceanBackground)
            .packByte(iceBackStyle)
            .packByte(jungleBackStyle)
            .packByte(hellBackStyle)
            .packSingle(windSpeedSet)
            .packByte(cloudNum)
            .packInt32(tree1)
            .packInt32(tree2)
            .packInt32(tree3)
            .packByte(treeStyle1)
            .packByte(treeStyle2)
            .packByte(treeStyle3)
            .packByte(treeStyle4)
            .packInt32(caveBack1)
            .packInt32(caveBack2)
            .packInt32(caveBack3)
            .packByte(caveBackStyle1)
            .packByte(caveBackStyle2)
            .packByte(caveBackStyle3)
            .packByte(caveBackStyle4)
            .packSingle(rain)
            .packByte(eventInfo.value)
            .packByte(eventInfo2.value)
            .packByte(eventInfo3.value)
            .packByte(eventInfo4.value)
            .packByte(invasionType)
            .packUInt64(lobbyId)
            .data;
        return false;
    }

    private handleStatus(server: TerrariaServer, packet: Packet): boolean {
        const reader = new PacketReader(packet.data);
        const statusMax = reader.readInt32();
        const netText = reader.readNetworkText();
        packet.data = new PacketWriter()
            .setType(PacketTypes.Status)
            .packInt32(statusMax)
            .packString(netText.text)
            .data;
        return false;
    }

    private handleLoadNetModule(server: TerrariaServer, packet: Packet): boolean {
        const reader = new PacketReader(packet.data);
        const moduleId = reader.readUInt16();
        if (moduleId === 1) {
            reader.readByte();
            const netText = reader.readNetworkText();
            const color = reader.readColor();
            packet.data = new PacketWriter()
                .setType(PacketTypes.ChatMessage)
                .packByte(PC_SERVER_ID)
                .packByte(color.R)
                .packByte(color.G)
                .packByte(color.B)
                .packString(netText.text)
                .data;
            if (server.client.state !== ClientState.FullyConnected) {
                packet.data = Buffer.allocUnsafe(0);
            }
        } else if (moduleId > 1) {
            packet.data = Buffer.allocUnsafe(0);
            return true;
        }

        return false;
    }

    private fixSendSection(data: Buffer) {
        var packetReader = new PacketReader(data);
        const compressed = packetReader.readByte() !== 0;
        const tileData = zlib.inflateRawSync(packetReader.readBuffer(data.length - 4));
        const reader = new BufferReader(tileData);
        const tileX = reader.readInt32();
        const tileY = reader.readInt32();
        const width = reader.readInt16();
        const height = reader.readInt16();

        let copies = 0;
        for (let i = 0; i < height; i++) {
            for (let j = 0; j < width; j++) {
                if (copies > 0) {
                    copies = copies - 1;
                    continue;
                }

                let extraFlags = 0;
                const tileFlags = reader.readByte();
                if (tileFlags & 1) {
                    const someFlags = reader.readByte();
                    if (someFlags & 1) {
                        extraFlags = reader.readByte();
                    }
                }

                if (tileFlags & 2) {
                    // tile.active(true)
                    let tileType: undefined | number = undefined;
                    if (tileFlags & 32) {
                        let part = reader.readByte();
                        tileType = (reader.readByte() << 8) | part;
                    } else {
                        tileType = reader.readByte();
                    }

                    if (tileType > 418) {
                        let newType = 1;
                        if (TileFrameImportant[tileType]) {
                            newType = 72; // Needed so client reads tileframeimportant bytes
                        }

                        if (tileFlags & 32) {
                            reader.data.writeUInt8(newType, reader.head - 2);
                            reader.data.writeUInt8(0, reader.head - 1);
                        } else {
                            reader.data.writeUInt8(newType, reader.head - 1);
                        }
                    }

                    if (TileFrameImportant[tileType]) {
                        reader.readInt16();
                        reader.readInt16();
                    }

                    if (extraFlags & 8) {
                        reader.readByte(); // color
                    }
                }

                if (tileFlags & 4) {
                    const wallId = reader.readByte(); // wall id
                    if (wallId > 224) {
                        reader.data.writeUInt8(1, reader.head - 1);
                    }

                    if (extraFlags & 16) {
                        reader.readByte(); // wall color
                    }
                }

                let num6 = ((tileFlags & 24) >> 3) & 255;
                if (num6 !== 0) {
                reader.readByte(); // tile liquid
                }

                switch ((tileFlags & 192) >> 6) {
                case 0:
                    copies = 0;
                    continue;
                case 1:
                    copies = reader.readByte();
                    continue;
                default:
                    copies = reader.readInt16();
                    continue;
                }
            }
        }

        return new PacketWriter()
            .setType(PacketTypes.SendSection)
            .packByte(1)
            .packBuffer(zlib.deflateRawSync(reader.data))
            .data
    }


    private handleSendSection(server: TerrariaServer, packet: Packet): boolean {
        packet.data = this.fixSendSection(packet.data);
        return false;
    }


    private handleSendTileSquare(server: TerrariaServer, packet: Packet): boolean {
        const reader = new PacketReader(packet.data);
        const num21 = reader.readUInt16();
        const num22 = (num21 & 32767);
        const num23 = (num21 & 32768) > 0 ? 1 : 0;

        // No compatible way to change it
        if (num23) {
            packet.data = Buffer.allocUnsafe(0);
        } else {
            packet.data = Buffer.allocUnsafe(0);
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
        if (npcNetId > 539) { // 539 is the last supported mobile npc id
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

        const newPacket = new PacketWriter()
            .setType(PacketTypes.NPCUpdate)
            .packInt16(npcSlotId)
            .packSingle(position.x)
            .packSingle(position.y)
            .packSingle(velocity.x)
            .packSingle(velocity.y)
            .packByte(target === PC_SERVER_ID ? MOBILE_SERVER_ID : Math.min(MAX_CLIENT_ID, target))
            .packByte(npcFlags1.value);

        for (let i = 0; i < 4; i++) {
            const aiVal = ai[i];
            if (aiVal !== null) {
                newPacket.packSingle(aiVal);
            }
        }
        newPacket.packInt16(npcNetId);
        if (life !== null) {
            newPacket.packByte(lifeBytes as number);
            switch (lifeBytes) {
                case 2:
                    newPacket.packInt16(life as number);
                    break;
                case 4:
                    newPacket.packInt32(life as number);
                    break;
                default:
                    newPacket.packSByte(life as number);
                    break;
            }
        }

        if (releaseOwner !== null) {
            newPacket.packByte(releaseOwner);
        }

        packet.data = newPacket.data;
        return false;
    }


    private handlePlayerHurt(server: TerrariaServer, packet: Packet): boolean {
        const reader = new PacketReader(packet.data);
        const playerId = reader.readByte();
        const deathReason = new PlayerDeathReason(reader);
        const damage = reader.readInt16();
        const hitDirection = reader.readByte();
        const flags = reader.readByte();
        const cooldownCounter = reader.readSByte();

        const realId = this._mcl.realId.get(server.client);
        if (playerIdNotMobileCompatible(playerId, realId)) {
            packet.data = Buffer.allocUnsafe(0);
        } else {
            packet.data = new PacketWriter()
                .setType(PacketTypes.PlayerDamage)
                .packByte(getPlayerId(playerId))
                .packByte(hitDirection)
                .packInt16(damage)
                .packString(deathReason.deathReason)
                .packByte(flags)
                .data;
        }

        return false;
    }


    private handlePlayerDeath(server: TerrariaServer, packet: Packet): boolean {
        const reader = new PacketReader(packet.data);
        const playerId = reader.readByte();
        const deathReason = new PlayerDeathReason(reader);
        const damage = reader.readInt16();
        const hitDirection = reader.readByte();
        const flags = reader.readByte();

        const realId = this._mcl.realId.get(server.client);
        if (playerIdNotMobileCompatible(playerId, realId)) {
            packet.data = Buffer.allocUnsafe(0);
        } else {
            packet.data = new PacketWriter()
                .setType(PacketTypes.KillMe)
                .packByte(getPlayerId(playerId))
                .packByte(hitDirection)
                .packInt16(damage)
                .packByte(flags)
                .packString(deathReason.deathReason)
                .data;
        }

        return false;
    }


    private handleSmartChatMessage(server: TerrariaServer, packet: Packet): boolean {
        const reader = new PacketReader(packet.data);
        const color = reader.readColor();
        const message = reader.readNetworkText();

        packet.data = new PacketWriter()
            .setType(PacketTypes.ChatMessage)
            .packByte(PC_SERVER_ID)
            .packColor(color)
            .packString(message.text)
            .data;

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
                .packByte(buff)
                .packInt16(Math.ceil(time / 60)) // Maybe fix this cause int32 -> int16 might not work properly
                .data;
        }

        return false;
    }


    private handleCreateCombatTextString(server: TerrariaServer, packet: Packet): boolean {
        const reader = new PacketReader(packet.data);
        const x = reader.readSingle();
        const y = reader.readSingle();
        const color = reader.readColor();
        const combatText = reader.readNetworkText();

        packet.data = new PacketWriter()
            .setType(PacketTypes.CreateCombatText)
            .packSingle(x)
            .packSingle(y)
            .packColor(color)
            .packString(combatText.text)
            .data;

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
        if (netId > 3601 || playerIdNotMobileCompatible(playerId, realId)) {
            packet.data = Buffer.allocUnsafe(0);
        } else if (shouldFakeId(playerId, realId)) {
            packet.data.writeUInt8(FAKED_CLIENT_ID, PACKET_HEADER_BYTES);
        }

        return false;
    }

    private handleUpdateItemDrop(server: TerrariaServer, packet: Packet): boolean {
        const reader = new PacketReader(packet.data);
        const itemId = reader.readInt16();
        const position = {
            x: reader.readSingle(),
            y: reader.readSingle(),
        };
        const velocity = {
            x: reader.readSingle(),
            y: reader.readSingle(),
        };
        const stack = reader.readInt16();
        const prefix = reader.readByte();
        const noDelay = reader.readByte();
        const netId = reader.readInt16();
        if (netId > 3601) {
            packet.data = Buffer.allocUnsafe(0);
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
        // Patch TShock SSC so that args.Player.IgnoreSSCPackets is false,
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
