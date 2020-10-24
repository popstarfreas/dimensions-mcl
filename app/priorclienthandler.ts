import ClientPacketHandler from 'dimensions/extension/clientpackethandler';
import Client from 'dimensions/client';
import Packet from 'dimensions/packet';
import PacketTypes from 'dimensions/packettypes';
import PacketWriter from 'dimensions/packets/packetwriter';
import PacketReader from 'dimensions/packets/packetreader';
import MCL  from './';

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
        }
        return handled;
    }


    private handleConnectRequest(client: Client, packet: Packet) {
        let reader = new PacketReader(packet.data);
        let version = reader.readString();
        // Mobile Version
        if (version === "Terraria230") {
            this._mcl.clients.add(client);
            packet.data = new PacketWriter()
                .setType(PacketTypes.ConnectRequest)
                .packString("Terraria233")
                .data;
            return false;
        }
        return false;
    }

}

export default PriorClientHandler;
