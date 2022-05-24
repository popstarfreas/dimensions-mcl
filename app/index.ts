import ListenServer from "dimensions/listenserver";
import Extension from "dimensions/extension";
import { requireNoCache } from "dimensions/utils";
import PriorPacketHandler from "./priorpackethandler";
import Client from "dimensions/client";
import { Socket } from "net";
import PostPacketHandler from "./postpackethandler";
import CLConfig from "./clConfig";
import { FSWatcher, watch } from "fs";
import { join } from "path";

export const PACKET_LEN_BYTES = 2;
export const PACKET_TYPE_BYTES = 1;
export const PACKET_HEADER_BYTES = PACKET_LEN_BYTES + PACKET_TYPE_BYTES;

class CompatibilityLayer implements Extension {
    public name: string;
    public version: string;
    public author: string;
    public reloadable: boolean;
    public priorPacketHandlers: PriorPacketHandler;
    public postPacketHandlers: PostPacketHandler;
    public listenServers: { [name: string]: ListenServer };
    public config: CLConfig;

    configWatcher: FSWatcher;

    constructor() {
        this.name = "Compatibility Layer 1.4.1.2 and above -> 1.4.1.1. ";
        this.version = "v1.2";
        this.author = "popstarfreas";
        this.reloadable = false;
        this.priorPacketHandlers = new PriorPacketHandler(this);
        this.postPacketHandlers = new PostPacketHandler(this);

        this.config = require('./clconfig.json');

        this.configWatcher = watch("./clconfig.json", (eventType, filename) => {
            if (eventType === "change")
            {
                let configPath = join(__dirname, "clconfig.json");
                this.config = requireNoCache(configPath, require);
            }
        });
    }

    public setListenServers(listenServers: { [name: string]: ListenServer }): void {
        this.listenServers = listenServers;
    }

}

export default CompatibilityLayer;
