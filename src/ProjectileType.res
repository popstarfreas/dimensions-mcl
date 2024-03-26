type t =
  | Empty
  | WoodenArrowFriendly
  | FlamingArrow
  | Shuriken
  | UnholyArrow
  | JestersArrow
  | EnchantedBoomerang
  | VilethornBase
  | VilethornTip
  | Starfury
  | PurificationPowder
  | VilePowder
  | FallingStar
  | GrapplingHook
  | OldSilverBullet
  | BallofFire
  | MagicMissile
  | DirtBall
  | ShadowOrb
  | Flamarang
  | GreenLaser
  | Bone
  | WaterStream
  | Harpoon
  | SpikyBallWeapon
  | BallOHurt
  | BlueMoon
  | WaterBolt
  | Bomb
  | Dynamite
  | Grenade
  | SandBallFalling
  | IvyWhip
  | ThornChakram
  | Flamelash
  | Sunfury
  | MeteorShot
  | StickyBomb
  | HarpyFeather
  | MudBall
  | AshBall
  | HellfireArrow
  | SandBallSandgun
  | Tombstone
  | DemonSickle
  | DemonScythe
  | DarkLance
  | Trident
  | ThrowingKnife
  | Spear
  | Glowstick
  | Seed
  | WoodenBoomerang
  | StickyGlowstick
  | PoisonedKnife
  | Stinger
  | EbonsandBallFalling
  | CobaltChainsaw
  | MythrilChainsaw
  | CobaltDrill
  | MythrilDrill
  | AdamantiteChainsaw
  | AdamantiteDrill
  | TheDaoofPow
  | MythrilHalberd
  | EbonsandBallSandgun
  | AdamantiteGlaive
  | PearlSandBallFalling
  | PearlSandBallSandgun
  | HolyWater
  | UnholyWater
  | SiltBall
  | BlueFairy
  | DualHookBlue
  | DualHookRed
  | HappyBomb
  | NoteQuarter
  | NoteEight
  | NoteTiedEighth
  | Rainbow
  | IceBlock
  | WoodenArrowHostile
  | FlamingArrowHostile
  | EyeLaser
  | PinkLaser
  | Flames
  | PinkFairy
  | GreenFairy
  | PurpleLaser
  | CrystalBullet
  | CrystalShard
  | HolyArrow
  | HallowStar
  | MagicDagger
  | CrystalStorm
  | CursedFlameFriendly
  | CursedFlameHostile
  | CobaltNaginata
  | PoisonDartTrap
  | Boulder
  | DeathLaser
  | EyeFire
  | SkeletronPrimeBomb
  | CursedArrow
  | CursedBullet
  | Gungnir
  | LightDisc
  | Hamdrax
  | Explosives
  | SnowBall
  | Bullet
  | Bunny
  | Penguin
  | IceBoomerang
  | UnholyTridentFriendly
  | UnholyTridentHostile
  | SwordBeam
  | BoneArrowMarrow
  | IceBolt
  | FrostBoltFrostbrand
  | FrostArrow
  | AmethystBolt
  | TopazBolt
  | SapphireBolt
  | EmeraldBolt
  | RubyBolt
  | DiamondBolt
  | Turtle
  | FrostBlastHostile
  | RuneBlast
  | MushroomSpear
  | Mushroom
  | TerraBeam
  | GrenadeI
  | RocketI
  | ProximityMineI
  | GrenadeII
  | RocketII
  | ProximityMineII
  | GrenadeIII
  | RocketIII
  | ProximityMineIII
  | GrenadeIV
  | RocketIV
  | ProximityMineIV
  | PureSpray
  | HallowSpray
  | CorruptSpray
  | MushroomSpray
  | CrimsonSpray
  | NettleBurstRight
  | NettleBurstLeft
  | NettleBurstEnd
  | TheRottedFork
  | TheMeatball
  | BeachBall
  | LightBeam
  | NightBeam
  | CopperCoin
  | SilverCoin
  | GoldCoin
  | PlatinumCoin
  | CannonballFriendly
  | Flare
  | Landmine
  | Web
  | SnowBallFriendly
  | RedFireworkRocket
  | GreenFireworkRocket
  | BlueFireworkRocket
  | YellowFireworkRocket
  | RopeCoil
  | FrostburnArrow
  | EnchantedBeam
  | IceSpike
  | BabyEater
  | JungleSpike
  | IcewaterSpit
  | ConfettiGun
  | SlushBall
  | BulletDeadeye
  | Bee
  | PossessedHatchet
  | Beenade
  | PoisonDartSuperDartTrap
  | SpikyBallTrap
  | SpearTrap
  | FlamethrowerTrap
  | FlameTrapFlames
  | Wasp
  | MechanicalPiranha
  | Pygmy1
  | Pygmy2
  | Pygmy3
  | Pygmy4
  | Pygmy5
  | SmokeBomb
  | BabySkeletronHead
  | BabyHornet
  | TikiSpirit
  | PetLizard
  | GraveMarker
  | CrossGraveMarker
  | HeadStone
  | GraveStone
  | Obelisk
  | Leaf
  | ChlorophyteBullet
  | Parrot
  | Truffle
  | Sapling
  | Wisp
  | PalladiumPike
  | PalladiumDrill
  | PalladiumChainsaw
  | OrichalcumHalberd
  | OrichalcumDrill
  | OrichalcumChainsaw
  | TitaniumTrident
  | TitaniumDrill
  | TitaniumChainsaw
  | FlowerPetal
  | ChlorophytePartisan
  | ChlorophyteDrill
  | ChlorophyteChainsaw
  | ChlorophyteArrow
  | CrystalLeaf
  | CrystalLeafShot
  | SporeCloud
  | ChlorophyteOrb
  | AmethystHook
  | TopazHook
  | SapphireHook
  | EmeraldHook
  | RubyHook
  | DiamondHook
  | BabyDino
  | RainCloudMoving
  | RainCloudRaining
  | RainFriendly
  | Cannonball
  | CrimsandBallFalling
  | HighVelocityBullet
  | BloodCloudMoving
  | BloodCloudRaining
  | BloodRain
  | StyngerBolt
  | FlowerPow
  | FlowerPowPetal
  | StyngerBoltShrapnel
  | RainbowFront
  | RainbowBack
  | ChlorophyteJackhammer
  | BallofFrost
  | MagnetSphereBall
  | MagnetSphereBolt
  | SkeletronHand
  | FrostBeam
  | Fireball
  | EyeBeam
  | HeatRay
  | BoulderStaffofEarth
  | GolemFist
  | IceSickle
  | Rain
  | PoisonFang
  | BabySlime
  | PoisonDartWeapon
  | EyeSpring
  | BabySnowman
  | Skull
  | BoxingGlove
  | Bananarang
  | ChainKnife
  | DeathSickle
  | PlanteraSeed
  | PoisonSeed
  | ThornBall
  | IchorArrow
  | IchorBullet
  | GoldenShowerFriendly
  | ExplosiveBunny
  | VenomArrow
  | VenomBullet
  | PartyBullet
  | NanoBullet
  | ExplosiveBullet
  | GoldenBullet
  | GoldenShowerHostile
  | ConfettiFlaskofParty
  | ShadowBeamHostile
  | InfernoBoltHostile
  | InfernoBlastHostile
  | LostSoulHostile
  | ShadowBeamFriendly
  | InfernoBoltFriendly
  | InfernoBlastFriendly
  | LostSoulFriendly
  | SpiritHeal
  | Shadowflames
  | PaladinsHammerHostile
  | PaladinsHammerFriendly
  | SniperBullet
  | SkeletonCommandoRocket
  | VampireKnife
  | VampireHeal
  | EatersBite
  | TinyEater
  | FrostHydra
  | FrostBlast
  | BlueFlare
  | CandyCorn
  | JackOLantern
  | Spider
  | Squashling
  | BatHook
  | Bat
  | Raven
  | RottenEgg
  | BlackCat
  | BloodyMachete
  | FlamingJack
  | WoodHook
  | Stake
  | CursedSapling
  | FlamingWood
  | GreekFire1
  | GreekFire2
  | GreekFire3
  | FlamingScythe
  | StarAnise
  | CandyCaneHook
  | ChristmasHook
  | FruitcakeChakram
  | Puppy
  | OrnamentFriendly
  | PineNeedleFriendly
  | Blizzard
  | SnowmanRocketI
  | SnowmanRocketII
  | SnowmanRocketIII
  | SnowmanRocketIV
  | NorthPole
  | NorthPoleSpearProjectile
  | NorthPoleSnowFlake
  | PineNeedle
  | OrnamentHostile
  | OrnamentShrapnel
  | FrostWave
  | FrostShard
  | Missile
  | Present
  | Spike
  | BabyGrinch
  | CrimsandBallSandgun
  | VenomFang
  | SpectreWrath
  | PulseBolt
  | WaterGun
  | FrostBolt
  | WoodBobber
  | ReinforcedBobber
  | FiberglassBobber
  | FisherofSoulsBobber
  | GoldenBobber
  | MechanicsBobber
  | SittingDucksBobber
  | ObsidianSwordfish
  | Swordfish
  | SawtoothShark
  | LovePotion
  | FoulPotion
  | FishHook
  | Hornet
  | HornetStinger
  | FlyingImp
  | ImpFireball
  | SpiderTurret
  | SpiderEgg
  | BabySpider
  | ZephyrFish
  | FleshCatcherBobber
  | HotlineBobber
  | Anchor
  | Sharknado
  | SharknadoBolt
  | Cthulunado
  | Retanimini
  | Spazmamini
  | MiniRetinaLaser
  | VenomSpider
  | JumperSpider
  | DangerousSpider
  | OneEyedPirate
  | SoulscourgePirate
  | PirateCaptain
  | SlimeHook
  | StickyGrenade
  | MiniMinotaur
  | MolotovCocktail
  | MolotovFire1
  | MolotovFire2
  | MolotovFire3
  | TrackHook
  | Flairon
  | FlaironBubble
  | SlimeGun
  | Tempest
  | MiniSharkron
  | Typhoon
  | Bubble
  | CopperCoins
  | SilverCoins
  | GoldCoins
  | PlatinumCoins
  | FireWorkRocketRed
  | FireWorkRocketGreen
  | FireWorkRocketBlue
  | FireWorkRocketYellow
  | FireworkFountainYellow
  | FireworkFountainRed
  | FireworkFountainBlue
  | FireworkFountainRainbow
  | UFO
  | Meteor1
  | Meteor2
  | Meteor3
  | VortexChainsaw
  | VortexDrill
  | NebulaChainsaw
  | NebulaDrill
  | SolarFlareChainsaw
  | SolarFlareDrill
  | UFORay
  | ScutlixLaser
  | ElectricBolt
  | BrainScramblingBolt
  | GigazapperSpearhead
  | LaserRay
  | LaserMachinegun
  | LaserMachinegunLaser
  | ScutlixCrosshair
  | ElectrosphereMissile
  | Electrosphere
  | Xenopopper
  | LaserDrill
  | AntiGravityHook
  | MartianDeathray
  | MartianRocket
  | SaucerLaser
  | SaucerScrap
  | InfluxWaver
  | PhantasmalEye
  | DrillCrosshair
  | PhantasmalSphere
  | PhantasmalDeathray
  | MoonLeech
  | PhasicWarpEjector
  | PhasicWarpDisc
  | ChargedBlasterOrb
  | ChargedBlasterCannon
  | ChargedBlasterLaser
  | PhantasmalBolt
  | ViciousPowder
  | IceMist
  | LightningOrb
  | LightningOrbArc
  | CultistFireball
  | ShadowFireball
  | BeeArrow
  | StickyDynamite
  | SkeletonMerchantBone
  | Webspit
  | SpelunkerGlowstick
  | BoneArrowAmmo
  | VineRopeCoil
  | SoulDrain
  | CrystalDart
  | CursedDart
  | IchorDart
  | CursedFlameClingerStaff
  | ChainGuillotine
  | CursedFlames
  | SeedlerNut
  | SeedlerThorn
  | Hellwing
  | TendonHook
  | ThornHook
  | IlluminantHook
  | WormHook
  | LightningRitual
  | FlyingKnife
  | MagicLantern
  | CrystalVileShardHead
  | CrystalVileShardShaft
  | ShadowflameArrow
  | Shadowflame
  | ShadowflameKnife
  | NailHostile
  | BabyFaceMonster
  | CrimsonHeart
  | Flask
  | Meowmere
  | StarWrath
  | Spark
  | SilkRopeCoil
  | WebRopeCoil
  | JavelinFriendly
  | JavelinHostile
  | ButchersChainsaw
  | ToxicFlask
  | ToxicCloud1
  | ToxicCloud2
  | ToxicCloud3
  | Nail
  | BouncyGlowstick
  | BouncyBomb
  | BouncyGrenade
  | CoinPortal
  | BombFish
  | FrostDaggerfish
  | CrystalCharge1
  | CrystalCharge2
  | ToxicBubble
  | IchorSplash
  | FlyingPiggyBank
  | Energy
  | GoldenCrossGraveMarker
  | GoldenTombstone
  | GoldenGraveMarker
  | GoldenGraveStone
  | GoldenHeadStone
  | XBone
  | DeadlySphere
  | Code1
  | MedusaHead
  | MedusaHeadRay
  | StardustLaser
  | Twinkle
  | FlowInvader
  | Starmark
  | WoodenYoyo
  | Malaise
  | Artery
  | Amazon
  | Cascase
  | Chik
  | Code2
  | Rally
  | Yelets
  | RedsThrow
  | ValkyrieYoyo
  | Amarok
  | HelFire
  | Kraken
  | TheEyeofCthulhuYoyo
  | BLackCounterweight
  | BlueCounterweight
  | GreenCounterweight
  | PurpleCounterweight
  | RedCounterweight
  | YellowCounterweight
  | FormatC
  | Gradient
  | Valor
  | BrainofConfusion
  | GiantBee
  | SporeTrap
  | SporeTrap2
  | SporeGas1
  | SporeGas2
  | SporeGas3
  | PoisonSpit
  | NebulaPiercer
  | NebulaEye
  | NebulaSphere
  | NebulaLaser
  | VortexLaser
  | VortexLightningPillar
  | Vortex
  | VortexLightningPortal
  | AlienGoop
  | MechanicsWrench
  | SyringeDamage
  | SyringeHealing
  | SkullClothier
  | Dryadsward
  | Paintball
  | ConfettiGrenade
  | ChristmasOrnament
  | TruffleSpore
  | MinecartLaser
  | LaserRayMartianWalker
  | ProphecysEnd
  | BlowupSmokeFlyingDutchman
  | Arkhalis
  | DesertSpiritsCurse
  | AmberBolt
  | BoneJavelin
  | BoneDagger
  | PortalGun
  | PortalBolt
  | PortalGate
  | Terrarian
  | TerrarianBeam
  | SlimeSpike
  | Laser
  | SolarFlare
  | SolarRadiance
  | StardustDrill
  | StardustChainsaw
  | SolarEruption
  | SolarEruptionExplosion
  | StardustCell
  | StardustCellShot
  | VortexBeater
  | VortexRocket
  | NebulaArcanum
  | NebulaArcanumSubShot
  | NebulaArcanumExplosionShot
  | NebulaArcanumExplosionShotShard
  | BloodWater
  | BlowupSmoke
  | StardustGuardian
  | Starburst
  | StardustDragon1
  | StardustDragon2
  | StardustDragon3
  | StardustDragon4
  | ReleasedEnergy
  | Phantasm
  | PhantasmArrow
  | LastPrismLaser
  | LastPrism
  | NebulaBlaze
  | NebulaBlazeEx
  | Daybreak
  | BouncyDynamite
  | LuminiteBullet
  | LuminiteArrow
  | LuminiteArrowTrail
  | LunarPortal
  | LunarPortalLaser
  | RainbowCrystal
  | RainbowExplosion
  | LunarFlare
  | LunarHookSolar
  | LunarHookVortex
  | LunarHookNebula
  | LunarHookStardust
  | SuspiciousLookingTentacle
  | WireKite
  | StaticHook
  | CompanionCube
  | Geyser
  | BeeHive
  | AncientStormFriendly
  | AncientStormHostile
  | AncientStormMark
  | SpiritFlame
  | SkyFracture
  | OnyxBlaster
  | EtherianJavelinT1
  | FlameburstTower1
  | FlameburstTowerShot1
  | FlameburstTower2
  | FlameburstTowerShot2
  | FlameburstTower3
  | FlameburstTowerShot3
  | Ale
  | OgresStomp1
  | Drakin
  | GrimEnd
  | DarkSigil1
  | DarkSigil2
  | DarkEnergy
  | OgreSpit
  | Ballista1
  | Ballista2
  | Ballista3
  | BallistaShot
  | GoblinBomb
  | WitheringBolt
  | OgresStomp
  | HeartySlash
  | EtherianJavelinT3
  | BetsysFireball
  | BetsysBreath
  | LightningAura1
  | LightningAura2
  | LightningAura3
  | ExplosiveTrap1
  | ExplosiveTrap2
  | ExplosiveTrap3
  | ExplosiveTrapShot1
  | ExplosiveTrapShot2
  | ExplosiveTrapShot3
  | SleepyOctopod
  | PoleSmash
  | GhastlyGlaive
  | Ghast
  | Hoardagron
  | Flickerwick
  | PropellerGato
  | WhirlwindofInfiniteWisdom
  | PhantomPhoenix
  | PhantomPhoenixPheonix
  | SkyDragonsFury1
  | SkyDragonsFury2
  | SkyDragonsFuryShot
  | AerialBane
  | BetsysWrath
  | TomeofInfiniteWisdom
  | VictoryDD2
  | CelebrationMk2
  | Celeb2Rocket
  | Celeb2RocketExplosive
  | Celeb2RocketLarge
  | Celeb2RocketExplosiveLarge
  | QueenBeesStinger
  | FallingStarSpawnerAnimation
  | GolfBall
  | GolfClub
  | ManaCloak
  | BeeCloak
  | StarVeil
  | StarCloak
  | RollingCactus
  | SuperStarCannonStar
  | SuperStarCannonAnimation
  | StormSpear
  | ThunderZapper
  | StormSpearShot
  | ToiletEffect
  | VoidLens
  | Terragrim
  | DungeonDebrisBlue
  | DungeonDebrisGreen
  | DungeonDebrisPink
  | BlackGolfBall
  | BlueGolfBall
  | BrownGolfBall
  | CyanGolfBall
  | GreenGolfBall
  | LimeGolfBall
  | OrangeGolfBall
  | PinkGolfBall
  | PurpleGolfBall
  | RedGolfBall
  | SkyBlueGolfBall
  | TealGolfBall
  | VioletGolfBall
  | YellowGolfBall
  | AmberHook
  | MysticSnakeCoil
  | SanguineBat
  | BloodThorn
  | DripplerCrippler2
  | VampireFrog
  | Finch
  | BobberBloody
  | PaperAirplane
  | PaperAirplaneWhite
  | RollingCactusSpike
  | UpbeatStar
  | SugarGlider
  | KiteBlue
  | KiteBlueAndYellow
  | KiteRed
  | KiteRedAndYellow
  | KiteYellow
  | KiteWyvern
  | Geode
  | ScarabBomb
  | SharkPup
  | BobberScarab
  | ClusterRocketI
  | ClusterGrenadeI
  | ClusterProximityMineI
  | ClusterFragmentI
  | ClusterRocketII
  | ClusterGrenadeII
  | ClusterProximityMineII
  | ClusterFragmentII
  | WetRocket
  | WetGrenade
  | WetProximityMine
  | LavaRocket
  | LavaGrenade
  | LavaProximityMine
  | HoneyRocket
  | HoneyGrenade
  | HoneyProximityMine
  | MiniNukeRocketI
  | MiniNukeGrenadeI
  | MiniNukeProximityMineI
  | MiniNukeRocketII
  | MiniNukeGrenadeII
  | MiniNukeProximityMineII
  | DryRocket
  | DryGrenade
  | DryProximityMine
  | Gladius
  | ClusterSnowmanRocketI
  | ClusterSnowmanRocketII
  | WetSnowmanRocket
  | LavaSnowmanRocket
  | HoneySnowmanRocket
  | MiniNukeSnowmanRocketI
  | MiniNukeSnowmanRocketII
  | DrySnowmanRocket
  | BloodShot
  | ShellPile
  | BloodTears
  | BloodShotNautilus
  | LilHarpy
  | FennecFox
  | GlitteryButterfly
  | DesertTiger1
  | BloodRainArrow
  | ChumBucket
  | BabyImp
  | KiteBoneSerpent
  | KiteWorldFeeder
  | KiteBunny
  | BabyRedPanda
  | KitePigron
  | KiteManEater
  | KiteJellyfishBlue
  | KiteJellyfishPink
  | KiteShark
  | DesertTiger2
  | DesertTiger3
  | DesertTigerT1
  | DesertTigerT2
  | DesertTigerT3
  | DandelionSeed
  | BookofSkulls
  | KiteSandShark
  | KiteBunnyCorrupt
  | KiteBunnyCrimson
  | LeatherWhip
  | Ruler
  | KiteGoldfish
  | KiteAngryTrapper
  | KiteKoi
  | KiteCrawltipede
  | Durendal
  | MorningStar
  | DarkHarvest
  | KiteSpectrum
  | ReleaseDoves
  | KiteWanderingEye
  | KiteUnicorn
  | Plantero
  | ReleaseLantern
  | StellarTune
  | FirstFractal
  | DynamiteKitten
  | BabyWerewolf
  | ShadowMimic
  | Football
  | SnowmanClusterFragment1
  | SnowmanClusterFragment2
  | EnchantedDagger
  | SquirrelHook
  | SergeantUnitedShield
  | Shroomerang
  | TreeGlobe
  | WorldGlobe
  | FairyGlowstick
  | HallowBossSplitShotCore
  | EverlastingRainbow
  | PrismaticBolt
  | HallowBossDeathAurora
  | VoltBunny
  | Zapinator
  | JoustingLance
  | ShadowJoustingLance
  | HallowedJoustingLance
  | ZoologistStrikeGreen
  | KingSlimePet
  | EyeOfCthulhuPet
  | EaterOfWorldsPet
  | BrainOfCthulhuPet
  | SkeletronPet
  | QueenBeePet
  | DestroyerPet
  | TwinsPet
  | SkeletronPrimePet
  | PlanteraPet
  | GolemPet
  | DukeFishronPet
  | LunaticCultistPet
  | MoonLordPet
  | FairyQueenPet
  | PumpkingPet
  | EverscreamPet
  | IceQueenPet
  | MartianPet
  | DD2OgrePet
  | DD2BetsyPet
  | CombatWrench
  | WetBomb
  | LavaBomb
  | HoneyBomb
  | DryBomb
  | OrnamentTreeSword
  | TitaniumShard
  | Rock
  | DirtBomb
  | StickyDirtBomb
  | CoolWhip
  | FirecrackerWhip1
  | Snapthorn
  | Kaleidoscope
  | Reaping
  | CoolFlake
  | FirecrackerWhip2
  | EtherealLance
  | CrystalSpike
  | BouncyGel
  | QueenlySmash
  | SunDance
  | FairyQueenHymn
  | StardustGuardianPunch
  | RegalGel
  | Starlight
  | DripplerCrippler1
  | ZoologistStrikeRed
  | SantankRocket
  | Nightglow
  | TwilightLance
  | Zenith
  | QueenSlimePet
  | QueenSlimeHook
  | SparkleSlimeBalloon
  | VolatileGelatin
  | CopperShortsword
  | TinShortsword
  | IronShortsword
  | LeadShortsword
  | SilverShortsword
  | TungstenShortsword
  | GoldShortsword
  | PlatinumShortsword
  | Terraprisma
  | Mace
  | FlamingMace
  | TheTorchGod
  | PrincessWeapon
  | FlinxMinion
  | BoneWhip
  | DaybreakExplosion
  | WandOfSparkingSpark
  | StarCannonStar
  | BerniePet
  | GlommerPet
  | DeerclopsPet
  | PigPet
  | ChesterPet
  | DeerclopsIceSpike
  | DeerclopsRangedProjectile
  | AbigailMinion
  | InsanityShadowFriendly
  | InsanityShadowHostile
  | HoundiusShootius
  | HoundiusShootiusFireball
  | PewMaticHornShot
  | WeatherPainShot
  | AbigailCounter
  | TentacleSpike
  | NightsEdge
  | TrueNightsEdge
  | LightsBane
  | BloodButcherer
  | BladeOfGrass
  | Muramasa
  | Volcano
  | WandOfFrostingFrost
  | VenomDartTrap
  | SilverBullet
  | Excalibur
  | TrueExcalibur
  | TerraBlade2
  | TerraBlade2Shot
  | FishingBobber
  | FishingBobberGlowingStar
  | FishingBobberGlowingLava
  | FishingBobberGlowingKrypton
  | FishingBobberGlowingXenon
  | FishingBobberGlowingArgon
  | FishingBobberGlowingViolet
  | FishingBobberGlowingRainbow
  | JunimoPet
  | JuminoStardropAnimation
  | MoonGlobe
  | TheHorsemansBlade
  | BlueChickenPet
  | HiveFive
  | Trimarang
  | HorsemanPumpkin
  | TntBarrel
  | Spiffo
  | CavelingGardener
  | MiniBoulder
  | ShimmerArrow
  | GasTrap
  | SpelunkerFlare
  | CursedFlare
  | RainbowFlare
  | ShimmerFlare
  | Waffle
  | BouncyBoulder
  | LifeCrystalBoulder
  | SandSpray
  | SnowSpray
  | DirtSpray
  | DirtiestBlock
  | Fertilizer
  | JimsDrone
  | MoonBoulder

