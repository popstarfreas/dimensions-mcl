import ClientPacketHandler from 'dimensions/extension/clientpackethandler';
import Client from 'dimensions/client';
import Packet from 'dimensions/packet';
import PacketTypes from 'dimensions/packettypes';
import PacketWriter from 'dimensions/packets/packetwriter';
import PacketReader from 'dimensions/packets/packetreader';
import MCL, { MAX_CLIENT_ID, MOBILE_SERVER_ID, PC_SERVER_ID } from './';
import BitsByte from 'dimensions/datatypes/bitsbyte';
import Point from 'dimensions/point';
import PlayerDeathReason from 'dimensions/datatypes/playerdeathreason';

class PriorClientHandler extends ClientPacketHandler {
    protected _mcl: MCL;

    constructor(mcl: MCL) {
        super();
        this._mcl = mcl;
    }

    public handlePacket(client: Client, packet: Packet) {
        let handled = false;
        handled = this.handleIncompatiblePacket(client, packet);
        return handled;
    }

    private handleIncompatiblePacket(client: Client, packet: Packet) {
        let handled = false;
        if (!this._mcl.clients.has(client) && packet.packetType !== PacketTypes.ConnectRequest) {
            return false;
        }
        switch (packet.packetType) {
            case PacketTypes.ConnectRequest:
                handled = this.handleConnectRequest(client, packet);
                break;
            case PacketTypes.PlayerHurtV2:
                handled = this.handlePlayerDamage(client, packet);
                break;
            case PacketTypes.PlayerDeathV2:
                handled = this.handlePlayerDeath(client, packet);
                break;
            case PacketTypes.AddPlayerBuff:
                handled = this.handleAddPlayerBuff(client, packet);
                break;
            case PacketTypes.UpdateItemOwner:
                this.handleUpdateItemOwner(client, packet);
                break;
        }
        return handled;
    }

    private handleUpdateItemOwner(client, packet) {
        const reader = new PacketReader(packet.data);
        const itemId = reader.readInt16();
        const owner = reader.readByte();

        if (owner === MOBILE_SERVER_ID) {
            packet.data.writeUInt8(PC_SERVER_ID, 2);
        }
    }

    private handleConnectRequest(client: Client, packet: Packet) {
        let reader = new PacketReader(packet.data);
        let version = reader.readString();
        // Mobile Version
        if (version === "Terraria230") {
            this._mcl.clients.add(client);
            /*packet.data = new PacketWriter()
                .setType(PacketTypes.ConnectRequest)
                .packString("Terraria226")
                .data;*/
            return false;
        }
        return false;
    }

    private handlePlayerDamage(client: Client, packet: Packet) {
        const reader = new PacketReader(packet.data);
        let playerId = reader.readByte();
        const deathReason = new PlayerDeathReason(reader);
        const damage = reader.readInt16();
        const hitDirection = reader.readByte();
        const flags = reader.readByte();
        const cooldownCounter = reader.readSByte();
        const realId = this._mcl.realId.get(client);

        if (playerId === MAX_CLIENT_ID && typeof realId !== "undefined") {
            playerId = realId;
            const writer = new PacketWriter()
                .setType(PacketTypes.PlayerHurtV2)
                .packByte(playerId)
            writer.packBuffer(deathReason.getHexData())
                .packInt16(damage)
                .packByte(hitDirection)
                .packByte(flags)
                .packSByte(cooldownCounter)
            packet.data = writer.data;
        }

        return false;
    }

    private handlePlayerDeath(client: Client, packet: Packet) {
        const reader = new PacketReader(packet.data);
        let playerId = reader.readByte();
        const deathReason = new PlayerDeathReason(reader);
        const damage = reader.readInt16();
        const hitDirection = reader.readByte();
        const flags = reader.readByte();
        const realId = this._mcl.realId.get(client);
        if (playerId === MAX_CLIENT_ID && typeof realId !== "undefined") {
            playerId = realId;
            const writer = new PacketWriter()
                .setType(PacketTypes.PlayerDeathV2)
                .packByte(playerId);
            writer.packBuffer(deathReason.getHexData())
                .packInt16(damage)
                .packByte(hitDirection)
                .packByte(flags);
            packet.data = writer.data;
        }

        return false;
    }

    private handleAddPlayerBuff(client: Client, packet: Packet) {
        const reader = new PacketReader(packet.data);
        let playerId = reader.readByte();
        const buff = reader.readUInt16();
        const time = reader.readInt32();
        const realId = this._mcl.realId.get(client);
        if (playerId === MAX_CLIENT_ID && typeof realId !== "undefined") {
            playerId = realId;

            packet.data = new PacketWriter()
                .setType(PacketTypes.AddPlayerBuff)
                .packByte(playerId)
                .packUInt16(buff)
                .packInt32(time)
                .data;
        }

        return false;
    }
}

export default PriorClientHandler;
