import CL from './'
import TerrariaServerPacketHandler from "dimensions/extension/terrariaserverpackethandler";
import Packet from 'dimensions/packet';
import TerrariaServer from 'dimensions/terrariaserver';
import PacketTypes from 'dimensions/packettypes';
import PacketReader from 'dimensions/packets/packetreader';
import PacketWriter from "dimensions/packets/packetwriter";
import * as WorldInfo1405 from "@darkgaming/rescript-terrariapacket/src/packet/v1405/Packetv1405_WorldInfo.bs";
import * as WorldInfo from "@darkgaming/rescript-terrariapacket/src/packet/Packet_WorldInfo.bs";
import * as TileSquare1405 from "@darkgaming/rescript-terrariapacket/src/packet/v1405/Packetv1405_TileSquareSend.bs";
import * as TileSquare from "@darkgaming/rescript-terrariapacket/src/packet/Packet_TileSquareSend.bs";
import { is144 } from "./is144";
import ClientState from "dimensions/clientstate";

class PriorServerHandler extends TerrariaServerPacketHandler {
    protected _cl: CL;

    constructor(cl: CL) {
        super();
        this._cl = cl;
    }

    public handlePacket(server: TerrariaServer, packet: Packet) {
        if (!this._cl.oldServers.has(server.name.toLowerCase())) {
            return false;
        }

        let handled = false;
        switch (packet.packetType) {
            case PacketTypes.DimensionsUpdate:
                return this.handleDimensionsUpdate(server, packet);
            case PacketTypes.SendTileSquare:
                handled = this.handleSendTileSquare(server, packet);
                break;
            case PacketTypes.SendSection:
                handled = this.handleSendSection(server, packet);
                break;
            case PacketTypes.WorldInfo:
                handled = this.handleWorldInfo(server, packet);
                break;
            case PacketTypes.PlayerInfo:
                handled = this.handlePlayerInfo(server, packet);
                break;
            case PacketTypes.SpawnPlayer:
                handled = this.handleSpawnPlayer(server, packet);
                break;
            case PacketTypes.UpdatePlayerBuff:
                handled = this.handlePlayerBuffs(server, packet);
                break;
            case PacketTypes.UpdateNPCBuff:
                handled = this.handleNpcBuffs(server, packet);
                break;
            case 134:
                handled = this.handlePlayerLuckFactors(server, packet);
                break;
            case PacketTypes.UpdateMoonLordCountdown:
                handled = this.handleUpdateMoonLordCountdown(server, packet);
                break;
        }
        return handled;
    }

    private handleWorldInfo(server: TerrariaServer, packet: Packet): boolean {
        const oldWorldInfo = WorldInfo1405.parse(packet.data);
        const newWorldInfo = WorldInfo1405.toLatest(oldWorldInfo);
        packet.data = WorldInfo.toBuffer(newWorldInfo);

        if (server.isSSC && server.client.state == ClientState.FinalisingSwitch) {
            server.client.socket.write(new PacketWriter().setType(147).packByte(server.client.player.id).packByte(0).data);
            server.client.socket.write(packet.data); for (let i = 260; i <= 349; i++) {
                const packet = new PacketWriter()
                    .setType(PacketTypes.PlayerInventorySlot)
                    .packByte(server.client.player.id)
                    .packInt16(i)
                    .packInt16(0)
                    .packByte(0)
                    .packInt16(0)
                    .data;
                server.client.socket.write(packet);
            }
            return true;
        }
        return false;
    }

    private handleSendTileSquare(server: TerrariaServer, packet: Packet): boolean {
        if (!is144((server.client as any).version)) {
            return this.handle143SendTileSquare(server, packet);
        }

        const old = TileSquare1405.parse(packet.data);
        const new_ = TileSquare1405.toLatest(old);
        packet.data = TileSquare.toBuffer(new_);

        return false;
    }

    private handle143SendTileSquare(server: TerrariaServer, packet: Packet): boolean {
        const reader = new PacketReader(packet.data);
        const sizeAndChangeFlag = reader.readUInt16();
        const size = sizeAndChangeFlag & 32767;
        let tileChangeType = 0;
        if ((sizeAndChangeFlag & 0x8000) !== 0) {
            tileChangeType = reader.readByte();
        }
        const tileX = reader.readInt16();
        const tileY = reader.readInt16();
        const tileData = reader.readBuffer(packet.data.length - reader.head);
        packet.data = new PacketWriter()
            .setType(PacketTypes.SendTileSquare)
            .packUInt16(tileX)
            .packUInt16(tileY)
            .packByte(size)
            .packByte(size)
            .packByte(tileChangeType)
            .packBuffer(tileData)
            .data;

        return false;
    }