let toInt = (projectileType: t): int =>
  switch projectileType {
  | Empty => 0
  | WoodenArrowFriendly => 1
  | FlamingArrow => 2
  | Shuriken => 3
  | UnholyArrow => 4
  | JestersArrow => 5
  | EnchantedBoomerang => 6
  | VilethornBase => 7
  | VilethornTip => 8
  | Starfury => 9
  | PurificationPowder => 10
  | VilePowder => 11
  | FallingStar => 12
  | GrapplingHook => 13
  | OldSilverBullet => 14
  | BallofFire => 15
  | MagicMissile => 16
  | DirtBall => 17
  | ShadowOrb => 18
  | Flamarang => 19
  | GreenLaser => 20
  | Bone => 21
  | WaterStream => 22
  | Harpoon => 23
  | SpikyBallWeapon => 24
  | BallOHurt => 25
  | BlueMoon => 26
  | WaterBolt => 27
  | Bomb => 28
  | Dynamite => 29
  | Grenade => 30
  | SandBallFalling => 31
  | IvyWhip => 32
  | ThornChakram => 33
  | Flamelash => 34
  | Sunfury => 35
  | MeteorShot => 36
  | StickyBomb => 37
  | HarpyFeather => 38
  | MudBall => 39
  | AshBall => 40
  | HellfireArrow => 41
  | SandBallSandgun => 42
  | Tombstone => 43
  | DemonSickle => 44
  | DemonScythe => 45
  | DarkLance => 46
  | Trident => 47
  | ThrowingKnife => 48
  | Spear => 49
  | Glowstick => 50
  | Seed => 51
  | WoodenBoomerang => 52
  | StickyGlowstick => 53
  | PoisonedKnife => 54
  | Stinger => 55
  | EbonsandBallFalling => 56
  | CobaltChainsaw => 57
  | MythrilChainsaw => 58
  | CobaltDrill => 59
  | MythrilDrill => 60
  | AdamantiteChainsaw => 61
  | AdamantiteDrill => 62
  | TheDaoofPow => 63
  | MythrilHalberd => 64
  | EbonsandBallSandgun => 65
  | AdamantiteGlaive => 66
  | PearlSandBallFalling => 67
  | PearlSandBallSandgun => 68
  | HolyWater => 69
  | UnholyWater => 70
  | SiltBall => 71
  | BlueFairy => 72
  | DualHookBlue => 73
  | DualHookRed => 74
  | HappyBomb => 75
  | NoteQuarter => 76
  | NoteEight => 77
  | NoteTiedEighth => 78
  | Rainbow => 79
  | IceBlock => 80
  | WoodenArrowHostile => 81
  | FlamingArrowHostile => 82
  | EyeLaser => 83
  | PinkLaser => 84
  | Flames => 85
  | PinkFairy => 86
  | GreenFairy => 87
  | PurpleLaser => 88
  | CrystalBullet => 89
  | CrystalShard => 90
  | HolyArrow => 91
  | HallowStar => 92
  | MagicDagger => 93
  | CrystalStorm => 94
  | CursedFlameFriendly => 95
  | CursedFlameHostile => 96
  | CobaltNaginata => 97
  | PoisonDartTrap => 98
  | Boulder => 99
  | DeathLaser => 100
  | EyeFire => 101
  | SkeletronPrimeBomb => 102
  | CursedArrow => 103
  | CursedBullet => 104
  | Gungnir => 105
  | LightDisc => 106
  | Hamdrax => 107
  | Explosives => 108
  | SnowBall => 109
  | Bullet => 110
  | Bunny => 111
  | Penguin => 112
  | IceBoomerang => 113
  | UnholyTridentFriendly => 114
  | UnholyTridentHostile => 115
  | SwordBeam => 116
  | BoneArrowMarrow => 117
  | IceBolt => 118
  | FrostBoltFrostbrand => 119
  | FrostArrow => 120
  | AmethystBolt => 121
  | TopazBolt => 122
  | SapphireBolt => 123
  | EmeraldBolt => 124
  | RubyBolt => 125
  | DiamondBolt => 126
  | Turtle => 127
  | FrostBlastHostile => 128
  | RuneBlast => 129
  | MushroomSpear => 130
  | Mushroom => 131
  | TerraBeam => 132
  | GrenadeI => 133
  | RocketI => 134
  | ProximityMineI => 135
  | GrenadeII => 136
  | RocketII => 137
  | ProximityMineII => 138
  | GrenadeIII => 139
  | RocketIII => 140
  | ProximityMineIII => 141
  | GrenadeIV => 142
  | RocketIV => 143
  | ProximityMineIV => 144
  | PureSpray => 145
  | HallowSpray => 146
  | CorruptSpray => 147
  | MushroomSpray => 148
  | CrimsonSpray => 149
  | NettleBurstRight => 150
  | NettleBurstLeft => 151
  | NettleBurstEnd => 152
  | TheRottedFork => 153
  | TheMeatball => 154
  | BeachBall => 155
  | LightBeam => 156
  | NightBeam => 157
  | CopperCoin => 158
  | SilverCoin => 159
  | GoldCoin => 160
  | PlatinumCoin => 161
  | CannonballFriendly => 162
  | Flare => 163
  | Landmine => 164
  | Web => 165
  | SnowBallFriendly => 166
  | RedFireworkRocket => 167
  | GreenFireworkRocket => 168
  | BlueFireworkRocket => 169
  | YellowFireworkRocket => 170
  | RopeCoil => 171
  | FrostburnArrow => 172
  | EnchantedBeam => 173
  | IceSpike => 174
  | BabyEater => 175
  | JungleSpike => 176
  | IcewaterSpit => 177
  | ConfettiGun => 178
  | SlushBall => 179
  | BulletDeadeye => 180
  | Bee => 181
  | PossessedHatchet => 182
  | Beenade => 183
  | PoisonDartSuperDartTrap => 184
  | SpikyBallTrap => 185
  | SpearTrap => 186
  | FlamethrowerTrap => 187
  | FlameTrapFlames => 188
  | Wasp => 189
  | MechanicalPiranha => 190
  | Pygmy1 => 191
  | Pygmy2 => 192
  | Pygmy3 => 193
  | Pygmy4 => 194
  | Pygmy5 => 195
  | SmokeBomb => 196
  | BabySkeletronHead => 197
  | BabyHornet => 198
  | TikiSpirit => 199
  | PetLizard => 200
  | GraveMarker => 201
  | CrossGraveMarker => 202
  | HeadStone => 203
  | GraveStone => 204
  | Obelisk => 205
  | Leaf => 206
  | ChlorophyteBullet => 207
  | Parrot => 208
  | Truffle => 209
  | Sapling => 210
  | Wisp => 211
  | PalladiumPike => 212
  | PalladiumDrill => 213
  | PalladiumChainsaw => 214
  | OrichalcumHalberd => 215
  | OrichalcumDrill => 216
  | OrichalcumChainsaw => 217
  | TitaniumTrident => 218
  | TitaniumDrill => 219
  | TitaniumChainsaw => 220
  | FlowerPetal => 221
  | ChlorophytePartisan => 222
  | ChlorophyteDrill => 223
  | ChlorophyteChainsaw => 224
  | ChlorophyteArrow => 225
  | CrystalLeaf => 226
  | CrystalLeafShot => 227
  | SporeCloud => 228
  | ChlorophyteOrb => 229
  | AmethystHook => 230
  | TopazHook => 231
  | SapphireHook => 232
  | EmeraldHook => 233
  | RubyHook => 234
  | DiamondHook => 235
  | BabyDino => 236
  | RainCloudMoving => 237
  | RainCloudRaining => 238
  | RainFriendly => 239
  | Cannonball => 240
  | CrimsandBallFalling => 241
  | HighVelocityBullet => 242
  | BloodCloudMoving => 243
  | BloodCloudRaining => 244
  | BloodRain => 245
  | StyngerBolt => 246
  | FlowerPow => 247
  | FlowerPowPetal => 248
  | StyngerBoltShrapnel => 249
  | RainbowFront => 250
  | RainbowBack => 251
  | ChlorophyteJackhammer => 252
  | BallofFrost => 253
  | MagnetSphereBall => 254
  | MagnetSphereBolt => 255
  | SkeletronHand => 256
  | FrostBeam => 257
  | Fireball => 258
  | EyeBeam => 259
  | HeatRay => 260
  | BoulderStaffofEarth => 261
  | GolemFist => 262
  | IceSickle => 263
  | Rain => 264
  | PoisonFang => 265
  | BabySlime => 266
  | PoisonDartWeapon => 267
  | EyeSpring => 268
  | BabySnowman => 269
  | Skull => 270
  | BoxingGlove => 271
  | Bananarang => 272
  | ChainKnife => 273
  | DeathSickle => 274
  | PlanteraSeed => 275
  | PoisonSeed => 276
  | ThornBall => 277
  | IchorArrow => 278
  | IchorBullet => 279
  | GoldenShowerFriendly => 280
  | ExplosiveBunny => 281
  | VenomArrow => 282
  | VenomBullet => 283
  | PartyBullet => 284
  | NanoBullet => 285
  | ExplosiveBullet => 286
  | GoldenBullet => 287
  | GoldenShowerHostile => 288
  | ConfettiFlaskofParty => 289
  | ShadowBeamHostile => 290
  | InfernoBoltHostile => 291
  | InfernoBlastHostile => 292
  | LostSoulHostile => 293
  | ShadowBeamFriendly => 294
  | InfernoBoltFriendly => 295
  | InfernoBlastFriendly => 296
  | LostSoulFriendly => 297
  | SpiritHeal => 298
  | Shadowflames => 299
  | PaladinsHammerHostile => 300
  | PaladinsHammerFriendly => 301
  | SniperBullet => 302
  | SkeletonCommandoRocket => 303
  | VampireKnife => 304
  | VampireHeal => 305
  | EatersBite => 306
  | TinyEater => 307
  | FrostHydra => 308
  | FrostBlast => 309
  | BlueFlare => 310
  | CandyCorn => 311
  | JackOLantern => 312
  | Spider => 313
  | Squashling => 314
  | BatHook => 315
  | Bat => 316
  | Raven => 317
  | RottenEgg => 318
  | BlackCat => 319
  | BloodyMachete => 320
  | FlamingJack => 321
  | WoodHook => 322
  | Stake => 323
  | CursedSapling => 324
  | FlamingWood => 325
  | GreekFire1 => 326
  | GreekFire2 => 327
  | GreekFire3 => 328
  | FlamingScythe => 329
  | StarAnise => 330
  | CandyCaneHook => 331
  | ChristmasHook => 332
  | FruitcakeChakram => 333
  | Puppy => 334
  | OrnamentFriendly => 335
  | PineNeedleFriendly => 336
  | Blizzard => 337
  | SnowmanRocketI => 338
  | SnowmanRocketII => 339
  | SnowmanRocketIII => 340
  | SnowmanRocketIV => 341
  | NorthPole => 342
  | NorthPoleSpearProjectile => 343
  | NorthPoleSnowFlake => 344
  | PineNeedle => 345
  | OrnamentHostile => 346
  | OrnamentShrapnel => 347
  | FrostWave => 348
  | FrostShard => 349
  | Missile => 350
  | Present => 351
  | Spike => 352
  | BabyGrinch => 353
  | CrimsandBallSandgun => 354
  | VenomFang => 355
  | SpectreWrath => 356
  | PulseBolt => 357
  | WaterGun => 358
  | FrostBolt => 359
  | WoodBobber => 360
  | ReinforcedBobber => 361
  | FiberglassBobber => 362
  | FisherofSoulsBobber => 363
  | GoldenBobber => 364
  | MechanicsBobber => 365
  | SittingDucksBobber => 366
  | ObsidianSwordfish => 367
  | Swordfish => 368
  | SawtoothShark => 369
  | LovePotion => 370
  | FoulPotion => 371
  | FishHook => 372
  | Hornet => 373
  | HornetStinger => 374
  | FlyingImp => 375
  | ImpFireball => 376
  | SpiderTurret => 377
  | SpiderEgg => 378
  | BabySpider => 379
  | ZephyrFish => 380
  | FleshCatcherBobber => 381
  | HotlineBobber => 382
  | Anchor => 383
  | Sharknado => 384
  | SharknadoBolt => 385
  | Cthulunado => 386
  | Retanimini => 387
  | Spazmamini => 388
  | MiniRetinaLaser => 389
  | VenomSpider => 390
  | JumperSpider => 391
  | DangerousSpider => 392
  | OneEyedPirate => 393
  | SoulscourgePirate => 394
  | PirateCaptain => 395
  | SlimeHook => 396
  | StickyGrenade => 397
  | MiniMinotaur => 398
  | MolotovCocktail => 399
  | MolotovFire1 => 400
  | MolotovFire2 => 401
  | MolotovFire3 => 402
  | TrackHook => 403
  | Flairon => 404
  | FlaironBubble => 405
  | SlimeGun => 406
  | Tempest => 407
  | MiniSharkron => 408
  | Typhoon => 409
  | Bubble => 410
  | CopperCoins => 411
  | SilverCoins => 412
  | GoldCoins => 413
  | PlatinumCoins => 414
  | FireWorkRocketRed => 415
  | FireWorkRocketGreen => 416
  | FireWorkRocketBlue => 417
  | FireWorkRocketYellow => 418
  | FireworkFountainYellow => 419
  | FireworkFountainRed => 420
  | FireworkFountainBlue => 421
  | FireworkFountainRainbow => 422
  | UFO => 423
  | Meteor1 => 424
  | Meteor2 => 425
  | Meteor3 => 426
  | VortexChainsaw => 427
  | VortexDrill => 428
  | NebulaChainsaw => 429
  | NebulaDrill => 430
  | SolarFlareChainsaw => 431
  | SolarFlareDrill => 432
  | UFORay => 433
  | ScutlixLaser => 434
  | ElectricBolt => 435
  | BrainScramblingBolt => 436
  | GigazapperSpearhead => 437
  | LaserRay => 438
  | LaserMachinegun => 439
  | LaserMachinegunLaser => 440
  | ScutlixCrosshair => 441
  | ElectrosphereMissile => 442
  | Electrosphere => 443
  | Xenopopper => 444
  | LaserDrill => 445
  | AntiGravityHook => 446
  | MartianDeathray => 447
  | MartianRocket => 448
  | SaucerLaser => 449
  | SaucerScrap => 450
  | InfluxWaver => 451
  | PhantasmalEye => 452
  | DrillCrosshair => 453
  | PhantasmalSphere => 454
  | PhantasmalDeathray => 455
  | MoonLeech => 456
  | PhasicWarpEjector => 457
  | PhasicWarpDisc => 458
  | ChargedBlasterOrb => 459
  | ChargedBlasterCannon => 460
  | ChargedBlasterLaser => 461
  | PhantasmalBolt => 462
  | ViciousPowder => 463
  | IceMist => 464
  | LightningOrb => 465
  | LightningOrbArc => 466
  | CultistFireball => 467
  | ShadowFireball => 468
  | BeeArrow => 469
  | StickyDynamite => 470
  | SkeletonMerchantBone => 471
  | Webspit => 472
  | SpelunkerGlowstick => 473
  | BoneArrowAmmo => 474
  | VineRopeCoil => 475
  | SoulDrain => 476
  | CrystalDart => 477
  | CursedDart => 478
  | IchorDart => 479
  | CursedFlameClingerStaff => 480
  | ChainGuillotine => 481
  | CursedFlames => 482
  | SeedlerNut => 483
  | SeedlerThorn => 484
  | Hellwing => 485
  | TendonHook => 486
  | ThornHook => 487
  | IlluminantHook => 488
  | WormHook => 489
  | LightningRitual => 490
  | FlyingKnife => 491
  | MagicLantern => 492
  | CrystalVileShardHead => 493
  | CrystalVileShardShaft => 494
  | ShadowflameArrow => 495
  | Shadowflame => 496
  | ShadowflameKnife => 497
  | NailHostile => 498
  | BabyFaceMonster => 499
  | CrimsonHeart => 500
  | Flask => 501
  | Meowmere => 502
  | StarWrath => 503
  | Spark => 504
  | SilkRopeCoil => 505
  | WebRopeCoil => 506
  | JavelinFriendly => 507
  | JavelinHostile => 508
  | ButchersChainsaw => 509
  | ToxicFlask => 510
  | ToxicCloud1 => 511
  | ToxicCloud2 => 512
  | ToxicCloud3 => 513
  | Nail => 514
  | BouncyGlowstick => 515
  | BouncyBomb => 516
  | BouncyGrenade => 517
  | CoinPortal => 518
  | BombFish => 519
  | FrostDaggerfish => 520
  | CrystalCharge1 => 521
  | CrystalCharge2 => 522
  | ToxicBubble => 523
  | IchorSplash => 524
  | FlyingPiggyBank => 525
  | Energy => 526
  | GoldenCrossGraveMarker => 527
  | GoldenTombstone => 528
  | GoldenGraveMarker => 529
  | GoldenGraveStone => 530
  | GoldenHeadStone => 531
  | XBone => 532
  | DeadlySphere => 533
  | Code1 => 534
  | MedusaHead => 535
  | MedusaHeadRay => 536
  | StardustLaser => 537
  | Twinkle => 538
  | FlowInvader => 539
  | Starmark => 540
  | WoodenYoyo => 541
  | Malaise => 542
  | Artery => 543
  | Amazon => 544
  | Cascase => 545
  | Chik => 546
  | Code2 => 547
  | Rally => 548
  | Yelets => 549
  | RedsThrow => 550
  | ValkyrieYoyo => 551
  | Amarok => 552
  | HelFire => 553
  | Kraken => 554
  | TheEyeofCthulhuYoyo => 555
  | BLackCounterweight => 556
  | BlueCounterweight => 557
  | GreenCounterweight => 558
  | PurpleCounterweight => 559
  | RedCounterweight => 560
  | YellowCounterweight => 561
  | FormatC => 562
  | Gradient => 563
  | Valor => 564
  | BrainofConfusion => 565
  | GiantBee => 566
  | SporeTrap => 567
  | SporeTrap2 => 568
  | SporeGas1 => 569
  | SporeGas2 => 570
  | SporeGas3 => 571
  | PoisonSpit => 572
  | NebulaPiercer => 573
  | NebulaEye => 574
  | NebulaSphere => 575
  | NebulaLaser => 576
  | VortexLaser => 577
  | VortexLightningPillar => 578
  | Vortex => 579
  | VortexLightningPortal => 580
  | AlienGoop => 581
  | MechanicsWrench => 582
  | SyringeDamage => 583
  | SyringeHealing => 584
  | SkullClothier => 585
  | Dryadsward => 586
  | Paintball => 587
  | ConfettiGrenade => 588
  | ChristmasOrnament => 589
  | TruffleSpore => 590
  | MinecartLaser => 591
  | LaserRayMartianWalker => 592
  | ProphecysEnd => 593
  | BlowupSmokeFlyingDutchman => 594
  | Arkhalis => 595
  | DesertSpiritsCurse => 596
  | AmberBolt => 597
  | BoneJavelin => 598
  | BoneDagger => 599
  | PortalGun => 600
  | PortalBolt => 601
  | PortalGate => 602
  | Terrarian => 603
  | TerrarianBeam => 604
  | SlimeSpike => 605
  | Laser => 606
  | SolarFlare => 607
  | SolarRadiance => 608
  | StardustDrill => 609
  | StardustChainsaw => 610
  | SolarEruption => 611
  | SolarEruptionExplosion => 612
  | StardustCell => 613
  | StardustCellShot => 614
  | VortexBeater => 615
  | VortexRocket => 616
  | NebulaArcanum => 617
  | NebulaArcanumSubShot => 618
  | NebulaArcanumExplosionShot => 619
  | NebulaArcanumExplosionShotShard => 620
  | BloodWater => 621
  | BlowupSmoke => 622
  | StardustGuardian => 623
  | Starburst => 624
  | StardustDragon1 => 625
  | StardustDragon2 => 626
  | StardustDragon3 => 627
  | StardustDragon4 => 628
  | ReleasedEnergy => 629
  | Phantasm => 630
  | PhantasmArrow => 631
  | LastPrismLaser => 632
  | LastPrism => 633
  | NebulaBlaze => 634
  | NebulaBlazeEx => 635
  | Daybreak => 636
  | BouncyDynamite => 637
  | LuminiteBullet => 638
  | LuminiteArrow => 639
  | LuminiteArrowTrail => 640
  | LunarPortal => 641
  | LunarPortalLaser => 642
  | RainbowCrystal => 643
  | RainbowExplosion => 644
  | LunarFlare => 645
  | LunarHookSolar => 646
  | LunarHookVortex => 647
  | LunarHookNebula => 648
  | LunarHookStardust => 649
  | SuspiciousLookingTentacle => 650
  | WireKite => 651
  | StaticHook => 652
  | CompanionCube => 653
  | Geyser => 654
  | BeeHive => 655
  | AncientStormFriendly => 656
  | AncientStormHostile => 657
  | AncientStormMark => 658
  | SpiritFlame => 659
  | SkyFracture => 660
  | OnyxBlaster => 661
  | EtherianJavelinT1 => 662
  | FlameburstTower1 => 663
  | FlameburstTowerShot1 => 664
  | FlameburstTower2 => 665
  | FlameburstTowerShot2 => 666
  | FlameburstTower3 => 667
  | FlameburstTowerShot3 => 668
  | Ale => 669
  | OgresStomp1 => 670
  | Drakin => 671
  | GrimEnd => 672
  | DarkSigil1 => 673
  | DarkSigil2 => 674
  | DarkEnergy => 675
  | OgreSpit => 676
  | Ballista1 => 677
  | Ballista2 => 678
  | Ballista3 => 679
  | BallistaShot => 680
  | GoblinBomb => 681
  | WitheringBolt => 682
  | OgresStomp => 683
  | HeartySlash => 684
  | EtherianJavelinT3 => 685
  | BetsysFireball => 686
  | BetsysBreath => 687
  | LightningAura1 => 688
  | LightningAura2 => 689
  | LightningAura3 => 690
  | ExplosiveTrap1 => 691
  | ExplosiveTrap2 => 692
  | ExplosiveTrap3 => 693
  | ExplosiveTrapShot1 => 694
  | ExplosiveTrapShot2 => 695
  | ExplosiveTrapShot3 => 696
  | SleepyOctopod => 697
  | PoleSmash => 698
  | GhastlyGlaive => 699
  | Ghast => 700
  | Hoardagron => 701
  | Flickerwick => 702
  | PropellerGato => 703
  | WhirlwindofInfiniteWisdom => 704
  | PhantomPhoenix => 705
  | PhantomPhoenixPheonix => 706
  | SkyDragonsFury1 => 707
  | SkyDragonsFury2 => 708
  | SkyDragonsFuryShot => 709
  | AerialBane => 710
  | BetsysWrath => 711
  | TomeofInfiniteWisdom => 712
  | VictoryDD2 => 713
  | CelebrationMk2 => 714
  | Celeb2Rocket => 715
  | Celeb2RocketExplosive => 716
  | Celeb2RocketLarge => 717
  | Celeb2RocketExplosiveLarge => 718
  | QueenBeesStinger => 719
  | FallingStarSpawnerAnimation => 720
  | GolfBall => 721
  | GolfClub => 722
  | ManaCloak => 723
  | BeeCloak => 724
  | StarVeil => 725
  | StarCloak => 726
  | RollingCactus => 727
  | SuperStarCannonStar => 728
  | SuperStarCannonAnimation => 729
  | StormSpear => 730
  | ThunderZapper => 731
  | StormSpearShot => 732
  | ToiletEffect => 733
  | VoidLens => 734
  | Terragrim => 735
  | DungeonDebrisBlue => 736
  | DungeonDebrisGreen => 737
  | DungeonDebrisPink => 738
  | BlackGolfBall => 739
  | BlueGolfBall => 740
  | BrownGolfBall => 741
  | CyanGolfBall => 742
  | GreenGolfBall => 743
  | LimeGolfBall => 744
  | OrangeGolfBall => 745
  | PinkGolfBall => 746
  | PurpleGolfBall => 747
  | RedGolfBall => 748
  | SkyBlueGolfBall => 749
  | TealGolfBall => 750
  | VioletGolfBall => 751
  | YellowGolfBall => 752
  | AmberHook => 753
  | MysticSnakeCoil => 754
  | SanguineBat => 755
  | BloodThorn => 756
  | DripplerCrippler2 => 757
  | VampireFrog => 758
  | Finch => 759
  | BobberBloody => 760
  | PaperAirplane => 761
  | PaperAirplaneWhite => 762
  | RollingCactusSpike => 763
  | UpbeatStar => 764
  | SugarGlider => 765
  | KiteBlue => 766
  | KiteBlueAndYellow => 767
  | KiteRed => 768
  | KiteRedAndYellow => 769
  | KiteYellow => 770
  | KiteWyvern => 771
  | Geode => 772
  | ScarabBomb => 773
  | SharkPup => 774
  | BobberScarab => 775
  | ClusterRocketI => 776
  | ClusterGrenadeI => 777
  | ClusterProximityMineI => 778
  | ClusterFragmentI => 779
  | ClusterRocketII => 780
  | ClusterGrenadeII => 781
  | ClusterProximityMineII => 782
  | ClusterFragmentII => 783
  | WetRocket => 784
  | WetGrenade => 785
  | WetProximityMine => 786
  | LavaRocket => 787
  | LavaGrenade => 788
  | LavaProximityMine => 789
  | HoneyRocket => 790
  | HoneyGrenade => 791
  | HoneyProximityMine => 792
  | MiniNukeRocketI => 793
  | MiniNukeGrenadeI => 794
  | MiniNukeProximityMineI => 795
  | MiniNukeRocketII => 796
  | MiniNukeGrenadeII => 797
  | MiniNukeProximityMineII => 798
  | DryRocket => 799
  | DryGrenade => 800
  | DryProximityMine => 801
  | Gladius => 802
  | ClusterSnowmanRocketI => 803
  | ClusterSnowmanRocketII => 804
  | WetSnowmanRocket => 805
  | LavaSnowmanRocket => 806
  | HoneySnowmanRocket => 807
  | MiniNukeSnowmanRocketI => 808
  | MiniNukeSnowmanRocketII => 809
  | DrySnowmanRocket => 810
  | BloodShot => 811
  | ShellPile => 812
  | BloodTears => 813
  | BloodShotNautilus => 814
  | LilHarpy => 815
  | FennecFox => 816
  | GlitteryButterfly => 817
  | DesertTiger1 => 818
  | BloodRainArrow => 819
  | ChumBucket => 820
  | BabyImp => 821
  | KiteBoneSerpent => 822
  | KiteWorldFeeder => 823
  | KiteBunny => 824
  | BabyRedPanda => 825
  | KitePigron => 826
  | KiteManEater => 827
  | KiteJellyfishBlue => 828
  | KiteJellyfishPink => 829
  | KiteShark => 830
  | DesertTiger2 => 831
  | DesertTiger3 => 832
  | DesertTigerT1 => 833
  | DesertTigerT2 => 834
  | DesertTigerT3 => 835
  | DandelionSeed => 836
  | BookofSkulls => 837
  | KiteSandShark => 838
  | KiteBunnyCorrupt => 839
  | KiteBunnyCrimson => 840
  | LeatherWhip => 841
  | Ruler => 842
  | KiteGoldfish => 843
  | KiteAngryTrapper => 844
  | KiteKoi => 845
  | KiteCrawltipede => 846
  | Durendal => 847
  | MorningStar => 848
  | DarkHarvest => 849
  | KiteSpectrum => 850
  | ReleaseDoves => 851
  | KiteWanderingEye => 852
  | KiteUnicorn => 853
  | Plantero => 854
  | ReleaseLantern => 855
  | StellarTune => 856
  | FirstFractal => 857
  | DynamiteKitten => 858
  | BabyWerewolf => 859
  | ShadowMimic => 860
  | Football => 861
  | SnowmanClusterFragment1 => 862
  | SnowmanClusterFragment2 => 863
  | EnchantedDagger => 864
  | SquirrelHook => 865
  | SergeantUnitedShield => 866
  | Shroomerang => 867
  | TreeGlobe => 868
  | WorldGlobe => 869
  | FairyGlowstick => 870
  | HallowBossSplitShotCore => 871
  | EverlastingRainbow => 872
  | PrismaticBolt => 873
  | HallowBossDeathAurora => 874
  | VoltBunny => 875
  | Zapinator => 876
  | JoustingLance => 877
  | ShadowJoustingLance => 878
  | HallowedJoustingLance => 879
  | ZoologistStrikeGreen => 880
  | KingSlimePet => 881
  | EyeOfCthulhuPet => 882
  | EaterOfWorldsPet => 883
  | BrainOfCthulhuPet => 884
  | SkeletronPet => 885
  | QueenBeePet => 886
  | DestroyerPet => 887
  | TwinsPet => 888
  | SkeletronPrimePet => 889
  | PlanteraPet => 890
  | GolemPet => 891
  | DukeFishronPet => 892
  | LunaticCultistPet => 893
  | MoonLordPet => 894
  | FairyQueenPet => 895
  | PumpkingPet => 896
  | EverscreamPet => 897
  | IceQueenPet => 898
  | MartianPet => 899
  | DD2OgrePet => 900
  | DD2BetsyPet => 901
  | CombatWrench => 902
  | WetBomb => 903
  | LavaBomb => 904
  | HoneyBomb => 905
  | DryBomb => 906
  | OrnamentTreeSword => 907
  | TitaniumShard => 908
  | Rock => 909
  | DirtBomb => 910
  | StickyDirtBomb => 911
  | CoolWhip => 912
  | FirecrackerWhip1 => 913
  | Snapthorn => 914
  | Kaleidoscope => 915
  | Reaping => 916
  | CoolFlake => 917
  | FirecrackerWhip2 => 918
  | EtherealLance => 919
  | CrystalSpike => 920
  | BouncyGel => 921
  | QueenlySmash => 922
  | SunDance => 923
  | FairyQueenHymn => 924
  | StardustGuardianPunch => 925
  | RegalGel => 926
  | Starlight => 927
  | DripplerCrippler1 => 928
  | ZoologistStrikeRed => 929
  | SantankRocket => 930
  | Nightglow => 931
  | TwilightLance => 932
  | Zenith => 933
  | QueenSlimePet => 934
  | QueenSlimeHook => 935
  | SparkleSlimeBalloon => 936
  | VolatileGelatin => 937
  | CopperShortsword => 938
  | TinShortsword => 939
  | IronShortsword => 940
  | LeadShortsword => 941
  | SilverShortsword => 942
  | TungstenShortsword => 943
  | GoldShortsword => 944
  | PlatinumShortsword => 945
  | Terraprisma => 946
  | Mace => 947
  | FlamingMace => 948
  | TheTorchGod => 949
  | PrincessWeapon => 950
  | FlinxMinion => 951
  | BoneWhip => 952
  | DaybreakExplosion => 953
  | WandOfSparkingSpark => 954
  | StarCannonStar => 955
  | BerniePet => 956
  | GlommerPet => 957
  | DeerclopsPet => 958
  | PigPet => 959
  | ChesterPet => 960
  | DeerclopsIceSpike => 961
  | DeerclopsRangedProjectile => 962
  | AbigailMinion => 963
  | InsanityShadowFriendly => 964
  | InsanityShadowHostile => 965
  | HoundiusShootius => 966
  | HoundiusShootiusFireball => 967
  | PewMaticHornShot => 968
  | WeatherPainShot => 969
  | AbigailCounter => 970
  | TentacleSpike => 971
  | NightsEdge => 972
  | TrueNightsEdge => 973
  | LightsBane => 974
  | BloodButcherer => 975
  | BladeOfGrass => 976
  | Muramasa => 977
  | Volcano => 978
  | WandOfFrostingFrost => 979
  | VenomDartTrap => 980
  | SilverBullet => 981
  | Excalibur => 982
  | TrueExcalibur => 983
  | TerraBlade2 => 984
  | TerraBlade2Shot => 985
  | FishingBobber => 986
  | FishingBobberGlowingStar => 987
  | FishingBobberGlowingLava => 988
  | FishingBobberGlowingKrypton => 989
  | FishingBobberGlowingXenon => 990
  | FishingBobberGlowingArgon => 991
  | FishingBobberGlowingViolet => 992
  | FishingBobberGlowingRainbow => 993
  | JunimoPet => 994
  | JuminoStardropAnimation => 995
  | MoonGlobe => 996
  | TheHorsemansBlade => 997
  | BlueChickenPet => 998
  | HiveFive => 999
  | Trimarang => 1000
  | HorsemanPumpkin => 1001
  | TntBarrel => 1002
  | Spiffo => 1003
  | CavelingGardener => 1004
  | MiniBoulder => 1005
  | ShimmerArrow => 1006
  | GasTrap => 1007
  | SpelunkerFlare => 1008
  | CursedFlare => 1009
  | RainbowFlare => 1010
  | ShimmerFlare => 1011
  | Waffle => 1012
  | BouncyBoulder => 1013
  | LifeCrystalBoulder => 1014
  | SandSpray => 1015
  | SnowSpray => 1016
  | DirtSpray => 1017
  | DirtiestBlock => 1018
  | Fertilizer => 1019
  | JimsDrone => 1020
  | MoonBoulder => 1021
  }

