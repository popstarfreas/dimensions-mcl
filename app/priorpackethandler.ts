import { PacketHandler } from "dimensions/extension";
import CL from "./";
import PriorServerHandler from "./priorserverhandler";

class PriorPacketHandler implements PacketHandler {
    serverHandler: PriorServerHandler;

    constructor(cl: CL) {
        this.serverHandler = new PriorServerHandler(cl);
    }
}

export default PriorPacketHandler;
