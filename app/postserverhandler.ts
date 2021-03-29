import TerrariaServerPacketHandler from "dimensions/extension/terrariaserverpackethandler";
import Packet from "dimensions/packet";
import PacketReader from "dimensions/packets/packetreader";
import PacketWriter from "dimensions/packets/packetwriter";
import PacketTypes from "dimensions/packettypes";
import TerrariaServer from "dimensions/terrariaserver";
import MCL from ".";
import BitsByte from "dimensions/datatypes/bitsbyte";
import Point from "dimensions/point";

class PriorServerHandler extends TerrariaServerPacketHandler {
    protected _mcl: MCL;

    constructor(mcl: MCL) {
        super();
        this._mcl = mcl;
    }

    public handlePacket(server: TerrariaServer, packet: Packet) {
        if (!this._mcl.clients.has(server.client)) {
            return false;
        }
        let handled = false;
        switch (packet.packetType) {
            case PacketTypes.NPCUpdate:
                this.handleNpcUpdate(server, packet);
                break;
            case PacketTypes.ProjectileUpdate:
                this.handleProjectileUpdate(server, packet);
                break;
            case PacketTypes.LoadNetModule:
                this.handleLoadNetModule(server, packet);
                break;
        }
        return handled;
    }

    private handleNpcUpdate(server: TerrariaServer, packet: Packet): boolean {
        const reader: PacketReader = new PacketReader(packet.data);
        const npcSlotId: number = reader.readInt16();
        const position: Point = {
            x: reader.readSingle(),
            y: reader.readSingle()
        };
        const velocity: Point = {
            x: reader.readSingle(),
            y: reader.readSingle()
        };
        const target: number = reader.readUInt16();
        const npcFlags1 = new BitsByte(reader.readByte());
        const npcFlags2 = new BitsByte(reader.readByte());
        const ai: [
            number | null,
            number | null,
            number | null,
            number | null
        ] = [null, null, null, null];
        if (npcFlags1[2]) {
            ai[0] = reader.readSingle();
        }
        if (npcFlags1[3]) {
            ai[1] = reader.readSingle();
        }
        if (npcFlags1[4]) {
            ai[2] = reader.readSingle();
        }
        if (npcFlags1[5]) {
            ai[3] = reader.readSingle();
        }

        const npcNetId: number = reader.readInt16();
        if (npcNetId > 662) { // 662 is the last supported mobile npc id
            packet.data = Buffer.allocUnsafe(0);
            return true;
        }

        let playerCountForMultiplayerDifficultyOverride: number | null = null;
        if (npcFlags2[0]) {
            playerCountForMultiplayerDifficultyOverride = reader.readByte();
        }
        let strengthMultiplier: number | null = null;
        if (npcFlags2[2]) {
            strengthMultiplier = reader.readSingle();
        }
        let life: number | null = null;
        let lifeBytes: number | null = null;
        if (!npcFlags1[7]) {
            lifeBytes = reader.readByte();
            if (lifeBytes == 2) {
                life = reader.readInt16();
            } else if (lifeBytes == 4) {
                life = reader.readInt32();
            } else {
                life = reader.readSByte();
            }
        }

        let releaseOwner: number | null = null;
        if (reader.head < packet.data.length) {
            releaseOwner = reader.readByte();
        }

        return false;
    }

    private handleProjectileUpdate(server: TerrariaServer, packet: Packet): boolean {
        const reader = new PacketReader(packet.data);
        const ident = reader.readInt16();
        const positionX = reader.readSingle();
        const positionY = reader.readSingle();
        const velocityX = reader.readSingle();
        const velocityY = reader.readSingle();
        const owner = reader.readByte();
        const projType = reader.readInt16();
        const ai = reader.readByte();
        const hasDamage = (ai & 16) === 16;
        const hasKnockback = (ai & 32) === 32;
        const needsUuid = (ai & 128) === 128;
        const hasOriginalDamage = (ai & 64) === 64;
        const hasAi0 = (ai & 1) === 1;
        const hasAi1 = (ai & 2) === 2;

        let ai0 = 0;
        if (hasAi0) {
            ai0 = reader.readSingle();
        }

        let ai1 = 0;
        if (hasAi1) {
            ai1 = reader.readSingle();
        }

        let damage = 0;
        if (hasDamage) {
            damage = reader.readInt16();
        }

        let knockback = 0;
        if (hasKnockback) {
            knockback = reader.readSingle();
        }

        let originalDamage = 0;
        if (hasOriginalDamage) {
            originalDamage = reader.readInt16();
        }

        let uuid = 0;
        if (needsUuid) {
            uuid = reader.readInt16();
        }

        // 948 is last supported projectile type on mobile (from wiki)
        if (projType > 849) {
            packet.data = Buffer.allocUnsafe(0);
            return true;
        }

        return false;
    }

    private handleLoadNetModule(server: TerrariaServer, packet: Packet): boolean {
        const reader = new PacketReader(packet.data);
        const netModuleId = reader.readUInt16();
        /// Creative Unlocks Module
        if (netModuleId === 5) {
            const itemId = reader.readInt16();
            // Is 5043 and 5044 from 1.4.0.5?
            if (itemId > 5042) {
                packet.data = Buffer.allocUnsafe(0);
                return true;
            }
        }

        return false;
    }
}

export default PriorServerHandler;
