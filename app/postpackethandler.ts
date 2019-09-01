import { PacketHandler } from "dimensions/extension";
import Translator from "./";
import PostServerHandler from "./postserverhandler";

class PostPacketHandler implements PacketHandler {
    serverHandler: PostServerHandler;

    constructor(translator: Translator) {
        this.serverHandler = new PostServerHandler(translator);
    }
}

export default PostPacketHandler;