let fromInt = (projectileType: int): option<t> =>
  switch projectileType {
  | 0 => Some(Empty)
  | 1 => Some(WoodenArrowFriendly)
  | 2 => Some(FlamingArrow)
  | 3 => Some(Shuriken)
  | 4 => Some(UnholyArrow)
  | 5 => Some(JestersArrow)
  | 6 => Some(EnchantedBoomerang)
  | 7 => Some(VilethornBase)
  | 8 => Some(VilethornTip)
  | 9 => Some(Starfury)
  | 10 => Some(PurificationPowder)
  | 11 => Some(VilePowder)
  | 12 => Some(FallingStar)
  | 13 => Some(GrapplingHook)
  | 14 => Some(OldSilverBullet)
  | 15 => Some(BallofFire)
  | 16 => Some(MagicMissile)
  | 17 => Some(DirtBall)
  | 18 => Some(ShadowOrb)
  | 19 => Some(Flamarang)
  | 20 => Some(GreenLaser)
  | 21 => Some(Bone)
  | 22 => Some(WaterStream)
  | 23 => Some(Harpoon)
  | 24 => Some(SpikyBallWeapon)
  | 25 => Some(BallOHurt)
  | 26 => Some(BlueMoon)
  | 27 => Some(WaterBolt)
  | 28 => Some(Bomb)
  | 29 => Some(Dynamite)
  | 30 => Some(Grenade)
  | 31 => Some(SandBallFalling)
  | 32 => Some(IvyWhip)
  | 33 => Some(ThornChakram)
  | 34 => Some(Flamelash)
  | 35 => Some(Sunfury)
  | 36 => Some(MeteorShot)
  | 37 => Some(StickyBomb)
  | 38 => Some(HarpyFeather)
  | 39 => Some(MudBall)
  | 40 => Some(AshBall)
  | 41 => Some(HellfireArrow)
  | 42 => Some(SandBallSandgun)
  | 43 => Some(Tombstone)
  | 44 => Some(DemonSickle)
  | 45 => Some(DemonScythe)
  | 46 => Some(DarkLance)
  | 47 => Some(Trident)
  | 48 => Some(ThrowingKnife)
  | 49 => Some(Spear)
  | 50 => Some(Glowstick)
  | 51 => Some(Seed)
  | 52 => Some(WoodenBoomerang)
  | 53 => Some(StickyGlowstick)
  | 54 => Some(PoisonedKnife)
  | 55 => Some(Stinger)
  | 56 => Some(EbonsandBallFalling)
  | 57 => Some(CobaltChainsaw)
  | 58 => Some(MythrilChainsaw)
  | 59 => Some(CobaltDrill)
  | 60 => Some(MythrilDrill)
  | 61 => Some(AdamantiteChainsaw)
  | 62 => Some(AdamantiteDrill)
  | 63 => Some(TheDaoofPow)
  | 64 => Some(MythrilHalberd)
  | 65 => Some(EbonsandBallSandgun)
  | 66 => Some(AdamantiteGlaive)
  | 67 => Some(PearlSandBallFalling)
  | 68 => Some(PearlSandBallSandgun)
  | 69 => Some(HolyWater)
  | 70 => Some(UnholyWater)
  | 71 => Some(SiltBall)
  | 72 => Some(BlueFairy)
  | 73 => Some(DualHookBlue)
  | 74 => Some(DualHookRed)
  | 75 => Some(HappyBomb)
  | 76 => Some(NoteQuarter)
  | 77 => Some(NoteEight)
  | 78 => Some(NoteTiedEighth)
  | 79 => Some(Rainbow)
  | 80 => Some(IceBlock)
  | 81 => Some(WoodenArrowHostile)
  | 82 => Some(FlamingArrowHostile)
  | 83 => Some(EyeLaser)
  | 84 => Some(PinkLaser)
  | 85 => Some(Flames)
  | 86 => Some(PinkFairy)
  | 87 => Some(GreenFairy)
  | 88 => Some(PurpleLaser)
  | 89 => Some(CrystalBullet)
  | 90 => Some(CrystalShard)
  | 91 => Some(HolyArrow)
  | 92 => Some(HallowStar)
  | 93 => Some(MagicDagger)
  | 94 => Some(CrystalStorm)
  | 95 => Some(CursedFlameFriendly)
  | 96 => Some(CursedFlameHostile)
  | 97 => Some(CobaltNaginata)
  | 98 => Some(PoisonDartTrap)
  | 99 => Some(Boulder)
  | 100 => Some(DeathLaser)
  | 101 => Some(EyeFire)
  | 102 => Some(SkeletronPrimeBomb)
  | 103 => Some(CursedArrow)
  | 104 => Some(CursedBullet)
  | 105 => Some(Gungnir)
  | 106 => Some(LightDisc)
  | 107 => Some(Hamdrax)
  | 108 => Some(Explosives)
  | 109 => Some(SnowBall)
  | 110 => Some(Bullet)
  | 111 => Some(Bunny)
  | 112 => Some(Penguin)
  | 113 => Some(IceBoomerang)
  | 114 => Some(UnholyTridentFriendly)
  | 115 => Some(UnholyTridentHostile)
  | 116 => Some(SwordBeam)
  | 117 => Some(BoneArrowMarrow)
  | 118 => Some(IceBolt)
  | 119 => Some(FrostBoltFrostbrand)
  | 120 => Some(FrostArrow)
  | 121 => Some(AmethystBolt)
  | 122 => Some(TopazBolt)
  | 123 => Some(SapphireBolt)
  | 124 => Some(EmeraldBolt)
  | 125 => Some(RubyBolt)
  | 126 => Some(DiamondBolt)
  | 127 => Some(Turtle)
  | 128 => Some(FrostBlastHostile)
  | 129 => Some(RuneBlast)
  | 130 => Some(MushroomSpear)
  | 131 => Some(Mushroom)
  | 132 => Some(TerraBeam)
  | 133 => Some(GrenadeI)
  | 134 => Some(RocketI)
  | 135 => Some(ProximityMineI)
  | 136 => Some(GrenadeII)
  | 137 => Some(RocketII)
  | 138 => Some(ProximityMineII)
  | 139 => Some(GrenadeIII)
  | 140 => Some(RocketIII)
  | 141 => Some(ProximityMineIII)
  | 142 => Some(GrenadeIV)
  | 143 => Some(RocketIV)
  | 144 => Some(ProximityMineIV)
  | 145 => Some(PureSpray)
  | 146 => Some(HallowSpray)
  | 147 => Some(CorruptSpray)
  | 148 => Some(MushroomSpray)
  | 149 => Some(CrimsonSpray)
  | 150 => Some(NettleBurstRight)
  | 151 => Some(NettleBurstLeft)
  | 152 => Some(NettleBurstEnd)
  | 153 => Some(TheRottedFork)
  | 154 => Some(TheMeatball)
  | 155 => Some(BeachBall)
  | 156 => Some(LightBeam)
  | 157 => Some(NightBeam)
  | 158 => Some(CopperCoin)
  | 159 => Some(SilverCoin)
  | 160 => Some(GoldCoin)
  | 161 => Some(PlatinumCoin)
  | 162 => Some(CannonballFriendly)
  | 163 => Some(Flare)
  | 164 => Some(Landmine)
  | 165 => Some(Web)
  | 166 => Some(SnowBallFriendly)
  | 167 => Some(RedFireworkRocket)
  | 168 => Some(GreenFireworkRocket)
  | 169 => Some(BlueFireworkRocket)
  | 170 => Some(YellowFireworkRocket)
  | 171 => Some(RopeCoil)
  | 172 => Some(FrostburnArrow)
  | 173 => Some(EnchantedBeam)
  | 174 => Some(IceSpike)
  | 175 => Some(BabyEater)
  | 176 => Some(JungleSpike)
  | 177 => Some(IcewaterSpit)
  | 178 => Some(ConfettiGun)
  | 179 => Some(SlushBall)
  | 180 => Some(BulletDeadeye)
  | 181 => Some(Bee)
  | 182 => Some(PossessedHatchet)
  | 183 => Some(Beenade)
  | 184 => Some(PoisonDartSuperDartTrap)
  | 185 => Some(SpikyBallTrap)
  | 186 => Some(SpearTrap)
  | 187 => Some(FlamethrowerTrap)
  | 188 => Some(FlameTrapFlames)
  | 189 => Some(Wasp)
  | 190 => Some(MechanicalPiranha)
  | 191 => Some(Pygmy1)
  | 192 => Some(Pygmy2)
  | 193 => Some(Pygmy3)
  | 194 => Some(Pygmy4)
  | 195 => Some(Pygmy5)
  | 196 => Some(SmokeBomb)
  | 197 => Some(BabySkeletronHead)
  | 198 => Some(BabyHornet)
  | 199 => Some(TikiSpirit)
  | 200 => Some(PetLizard)
  | 201 => Some(GraveMarker)
  | 202 => Some(CrossGraveMarker)
  | 203 => Some(HeadStone)
  | 204 => Some(GraveStone)
  | 205 => Some(Obelisk)
  | 206 => Some(Leaf)
  | 207 => Some(ChlorophyteBullet)
  | 208 => Some(Parrot)
  | 209 => Some(Truffle)
  | 210 => Some(Sapling)
  | 211 => Some(Wisp)
  | 212 => Some(PalladiumPike)
  | 213 => Some(PalladiumDrill)
  | 214 => Some(PalladiumChainsaw)
  | 215 => Some(OrichalcumHalberd)
  | 216 => Some(OrichalcumDrill)
  | 217 => Some(OrichalcumChainsaw)
  | 218 => Some(TitaniumTrident)
  | 219 => Some(TitaniumDrill)
  | 220 => Some(TitaniumChainsaw)
  | 221 => Some(FlowerPetal)
  | 222 => Some(ChlorophytePartisan)
  | 223 => Some(ChlorophyteDrill)
  | 224 => Some(ChlorophyteChainsaw)
  | 225 => Some(ChlorophyteArrow)
  | 226 => Some(CrystalLeaf)
  | 227 => Some(CrystalLeafShot)
  | 228 => Some(SporeCloud)
  | 229 => Some(ChlorophyteOrb)
  | 230 => Some(AmethystHook)
  | 231 => Some(TopazHook)
  | 232 => Some(SapphireHook)
  | 233 => Some(EmeraldHook)
  | 234 => Some(RubyHook)
  | 235 => Some(DiamondHook)
  | 236 => Some(BabyDino)
  | 237 => Some(RainCloudMoving)
  | 238 => Some(RainCloudRaining)
  | 239 => Some(RainFriendly)
  | 240 => Some(Cannonball)
  | 241 => Some(CrimsandBallFalling)
  | 242 => Some(HighVelocityBullet)
  | 243 => Some(BloodCloudMoving)
  | 244 => Some(BloodCloudRaining)
  | 245 => Some(BloodRain)
  | 246 => Some(StyngerBolt)
  | 247 => Some(FlowerPow)
  | 248 => Some(FlowerPowPetal)
  | 249 => Some(StyngerBoltShrapnel)
  | 250 => Some(RainbowFront)
  | 251 => Some(RainbowBack)
  | 252 => Some(ChlorophyteJackhammer)
  | 253 => Some(BallofFrost)
  | 254 => Some(MagnetSphereBall)
  | 255 => Some(MagnetSphereBolt)
  | 256 => Some(SkeletronHand)
  | 257 => Some(FrostBeam)
  | 258 => Some(Fireball)
  | 259 => Some(EyeBeam)
  | 260 => Some(HeatRay)
  | 261 => Some(BoulderStaffofEarth)
  | 262 => Some(GolemFist)
  | 263 => Some(IceSickle)
  | 264 => Some(Rain)
  | 265 => Some(PoisonFang)
  | 266 => Some(BabySlime)
  | 267 => Some(PoisonDartWeapon)
  | 268 => Some(EyeSpring)
  | 269 => Some(BabySnowman)
  | 270 => Some(Skull)
  | 271 => Some(BoxingGlove)
  | 272 => Some(Bananarang)
  | 273 => Some(ChainKnife)
  | 274 => Some(DeathSickle)
  | 275 => Some(PlanteraSeed)
  | 276 => Some(PoisonSeed)
  | 277 => Some(ThornBall)
  | 278 => Some(IchorArrow)
  | 279 => Some(IchorBullet)
  | 280 => Some(GoldenShowerFriendly)
  | 281 => Some(ExplosiveBunny)
  | 282 => Some(VenomArrow)
  | 283 => Some(VenomBullet)
  | 284 => Some(PartyBullet)
  | 285 => Some(NanoBullet)
  | 286 => Some(ExplosiveBullet)
  | 287 => Some(GoldenBullet)
  | 288 => Some(GoldenShowerHostile)
  | 289 => Some(ConfettiFlaskofParty)
  | 290 => Some(ShadowBeamHostile)
  | 291 => Some(InfernoBoltHostile)
  | 292 => Some(InfernoBlastHostile)
  | 293 => Some(LostSoulHostile)
  | 294 => Some(ShadowBeamFriendly)
  | 295 => Some(InfernoBoltFriendly)
  | 296 => Some(InfernoBlastFriendly)
  | 297 => Some(LostSoulFriendly)
  | 298 => Some(SpiritHeal)
  | 299 => Some(Shadowflames)
  | 300 => Some(PaladinsHammerHostile)
  | 301 => Some(PaladinsHammerFriendly)
  | 302 => Some(SniperBullet)
  | 303 => Some(SkeletonCommandoRocket)
  | 304 => Some(VampireKnife)
  | 305 => Some(VampireHeal)
  | 306 => Some(EatersBite)
  | 307 => Some(TinyEater)
  | 308 => Some(FrostHydra)
  | 309 => Some(FrostBlast)
  | 310 => Some(BlueFlare)
  | 311 => Some(CandyCorn)
  | 312 => Some(JackOLantern)
  | 313 => Some(Spider)
  | 314 => Some(Squashling)
  | 315 => Some(BatHook)
  | 316 => Some(Bat)
  | 317 => Some(Raven)
  | 318 => Some(RottenEgg)
  | 319 => Some(BlackCat)
  | 320 => Some(BloodyMachete)
  | 321 => Some(FlamingJack)
  | 322 => Some(WoodHook)
  | 323 => Some(Stake)
  | 324 => Some(CursedSapling)
  | 325 => Some(FlamingWood)
  | 326 => Some(GreekFire1)
  | 327 => Some(GreekFire2)
  | 328 => Some(GreekFire3)
  | 329 => Some(FlamingScythe)
  | 330 => Some(StarAnise)
  | 331 => Some(CandyCaneHook)
  | 332 => Some(ChristmasHook)
  | 333 => Some(FruitcakeChakram)
  | 334 => Some(Puppy)
  | 335 => Some(OrnamentFriendly)
  | 336 => Some(PineNeedleFriendly)
  | 337 => Some(Blizzard)
  | 338 => Some(SnowmanRocketI)
  | 339 => Some(SnowmanRocketII)
  | 340 => Some(SnowmanRocketIII)
  | 341 => Some(SnowmanRocketIV)
  | 342 => Some(NorthPole)
  | 343 => Some(NorthPoleSpearProjectile)
  | 344 => Some(NorthPoleSnowFlake)
  | 345 => Some(PineNeedle)
  | 346 => Some(OrnamentHostile)
  | 347 => Some(OrnamentShrapnel)
  | 348 => Some(FrostWave)
  | 349 => Some(FrostShard)
  | 350 => Some(Missile)
  | 351 => Some(Present)
  | 352 => Some(Spike)
  | 353 => Some(BabyGrinch)
  | 354 => Some(CrimsandBallSandgun)
  | 355 => Some(VenomFang)
  | 356 => Some(SpectreWrath)
  | 357 => Some(PulseBolt)
  | 358 => Some(WaterGun)
  | 359 => Some(FrostBolt)
  | 360 => Some(WoodBobber)
  | 361 => Some(ReinforcedBobber)
  | 362 => Some(FiberglassBobber)
  | 363 => Some(FisherofSoulsBobber)
  | 364 => Some(GoldenBobber)
  | 365 => Some(MechanicsBobber)
  | 366 => Some(SittingDucksBobber)
  | 367 => Some(ObsidianSwordfish)
  | 368 => Some(Swordfish)
  | 369 => Some(SawtoothShark)
  | 370 => Some(LovePotion)
  | 371 => Some(FoulPotion)
  | 372 => Some(FishHook)
  | 373 => Some(Hornet)
  | 374 => Some(HornetStinger)
  | 375 => Some(FlyingImp)
  | 376 => Some(ImpFireball)
  | 377 => Some(SpiderTurret)
  | 378 => Some(SpiderEgg)
  | 379 => Some(BabySpider)
  | 380 => Some(ZephyrFish)
  | 381 => Some(FleshCatcherBobber)
  | 382 => Some(HotlineBobber)
  | 383 => Some(Anchor)
  | 384 => Some(Sharknado)
  | 385 => Some(SharknadoBolt)
  | 386 => Some(Cthulunado)
  | 387 => Some(Retanimini)
  | 388 => Some(Spazmamini)
  | 389 => Some(MiniRetinaLaser)
  | 390 => Some(VenomSpider)
  | 391 => Some(JumperSpider)
  | 392 => Some(DangerousSpider)
  | 393 => Some(OneEyedPirate)
  | 394 => Some(SoulscourgePirate)
  | 395 => Some(PirateCaptain)
  | 396 => Some(SlimeHook)
  | 397 => Some(StickyGrenade)
  | 398 => Some(MiniMinotaur)
  | 399 => Some(MolotovCocktail)
  | 400 => Some(MolotovFire1)
  | 401 => Some(MolotovFire2)
  | 402 => Some(MolotovFire3)
  | 403 => Some(TrackHook)
  | 404 => Some(Flairon)
  | 405 => Some(FlaironBubble)
  | 406 => Some(SlimeGun)
  | 407 => Some(Tempest)
  | 408 => Some(MiniSharkron)
  | 409 => Some(Typhoon)
  | 410 => Some(Bubble)
  | 411 => Some(CopperCoins)
  | 412 => Some(SilverCoins)
  | 413 => Some(GoldCoins)
  | 414 => Some(PlatinumCoins)
  | 415 => Some(FireWorkRocketRed)
  | 416 => Some(FireWorkRocketGreen)
  | 417 => Some(FireWorkRocketBlue)
  | 418 => Some(FireWorkRocketYellow)
  | 419 => Some(FireworkFountainYellow)
  | 420 => Some(FireworkFountainRed)
  | 421 => Some(FireworkFountainBlue)
  | 422 => Some(FireworkFountainRainbow)
  | 423 => Some(UFO)
  | 424 => Some(Meteor1)
  | 425 => Some(Meteor2)
  | 426 => Some(Meteor3)
  | 427 => Some(VortexChainsaw)
  | 428 => Some(VortexDrill)
  | 429 => Some(NebulaChainsaw)
  | 430 => Some(NebulaDrill)
  | 431 => Some(SolarFlareChainsaw)
  | 432 => Some(SolarFlareDrill)
  | 433 => Some(UFORay)
  | 434 => Some(ScutlixLaser)
  | 435 => Some(ElectricBolt)
  | 436 => Some(BrainScramblingBolt)
  | 437 => Some(GigazapperSpearhead)
  | 438 => Some(LaserRay)
  | 439 => Some(LaserMachinegun)
  | 440 => Some(LaserMachinegunLaser)
  | 441 => Some(ScutlixCrosshair)
  | 442 => Some(ElectrosphereMissile)
  | 443 => Some(Electrosphere)
  | 444 => Some(Xenopopper)
  | 445 => Some(LaserDrill)
  | 446 => Some(AntiGravityHook)
  | 447 => Some(MartianDeathray)
  | 448 => Some(MartianRocket)
  | 449 => Some(SaucerLaser)
  | 450 => Some(SaucerScrap)
  | 451 => Some(InfluxWaver)
  | 452 => Some(PhantasmalEye)
  | 453 => Some(DrillCrosshair)
  | 454 => Some(PhantasmalSphere)
  | 455 => Some(PhantasmalDeathray)
  | 456 => Some(MoonLeech)
  | 457 => Some(PhasicWarpEjector)
  | 458 => Some(PhasicWarpDisc)
  | 459 => Some(ChargedBlasterOrb)
  | 460 => Some(ChargedBlasterCannon)
  | 461 => Some(ChargedBlasterLaser)
  | 462 => Some(PhantasmalBolt)
  | 463 => Some(ViciousPowder)
  | 464 => Some(IceMist)
  | 465 => Some(LightningOrb)
  | 466 => Some(LightningOrbArc)
  | 467 => Some(CultistFireball)
  | 468 => Some(ShadowFireball)
  | 469 => Some(BeeArrow)
  | 470 => Some(StickyDynamite)
  | 471 => Some(SkeletonMerchantBone)
  | 472 => Some(Webspit)
  | 473 => Some(SpelunkerGlowstick)
  | 474 => Some(BoneArrowAmmo)
  | 475 => Some(VineRopeCoil)
  | 476 => Some(SoulDrain)
  | 477 => Some(CrystalDart)
  | 478 => Some(CursedDart)
  | 479 => Some(IchorDart)
  | 480 => Some(CursedFlameClingerStaff)
  | 481 => Some(ChainGuillotine)
  | 482 => Some(CursedFlames)
  | 483 => Some(SeedlerNut)
  | 484 => Some(SeedlerThorn)
  | 485 => Some(Hellwing)
  | 486 => Some(TendonHook)
  | 487 => Some(ThornHook)
  | 488 => Some(IlluminantHook)
  | 489 => Some(WormHook)
  | 490 => Some(LightningRitual)
  | 491 => Some(FlyingKnife)
  | 492 => Some(MagicLantern)
  | 493 => Some(CrystalVileShardHead)
  | 494 => Some(CrystalVileShardShaft)
  | 495 => Some(ShadowflameArrow)
  | 496 => Some(Shadowflame)
  | 497 => Some(ShadowflameKnife)
  | 498 => Some(NailHostile)
  | 499 => Some(BabyFaceMonster)
  | 500 => Some(CrimsonHeart)
  | 501 => Some(Flask)
  | 502 => Some(Meowmere)
  | 503 => Some(StarWrath)
  | 504 => Some(Spark)
  | 505 => Some(SilkRopeCoil)
  | 506 => Some(WebRopeCoil)
  | 507 => Some(JavelinFriendly)
  | 508 => Some(JavelinHostile)
  | 509 => Some(ButchersChainsaw)
  | 510 => Some(ToxicFlask)
  | 511 => Some(ToxicCloud1)
  | 512 => Some(ToxicCloud2)
  | 513 => Some(ToxicCloud3)
  | 514 => Some(Nail)
  | 515 => Some(BouncyGlowstick)
  | 516 => Some(BouncyBomb)
  | 517 => Some(BouncyGrenade)
  | 518 => Some(CoinPortal)
  | 519 => Some(BombFish)
  | 520 => Some(FrostDaggerfish)
  | 521 => Some(CrystalCharge1)
  | 522 => Some(CrystalCharge2)
  | 523 => Some(ToxicBubble)
  | 524 => Some(IchorSplash)
  | 525 => Some(FlyingPiggyBank)
  | 526 => Some(Energy)
  | 527 => Some(GoldenCrossGraveMarker)
  | 528 => Some(GoldenTombstone)
  | 529 => Some(GoldenGraveMarker)
  | 530 => Some(GoldenGraveStone)
  | 531 => Some(GoldenHeadStone)
  | 532 => Some(XBone)
  | 533 => Some(DeadlySphere)
  | 534 => Some(Code1)
  | 535 => Some(MedusaHead)
  | 536 => Some(MedusaHeadRay)
  | 537 => Some(StardustLaser)
  | 538 => Some(Twinkle)
  | 539 => Some(FlowInvader)
  | 540 => Some(Starmark)
  | 541 => Some(WoodenYoyo)
  | 542 => Some(Malaise)
  | 543 => Some(Artery)
  | 544 => Some(Amazon)
  | 545 => Some(Cascase)
  | 546 => Some(Chik)
  | 547 => Some(Code2)
  | 548 => Some(Rally)
  | 549 => Some(Yelets)
  | 550 => Some(RedsThrow)
  | 551 => Some(ValkyrieYoyo)
  | 552 => Some(Amarok)
  | 553 => Some(HelFire)
  | 554 => Some(Kraken)
  | 555 => Some(TheEyeofCthulhuYoyo)
  | 556 => Some(BLackCounterweight)
  | 557 => Some(BlueCounterweight)
  | 558 => Some(GreenCounterweight)
  | 559 => Some(PurpleCounterweight)
  | 560 => Some(RedCounterweight)
  | 561 => Some(YellowCounterweight)
  | 562 => Some(FormatC)
  | 563 => Some(Gradient)
  | 564 => Some(Valor)
  | 565 => Some(BrainofConfusion)
  | 566 => Some(GiantBee)
  | 567 => Some(SporeTrap)
  | 568 => Some(SporeTrap2)
  | 569 => Some(SporeGas1)
  | 570 => Some(SporeGas2)
  | 571 => Some(SporeGas3)
  | 572 => Some(PoisonSpit)
  | 573 => Some(NebulaPiercer)
  | 574 => Some(NebulaEye)
  | 575 => Some(NebulaSphere)
  | 576 => Some(NebulaLaser)
  | 577 => Some(VortexLaser)
  | 578 => Some(VortexLightningPillar)
  | 579 => Some(Vortex)
  | 580 => Some(VortexLightningPortal)
  | 581 => Some(AlienGoop)
  | 582 => Some(MechanicsWrench)
  | 583 => Some(SyringeDamage)
  | 584 => Some(SyringeHealing)
  | 585 => Some(SkullClothier)
  | 586 => Some(Dryadsward)
  | 587 => Some(Paintball)
  | 588 => Some(ConfettiGrenade)
  | 589 => Some(ChristmasOrnament)
  | 590 => Some(TruffleSpore)
  | 591 => Some(MinecartLaser)
  | 592 => Some(LaserRayMartianWalker)
  | 593 => Some(ProphecysEnd)
  | 594 => Some(BlowupSmokeFlyingDutchman)
  | 595 => Some(Arkhalis)
  | 596 => Some(DesertSpiritsCurse)
  | 597 => Some(AmberBolt)
  | 598 => Some(BoneJavelin)
  | 599 => Some(BoneDagger)
  | 600 => Some(PortalGun)
  | 601 => Some(PortalBolt)
  | 602 => Some(PortalGate)
  | 603 => Some(Terrarian)
  | 604 => Some(TerrarianBeam)
  | 605 => Some(SlimeSpike)
  | 606 => Some(Laser)
  | 607 => Some(SolarFlare)
  | 608 => Some(SolarRadiance)
  | 609 => Some(StardustDrill)
  | 610 => Some(StardustChainsaw)
  | 611 => Some(SolarEruption)
  | 612 => Some(SolarEruptionExplosion)
  | 613 => Some(StardustCell)
  | 614 => Some(StardustCellShot)
  | 615 => Some(VortexBeater)
  | 616 => Some(VortexRocket)
  | 617 => Some(NebulaArcanum)
  | 618 => Some(NebulaArcanumSubShot)
  | 619 => Some(NebulaArcanumExplosionShot)
  | 620 => Some(NebulaArcanumExplosionShotShard)
  | 621 => Some(BloodWater)
  | 622 => Some(BlowupSmoke)
  | 623 => Some(StardustGuardian)
  | 624 => Some(Starburst)
  | 625 => Some(StardustDragon1)
  | 626 => Some(StardustDragon2)
  | 627 => Some(StardustDragon3)
  | 628 => Some(StardustDragon4)
  | 629 => Some(ReleasedEnergy)
  | 630 => Some(Phantasm)
  | 631 => Some(PhantasmArrow)
  | 632 => Some(LastPrismLaser)
  | 633 => Some(LastPrism)
  | 634 => Some(NebulaBlaze)
  | 635 => Some(NebulaBlazeEx)
  | 636 => Some(Daybreak)
  | 637 => Some(BouncyDynamite)
  | 638 => Some(LuminiteBullet)
  | 639 => Some(LuminiteArrow)
  | 640 => Some(LuminiteArrowTrail)
  | 641 => Some(LunarPortal)
  | 642 => Some(LunarPortalLaser)
  | 643 => Some(RainbowCrystal)
  | 644 => Some(RainbowExplosion)
  | 645 => Some(LunarFlare)
  | 646 => Some(LunarHookSolar)
  | 647 => Some(LunarHookVortex)
  | 648 => Some(LunarHookNebula)
  | 649 => Some(LunarHookStardust)
  | 650 => Some(SuspiciousLookingTentacle)
  | 651 => Some(WireKite)
  | 652 => Some(StaticHook)
  | 653 => Some(CompanionCube)
  | 654 => Some(Geyser)
  | 655 => Some(BeeHive)
  | 656 => Some(AncientStormFriendly)
  | 657 => Some(AncientStormHostile)
  | 658 => Some(AncientStormMark)
  | 659 => Some(SpiritFlame)
  | 660 => Some(SkyFracture)
  | 661 => Some(OnyxBlaster)
  | 662 => Some(EtherianJavelinT1)
  | 663 => Some(FlameburstTower1)
  | 664 => Some(FlameburstTowerShot1)
  | 665 => Some(FlameburstTower2)
  | 666 => Some(FlameburstTowerShot2)
  | 667 => Some(FlameburstTower3)
  | 668 => Some(FlameburstTowerShot3)
  | 669 => Some(Ale)
  | 670 => Some(OgresStomp1)
  | 671 => Some(Drakin)
  | 672 => Some(GrimEnd)
  | 673 => Some(DarkSigil1)
  | 674 => Some(DarkSigil2)
  | 675 => Some(DarkEnergy)
  | 676 => Some(OgreSpit)
  | 677 => Some(Ballista1)
  | 678 => Some(Ballista2)
  | 679 => Some(Ballista3)
  | 680 => Some(BallistaShot)
  | 681 => Some(GoblinBomb)
  | 682 => Some(WitheringBolt)
  | 683 => Some(OgresStomp)
  | 684 => Some(HeartySlash)
  | 685 => Some(EtherianJavelinT3)
  | 686 => Some(BetsysFireball)
  | 687 => Some(BetsysBreath)
  | 688 => Some(LightningAura1)
  | 689 => Some(LightningAura2)
  | 690 => Some(LightningAura3)
  | 691 => Some(ExplosiveTrap1)
  | 692 => Some(ExplosiveTrap2)
  | 693 => Some(ExplosiveTrap3)
  | 694 => Some(ExplosiveTrapShot1)
  | 695 => Some(ExplosiveTrapShot2)
  | 696 => Some(ExplosiveTrapShot3)
  | 697 => Some(SleepyOctopod)
  | 698 => Some(PoleSmash)
  | 699 => Some(GhastlyGlaive)
  | 700 => Some(Ghast)
  | 701 => Some(Hoardagron)
  | 702 => Some(Flickerwick)
  | 703 => Some(PropellerGato)
  | 704 => Some(WhirlwindofInfiniteWisdom)
  | 705 => Some(PhantomPhoenix)
  | 706 => Some(PhantomPhoenixPheonix)
  | 707 => Some(SkyDragonsFury1)
  | 708 => Some(SkyDragonsFury2)
  | 709 => Some(SkyDragonsFuryShot)
  | 710 => Some(AerialBane)
  | 711 => Some(BetsysWrath)
  | 712 => Some(TomeofInfiniteWisdom)
  | 713 => Some(VictoryDD2)
  | 714 => Some(CelebrationMk2)
  | 715 => Some(Celeb2Rocket)
  | 716 => Some(Celeb2RocketExplosive)
  | 717 => Some(Celeb2RocketLarge)
  | 718 => Some(Celeb2RocketExplosiveLarge)
  | 719 => Some(QueenBeesStinger)
  | 720 => Some(FallingStarSpawnerAnimation)
  | 721 => Some(GolfBall)
  | 722 => Some(GolfClub)
  | 723 => Some(ManaCloak)
  | 724 => Some(BeeCloak)
  | 725 => Some(StarVeil)
  | 726 => Some(StarCloak)
  | 727 => Some(RollingCactus)
  | 728 => Some(SuperStarCannonStar)
  | 729 => Some(SuperStarCannonAnimation)
  | 730 => Some(StormSpear)
  | 731 => Some(ThunderZapper)
  | 732 => Some(StormSpearShot)
  | 733 => Some(ToiletEffect)
  | 734 => Some(VoidLens)
  | 735 => Some(Terragrim)
  | 736 => Some(DungeonDebrisBlue)
  | 737 => Some(DungeonDebrisGreen)
  | 738 => Some(DungeonDebrisPink)
  | 739 => Some(BlackGolfBall)
  | 740 => Some(BlueGolfBall)
  | 741 => Some(BrownGolfBall)
  | 742 => Some(CyanGolfBall)
  | 743 => Some(GreenGolfBall)
  | 744 => Some(LimeGolfBall)
  | 745 => Some(OrangeGolfBall)
  | 746 => Some(PinkGolfBall)
  | 747 => Some(PurpleGolfBall)
  | 748 => Some(RedGolfBall)
  | 749 => Some(SkyBlueGolfBall)
  | 750 => Some(TealGolfBall)
  | 751 => Some(VioletGolfBall)
  | 752 => Some(YellowGolfBall)
  | 753 => Some(AmberHook)
  | 754 => Some(MysticSnakeCoil)
  | 755 => Some(SanguineBat)
  | 756 => Some(BloodThorn)
  | 757 => Some(DripplerCrippler2)
  | 758 => Some(VampireFrog)
  | 759 => Some(Finch)
  | 760 => Some(BobberBloody)
  | 761 => Some(PaperAirplane)
  | 762 => Some(PaperAirplaneWhite)
  | 763 => Some(RollingCactusSpike)
  | 764 => Some(UpbeatStar)
  | 765 => Some(SugarGlider)
  | 766 => Some(KiteBlue)
  | 767 => Some(KiteBlueAndYellow)
  | 768 => Some(KiteRed)
  | 769 => Some(KiteRedAndYellow)
  | 770 => Some(KiteYellow)
  | 771 => Some(KiteWyvern)
  | 772 => Some(Geode)
  | 773 => Some(ScarabBomb)
  | 774 => Some(SharkPup)
  | 775 => Some(BobberScarab)
  | 776 => Some(ClusterRocketI)
  | 777 => Some(ClusterGrenadeI)
  | 778 => Some(ClusterProximityMineI)
  | 779 => Some(ClusterFragmentI)
  | 780 => Some(ClusterRocketII)
  | 781 => Some(ClusterGrenadeII)
  | 782 => Some(ClusterProximityMineII)
  | 783 => Some(ClusterFragmentII)
  | 784 => Some(WetRocket)
  | 785 => Some(WetGrenade)
  | 786 => Some(WetProximityMine)
  | 787 => Some(LavaRocket)
  | 788 => Some(LavaGrenade)
  | 789 => Some(LavaProximityMine)
  | 790 => Some(HoneyRocket)
  | 791 => Some(HoneyGrenade)
  | 792 => Some(HoneyProximityMine)
  | 793 => Some(MiniNukeRocketI)
  | 794 => Some(MiniNukeGrenadeI)
  | 795 => Some(MiniNukeProximityMineI)
  | 796 => Some(MiniNukeRocketII)
  | 797 => Some(MiniNukeGrenadeII)
  | 798 => Some(MiniNukeProximityMineII)
  | 799 => Some(DryRocket)
  | 800 => Some(DryGrenade)
  | 801 => Some(DryProximityMine)
  | 802 => Some(Gladius)
  | 803 => Some(ClusterSnowmanRocketI)
  | 804 => Some(ClusterSnowmanRocketII)
  | 805 => Some(WetSnowmanRocket)
  | 806 => Some(LavaSnowmanRocket)
  | 807 => Some(HoneySnowmanRocket)
  | 808 => Some(MiniNukeSnowmanRocketI)
  | 809 => Some(MiniNukeSnowmanRocketII)
  | 810 => Some(DrySnowmanRocket)
  | 811 => Some(BloodShot)
  | 812 => Some(ShellPile)
  | 813 => Some(BloodTears)
  | 814 => Some(BloodShotNautilus)
  | 815 => Some(LilHarpy)
  | 816 => Some(FennecFox)
  | 817 => Some(GlitteryButterfly)
  | 818 => Some(DesertTiger1)
  | 819 => Some(BloodRainArrow)
  | 820 => Some(ChumBucket)
  | 821 => Some(BabyImp)
  | 822 => Some(KiteBoneSerpent)
  | 823 => Some(KiteWorldFeeder)
  | 824 => Some(KiteBunny)
  | 825 => Some(BabyRedPanda)
  | 826 => Some(KitePigron)
  | 827 => Some(KiteManEater)
  | 828 => Some(KiteJellyfishBlue)
  | 829 => Some(KiteJellyfishPink)
  | 830 => Some(KiteShark)
  | 831 => Some(DesertTiger2)
  | 832 => Some(DesertTiger3)
  | 833 => Some(DesertTigerT1)
  | 834 => Some(DesertTigerT2)
  | 835 => Some(DesertTigerT3)
  | 836 => Some(DandelionSeed)
  | 837 => Some(BookofSkulls)
  | 838 => Some(KiteSandShark)
  | 839 => Some(KiteBunnyCorrupt)
  | 840 => Some(KiteBunnyCrimson)
  | 841 => Some(LeatherWhip)
  | 842 => Some(Ruler)
  | 843 => Some(KiteGoldfish)
  | 844 => Some(KiteAngryTrapper)
  | 845 => Some(KiteKoi)
  | 846 => Some(KiteCrawltipede)
  | 847 => Some(Durendal)
  | 848 => Some(MorningStar)
  | 849 => Some(DarkHarvest)
  | 850 => Some(KiteSpectrum)
  | 851 => Some(ReleaseDoves)
  | 852 => Some(KiteWanderingEye)
  | 853 => Some(KiteUnicorn)
  | 854 => Some(Plantero)
  | 855 => Some(ReleaseLantern)
  | 856 => Some(StellarTune)
  | 857 => Some(FirstFractal)
  | 858 => Some(DynamiteKitten)
  | 859 => Some(BabyWerewolf)
  | 860 => Some(ShadowMimic)
  | 861 => Some(Football)
  | 862 => Some(SnowmanClusterFragment1)
  | 863 => Some(SnowmanClusterFragment2)
  | 864 => Some(EnchantedDagger)
  | 865 => Some(SquirrelHook)
  | 866 => Some(SergeantUnitedShield)
  | 867 => Some(Shroomerang)
  | 868 => Some(TreeGlobe)
  | 869 => Some(WorldGlobe)
  | 870 => Some(FairyGlowstick)
  | 871 => Some(HallowBossSplitShotCore)
  | 872 => Some(EverlastingRainbow)
  | 873 => Some(PrismaticBolt)
  | 874 => Some(HallowBossDeathAurora)
  | 875 => Some(VoltBunny)
  | 876 => Some(Zapinator)
  | 877 => Some(JoustingLance)
  | 878 => Some(ShadowJoustingLance)
  | 879 => Some(HallowedJoustingLance)
  | 880 => Some(ZoologistStrikeGreen)
  | 881 => Some(KingSlimePet)
  | 882 => Some(EyeOfCthulhuPet)
  | 883 => Some(EaterOfWorldsPet)
  | 884 => Some(BrainOfCthulhuPet)
  | 885 => Some(SkeletronPet)
  | 886 => Some(QueenBeePet)
  | 887 => Some(DestroyerPet)
  | 888 => Some(TwinsPet)
  | 889 => Some(SkeletronPrimePet)
  | 890 => Some(PlanteraPet)
  | 891 => Some(GolemPet)
  | 892 => Some(DukeFishronPet)
  | 893 => Some(LunaticCultistPet)
  | 894 => Some(MoonLordPet)
  | 895 => Some(FairyQueenPet)
  | 896 => Some(PumpkingPet)
  | 897 => Some(EverscreamPet)
  | 898 => Some(IceQueenPet)
  | 899 => Some(MartianPet)
  | 900 => Some(DD2OgrePet)
  | 901 => Some(DD2BetsyPet)
  | 902 => Some(CombatWrench)
  | 903 => Some(WetBomb)
  | 904 => Some(LavaBomb)
  | 905 => Some(HoneyBomb)
  | 906 => Some(DryBomb)
  | 907 => Some(OrnamentTreeSword)
  | 908 => Some(TitaniumShard)
  | 909 => Some(Rock)
  | 910 => Some(DirtBomb)
  | 911 => Some(StickyDirtBomb)
  | 912 => Some(CoolWhip)
  | 913 => Some(FirecrackerWhip1)
  | 914 => Some(Snapthorn)
  | 915 => Some(Kaleidoscope)
  | 916 => Some(Reaping)
  | 917 => Some(CoolFlake)
  | 918 => Some(FirecrackerWhip2)
  | 919 => Some(EtherealLance)
  | 920 => Some(CrystalSpike)
  | 921 => Some(BouncyGel)
  | 922 => Some(QueenlySmash)
  | 923 => Some(SunDance)
  | 924 => Some(FairyQueenHymn)
  | 925 => Some(StardustGuardianPunch)
  | 926 => Some(RegalGel)
  | 927 => Some(Starlight)
  | 928 => Some(DripplerCrippler1)
  | 929 => Some(ZoologistStrikeRed)
  | 930 => Some(SantankRocket)
  | 931 => Some(Nightglow)
  | 932 => Some(TwilightLance)
  | 933 => Some(Zenith)
  | 934 => Some(QueenSlimePet)
  | 935 => Some(QueenSlimeHook)
  | 936 => Some(SparkleSlimeBalloon)
  | 937 => Some(VolatileGelatin)
  | 938 => Some(CopperShortsword)
  | 939 => Some(TinShortsword)
  | 940 => Some(IronShortsword)
  | 941 => Some(LeadShortsword)
  | 942 => Some(SilverShortsword)
  | 943 => Some(TungstenShortsword)
  | 944 => Some(GoldShortsword)
  | 945 => Some(PlatinumShortsword)
  | 946 => Some(Terraprisma)
  | 947 => Some(Mace)
  | 948 => Some(FlamingMace)
  | 949 => Some(TheTorchGod)
  | 950 => Some(PrincessWeapon)
  | 951 => Some(FlinxMinion)
  | 952 => Some(BoneWhip)
  | 953 => Some(DaybreakExplosion)
  | 954 => Some(WandOfSparkingSpark)
  | 955 => Some(StarCannonStar)
  | 956 => Some(BerniePet)
  | 957 => Some(GlommerPet)
  | 958 => Some(DeerclopsPet)
  | 959 => Some(PigPet)
  | 960 => Some(ChesterPet)
  | 961 => Some(DeerclopsIceSpike)
  | 962 => Some(DeerclopsRangedProjectile)
  | 963 => Some(AbigailMinion)
  | 964 => Some(InsanityShadowFriendly)
  | 965 => Some(InsanityShadowHostile)
  | 966 => Some(HoundiusShootius)
  | 967 => Some(HoundiusShootiusFireball)
  | 968 => Some(PewMaticHornShot)
  | 969 => Some(WeatherPainShot)
  | 970 => Some(AbigailCounter)
  | 971 => Some(TentacleSpike)
  | 972 => Some(NightsEdge)
  | 973 => Some(TrueNightsEdge)
  | 974 => Some(LightsBane)
  | 975 => Some(BloodButcherer)
  | 976 => Some(BladeOfGrass)
  | 977 => Some(Muramasa)
  | 978 => Some(Volcano)
  | 979 => Some(WandOfFrostingFrost)
  | 980 => Some(VenomDartTrap)
  | 981 => Some(SilverBullet)
  | 982 => Some(Excalibur)
  | 983 => Some(TrueExcalibur)
  | 984 => Some(TerraBlade2)
  | 985 => Some(TerraBlade2Shot)
  | 986 => Some(FishingBobber)
  | 987 => Some(FishingBobberGlowingStar)
  | 988 => Some(FishingBobberGlowingLava)
  | 989 => Some(FishingBobberGlowingKrypton)
  | 990 => Some(FishingBobberGlowingXenon)
  | 991 => Some(FishingBobberGlowingArgon)
  | 992 => Some(FishingBobberGlowingViolet)
  | 993 => Some(FishingBobberGlowingRainbow)
  | 994 => Some(JunimoPet)
  | 995 => Some(JuminoStardropAnimation)
  | 996 => Some(MoonGlobe)
  | 997 => Some(TheHorsemansBlade)
  | 998 => Some(BlueChickenPet)
  | 999 => Some(HiveFive)
  | 1000 => Some(Trimarang)
  | 1001 => Some(HorsemanPumpkin)
  | 1002 => Some(TntBarrel)
  | 1003 => Some(Spiffo)
  | 1004 => Some(CavelingGardener)
  | 1005 => Some(MiniBoulder)
  | 1006 => Some(ShimmerArrow)
  | 1007 => Some(GasTrap)
  | 1008 => Some(SpelunkerFlare)
  | 1009 => Some(CursedFlare)
  | 1010 => Some(RainbowFlare)
  | 1011 => Some(ShimmerFlare)
  | 1012 => Some(Waffle)
  | 1013 => Some(BouncyBoulder)
  | 1014 => Some(LifeCrystalBoulder)
  | 1015 => Some(SandSpray)
  | 1016 => Some(SnowSpray)
  | 1017 => Some(DirtSpray)
  | 1018 => Some(DirtiestBlock)
  | 1019 => Some(Fertilizer)
  | 1020 => Some(JimsDrone)
  | 1021 => Some(MoonBoulder)
  | _ => None
  }

