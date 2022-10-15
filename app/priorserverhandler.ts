import CL from './'
import TerrariaServerPacketHandler from "dimensions/extension/terrariaserverpackethandler";
import Packet from 'dimensions/packet';
import TerrariaServer from 'dimensions/terrariaserver';
import PacketTypes from 'dimensions/packettypes';
import PacketReader from 'dimensions/packets/packetreader';

class PriorServerHandler extends TerrariaServerPacketHandler {
    protected _cl: CL;

    constructor(cl: CL) {
        super();
        this._cl = cl;
    }

    public handlePacket(server: TerrariaServer, packet: Packet): boolean {
        switch (packet.packetType) {
            case PacketTypes.DimensionsUpdate:
                return this.handleDimensionsUpdate(server, packet);
            default:
                return false;
        }
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
            return true;
        }

        return false;
    }
}

export default PriorServerHandler;
