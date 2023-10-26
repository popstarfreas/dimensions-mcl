import { PacketHandler } from "dimensions/extension";
import CL from "./";
import PostClientHandler from "./postclienthandler";

class PostPacketHandler implements PacketHandler {
    clientHandler: PostClientHandler;

    constructor(cl: CL) {
        this.clientHandler = new PostClientHandler(cl);
    }
}

export default PostPacketHandler;