    private handleSendSection(server: TerrariaServer, packet: Packet): boolean {
        if (!is144((server.client as any).version)) {
            return false;
        }

        const reader = new PacketReader(packet.data);
        const payload = reader.readBuffer(packet.data.length - 3)
        const correctedPayload = payload.slice(1);
        packet.data = new PacketWriter().setType(packet.packetType)
            .packBuffer(correctedPayload)
            .data;


        return false;
    }

    private handlePlayerInfo(server: TerrariaServer, packet: Packet): boolean {
        if (!is144((server.client as any).version)) {
            return false;
        }

        const reader = new PacketReader(packet.data);
        const payload = reader.readBuffer(packet.data.length - 3);
        packet.data = new PacketWriter().setType(packet.packetType)
            .packBuffer(payload)
            .packByte(0)
            .data;

        return false;
    }

    private handleSpawnPlayer(server: TerrariaServer, packet: Packet): boolean {
        if (!is144((server.client as any).version)) {
            return false;
        }

        const reader = new PacketReader(packet.data);
        const payload = reader.readBuffer(packet.data.length - 3);
        packet.data = new PacketWriter().setType(packet.packetType)
            .packBuffer(payload)
            .packInt16(0)
            .packInt16(0)
            .data;

        return false;
    }

    private handlePlayerBuffs(server: TerrariaServer, packet: Packet): boolean {
        if (!is144((server.client as any).version)) {
            return false;
        }

        const reader = new PacketReader(packet.data);
        const payload = reader.readBuffer(packet.data.length - 3);
        const writer = new PacketWriter().setType(packet.packetType)
            .packBuffer(payload);
        // 22 new buff slots
        for (let i = 0; i < 22; i++) {
            writer.packUInt16(0);
        }
        packet.data = writer.data;

        return false;
    }

    private handleNpcBuffs(server: TerrariaServer, packet: Packet): boolean {
        if (!is144((server.client as any).version)) {
            return false;
        }

        const reader = new PacketReader(packet.data);
        const payload = reader.readBuffer(packet.data.length - 3);
        const writer = new PacketWriter().setType(packet.packetType)
            .packBuffer(payload);
        // 15 new buff slots
        for (let i = 0; i < 15; i++) {
            writer.packUInt16(0);
            writer.packInt16(0);
        }
        packet.data = writer.data;

        return false;
    }

    private handlePlayerLuckFactors(server: TerrariaServer, packet: Packet): boolean {
        if (!is144((server.client as any).version)) {
            return false;
        }

        const reader = new PacketReader(packet.data);
        const payload = reader.readBuffer(packet.data.length - 3);
        const writer = new PacketWriter().setType(packet.packetType)
            .packBuffer(payload)
            .packSingle(0)
            .packSingle(0);
        packet.data = writer.data;

        return false;
    }

    private handleUpdateMoonLordCountdown(server: TerrariaServer, packet: Packet): boolean {
        if (!is144((server.client as any).version)) {
            return false;
        }

        const reader = new PacketReader(packet.data);
        const payload = reader.readBuffer(packet.data.length - 3);
        const writer = new PacketWriter().setType(packet.packetType)
            .packInt32(100) // Idk what to set max to
            .packBuffer(payload);
        packet.data = writer.data;

        return false;
    }

    private handleDimensionsUpdate(server: TerrariaServer, packet: Packet): boolean {
        const reader = new PacketReader(packet.data);
        const messageType = reader.readInt16();
        const messageContent = reader.readString();

        if (messageType === 3) {
            const ip = messageContent;
            const port = reader.readUInt16();
            const name = reader.head < reader.data.length
                ? reader.readString()
                : `${ip}:${port}`
            server.client.changeServer({
                name: name,
                serverIP: ip,
                serverPort: port
            }, {
                preventSpawnOnJoin: false
            });
            console.log("Changing", server.client.player.name, "from", server.name, "to", name, "via", `${ip}:${port}`);
            return true;
        }

        return false;
    }
}

export default PriorServerHandler;
