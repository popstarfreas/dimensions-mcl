import { PacketHandler } from "dimensions/extension";
import CL from "./";
import PriorClientHandler from "./priorclienthandler";

class PriorPacketHandler implements PacketHandler {
    clientHandler: PriorClientHandler;

    constructor(cl: CL) {
        this.clientHandler = new PriorClientHandler(cl);
    }
}

export default PriorPacketHandler;
