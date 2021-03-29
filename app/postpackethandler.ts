import { PacketHandler } from "dimensions/extension";
import CL from "./";
import PostServerHandler from "./postserverhandler";

class PostPacketHandler implements PacketHandler {
    serverHandler: PostServerHandler;

    constructor(cl: CL) {
        this.serverHandler = new PostServerHandler(cl);
    }
}

export default PostPacketHandler;
