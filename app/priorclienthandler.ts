import ClientPacketHandler from 'dimensions/extension/clientpackethandler';
import Client from 'dimensions/client';
import Packet from 'dimensions/packet';
import PacketTypes from 'dimensions/packettypes';
import PacketWriter from 'dimensions/packets/packetwriter';
import PacketReader from 'dimensions/packets/packetreader';
import BitsByte from 'dimensions/datatypes/bitsbyte';
import CL from './';

class PriorClientHandler extends ClientPacketHandler {
    protected _cl: CL;

    constructor(cl: CL) {
        super();
        this._cl = cl;
    }

    public handlePacket(client: Client, packet: Packet) {
        let handled = false;
        handled = this.handleIncompatiblePacket(client, packet);
        return handled;
    }

    private handleIncompatiblePacket(client: Client, packet: Packet) {
        let handled = false;
        switch (packet.packetType) {
            case PacketTypes.ConnectRequest:
                handled = this.handleConnectRequest(client, packet);
                break;
            case PacketTypes.ProjectileUpdate:
                handled = this.handleProjectileUpdate(client, packet);
                break;
            case PacketTypes.SendTileSquare:
                handled = this.handleSendTileRectangle(client, packet);
                break;
        }
        return handled;
    }


    private handleConnectRequest(client: Client, packet: Packet) {
        const reader = new PacketReader(packet.data);
        const version = reader.readString();
        const versionMatch = version.match(/Terraria(\d+)/)
        const versionNumber = versionMatch?.[1];
        let isPcVersion = false;
        if (versionNumber && parseInt(versionNumber).toString() === versionNumber) {
            isPcVersion = parseInt(versionNumber) >= 234; // 1.4.1.2 or above
        }
        if (isPcVersion) {
            this._cl.clients.add(client);
            packet.data = new PacketWriter()
                .setType(PacketTypes.ConnectRequest)
                .packString("Terraria233") // 1.4.1.1
                .data;
            return false;
        }
        return false;
    }

    private handleProjectileUpdate(client, packet: Packet) {
        const reader = new PacketReader(packet.data);
        const id = reader.readInt16();
        const location = {
            x: reader.readSingle(),
            y: reader.readSingle(),
        }
        const velocity = {
            x: reader.readSingle(),
            y: reader.readSingle(),
        }
        const owner = reader.readByte();
        const startFrom = reader.head;
        const type = reader.readInt16();

        if (type === 954) {
            packet.data.writeInt16LE(504, startFrom);
        }

        if (type === 955) {
            packet.data.writeInt16LE(12, startFrom);
        }
        return false;
    }

    private handleSendTileRectangle(client: Client, packet: Packet) {
        const reader = new PacketReader(packet.data);
        let tileX = reader.readInt16();
        let tileY = reader.readInt16();
        let sizeX = reader.readByte();
        let sizeY = reader.readByte();
        const tileChangeType = reader.readByte();

        if (sizeX == sizeY) {
            packet.data = createSTSWriter(sizeX, tileChangeType, tileX, tileY)
                         .packBuffer(reader.readBuffer(packet.data.length - reader.head))
                         .data;
        } else {
            return true;
        }

        return false;

        function createSTSWriter(size, tileChangeType, tileX, tileY) {
            const writer = new PacketWriter()
                .setType(PacketTypes.SendTileSquare);

            if (tileChangeType != 0) {
                writer.packUInt16((size & 0x7FFF) | 0x8000);
                writer.packByte(tileChangeType);
            } else {
                writer.packUInt16(size);
            }

            writer.packInt16(tileX)
                  .packInt16(tileY);

            return writer;
        }
    }

}

export default PriorClientHandler;
