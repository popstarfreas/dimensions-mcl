import ListenServer from "dimensions/listenserver";
import Extension from "dimensions/extension";
import PriorPacketHandler from "./priorpackethandler";
import Client from "dimensions/client";
import { Socket } from "net";
import PostPacketHandler from "./postpackethandler";

export const PACKET_LEN_BYTES = 2;
export const PACKET_TYPE_BYTES = 1;
export const PACKET_HEADER_BYTES = PACKET_LEN_BYTES + PACKET_TYPE_BYTES;

class MobileCompatibilityLayer implements Extension {
    public name: string;
    public version: string;
    public author: string;
    public reloadable: boolean;
    public priorPacketHandlers: PriorPacketHandler;
    public postPacketHandlers: PostPacketHandler;
    public listenServers: { [name: string]: ListenServer };
    public clients: Set<Client> = new Set<Client>();

    constructor() {
        this.name = "Mobile Compatibility Layer 1.4.0.5 -> 1.4.1.1. With iOS support!";
        this.version = "v1.4";
        this.author = "popstarfreas";
        this.reloadable = false;
        this.priorPacketHandlers = new PriorPacketHandler(this);
        this.postPacketHandlers = new PostPacketHandler(this);
    }

    public setListenServers(listenServers: { [name: string]: ListenServer }): void {
        this.listenServers = listenServers;
    }

    public socketClosePostHandler(_socket: Socket, client: Client) {
        this.clients.delete(client);
    }

}

export default MobileCompatibilityLayer;
