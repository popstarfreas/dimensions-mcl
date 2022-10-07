import { PacketHandler } from "dimensions/extension";
import CL from "./";
import PriorClientHandler from "./priorclienthandler";
import PriorServerHandler from "./priorserverhandler";

class PriorPacketHandler implements PacketHandler {
    clientHandler: PriorClientHandler;
    serverHandler: PriorServerHandler;

    constructor(cl: CL) {
        this.clientHandler = new PriorClientHandler(cl);
        this.serverHandler = new PriorServerHandler(cl);
    }
}

export default PriorPacketHandler;
