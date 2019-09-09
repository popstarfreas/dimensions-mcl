import ClientPacketHandler from 'dimensions/extension/clientpackethandler';
import Client from 'dimensions/client';
import Packet from 'dimensions/packet';
import PacketTypes from 'dimensions/packettypes';
import PacketWriter from 'dimensions/packets/packetwriter';
import PacketReader from 'dimensions/packets/packetreader';
import MCL from './';

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
            case PacketTypes.ChatMessage:
                handled = this.handleChatMessage(client, packet);
                break;
            case PacketTypes.PlayerDamage:
                handled = this.handlePlayerDamage(client, packet);
                break;
            case PacketTypes.KillMe:
                handled = this.handlePlayerKillMe(client, packet);
                break;
            case PacketTypes.AddPlayerBuff:
                handled = this.handleAddPlayerBuff(client, packet);
                break;
        }
        return handled;
    }

    private handleConnectRequest(client: Client, packet: Packet) {
        let reader = new PacketReader(packet.data);
        let version = reader.readString();
        console.log("Version: "+version);
        // Mobile Version
        if (version === "Terraria155" || version === "Terraria156") {
            this._mcl.clients.add(client);
            packet.data = new PacketWriter()
                .setType(PacketTypes.ConnectRequest)
                .packString("Terraria194")
                .data;
            return false;
        }
        return false;
    }

    private handleChatMessage(client: Client, packet: Packet) {
        let reader = new PacketReader(packet.data);
        reader.readByte();
        reader.readByte();
        reader.readByte();
        reader.readByte();
        let message = reader.readString();
        packet.packetType = PacketTypes.LoadNetModule;
        packet.data = new PacketWriter()
            .setType(PacketTypes.LoadNetModule)
            .packUInt16(1)
            .packString("Say")
            .packString(message)
            .data;
        return false;
    }

    private handlePlayerDamage(client: Client, packet: Packet) {
        const reader = new PacketReader(packet.data);
        const playerId = reader.readByte();
        const hitDirection = reader.readByte();
        const damage = reader.readInt16();
        const message = reader.readString();
        const flags = reader.readByte();

        packet.data = new PacketWriter()
            .setType(PacketTypes.PlayerHurtV2)
            .packByte(playerId)
            .packByte(128)
            .packString(message)
            .packInt16(damage)
            .packByte(hitDirection)
            .packByte(flags)
            .packSByte(0)
            .data;

        return false;
    }

    private handlePlayerKillMe(client: Client, packet: Packet) {
        const reader = new PacketReader(packet.data);
        const playerId = reader.readByte();
        const hitDirection = reader.readByte();
        const damage = reader.readInt16();
        const message = reader.readString();
        const flags = reader.readByte();

        packet.data = new PacketWriter()
            .setType(PacketTypes.PlayerDeathV2)
            .packByte(playerId)
            .packByte(128)
            .packString(message)
            .packInt16(damage)
            .packByte(hitDirection)
            .packByte(flags)
            .data;

        return false;
    }

    private handleAddPlayerBuff(client: Client, packet: Packet) {
        const reader = new PacketReader(packet.data);
        const playerId = reader.readByte();
        const buff = reader.readByte();
        const time = reader.readInt16();

        packet.data = new PacketWriter()
            .setType(PacketTypes.AddPlayerBuff)
            .packByte(playerId)
            .packByte(buff)
            .packInt32(time)
            .data;

        return false;
    }
}

export default PriorClientHandler;
