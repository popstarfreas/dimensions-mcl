import { PacketHandler } from "dimensions/extension";
import MCL from "./";
import PostServerHandler from "./postserverhandler";

class PostPacketHandler implements PacketHandler {
    serverHandler: PostServerHandler;

    constructor(mcl: MCL) {
        this.serverHandler = new PostServerHandler(mcl);
    }
}

export default PostPacketHandler;