let toString = (projectileType: t): string =>
  switch projectileType {
  | Empty => "Empty"
  | WoodenArrowFriendly => "WoodenArrowFriendly"
  | FlamingArrow => "FlamingArrow"
  | Shuriken => "Shuriken"
  | UnholyArrow => "UnholyArrow"
  | JestersArrow => "JestersArrow"
  | EnchantedBoomerang => "EnchantedBoomerang"
  | VilethornBase => "VilethornBase"
  | VilethornTip => "VilethornTip"
  | Starfury => "Starfury"
  | PurificationPowder => "PurificationPowder"
  | VilePowder => "VilePowder"
  | FallingStar => "FallingStar"
  | GrapplingHook => "GrapplingHook"
  | OldSilverBullet => "OldSilverBullet"
  | BallofFire => "BallofFire"
  | MagicMissile => "MagicMissile"
  | DirtBall => "DirtBall"
  | ShadowOrb => "ShadowOrb"
  | Flamarang => "Flamarang"
  | GreenLaser => "GreenLaser"
  | Bone => "Bone"
  | WaterStream => "WaterStream"
  | Harpoon => "Harpoon"
  | SpikyBallWeapon => "SpikyBallWeapon"
  | BallOHurt => "BallOHurt"
  | BlueMoon => "BlueMoon"
  | WaterBolt => "WaterBolt"
  | Bomb => "Bomb"
  | Dynamite => "Dynamite"
  | Grenade => "Grenade"
  | SandBallFalling => "SandBallFalling"
  | IvyWhip => "IvyWhip"
  | ThornChakram => "ThornChakram"
  | Flamelash => "Flamelash"
  | Sunfury => "Sunfury"
  | MeteorShot => "MeteorShot"
  | StickyBomb => "StickyBomb"
  | HarpyFeather => "HarpyFeather"
  | MudBall => "MudBall"
  | AshBall => "AshBall"
  | HellfireArrow => "HellfireArrow"
  | SandBallSandgun => "SandBallSandgun"
  | Tombstone => "Tombstone"
  | DemonSickle => "DemonSickle"
  | DemonScythe => "DemonScythe"
  | DarkLance => "DarkLance"
  | Trident => "Trident"
  | ThrowingKnife => "ThrowingKnife"
  | Spear => "Spear"
  | Glowstick => "Glowstick"
  | Seed => "Seed"
  | WoodenBoomerang => "WoodenBoomerang"
  | StickyGlowstick => "StickyGlowstick"
  | PoisonedKnife => "PoisonedKnife"
  | Stinger => "Stinger"
  | EbonsandBallFalling => "EbonsandBallFalling"
  | CobaltChainsaw => "CobaltChainsaw"
  | MythrilChainsaw => "MythrilChainsaw"
  | CobaltDrill => "CobaltDrill"
  | MythrilDrill => "MythrilDrill"
  | AdamantiteChainsaw => "AdamantiteChainsaw"
  | AdamantiteDrill => "AdamantiteDrill"
  | TheDaoofPow => "TheDaoofPow"
  | MythrilHalberd => "MythrilHalberd"
  | EbonsandBallSandgun => "EbonsandBallSandgun"
  | AdamantiteGlaive => "AdamantiteGlaive"
  | PearlSandBallFalling => "PearlSandBallFalling"
  | PearlSandBallSandgun => "PearlSandBallSandgun"
  | HolyWater => "HolyWater"
  | UnholyWater => "UnholyWater"
  | SiltBall => "SiltBall"
  | BlueFairy => "BlueFairy"
  | DualHookBlue => "DualHookBlue"
  | DualHookRed => "DualHookRed"
  | HappyBomb => "HappyBomb"
  | NoteQuarter => "NoteQuarter"
  | NoteEight => "NoteEight"
  | NoteTiedEighth => "NoteTiedEighth"
  | Rainbow => "Rainbow"
  | IceBlock => "IceBlock"
  | WoodenArrowHostile => "WoodenArrowHostile"
  | FlamingArrowHostile => "FlamingArrowHostile"
  | EyeLaser => "EyeLaser"
  | PinkLaser => "PinkLaser"
  | Flames => "Flames"
  | PinkFairy => "PinkFairy"
  | GreenFairy => "GreenFairy"
  | PurpleLaser => "PurpleLaser"
  | CrystalBullet => "CrystalBullet"
  | CrystalShard => "CrystalShard"
  | HolyArrow => "HolyArrow"
  | HallowStar => "HallowStar"
  | MagicDagger => "MagicDagger"
  | CrystalStorm => "CrystalStorm"
  | CursedFlameFriendly => "CursedFlameFriendly"
  | CursedFlameHostile => "CursedFlameHostile"
  | CobaltNaginata => "CobaltNaginata"
  | PoisonDartTrap => "PoisonDartTrap"
  | Boulder => "Boulder"
  | DeathLaser => "DeathLaser"
  | EyeFire => "EyeFire"
  | SkeletronPrimeBomb => "SkeletronPrimeBomb"
  | CursedArrow => "CursedArrow"
  | CursedBullet => "CursedBullet"
  | Gungnir => "Gungnir"
  | LightDisc => "LightDisc"
  | Hamdrax => "Hamdrax"
  | Explosives => "Explosives"
  | SnowBall => "SnowBall"
  | Bullet => "Bullet"
  | Bunny => "Bunny"
  | Penguin => "Penguin"
  | IceBoomerang => "IceBoomerang"
  | UnholyTridentFriendly => "UnholyTridentFriendly"
  | UnholyTridentHostile => "UnholyTridentHostile"
  | SwordBeam => "SwordBeam"
  | BoneArrowMarrow => "BoneArrowMarrow"
  | IceBolt => "IceBolt"
  | FrostBoltFrostbrand => "FrostBoltFrostbrand"
  | FrostArrow => "FrostArrow"
  | AmethystBolt => "AmethystBolt"
  | TopazBolt => "TopazBolt"
  | SapphireBolt => "SapphireBolt"
  | EmeraldBolt => "EmeraldBolt"
  | RubyBolt => "RubyBolt"
  | DiamondBolt => "DiamondBolt"
  | Turtle => "Turtle"
  | FrostBlastHostile => "FrostBlastHostile"
  | RuneBlast => "RuneBlast"
  | MushroomSpear => "MushroomSpear"
  | Mushroom => "Mushroom"
  | TerraBeam => "TerraBeam"
  | GrenadeI => "GrenadeI"
  | RocketI => "RocketI"
  | ProximityMineI => "ProximityMineI"
  | GrenadeII => "GrenadeII"
  | RocketII => "RocketII"
  | ProximityMineII => "ProximityMineII"
  | GrenadeIII => "GrenadeIII"
  | RocketIII => "RocketIII"
  | ProximityMineIII => "ProximityMineIII"
  | GrenadeIV => "GrenadeIV"
  | RocketIV => "RocketIV"
  | ProximityMineIV => "ProximityMineIV"
  | PureSpray => "PureSpray"
  | HallowSpray => "HallowSpray"
  | CorruptSpray => "CorruptSpray"
  | MushroomSpray => "MushroomSpray"
  | CrimsonSpray => "CrimsonSpray"
  | NettleBurstRight => "NettleBurstRight"
  | NettleBurstLeft => "NettleBurstLeft"
  | NettleBurstEnd => "NettleBurstEnd"
  | TheRottedFork => "TheRottedFork"
  | TheMeatball => "TheMeatball"
  | BeachBall => "BeachBall"
  | LightBeam => "LightBeam"
  | NightBeam => "NightBeam"
  | CopperCoin => "CopperCoin"
  | SilverCoin => "SilverCoin"
  | GoldCoin => "GoldCoin"
  | PlatinumCoin => "PlatinumCoin"
  | CannonballFriendly => "CannonballFriendly"
  | Flare => "Flare"
  | Landmine => "Landmine"
  | Web => "Web"
  | SnowBallFriendly => "SnowBallFriendly"
  | RedFireworkRocket => "RedFireworkRocket"
  | GreenFireworkRocket => "GreenFireworkRocket"
  | BlueFireworkRocket => "BlueFireworkRocket"
  | YellowFireworkRocket => "YellowFireworkRocket"
  | RopeCoil => "RopeCoil"
  | FrostburnArrow => "FrostburnArrow"
  | EnchantedBeam => "EnchantedBeam"
  | IceSpike => "IceSpike"
  | BabyEater => "BabyEater"
  | JungleSpike => "JungleSpike"
  | IcewaterSpit => "IcewaterSpit"
  | ConfettiGun => "ConfettiGun"
  | SlushBall => "SlushBall"
  | BulletDeadeye => "BulletDeadeye"
  | Bee => "Bee"
  | PossessedHatchet => "PossessedHatchet"
  | Beenade => "Beenade"
  | PoisonDartSuperDartTrap => "PoisonDartSuperDartTrap"
  | SpikyBallTrap => "SpikyBallTrap"
  | SpearTrap => "SpearTrap"
  | FlamethrowerTrap => "FlamethrowerTrap"
  | FlameTrapFlames => "FlameTrapFlames"
  | Wasp => "Wasp"
  | MechanicalPiranha => "MechanicalPiranha"
  | Pygmy1 => "Pygmy1"
  | Pygmy2 => "Pygmy2"
  | Pygmy3 => "Pygmy3"
  | Pygmy4 => "Pygmy4"
  | Pygmy5 => "Pygmy5"
  | SmokeBomb => "SmokeBomb"
  | BabySkeletronHead => "BabySkeletronHead"
  | BabyHornet => "BabyHornet"
  | TikiSpirit => "TikiSpirit"
  | PetLizard => "PetLizard"
  | GraveMarker => "GraveMarker"
  | CrossGraveMarker => "CrossGraveMarker"
  | HeadStone => "HeadStone"
  | GraveStone => "GraveStone"
  | Obelisk => "Obelisk"
  | Leaf => "Leaf"
  | ChlorophyteBullet => "ChlorophyteBullet"
  | Parrot => "Parrot"
  | Truffle => "Truffle"
  | Sapling => "Sapling"
  | Wisp => "Wisp"
  | PalladiumPike => "PalladiumPike"
  | PalladiumDrill => "PalladiumDrill"
  | PalladiumChainsaw => "PalladiumChainsaw"
  | OrichalcumHalberd => "OrichalcumHalberd"
  | OrichalcumDrill => "OrichalcumDrill"
  | OrichalcumChainsaw => "OrichalcumChainsaw"
  | TitaniumTrident => "TitaniumTrident"
  | TitaniumDrill => "TitaniumDrill"
  | TitaniumChainsaw => "TitaniumChainsaw"
  | FlowerPetal => "FlowerPetal"
  | ChlorophytePartisan => "ChlorophytePartisan"
  | ChlorophyteDrill => "ChlorophyteDrill"
  | ChlorophyteChainsaw => "ChlorophyteChainsaw"
  | ChlorophyteArrow => "ChlorophyteArrow"
  | CrystalLeaf => "CrystalLeaf"
  | CrystalLeafShot => "CrystalLeafShot"
  | SporeCloud => "SporeCloud"
  | ChlorophyteOrb => "ChlorophyteOrb"
  | AmethystHook => "AmethystHook"
  | TopazHook => "TopazHook"
  | SapphireHook => "SapphireHook"
  | EmeraldHook => "EmeraldHook"
  | RubyHook => "RubyHook"
  | DiamondHook => "DiamondHook"
  | BabyDino => "BabyDino"
  | RainCloudMoving => "RainCloudMoving"
  | RainCloudRaining => "RainCloudRaining"
  | RainFriendly => "RainFriendly"
  | Cannonball => "Cannonball"
  | CrimsandBallFalling => "CrimsandBallFalling"
  | HighVelocityBullet => "HighVelocityBullet"
  | BloodCloudMoving => "BloodCloudMoving"
  | BloodCloudRaining => "BloodCloudRaining"
  | BloodRain => "BloodRain"
  | StyngerBolt => "StyngerBolt"
  | FlowerPow => "FlowerPow"
  | FlowerPowPetal => "FlowerPowPetal"
  | StyngerBoltShrapnel => "StyngerBoltShrapnel"
  | RainbowFront => "RainbowFront"
  | RainbowBack => "RainbowBack"
  | ChlorophyteJackhammer => "ChlorophyteJackhammer"
  | BallofFrost => "BallofFrost"
  | MagnetSphereBall => "MagnetSphereBall"
  | MagnetSphereBolt => "MagnetSphereBolt"
  | SkeletronHand => "SkeletronHand"
  | FrostBeam => "FrostBeam"
  | Fireball => "Fireball"
  | EyeBeam => "EyeBeam"
  | HeatRay => "HeatRay"
  | BoulderStaffofEarth => "BoulderStaffofEarth"
  | GolemFist => "GolemFist"
  | IceSickle => "IceSickle"
  | Rain => "Rain"
  | PoisonFang => "PoisonFang"
  | BabySlime => "BabySlime"
  | PoisonDartWeapon => "PoisonDartWeapon"
  | EyeSpring => "EyeSpring"
  | BabySnowman => "BabySnowman"
  | Skull => "Skull"
  | BoxingGlove => "BoxingGlove"
  | Bananarang => "Bananarang"
  | ChainKnife => "ChainKnife"
  | DeathSickle => "DeathSickle"
  | PlanteraSeed => "PlanteraSeed"
  | PoisonSeed => "PoisonSeed"
  | ThornBall => "ThornBall"
  | IchorArrow => "IchorArrow"
  | IchorBullet => "IchorBullet"
  | GoldenShowerFriendly => "GoldenShowerFriendly"
  | ExplosiveBunny => "ExplosiveBunny"
  | VenomArrow => "VenomArrow"
  | VenomBullet => "VenomBullet"
  | PartyBullet => "PartyBullet"
  | NanoBullet => "NanoBullet"
  | ExplosiveBullet => "ExplosiveBullet"
  | GoldenBullet => "GoldenBullet"
  | GoldenShowerHostile => "GoldenShowerHostile"
  | ConfettiFlaskofParty => "ConfettiFlaskofParty"
  | ShadowBeamHostile => "ShadowBeamHostile"
  | InfernoBoltHostile => "InfernoBoltHostile"
  | InfernoBlastHostile => "InfernoBlastHostile"
  | LostSoulHostile => "LostSoulHostile"
  | ShadowBeamFriendly => "ShadowBeamFriendly"
  | InfernoBoltFriendly => "InfernoBoltFriendly"
  | InfernoBlastFriendly => "InfernoBlastFriendly"
  | LostSoulFriendly => "LostSoulFriendly"
  | SpiritHeal => "SpiritHeal"
  | Shadowflames => "Shadowflames"
  | PaladinsHammerHostile => "PaladinsHammerHostile"
  | PaladinsHammerFriendly => "PaladinsHammerFriendly"
  | SniperBullet => "SniperBullet"
  | SkeletonCommandoRocket => "SkeletonCommandoRocket"
  | VampireKnife => "VampireKnife"
  | VampireHeal => "VampireHeal"
  | EatersBite => "EatersBite"
  | TinyEater => "TinyEater"
  | FrostHydra => "FrostHydra"
  | FrostBlast => "FrostBlast"
  | BlueFlare => "BlueFlare"
  | CandyCorn => "CandyCorn"
  | JackOLantern => "JackOLantern"
  | Spider => "Spider"
  | Squashling => "Squashling"
  | BatHook => "BatHook"
  | Bat => "Bat"
  | Raven => "Raven"
  | RottenEgg => "RottenEgg"
  | BlackCat => "BlackCat"
  | BloodyMachete => "BloodyMachete"
  | FlamingJack => "FlamingJack"
  | WoodHook => "WoodHook"
  | Stake => "Stake"
  | CursedSapling => "CursedSapling"
  | FlamingWood => "FlamingWood"
  | GreekFire1 => "GreekFire1"
  | GreekFire2 => "GreekFire2"
  | GreekFire3 => "GreekFire3"
  | FlamingScythe => "FlamingScythe"
  | StarAnise => "StarAnise"
  | CandyCaneHook => "CandyCaneHook"
  | ChristmasHook => "ChristmasHook"
  | FruitcakeChakram => "FruitcakeChakram"
  | Puppy => "Puppy"
  | OrnamentFriendly => "OrnamentFriendly"
  | PineNeedleFriendly => "PineNeedleFriendly"
  | Blizzard => "Blizzard"
  | SnowmanRocketI => "SnowmanRocketI"
  | SnowmanRocketII => "SnowmanRocketII"
  | SnowmanRocketIII => "SnowmanRocketIII"
  | SnowmanRocketIV => "SnowmanRocketIV"
  | NorthPole => "NorthPole"
  | NorthPoleSpearProjectile => "NorthPoleSpearProjectile"
  | NorthPoleSnowFlake => "NorthPoleSnowFlake"
  | PineNeedle => "PineNeedle"
  | OrnamentHostile => "OrnamentHostile"
  | OrnamentShrapnel => "OrnamentShrapnel"
  | FrostWave => "FrostWave"
  | FrostShard => "FrostShard"
  | Missile => "Missile"
  | Present => "Present"
  | Spike => "Spike"
  | BabyGrinch => "BabyGrinch"
  | CrimsandBallSandgun => "CrimsandBallSandgun"
  | VenomFang => "VenomFang"
  | SpectreWrath => "SpectreWrath"
  | PulseBolt => "PulseBolt"
  | WaterGun => "WaterGun"
  | FrostBolt => "FrostBolt"
  | WoodBobber => "WoodBobber"
  | ReinforcedBobber => "ReinforcedBobber"
  | FiberglassBobber => "FiberglassBobber"
  | FisherofSoulsBobber => "FisherofSoulsBobber"
  | GoldenBobber => "GoldenBobber"
  | MechanicsBobber => "MechanicsBobber"
  | SittingDucksBobber => "SittingDucksBobber"
  | ObsidianSwordfish => "ObsidianSwordfish"
  | Swordfish => "Swordfish"
  | SawtoothShark => "SawtoothShark"
  | LovePotion => "LovePotion"
  | FoulPotion => "FoulPotion"
  | FishHook => "FishHook"
  | Hornet => "Hornet"
  | HornetStinger => "HornetStinger"
  | FlyingImp => "FlyingImp"
  | ImpFireball => "ImpFireball"
  | SpiderTurret => "SpiderTurret"
  | SpiderEgg => "SpiderEgg"
  | BabySpider => "BabySpider"
  | ZephyrFish => "ZephyrFish"
  | FleshCatcherBobber => "FleshCatcherBobber"
  | HotlineBobber => "HotlineBobber"
  | Anchor => "Anchor"
  | Sharknado => "Sharknado"
  | SharknadoBolt => "SharknadoBolt"
  | Cthulunado => "Cthulunado"
  | Retanimini => "Retanimini"
  | Spazmamini => "Spazmamini"
  | MiniRetinaLaser => "MiniRetinaLaser"
  | VenomSpider => "VenomSpider"
  | JumperSpider => "JumperSpider"
  | DangerousSpider => "DangerousSpider"
  | OneEyedPirate => "OneEyedPirate"
  | SoulscourgePirate => "SoulscourgePirate"
  | PirateCaptain => "PirateCaptain"
  | SlimeHook => "SlimeHook"
  | StickyGrenade => "StickyGrenade"
  | MiniMinotaur => "MiniMinotaur"
  | MolotovCocktail => "MolotovCocktail"
  | MolotovFire1 => "MolotovFire1"
  | MolotovFire2 => "MolotovFire2"
  | MolotovFire3 => "MolotovFire3"
  | TrackHook => "TrackHook"
  | Flairon => "Flairon"
  | FlaironBubble => "FlaironBubble"
  | SlimeGun => "SlimeGun"
  | Tempest => "Tempest"
  | MiniSharkron => "MiniSharkron"
  | Typhoon => "Typhoon"
  | Bubble => "Bubble"
  | CopperCoins => "CopperCoins"
  | SilverCoins => "SilverCoins"
  | GoldCoins => "GoldCoins"
  | PlatinumCoins => "PlatinumCoins"
  | FireWorkRocketRed => "FireWorkRocketRed"
  | FireWorkRocketGreen => "FireWorkRocketGreen"
  | FireWorkRocketBlue => "FireWorkRocketBlue"
  | FireWorkRocketYellow => "FireWorkRocketYellow"
  | FireworkFountainYellow => "FireworkFountainYellow"
  | FireworkFountainRed => "FireworkFountainRed"
  | FireworkFountainBlue => "FireworkFountainBlue"
  | FireworkFountainRainbow => "FireworkFountainRainbow"
  | UFO => "UFO"
  | Meteor1 => "Meteor1"
  | Meteor2 => "Meteor2"
  | Meteor3 => "Meteor3"
  | VortexChainsaw => "VortexChainsaw"
  | VortexDrill => "VortexDrill"
  | NebulaChainsaw => "NebulaChainsaw"
  | NebulaDrill => "NebulaDrill"
  | SolarFlareChainsaw => "SolarFlareChainsaw"
  | SolarFlareDrill => "SolarFlareDrill"
  | UFORay => "UFORay"
  | ScutlixLaser => "ScutlixLaser"
  | ElectricBolt => "ElectricBolt"
  | BrainScramblingBolt => "BrainScramblingBolt"
  | GigazapperSpearhead => "GigazapperSpearhead"
  | LaserRay => "LaserRay"
  | LaserMachinegun => "LaserMachinegun"
  | LaserMachinegunLaser => "LaserMachinegunLaser"
  | ScutlixCrosshair => "ScutlixCrosshair"
  | ElectrosphereMissile => "ElectrosphereMissile"
  | Electrosphere => "Electrosphere"
  | Xenopopper => "Xenopopper"
  | LaserDrill => "LaserDrill"
  | AntiGravityHook => "AntiGravityHook"
  | MartianDeathray => "MartianDeathray"
  | MartianRocket => "MartianRocket"
  | SaucerLaser => "SaucerLaser"
  | SaucerScrap => "SaucerScrap"
  | InfluxWaver => "InfluxWaver"
  | PhantasmalEye => "PhantasmalEye"
  | DrillCrosshair => "DrillCrosshair"
  | PhantasmalSphere => "PhantasmalSphere"
  | PhantasmalDeathray => "PhantasmalDeathray"
  | MoonLeech => "MoonLeech"
  | PhasicWarpEjector => "PhasicWarpEjector"
  | PhasicWarpDisc => "PhasicWarpDisc"
  | ChargedBlasterOrb => "ChargedBlasterOrb"
  | ChargedBlasterCannon => "ChargedBlasterCannon"
  | ChargedBlasterLaser => "ChargedBlasterLaser"
  | PhantasmalBolt => "PhantasmalBolt"
  | ViciousPowder => "ViciousPowder"
  | IceMist => "IceMist"
  | LightningOrb => "LightningOrb"
  | LightningOrbArc => "LightningOrbArc"
  | CultistFireball => "CultistFireball"
  | ShadowFireball => "ShadowFireball"
  | BeeArrow => "BeeArrow"
  | StickyDynamite => "StickyDynamite"
  | SkeletonMerchantBone => "SkeletonMerchantBone"
  | Webspit => "Webspit"
  | SpelunkerGlowstick => "SpelunkerGlowstick"
  | BoneArrowAmmo => "BoneArrowAmmo"
  | VineRopeCoil => "VineRopeCoil"
  | SoulDrain => "SoulDrain"
  | CrystalDart => "CrystalDart"
  | CursedDart => "CursedDart"
  | IchorDart => "IchorDart"
  | CursedFlameClingerStaff => "CursedFlameClingerStaff"
  | ChainGuillotine => "ChainGuillotine"
  | CursedFlames => "CursedFlames"
  | SeedlerNut => "SeedlerNut"
  | SeedlerThorn => "SeedlerThorn"
  | Hellwing => "Hellwing"
  | TendonHook => "TendonHook"
  | ThornHook => "ThornHook"
  | IlluminantHook => "IlluminantHook"
  | WormHook => "WormHook"
  | LightningRitual => "LightningRitual"
  | FlyingKnife => "FlyingKnife"
  | MagicLantern => "MagicLantern"
  | CrystalVileShardHead => "CrystalVileShardHead"
  | CrystalVileShardShaft => "CrystalVileShardShaft"
  | ShadowflameArrow => "ShadowflameArrow"
  | Shadowflame => "Shadowflame"
  | ShadowflameKnife => "ShadowflameKnife"
  | NailHostile => "NailHostile"
  | BabyFaceMonster => "BabyFaceMonster"
  | CrimsonHeart => "CrimsonHeart"
  | Flask => "Flask"
  | Meowmere => "Meowmere"
  | StarWrath => "StarWrath"
  | Spark => "Spark"
  | SilkRopeCoil => "SilkRopeCoil"
  | WebRopeCoil => "WebRopeCoil"
  | JavelinFriendly => "JavelinFriendly"
  | JavelinHostile => "JavelinHostile"
  | ButchersChainsaw => "ButchersChainsaw"
  | ToxicFlask => "ToxicFlask"
  | ToxicCloud1 => "ToxicCloud1"
  | ToxicCloud2 => "ToxicCloud2"
  | ToxicCloud3 => "ToxicCloud3"
  | Nail => "Nail"
  | BouncyGlowstick => "BouncyGlowstick"
  | BouncyBomb => "BouncyBomb"
  | BouncyGrenade => "BouncyGrenade"
  | CoinPortal => "CoinPortal"
  | BombFish => "BombFish"
  | FrostDaggerfish => "FrostDaggerfish"
  | CrystalCharge1 => "CrystalCharge1"
  | CrystalCharge2 => "CrystalCharge2"
  | ToxicBubble => "ToxicBubble"
  | IchorSplash => "IchorSplash"
  | FlyingPiggyBank => "FlyingPiggyBank"
  | Energy => "Energy"
  | GoldenCrossGraveMarker => "GoldenCrossGraveMarker"
  | GoldenTombstone => "GoldenTombstone"
  | GoldenGraveMarker => "GoldenGraveMarker"
  | GoldenGraveStone => "GoldenGraveStone"
  | GoldenHeadStone => "GoldenHeadStone"
  | XBone => "XBone"
  | DeadlySphere => "DeadlySphere"
  | Code1 => "Code1"
  | MedusaHead => "MedusaHead"
  | MedusaHeadRay => "MedusaHeadRay"
  | StardustLaser => "StardustLaser"
  | Twinkle => "Twinkle"
  | FlowInvader => "FlowInvader"
  | Starmark => "Starmark"
  | WoodenYoyo => "WoodenYoyo"
  | Malaise => "Malaise"
  | Artery => "Artery"
  | Amazon => "Amazon"
  | Cascase => "Cascase"
  | Chik => "Chik"
  | Code2 => "Code2"
  | Rally => "Rally"
  | Yelets => "Yelets"
  | RedsThrow => "RedsThrow"
  | ValkyrieYoyo => "ValkyrieYoyo"
  | Amarok => "Amarok"
  | HelFire => "HelFire"
  | Kraken => "Kraken"
  | TheEyeofCthulhuYoyo => "TheEyeofCthulhuYoyo"
  | BLackCounterweight => "BLackCounterweight"
  | BlueCounterweight => "BlueCounterweight"
  | GreenCounterweight => "GreenCounterweight"
  | PurpleCounterweight => "PurpleCounterweight"
  | RedCounterweight => "RedCounterweight"
  | YellowCounterweight => "YellowCounterweight"
  | FormatC => "FormatC"
  | Gradient => "Gradient"
  | Valor => "Valor"
  | BrainofConfusion => "BrainofConfusion"
  | GiantBee => "GiantBee"
  | SporeTrap => "SporeTrap"
  | SporeTrap2 => "SporeTrap2"
  | SporeGas1 => "SporeGas1"
  | SporeGas2 => "SporeGas2"
  | SporeGas3 => "SporeGas3"
  | PoisonSpit => "PoisonSpit"
  | NebulaPiercer => "NebulaPiercer"
  | NebulaEye => "NebulaEye"
  | NebulaSphere => "NebulaSphere"
  | NebulaLaser => "NebulaLaser"
  | VortexLaser => "VortexLaser"
  | VortexLightningPillar => "VortexLightningPillar"
  | Vortex => "Vortex"
  | VortexLightningPortal => "VortexLightningPortal"
  | AlienGoop => "AlienGoop"
  | MechanicsWrench => "MechanicsWrench"
  | SyringeDamage => "SyringeDamage"
  | SyringeHealing => "SyringeHealing"
  | SkullClothier => "SkullClothier"
  | Dryadsward => "Dryadsward"
  | Paintball => "Paintball"
  | ConfettiGrenade => "ConfettiGrenade"
  | ChristmasOrnament => "ChristmasOrnament"
  | TruffleSpore => "TruffleSpore"
  | MinecartLaser => "MinecartLaser"
  | LaserRayMartianWalker => "LaserRayMartianWalker"
  | ProphecysEnd => "ProphecysEnd"
  | BlowupSmokeFlyingDutchman => "BlowupSmokeFlyingDutchman"
  | Arkhalis => "Arkhalis"
  | DesertSpiritsCurse => "DesertSpiritsCurse"
  | AmberBolt => "AmberBolt"
  | BoneJavelin => "BoneJavelin"
  | BoneDagger => "BoneDagger"
  | PortalGun => "PortalGun"
  | PortalBolt => "PortalBolt"
  | PortalGate => "PortalGate"
  | Terrarian => "Terrarian"
  | TerrarianBeam => "TerrarianBeam"
  | SlimeSpike => "SlimeSpike"
  | Laser => "Laser"
  | SolarFlare => "SolarFlare"
  | SolarRadiance => "SolarRadiance"
  | StardustDrill => "StardustDrill"
  | StardustChainsaw => "StardustChainsaw"
  | SolarEruption => "SolarEruption"
  | SolarEruptionExplosion => "SolarEruptionExplosion"
  | StardustCell => "StardustCell"
  | StardustCellShot => "StardustCellShot"
  | VortexBeater => "VortexBeater"
  | VortexRocket => "VortexRocket"
  | NebulaArcanum => "NebulaArcanum"
  | NebulaArcanumSubShot => "NebulaArcanumSubShot"
  | NebulaArcanumExplosionShot => "NebulaArcanumExplosionShot"
  | NebulaArcanumExplosionShotShard => "NebulaArcanumExplosionShotShard"
  | BloodWater => "BloodWater"
  | BlowupSmoke => "BlowupSmoke"
  | StardustGuardian => "StardustGuardian"
  | Starburst => "Starburst"
  | StardustDragon1 => "StardustDragon1"
  | StardustDragon2 => "StardustDragon2"
  | StardustDragon3 => "StardustDragon3"
  | StardustDragon4 => "StardustDragon4"
  | ReleasedEnergy => "ReleasedEnergy"
  | Phantasm => "Phantasm"
  | PhantasmArrow => "PhantasmArrow"
  | LastPrismLaser => "LastPrismLaser"
  | LastPrism => "LastPrism"
  | NebulaBlaze => "NebulaBlaze"
  | NebulaBlazeEx => "NebulaBlazeEx"
  | Daybreak => "Daybreak"
  | BouncyDynamite => "BouncyDynamite"
  | LuminiteBullet => "LuminiteBullet"
  | LuminiteArrow => "LuminiteArrow"
  | LuminiteArrowTrail => "LuminiteArrowTrail"
  | LunarPortal => "LunarPortal"
  | LunarPortalLaser => "LunarPortalLaser"
  | RainbowCrystal => "RainbowCrystal"
  | RainbowExplosion => "RainbowExplosion"
  | LunarFlare => "LunarFlare"
  | LunarHookSolar => "LunarHookSolar"
  | LunarHookVortex => "LunarHookVortex"
  | LunarHookNebula => "LunarHookNebula"
  | LunarHookStardust => "LunarHookStardust"
  | SuspiciousLookingTentacle => "SuspiciousLookingTentacle"
  | WireKite => "WireKite"
  | StaticHook => "StaticHook"
  | CompanionCube => "CompanionCube"
  | Geyser => "Geyser"
  | BeeHive => "BeeHive"
  | AncientStormFriendly => "AncientStormFriendly"
  | AncientStormHostile => "AncientStormHostile"
  | AncientStormMark => "AncientStormMark"
  | SpiritFlame => "SpiritFlame"
  | SkyFracture => "SkyFracture"
  | OnyxBlaster => "OnyxBlaster"
  | EtherianJavelinT1 => "EtherianJavelinT1"
  | FlameburstTower1 => "FlameburstTower1"
  | FlameburstTowerShot1 => "FlameburstTowerShot1"
  | FlameburstTower2 => "FlameburstTower2"
  | FlameburstTowerShot2 => "FlameburstTowerShot2"
  | FlameburstTower3 => "FlameburstTower3"
  | FlameburstTowerShot3 => "FlameburstTowerShot3"
  | Ale => "Ale"
  | OgresStomp1 => "OgresStomp1"
  | Drakin => "Drakin"
  | GrimEnd => "GrimEnd"
  | DarkSigil1 => "DarkSigil1"
  | DarkSigil2 => "DarkSigil2"
  | DarkEnergy => "DarkEnergy"
  | OgreSpit => "OgreSpit"
  | Ballista1 => "Ballista1"
  | Ballista2 => "Ballista2"
  | Ballista3 => "Ballista3"
  | BallistaShot => "BallistaShot"
  | GoblinBomb => "GoblinBomb"
  | WitheringBolt => "WitheringBolt"
  | OgresStomp => "OgresStomp"
  | HeartySlash => "HeartySlash"
  | EtherianJavelinT3 => "EtherianJavelinT3"
  | BetsysFireball => "BetsysFireball"
  | BetsysBreath => "BetsysBreath"
  | LightningAura1 => "LightningAura1"
  | LightningAura2 => "LightningAura2"
  | LightningAura3 => "LightningAura3"
  | ExplosiveTrap1 => "ExplosiveTrap1"
  | ExplosiveTrap2 => "ExplosiveTrap2"
  | ExplosiveTrap3 => "ExplosiveTrap3"
  | ExplosiveTrapShot1 => "ExplosiveTrapShot1"
  | ExplosiveTrapShot2 => "ExplosiveTrapShot2"
  | ExplosiveTrapShot3 => "ExplosiveTrapShot3"
  | SleepyOctopod => "SleepyOctopod"
  | PoleSmash => "PoleSmash"
  | GhastlyGlaive => "GhastlyGlaive"
  | Ghast => "Ghast"
  | Hoardagron => "Hoardagron"
  | Flickerwick => "Flickerwick"
  | PropellerGato => "PropellerGato"
  | WhirlwindofInfiniteWisdom => "WhirlwindofInfiniteWisdom"
  | PhantomPhoenix => "PhantomPhoenix"
  | PhantomPhoenixPheonix => "PhantomPhoenixPheonix"
  | SkyDragonsFury1 => "SkyDragonsFury1"
  | SkyDragonsFury2 => "SkyDragonsFury2"
  | SkyDragonsFuryShot => "SkyDragonsFuryShot"
  | AerialBane => "AerialBane"
  | BetsysWrath => "BetsysWrath"
  | TomeofInfiniteWisdom => "TomeofInfiniteWisdom"
  | VictoryDD2 => "VictoryDD2"
  | CelebrationMk2 => "CelebrationMk2"
  | Celeb2Rocket => "Celeb2Rocket"
  | Celeb2RocketExplosive => "Celeb2RocketExplosive"
  | Celeb2RocketLarge => "Celeb2RocketLarge"
  | Celeb2RocketExplosiveLarge => "Celeb2RocketExplosiveLarge"
  | QueenBeesStinger => "QueenBeesStinger"
  | FallingStarSpawnerAnimation => "FallingStarSpawnerAnimation"
  | GolfBall => "GolfBall"
  | GolfClub => "GolfClub"
  | ManaCloak => "ManaCloak"
  | BeeCloak => "BeeCloak"
  | StarVeil => "StarVeil"
  | StarCloak => "StarCloak"
  | RollingCactus => "RollingCactus"
  | SuperStarCannonStar => "SuperStarCannonStar"
  | SuperStarCannonAnimation => "SuperStarCannonAnimation"
  | StormSpear => "StormSpear"
  | ThunderZapper => "ThunderZapper"
  | StormSpearShot => "StormSpearShot"
  | ToiletEffect => "ToiletEffect"
  | VoidLens => "VoidLens"
  | Terragrim => "Terragrim"
  | DungeonDebrisBlue => "DungeonDebrisBlue"
  | DungeonDebrisGreen => "DungeonDebrisGreen"
  | DungeonDebrisPink => "DungeonDebrisPink"
  | BlackGolfBall => "BlackGolfBall"
  | BlueGolfBall => "BlueGolfBall"
  | BrownGolfBall => "BrownGolfBall"
  | CyanGolfBall => "CyanGolfBall"
  | GreenGolfBall => "GreenGolfBall"
  | LimeGolfBall => "LimeGolfBall"
  | OrangeGolfBall => "OrangeGolfBall"
  | PinkGolfBall => "PinkGolfBall"
  | PurpleGolfBall => "PurpleGolfBall"
  | RedGolfBall => "RedGolfBall"
  | SkyBlueGolfBall => "SkyBlueGolfBall"
  | TealGolfBall => "TealGolfBall"
  | VioletGolfBall => "VioletGolfBall"
  | YellowGolfBall => "YellowGolfBall"
  | AmberHook => "AmberHook"
  | MysticSnakeCoil => "MysticSnakeCoil"
  | SanguineBat => "SanguineBat"
  | BloodThorn => "BloodThorn"
  | DripplerCrippler2 => "DripplerCrippler2"
  | VampireFrog => "VampireFrog"
  | Finch => "Finch"
  | BobberBloody => "BobberBloody"
  | PaperAirplane => "PaperAirplane"
  | PaperAirplaneWhite => "PaperAirplaneWhite"
  | RollingCactusSpike => "RollingCactusSpike"
  | UpbeatStar => "UpbeatStar"
  | SugarGlider => "SugarGlider"
  | KiteBlue => "KiteBlue"
  | KiteBlueAndYellow => "KiteBlueAndYellow"
  | KiteRed => "KiteRed"
  | KiteRedAndYellow => "KiteRedAndYellow"
  | KiteYellow => "KiteYellow"
  | KiteWyvern => "KiteWyvern"
  | Geode => "Geode"
  | ScarabBomb => "ScarabBomb"
  | SharkPup => "SharkPup"
  | BobberScarab => "BobberScarab"
  | ClusterRocketI => "ClusterRocketI"
  | ClusterGrenadeI => "ClusterGrenadeI"
  | ClusterProximityMineI => "ClusterProximityMineI"
  | ClusterFragmentI => "ClusterFragmentI"
  | ClusterRocketII => "ClusterRocketII"
  | ClusterGrenadeII => "ClusterGrenadeII"
  | ClusterProximityMineII => "ClusterProximityMineII"
  | ClusterFragmentII => "ClusterFragmentII"
  | WetRocket => "WetRocket"
  | WetGrenade => "WetGrenade"
  | WetProximityMine => "WetProximityMine"
  | LavaRocket => "LavaRocket"
  | LavaGrenade => "LavaGrenade"
  | LavaProximityMine => "LavaProximityMine"
  | HoneyRocket => "HoneyRocket"
  | HoneyGrenade => "HoneyGrenade"
  | HoneyProximityMine => "HoneyProximityMine"
  | MiniNukeRocketI => "MiniNukeRocketI"
  | MiniNukeGrenadeI => "MiniNukeGrenadeI"
  | MiniNukeProximityMineI => "MiniNukeProximityMineI"
  | MiniNukeRocketII => "MiniNukeRocketII"
  | MiniNukeGrenadeII => "MiniNukeGrenadeII"
  | MiniNukeProximityMineII => "MiniNukeProximityMineII"
  | DryRocket => "DryRocket"
  | DryGrenade => "DryGrenade"
  | DryProximityMine => "DryProximityMine"
  | Gladius => "Gladius"
  | ClusterSnowmanRocketI => "ClusterSnowmanRocketI"
  | ClusterSnowmanRocketII => "ClusterSnowmanRocketII"
  | WetSnowmanRocket => "WetSnowmanRocket"
  | LavaSnowmanRocket => "LavaSnowmanRocket"
  | HoneySnowmanRocket => "HoneySnowmanRocket"
  | MiniNukeSnowmanRocketI => "MiniNukeSnowmanRocketI"
  | MiniNukeSnowmanRocketII => "MiniNukeSnowmanRocketII"
  | DrySnowmanRocket => "DrySnowmanRocket"
  | BloodShot => "BloodShot"
  | ShellPile => "ShellPile"
  | BloodTears => "BloodTears"
  | BloodShotNautilus => "BloodShotNautilus"
  | LilHarpy => "LilHarpy"
  | FennecFox => "FennecFox"
  | GlitteryButterfly => "GlitteryButterfly"
  | DesertTiger1 => "DesertTiger1"
  | BloodRainArrow => "BloodRainArrow"
  | ChumBucket => "ChumBucket"
  | BabyImp => "BabyImp"
  | KiteBoneSerpent => "KiteBoneSerpent"
  | KiteWorldFeeder => "KiteWorldFeeder"
  | KiteBunny => "KiteBunny"
  | BabyRedPanda => "BabyRedPanda"
  | KitePigron => "KitePigron"
  | KiteManEater => "KiteManEater"
  | KiteJellyfishBlue => "KiteJellyfishBlue"
  | KiteJellyfishPink => "KiteJellyfishPink"
  | KiteShark => "KiteShark"
  | DesertTiger2 => "DesertTiger2"
  | DesertTiger3 => "DesertTiger3"
  | DesertTigerT1 => "DesertTigerT1"
  | DesertTigerT2 => "DesertTigerT2"
  | DesertTigerT3 => "DesertTigerT3"
  | DandelionSeed => "DandelionSeed"
  | BookofSkulls => "BookofSkulls"
  | KiteSandShark => "KiteSandShark"
  | KiteBunnyCorrupt => "KiteBunnyCorrupt"
  | KiteBunnyCrimson => "KiteBunnyCrimson"
  | LeatherWhip => "LeatherWhip"
  | Ruler => "Ruler"
  | KiteGoldfish => "KiteGoldfish"
  | KiteAngryTrapper => "KiteAngryTrapper"
  | KiteKoi => "KiteKoi"
  | KiteCrawltipede => "KiteCrawltipede"
  | Durendal => "Durendal"
  | MorningStar => "MorningStar"
  | DarkHarvest => "DarkHarvest"
  | KiteSpectrum => "KiteSpectrum"
  | ReleaseDoves => "ReleaseDoves"
  | KiteWanderingEye => "KiteWanderingEye"
  | KiteUnicorn => "KiteUnicorn"
  | Plantero => "Plantero"
  | ReleaseLantern => "ReleaseLantern"
  | StellarTune => "StellarTune"
  | FirstFractal => "FirstFractal"
  | DynamiteKitten => "DynamiteKitten"
  | BabyWerewolf => "BabyWerewolf"
  | ShadowMimic => "ShadowMimic"
  | Football => "Football"
  | SnowmanClusterFragment1 => "SnowmanClusterFragment1"
  | SnowmanClusterFragment2 => "SnowmanClusterFragment2"
  | EnchantedDagger => "EnchantedDagger"
  | SquirrelHook => "SquirrelHook"
  | SergeantUnitedShield => "SergeantUnitedShield"
  | Shroomerang => "Shroomerang"
  | TreeGlobe => "TreeGlobe"
  | WorldGlobe => "WorldGlobe"
  | FairyGlowstick => "FairyGlowstick"
  | HallowBossSplitShotCore => "HallowBossSplitShotCore"
  | EverlastingRainbow => "EverlastingRainbow"
  | PrismaticBolt => "PrismaticBolt"
  | HallowBossDeathAurora => "HallowBossDeathAurora"
  | VoltBunny => "VoltBunny"
  | Zapinator => "Zapinator"
  | JoustingLance => "JoustingLance"
  | ShadowJoustingLance => "ShadowJoustingLance"
  | HallowedJoustingLance => "HallowedJoustingLance"
  | ZoologistStrikeGreen => "ZoologistStrikeGreen"
  | KingSlimePet => "KingSlimePet"
  | EyeOfCthulhuPet => "EyeOfCthulhuPet"
  | EaterOfWorldsPet => "EaterOfWorldsPet"
  | BrainOfCthulhuPet => "BrainOfCthulhuPet"
  | SkeletronPet => "SkeletronPet"
  | QueenBeePet => "QueenBeePet"
  | DestroyerPet => "DestroyerPet"
  | TwinsPet => "TwinsPet"
  | SkeletronPrimePet => "SkeletronPrimePet"
  | PlanteraPet => "PlanteraPet"
  | GolemPet => "GolemPet"
  | DukeFishronPet => "DukeFishronPet"
  | LunaticCultistPet => "LunaticCultistPet"
  | MoonLordPet => "MoonLordPet"
  | FairyQueenPet => "FairyQueenPet"
  | PumpkingPet => "PumpkingPet"
  | EverscreamPet => "EverscreamPet"
  | IceQueenPet => "IceQueenPet"
  | MartianPet => "MartianPet"
  | DD2OgrePet => "DD2OgrePet"
  | DD2BetsyPet => "DD2BetsyPet"
  | CombatWrench => "CombatWrench"
  | WetBomb => "WetBomb"
  | LavaBomb => "LavaBomb"
  | HoneyBomb => "HoneyBomb"
  | DryBomb => "DryBomb"
  | OrnamentTreeSword => "OrnamentTreeSword"
  | TitaniumShard => "TitaniumShard"
  | Rock => "Rock"
  | DirtBomb => "DirtBomb"
  | StickyDirtBomb => "StickyDirtBomb"
  | CoolWhip => "CoolWhip"
  | FirecrackerWhip1 => "FirecrackerWhip1"
  | Snapthorn => "Snapthorn"
  | Kaleidoscope => "Kaleidoscope"
  | Reaping => "Reaping"
  | CoolFlake => "CoolFlake"
  | FirecrackerWhip2 => "FirecrackerWhip2"
  | EtherealLance => "EtherealLance"
  | CrystalSpike => "CrystalSpike"
  | BouncyGel => "BouncyGel"
  | QueenlySmash => "QueenlySmash"
  | SunDance => "SunDance"
  | FairyQueenHymn => "FairyQueenHymn"
  | StardustGuardianPunch => "StardustGuardianPunch"
  | RegalGel => "RegalGel"
  | Starlight => "Starlight"
  | DripplerCrippler1 => "DripplerCrippler1"
  | ZoologistStrikeRed => "ZoologistStrikeRed"
  | SantankRocket => "SantankRocket"
  | Nightglow => "Nightglow"
  | TwilightLance => "TwilightLance"
  | Zenith => "Zenith"
  | QueenSlimePet => "QueenSlimePet"
  | QueenSlimeHook => "QueenSlimeHook"
  | SparkleSlimeBalloon => "SparkleSlimeBalloon"
  | VolatileGelatin => "VolatileGelatin"
  | CopperShortsword => "CopperShortsword"
  | TinShortsword => "TinShortsword"
  | IronShortsword => "IronShortsword"
  | LeadShortsword => "LeadShortsword"
  | SilverShortsword => "SilverShortsword"
  | TungstenShortsword => "TungstenShortsword"
  | GoldShortsword => "GoldShortsword"
  | PlatinumShortsword => "PlatinumShortsword"
  | Terraprisma => "Terraprisma"
  | Mace => "Mace"
  | FlamingMace => "FlamingMace"
  | TheTorchGod => "TheTorchGod"
  | PrincessWeapon => "PrincessWeapon"
  | FlinxMinion => "FlinxMinion"
  | BoneWhip => "BoneWhip"
  | DaybreakExplosion => "DaybreakExplosion"
  | WandOfSparkingSpark => "WandOfSparkingSpark"
  | StarCannonStar => "StarCannonStar"
  | BerniePet => "BerniePet"
  | GlommerPet => "GlommerPet"
  | DeerclopsPet => "DeerclopsPet"
  | PigPet => "PigPet"
  | ChesterPet => "ChesterPet"
  | DeerclopsIceSpike => "DeerclopsIceSpike"
  | DeerclopsRangedProjectile => "DeerclopsRangedProjectile"
  | AbigailMinion => "AbigailMinion"
  | InsanityShadowFriendly => "InsanityShadowFriendly"
  | InsanityShadowHostile => "InsanityShadowHostile"
  | HoundiusShootius => "HoundiusShootius"
  | HoundiusShootiusFireball => "HoundiusShootiusFireball"
  | PewMaticHornShot => "PewMaticHornShot"
  | WeatherPainShot => "WeatherPainShot"
  | AbigailCounter => "AbigailCounter"
  | TentacleSpike => "TentacleSpike"
  | NightsEdge => "NightsEdge"
  | TrueNightsEdge => "TrueNightsEdge"
  | LightsBane => "LightsBane"
  | BloodButcherer => "BloodButcherer"
  | BladeOfGrass => "BladeOfGrass"
  | Muramasa => "Muramasa"
  | Volcano => "Volcano"
  | WandOfFrostingFrost => "WandOfFrostingFrost"
  | VenomDartTrap => "VenomDartTrap"
  | SilverBullet => "SilverBullet"
  | Excalibur => "Excalibur"
  | TrueExcalibur => "TrueExcalibur"
  | TerraBlade2 => "TerraBlade2"
  | TerraBlade2Shot => "TerraBlade2Shot"
  | FishingBobber => "FishingBobber"
  | FishingBobberGlowingStar => "FishingBobberGlowingStar"
  | FishingBobberGlowingLava => "FishingBobberGlowingLava"
  | FishingBobberGlowingKrypton => "FishingBobberGlowingKrypton"
  | FishingBobberGlowingXenon => "FishingBobberGlowingXenon"
  | FishingBobberGlowingArgon => "FishingBobberGlowingArgon"
  | FishingBobberGlowingViolet => "FishingBobberGlowingViolet"
  | FishingBobberGlowingRainbow => "FishingBobberGlowingRainbow"
  | JunimoPet => "JunimoPet"
  | JuminoStardropAnimation => "JuminoStardropAnimation"
  | MoonGlobe => "MoonGlobe"
  | TheHorsemansBlade => "TheHorsemansBlade"
  | BlueChickenPet => "BlueChickenPet"
  | HiveFive => "HiveFive"
  | Trimarang => "Trimarang"
  | HorsemanPumpkin => "HorsemanPumpkin"
  | TntBarrel => "TntBarrel"
  | Spiffo => "Spiffo"
  | CavelingGardener => "CavelingGardener"
  | MiniBoulder => "MiniBoulder"
  | ShimmerArrow => "ShimmerArrow"
  | GasTrap => "GasTrap"
  | SpelunkerFlare => "SpelunkerFlare"
  | CursedFlare => "CursedFlare"
  | RainbowFlare => "RainbowFlare"
  | ShimmerFlare => "ShimmerFlare"
  | Waffle => "Waffle"
  | BouncyBoulder => "BouncyBoulder"
  | LifeCrystalBoulder => "LifeCrystalBoulder"
  | SandSpray => "SandSpray"
  | SnowSpray => "SnowSpray"
  | DirtSpray => "DirtSpray"
  | DirtiestBlock => "DirtiestBlock"
  | Fertilizer => "Fertilizer"
  | JimsDrone => "JimsDrone"
  | MoonBoulder => "MoonBoulder"
  }
