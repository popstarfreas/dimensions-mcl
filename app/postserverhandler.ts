import TerrariaServerPacketHandler from "dimensions/extension/terrariaserverpackethandler";
import Packet from "dimensions/packet";
import PacketReader from "dimensions/packets/packetreader";
import PacketWriter from "dimensions/packets/packetwriter";
import PacketTypes from "dimensions/packettypes";
import TerrariaServer from "dimensions/terrariaserver";
import Translator from ".";
import ClientState from "dimensions/clientstate";
import * as zlib from "zlib";
import BufferReader from "dimensions/packets/bufferreader";
import BitsByte from "dimensions/datatypes/bitsbyte";
import PlayerDeathReason from "dimensions/datatypes/playerdeathreason";
import TileFrameImportant from "./tileframeimportant";

class PriorServerHandler extends TerrariaServerPacketHandler {
    protected _translator: Translator;

    constructor(translator: Translator) {
        super();
        this._translator = translator;
    }

    public handlePacket(server: TerrariaServer, packet: Packet) {
        if (!this._translator.clients.has(server.client)) {
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
                this.handleUpdateItemDrop(server, packet);
                break;
            case PacketTypes.UpdatePlayer:
            case PacketTypes.SpawnPlayer:
            case PacketTypes.PlayerInfo:
            case PacketTypes.PlayerActive:
            case PacketTypes.PlayerHP:
            case PacketTypes.TogglePVP:
            case PacketTypes.PlayerItemAnimation:
                this.handlePlayerPacket(server, packet);
                break;

            case PacketTypes.HealEffect:
            case PacketTypes.PlayerMana:
            case PacketTypes.ManaEffect:
            case PacketTypes.PlayerTeam:
            case PacketTypes.UpdatePlayerBuff:
            case PacketTypes.SpecialNPCEffect:
            case PacketTypes.PlayMusicItem:
            case PacketTypes.PlayerDodge:
            case PacketTypes.HealOtherPlayer:
            case PacketTypes.PlayerTeleportThroughPortal:
            case PacketTypes.UpdateMinionTarget:
            case PacketTypes.NebulaLevelUpRequest:
            case PacketTypes.MinionAttackTargetUpdate:
                packet.data = Buffer.allocUnsafe(0);
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
        if (playerId > 15) {
            packet.data = new PacketWriter()
                .setType(PacketTypes.ChatMessage)
                .packByte(255)
                .packColor({
                    R: 255,
                    G: 0,
                    B: 0
                })
                .packString("Unable to join. Too many players for mobile.")
                .data;
            server.socket.destroy();
            return true;
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
        const time = reader.readInt32();
        const dayMoon = reader.readByte();
        const moonPhase = reader.readByte();
        const maxTilesX = reader.readInt16();
        const maxTilesY = reader.readInt16();
        const spawnX = reader.readInt16();
        const spawnY = reader.readInt16();
        const worldSurface = reader.readInt16();
        const rockLayer = reader.readInt16();
        const worldId = reader.readInt32();
        const worldName = reader.readString();
        const worldUId = reader.readBytes(16);
        const worldGenVer = reader.readUInt64();
        const moonType = reader.readByte();
        const treeBg = reader.readByte();
        const corruptBg = reader.readByte();
        const jungleBg = reader.readByte();
        const snowBg = reader.readByte();
        const hallowBg = reader.readByte();
        const crimsonBg = reader.readByte();
        const desertBg = reader.readByte();
        const oceanBg = reader.readByte();
        const iceBackStyle = reader.readByte();
        const jungleBackStyle = reader.readByte();
        const hellBackStyle = reader.readByte();
        const windSpeed = reader.readSingle();
        const cloudNum = reader.readByte();
        const tree1 = reader.readInt32();
        const tree2 = reader.readInt32();
        const tree3 = reader.readInt32();
        const treeStyle1 = reader.readByte();
        const treeStyle2 = reader.readByte();
        const treeStyle3 = reader.readByte();
        const treeStyle4 = reader.readByte();
        const caveBack1 = reader.readInt32();
        const caveBack2 = reader.readInt32();
        const caveBack3 = reader.readInt32();
        const caveBackStyle1 = reader.readByte();
        const caveBackStyle2 = reader.readByte();
        const caveBackStyle3 = reader.readByte();
        const caveBackStyle4 = reader.readByte();
        const rain = reader.readSingle();
        const eventInfo = reader.readByte();
        const eventInfo2 = reader.readByte();
        const eventInfo3 = reader.readByte();
        const eventInfo4 = reader.readByte();
        const eventInfo5 = reader.readByte();
        const invasionType = reader.readSByte();
        const lobbyId = reader.readUInt64();
        const sandstormSeverity = reader.readSingle();
        packet.data = new PacketWriter()
            .setType(PacketTypes.WorldInfo)
            .packInt32(time)
            .packByte(dayMoon)
            .packByte(moonPhase)
            .packInt16(maxTilesX)
            .packInt16(maxTilesY)
            .packInt16(spawnX)
            .packInt16(spawnY)
            .packInt16(worldSurface)
            .packInt16(rockLayer)
            .packInt32(worldId)
            .packString(worldName)
            .packByte(moonType)
            .packByte(treeBg)
            .packByte(corruptBg)
            .packByte(jungleBg)
            .packByte(snowBg)
            .packByte(hallowBg)
            .packByte(crimsonBg)
            .packByte(desertBg)
            .packByte(oceanBg)
            .packByte(iceBackStyle)
            .packByte(jungleBackStyle)
            .packByte(hellBackStyle)
            .packSingle(windSpeed)
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
            .packByte(eventInfo)
            .packByte(eventInfo2)
            .packByte(eventInfo3)
            .packByte(eventInfo4)
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
                .packByte(255)
                .packByte(color.R)
                .packByte(color.G)
                .packByte(color.B)
                .packString(netText.text)
                .data;
            if (server.client.state !== ClientState.FullyConnected) {
                packet.data = Buffer.allocUnsafe(0);
            }
        } else {
            packet.data = Buffer.allocUnsafe(0);
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
                        console.log(`Correcting incompatible tile type ${tileType}`);
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
                    console.log(`Correcting incompatible wall type ${wallId}`);
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
        const reader = new PacketReader(packet.data);
        const npcId = reader.readInt16();
        const position = {
            x: reader.readSingle(),
            y: reader.readSingle(),
        };
        const velocity = {
            x: reader.readSingle(),
            y: reader.readSingle(),
        };
        const target = reader.readUInt16(); // -> byte
        const val = reader.readByte();
        const flags = new BitsByte(val);
        const ai: number[] = [];
        for (let i = 0; i < 4; i++) {
            if (flags[i + 2]) {
                ai[i] = reader.readSingle();
            }
        }
        const npcNetId = reader.readInt16();
        if (npcNetId >= 540) {
            packet.data = Buffer.allocUnsafe(0);
            return false;
        }
        let life: number | undefined = undefined;
        let lifeBytes: number | undefined = undefined;
        if (!flags[7]) {
            lifeBytes = reader.readByte();
            switch(lifeBytes) {
                case 2:
                    life = reader.readInt16();
                    break;
                case 4:
                    life = reader.readInt32();
                    break;
                default:
                    life = reader.readSByte();
                    break;
            }
        }

        let release: number | undefined = undefined;
        if (reader.head < reader.data.length) {
            release = reader.readByte();
        }

        const newPacket = new PacketWriter()
            .setType(PacketTypes.NPCUpdate)
            .packInt16(npcId)
            .packSingle(position.x)
            .packSingle(position.y)
            .packSingle(velocity.x)
            .packSingle(velocity.y)
            .packByte(target === 255 ? 16 : Math.min(15, target))
            .packByte(val);

        for (let i = 0; i < 4; i++) {
            if (typeof ai[i] !== "undefined") {
                newPacket.packSingle(ai[i]);
            }
        }
        newPacket.packInt16(npcNetId);
        if (!flags[7]) {
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

        if (typeof release !== "undefined") {
            newPacket.packByte(release);
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

        if (playerId >= 16) {
            packet.data = Buffer.allocUnsafe(0);
        } else {
            packet.data = new PacketWriter()
                .setType(PacketTypes.PlayerDamage)
                .packByte(playerId)
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

        if (playerId >= 16) {
            packet.data = Buffer.allocUnsafe(0);
        } else {
            packet.data = new PacketWriter()
                .setType(PacketTypes.KillMe)
                .packByte(playerId)
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
            .packByte(255)
            .packColor(color)
            .packString(message.text)
            .data;

        return false;
    }

    
    private handleAddPlayerBuff(server: TerrariaServer, packet: Packet): boolean {
        const reader = new PacketReader(packet.data);
        const playerId = reader.readByte();
        const buff = reader.readByte();
        const time = reader.readInt32();

        if (buff <= 190 && playerId < 16) {
            packet.data = new PacketWriter()
                .setType(PacketTypes.AddPlayerBuff)
                .packByte(playerId)
                .packByte(buff)
                .packInt16(time) // Maybe fix this cause int32 -> int16 might not work properly
                .data;
        } else {
            packet.data = Buffer.allocUnsafe(0);
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
        const projectileId = reader.readInt16();
        const position = {
            x: reader.readSingle(),
            y: reader.readSingle(),
        };
        const velocity = {
            x: reader.readSingle(),
            y: reader.readSingle(),
        };
        const knockback = reader.readSingle();
        const damage = reader.readInt16();
        const owner = reader.readByte();
        const type = reader.readInt16();

        // 650 is last supported projectile type on mobile (from wiki)
        if (type > 650) {
            packet.data = Buffer.allocUnsafe(0);
        }

        if (owner === 255) {
            packet.data.writeUInt8(16, reader.head - 3);
        } else if (owner >= 16) {
            packet.data = Buffer.allocUnsafe(0);
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

        // 3601 is last netId on mobile (prob, I didn't check the code, just the wiki)
        if (netId > 3601 || playerId >= 16) {
            packet.data = Buffer.allocUnsafe(0);
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

    private handlePlayerPacket(server: TerrariaServer, packet: Packet): boolean {
        const reader = new PacketReader(packet.data);
        const playerId = reader.readByte();
        if (playerId >= 16) {
            packet.data = Buffer.allocUnsafe(0);
        }
        return false;
    }
}

export default PriorServerHandler;