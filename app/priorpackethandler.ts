import { PacketHandler } from "dimensions/extension";
import Translator from "./";
import PriorServerHandler from "./postserverhandler";
import PriorClientHandler from "./priorclienthandler";

class PriorPacketHandler implements PacketHandler {
    clientHandler: PriorClientHandler;

    constructor(translator: Translator) {
        this.clientHandler = new PriorClientHandler(translator);
    }
}

export default PriorPacketHandler;