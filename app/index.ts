import ListenServer from "dimensions/listenserver";
import Extension from "dimensions/extension";
import PriorPacketHandler from "./priorpackethandler";
import Client from "dimensions/client";
import { Socket } from "net";
import PostPacketHandler from "./postpackethandler";

export const MOBILE_SERVER_ID = 16;
export const PC_SERVER_ID = 255;
export const MAX_CLIENT_ID = 15;
export const FAKED_CLIENT_ID = 15;

class MobileCompatibilityLayer implements Extension {
    public name: string;
    public version: string;
    public author: string;
    public reloadable: boolean;
    public priorPacketHandlers: PriorPacketHandler;
    public postPacketHandlers: PostPacketHandler;
    public listenServers: { [name: string]: ListenServer };
    public clients: Set<Client> = new Set<Client>();
    public realId: Map<Client, number> = new Map<Client, number>(); // used when server tells mobile client their id > 15

    constructor() {
        this.name = "Mobile Compatibility Layer";
        this.version = "v1.0";
        this.author = "popstarfreas";
        this.reloadable = false;
        this.priorPacketHandlers = new PriorPacketHandler(this);
        this.postPacketHandlers = new PostPacketHandler(this);
    }

    public setListenServers(listenServers: { [name: string]: ListenServer }): void {
        this.listenServers = listenServers;
    }

    public socketClosePostHandler(socket: Socket, client: Client) {
        this.clients.delete(client);
        this.realId.delete(client);
    }

}

export default MobileCompatibilityLayer;
