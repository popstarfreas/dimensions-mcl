import TerrariaServerPacketHandler from "dimensions/extension/terrariaserverpackethandler";
import Packet from "dimensions/packet";
import PacketReader from "dimensions/packets/packetreader";
import PacketWriter from "dimensions/packets/packetwriter";
import PacketTypes from "dimensions/packettypes";
import TerrariaServer from "dimensions/terrariaserver";
import CL from ".";

class PriorServerHandler extends TerrariaServerPacketHandler {
    protected _cl: CL;

    constructor(cl: CL) {
        super();
        this._cl = cl;
    }

    public handlePacket(server: TerrariaServer, packet: Packet) {
        if (!this._cl.clients.has(server.client)) {
            return false;
        }
        let handled = false;
        switch (packet.packetType) {
            case PacketTypes.SendTileSquare:
                handled = this.handleSendTileSquare(server, packet);
                break;
        }
        return handled;
    }

    private handleSendTileSquare(server: TerrariaServer, packet: Packet): boolean {
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
}

export default PriorServerHandler;
