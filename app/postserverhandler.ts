import Client from "dimensions/client";
import TerrariaServerPacketHandler from "dimensions/extension/terrariaserverpackethandler";
import ListenServer from "dimensions/listenserver";
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
            .packInt32(time) // 23902 vs 27000
            .packByte(dayMoon) // 0 vs 1
            .packByte(moonPhase) // 0 vs 0
            .packInt16(maxTilesX) // 4200 vs 8400
            .packInt16(maxTilesY) // 1200 vs 2400
            .packInt16(spawnX) // 2096 vs 4227
            .packInt16(spawnY) // 246 vs 1275
            .packInt16(worldSurface) // 366 vs 745
            .packInt16(rockLayer) // 480 vs 1 009
            .packInt32(worldId) // 17169071 vs 1
            .packString(worldName) // World 1 vs Dark Gaming - Lite
            .packByte(moonType) // 1 vs 147
            .packByte(treeBg) // 8 vs 134
            .packByte(corruptBg) // 0 vs 228
            .packByte(jungleBg) // 0 vs 29
            .packByte(snowBg) // 32 vs 125
            .packByte(hallowBg) // 0 vs 22
            .packByte(crimsonBg) // 0 vs 0
            .packByte(desertBg) // 0 vs 0
            .packByte(oceanBg) // 2 vs 0
            .packByte(iceBackStyle) // 2 vs 0
            .packByte(jungleBackStyle) // 1 vs 0
            .packByte(hellBackStyle) // 0 vs 0
            .packSingle(windSpeed) // 0.04220030456781387 vs 0
            .packByte(cloudNum) // 113 vs 0
            .packInt32(tree1) // 2736 vs 0
            .packInt32(tree2) // 4200 vs 0
            .packInt32(tree3) // 4200 vs 0
            .packByte(treeStyle1) // 3 vs 0
            .packByte(treeStyle2) // 4 vs 0
            .packByte(treeStyle3) // 0 vs 0
            .packByte(treeStyle4) // 0 vs 0
            .packInt32(caveBack1) // 2342 vs 0
            .packInt32(caveBack2) // 4200 vs 0
            .packInt32(caveBack3) // 4200 vs 0
            .packByte(caveBackStyle1) // 6 vs 0
            .packByte(caveBackStyle2) // 2 vs 0
            .packByte(caveBackStyle3) // 5 vs 0
            .packByte(caveBackStyle4) // 1 vs 0
            .packSingle(rain) // 0.5299999713897705 vs 0
            .packByte(eventInfo) // 0 vs 0
            .packByte(eventInfo2) // 48 vs 0
            .packByte(eventInfo3) // 0 vs 0
            .packByte(eventInfo4) // 0 vs 0
            .packByte(invasionType) // 0 vs 0
            .packUInt64(lobbyId) // 0 vs 0
            .data;

        // packet.data = new Buffer("6300075e5d000000006810b0043008f6006e01e001affa050107576f726c6420310108000020000000020201003ada2c3d71b00a00006810000068100000030400002609000068100000681000000602050114ae073f00300000000000000000000000", "hex"); // 
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
        const flags = new BitsByte(reader.readByte());
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
            .packByte(target)
            .packByte(flags.value);

        for (let i = 0; i < 4; i++) {
            if (typeof ai[i] !== "undefined") {
                newPacket.packSingle(ai[i]);
            }
        }
        newPacket.packInt16(npcNetId);
        if (flags[7]) {
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

        packet.data = new PacketWriter()
            .setType(PacketTypes.PlayerDamage)
            .packByte(playerId)
            .packByte(hitDirection)
            .packInt16(damage)
            .packString(deathReason.deathReason)
            .packByte(flags)
            .data;

        return false;
    }

    
    private handlePlayerDeath(server: TerrariaServer, packet: Packet): boolean {
        const reader = new PacketReader(packet.data);
        const playerId = reader.readByte();
        const deathReason = new PlayerDeathReason(reader);
        const damage = reader.readInt16();
        const hitDirection = reader.readByte();
        const flags = reader.readByte();

        packet.data = new PacketWriter()
            .setType(PacketTypes.KillMe)
            .packByte(playerId)
            .packByte(hitDirection)
            .packInt16(damage)
            .packByte(flags)
            .packString(deathReason.deathReason)
            .data;

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

        if (buff <= 190) {
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
        return false;
    }

    private handlePlayerInventorySlot(server: TerrariaServer, packet: Packet): boolean {
        3602
        const reader = new PacketReader(packet.data);
        const playerId = reader.readByte();
        const slotId = reader.readByte();
        const stack = reader.readInt16();
        const prefix = reader.readByte();
        const netId = reader.readInt16();

        // 3601 is last netId on mobile (prob, I didn't check the code, just the wiki)
        if (netId > 3601) {
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
}

export default PriorServerHandler;