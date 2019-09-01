import PlayerInfo from "../../app";
import ListenServer from "dimensions/listenserver";
import RoutingServer from "dimensions/routingserver";
import PacketTypes from "dimensions/packettypes";
import PacketWriter from "dimensions/packets/packetwriter";
import PacketReader from "dimensions/packets/packetreader";

describe("playerinfo", () => {
    const playerInfo = new PlayerInfo();
    const routingServer: RoutingServer = {
        name: "testName",
        serverIP: "localhost",
        serverPort: 7777
    };
    const client = {player:{name:"test_player",inventory: [],position: {x: 1, y: 2}}, server: routingServer};
    let result = null;
    const server: any = {client, socket: {write: (buf) => result = buf}, ip: "localhost", port: 7778, name: "testServer"};
    const listenServer: ListenServer | any = {
        clients: [client],
        servers: {
            testName: routingServer
        }
    }
    playerInfo.setListenServers({
        "7777": listenServer
    });

    beforeEach(() => {
        result = null;
    });
    
    it("should write the player info into the buffer", () => {
        const writer = new PacketWriter();
        const data = writer
            .setType(PacketTypes.DimensionsUpdate)
            .packInt16(4)
            .packString("test_player")
            .data;
        playerInfo.priorPacketHandlers.serverHandler.handlePacket(server, {
            data,
            packetType: PacketTypes.DimensionsUpdate
        });
        const reader = new PacketReader(result.toString("hex"));
        expect(result).not.toBeNull();
        expect(reader.readInt16()).toBe(4);
        expect(reader.readString()).toBe("test_player");
        expect(reader.readByte()).toBe(1);
    });

    it("should write a failure message when no such player exists", () => {
        const writer = new PacketWriter();
        const data = writer
            .setType(PacketTypes.DimensionsUpdate)
            .packInt16(4)
            .packString("test_player_notexist")
            .data;
        playerInfo.priorPacketHandlers.serverHandler.handlePacket(server, {
            data,
            packetType: PacketTypes.DimensionsUpdate
        });
        const reader = new PacketReader(result.toString("hex"));
        expect(result).not.toBeNull();
        expect(reader.readInt16()).toBe(4);
        expect(reader.readString()).toBe("test_player_notexist");
        expect(reader.readByte()).toBe(0);
    });
});