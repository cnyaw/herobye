
local beg_money_lvl_id = 293
local curcus_tex_id = 73
local island_field_lvl_id = 455
local janken_lib_lvl_id = 217
local temple_tex_id = 50

QuestData = {
  -- Main map, hero mt.
  [1000] = {TalkId = 2, NextCond = IsSendTeacherLetterValid, NextId = 1001},
  [1001] = {TalkId = 52, RedPt = 1, NextId = 1002},
  [1002] = {TalkId = 2, NextCond = IsTempleCrowdFunding, NextId = 1003},
  [1003] = {TalkId = 2, NextCond = HasBackScratcher, NextId = 1004},
  [1004] = {TalkId = 53, RedPt = 1, NextId = 1005},
  [1005] = {TalkId = 53},
  -- Main map, shop.
  [2000] = {TalkId = 450, NextCond = IsBuyBou2Valid, NextId = 2001},
  [2001] = {TalkId = 300, RedPt = 1, NextId = 2002},
  [2002] = {TalkId = 450, NextCond = IsBuyBou3Valid, NextId = 2003},
  [2003] = {TalkId = 400, RedPt = 1, NextId = 2004},
  [2004] = {TalkId = 450, NextCond = IsOpenRacingValid, NextId = 2005},
  [2005] = {TalkId = 510, RedPt = 1, NextId = 2006},
  [2006] = {TalkId = 511, TexId = curcus_tex_id, NextCond = IsGiveGodzillaValid, NextId = 2007},
  [2007] = {TalkId = 512, TexId = curcus_tex_id, RedPt = 1, NextId = 2008},
  [2008] = {TalkId = 511, TexId = curcus_tex_id},
  -- Main map, village.
  [3000] = {LevelId = beg_money_lvl_id},
  -- Main map, church.
  [4000] = {TalkId = 1000, NextCond = IsTransLetterToPriestValid, NextId = 4001},
  [4001] = {TalkId = 1150, RedPt = 1, NextId = 4002},
  [4002] = {TalkId = 1000, NextCond = IsChurch2ndDreamValid, NextId = 4003},
  [4003] = {TalkId = 1152, RedPt = 1, NextId = 4004},
  [4004] = {TalkId = 1153, NextCond = IsRestValid, NextId = 4005},
  [4005] = {TalkId = 1154, NextCond = NotRestValid, NextId = 4004},
  -- Main map, bag.
  [5000] = {LevelId = BAG_LVL_ID, NextCond = HasBou2, NextId = 5001},
  [5001] = {LevelId = BAG_LVL_ID, NextCond = TrueCond, RedPt = 1, NextId = 5002},
  [5002] = {LevelId = BAG_LVL_ID, NextCond = HasBou3, NextId = 5003},
  [5003] = {LevelId = BAG_LVL_ID, NextCond = TrueCond, RedPt = 1, NextId = 5004},
  [5004] = {LevelId = BAG_LVL_ID, NextCond = HasLetter, NextId = 5005},
  [5005] = {LevelId = BAG_LVL_ID, NextCond = TrueCond, RedPt = 1, NextId = 5006},
  [5006] = {LevelId = BAG_LVL_ID, NextCond = HasGodzilla, NextId = 5007},
  [5007] = {LevelId = BAG_LVL_ID, NextCond = TrueCond, RedPt = 1, NextId = 5008},
  [5008] = {LevelId = BAG_LVL_ID},
  -- Training map, brother 1.
  [6000] = {TalkId = 100, NextId = 6001},
  [6001] = {LevelId = TRANINING_CLICK_LVL_ID, NextCond = IsClickTrainingMaxLv, NextId = 6002},
  [6002] = {TalkId = 150, NextCond = IsTempleCrowdFunding, NextId = 6003},
  [6003] = {LevelId = TRANINING_CLICK_LVL_ID},
  -- Training map, brother 2.
  [7000] = {TalkId = 200, NextId = 7001},
  [7001] = {LevelId = TRANINING_STICK_LVL_ID, NextCond = IsStickTrainingMaxLv, NextId = 7002},
  [7002] = {TalkId = 250, NextCond = IsTempleCrowdFunding, NextId = 7003},
  [7003] = {LevelId = TRANINING_STICK_LVL_ID},
  --- Main map, temple.
  [8000] = {TalkId = 1200, NextCond = IsTempleCrowdFunding, NextId = 8001},
  [8001] = {TalkId = 1201, RedPt = 1, NextId = 8002},
  [8002] = {TalkId = 1201, NextCond = IsTempleCrowdFundingDone, NextId = 8003},
  [8003] = {TalkId = 1202, RedPt = 1, NextId = 8004},
  [8004] = {TalkId = 1203, NextCond = HasMallet, NextId = 8005},
  [8005] = {TalkId = 1204, RedPt = 1, NextId = 8006},
  [8006] = {TalkId = 1205, TexId = temple_tex_id},
  -- Hero village, church.
  [9000] = {LevelId = HERO_VILLAGE_CHURCH_LVL_ID},
  -- Hero village church, grandpa.
  [9100] = {TalkId = 1300, NextId = 9101},
  [9101] = {TalkId = 1301, NextId = 9102},
  [9102] = {TalkId = 1302, NextCond = IsEnterCave, NextId = 9103},
  [9103] = {TalkId = 1303, NextCond = IsEnterCave2Times, NextId = 9104},
  [9104] = {TalkId = 1304, NextId = 9105},
  [9105] = {TalkId = 1303, NextCond = HasFlashlight, NextId = 9106},
  [9106] = {TalkId = 1305, NextId = 9107},
  [9107] = {TalkId = 1303, NextCond = HasMallet, NextId = 9108},
  [9108] = {TalkId = 1306, NextCond = HasPowerScissor, NextId = 9109},
  [9109] = {TalkId = 1302, NextCond = HasRpsMedal, NextId = 9110},
  [9110] = {TalkId = 1307, NextCond = HasCaveMazeBookFlag, NextId = 9111},
  [9111] = {TalkId = 1308, NextId = 9112},
  [9112] = {TalkId = 1307, NextCond = IsNeedRope, NextId = 9113},
  [9113] = {TalkId = 1309, NextId = 9114},
  [9114] = {TalkId = 1307, NextCond = IsHelpElderGlass, NextId = 9115},
  [9115] = {TalkId = 1310, NextCond = IsFindUfoPower, NextId = 9116},
  [9116] = {TalkId = 1311, NextId = 9117},
  [9117] = {TalkId = 1310, NextCond = HasSuperNanoTowelFlag, NextId = 9118},
  [9118] = {TalkId = 1312, NextCond = HasShip, NextId = 9119},
  [9119] = {TalkId = 1313},
  -- Hero village church, shelf.
  [9200] = {LevelId = BAG_LVL_ID},
  -- Hero village, Zhang mama home.
  [10000] = {TalkId = 1500, NextCond = IsEnterCave, NextId = 10001},
  [10001] = {TalkId = 1501, NextCond = IsEnterCave2Times, NextId = 10002},
  [10002] = {TalkId = 1502, NextId = 10003},
  [10003] = {TalkId = 1501, NextCond = OpenCaveDoor, NextId = 10004},
  [10004] = {TalkId = 1504, NextCond = HasMallet, NextId = 10005},
  [10005] = {TalkId = 1502, NextCond = IsHelpElderYellow, NextId = 10006},
  [10006] = {TalkId = 1505, NextCond = HasSuperSoap, NextId = 10007},
  [10007] = {TalkId = 1506, NextId = 10008},
  [10008] = {TalkId = 1502},
  -- Hero village, Shop.
  [11000] = {TalkId = 1600, NextCond = IsEnterCave, NextId = 11001},
  [11001] = {TalkId = 1601, NextCond = IsFlashlightBuyable, NextId = 11002},
  [11002] = {TalkId = 1602, NextId = 11003},
  [11003] = {TalkId = 1608, NextCond = BuyCandyLoop, NextId = 11004},
  [11004] = {TalkId = 1605, NextCond = IsBuyCandyValid, NextId = 11005},
  [11005] = {TalkId = 1606, NextId = 11006},
  [11006] = {TalkId = 1608, NextCond = IsHelpElderYellow, NextId = 11007},
  [11007] = {TalkId = 1609, NextId = 11008},
  [11008] = {TalkId = 1608, NextCond = IsSuperSoapMaterialReady, NextId = 11009},
  [11009] = {TalkId = 1610, NextId = 11010},
  [11010] = {TalkId = 1608},
  -- Hero village, Pinky home.
  [12000] = {TalkId = 1700, NextCond = HasMallet, NextId = 12001},
  [12001] = {TalkId = 1701, NextCond = HasCandy, NextId = 12002},
  [12002] = {TalkId = 1702, NextId = 12003},
  [12003] = {TalkId = 1700, NextCond = IsPowerupScissorLoop, NextId = 12004},
  [12004] = {TalkId = 1704, NextCond = IsPowerupScissorReady, NextId = 12005},
  [12005] = {TalkId = 1705, NextId = 12006},
  [12006] = {TalkId = 1706, NextCond = IsHelpElderWhite, NextId = 12007},
  [12007] = {TalkId = 1708, NextCond = HasShaveBook, NextId = 12008},
  [12008] = {TalkId = 1706},
  -- Hero village, hero home.
  [13000] = {TalkId = 1800, NextCond = HasFlashlight, NextId = 13001},
  [13001] = {TalkId = 1801, NextId = 13002},
  [13002] = {TalkId = 1802},
  -- Hero village, to alien path.
  [14000] = {LevelId = ALIEN_PATH_LVL_ID, NextCond = HasScissor, NextId = 14001},
  [14001] = {TalkId = 1703, NextCond = HasPowerScissor, NextId = 14002},
  [14002] = {LevelId = ALIEN_PATH_LVL_ID},
  -- Hero village, to country.
  [14100] = {LevelId = COUNTRY_LVL_ID},
  -- Country, to hero village.
  [14200] = {LevelId = HERO_VILLAGE_LVL_ID},
  -- Country, to cave field.
  [14300] = {LevelId = CAVE_FIELD_LVL_ID},
  -- Cuntry, Kai home.
  [15000] = {TalkId = 1900, NextCond = IsEnterCave, NextId = 15001},
  [15001] = {TalkId = 1901, NextCond = IsDrumStickLoop, NextId = 15002},
  [15002] = {TalkId = 1902, NextId = 15003},
  [15003] = {TalkId = 1903},
  -- Country, pond.
  [16000] = {TalkId = 2000, NextCond = IsPowerupScissorLoop, NextId = 16001},
  [16001] = {TalkId = 2001},
  -- Cave field, cave.
  [17000] = {TalkId = 2100, NextId = 17001},
  [17001] = {TalkId = 2101, NextCond = HasFlashlight, NextId = 17002},
  [17002] = {TalkId = 2102, NextId = 17003},
  [17003] = {TalkId = 2103, NextCond = HasRpsMedal, NextId = 17004},
  [17004] = {TalkId = 2109, NextId = 17005},
  [17005] = {TalkId = 2110},
  -- Cave maze, well.
  [17100] = {TalkId = 2111, NextCond = HasRope, NextId = 17101},
  [17101] = {TalkId = 2112},
  -- Cave maze, mirror.
  [17200] = {TalkId = 2113, NextCond = HasUfoPowerBook, NextId = 17201},
  [17201] = {TalkId = 2114, NextId = 17202},
  [17202] = {TalkId = 2113},
  -- Alien path, to alien area.
  [19000] = {LevelId = ALIEN_AREA_LVL_ID},
  -- Alien area, ufo.
  [20000] = {TalkId = 2200, NextCond = IsHelpElderGlass, NextId = 20001},
  [20001] = {TalkId = 2203, NextId = 20002},
  [20002] = {TalkId = 2204, NextCond = HasUfoPower, NextId = 20003},
  [20003] = {TalkId = 2205, NextId = 20004},
  [20004] = {TalkId = 2206},
  -- Alien area, to dock.
  [20100] = {LevelId = DOCK_LVL_ID},
  -- Under world entry, well.
  [21000] = {TalkId = 2300},
  -- Under world entry, dwarf potato.
  [21100] = {TalkId = 2400, NextCond = IsPassPotatoTest, NextId = 21101},
  [21101] = {TalkId = 2401, NextCond = IsBatCaveBlocked, NextId = 21102},
  [21102] = {TalkId = 2402, NextId = 21103},
  [21103] = {TalkId = 2401},
  -- Under world entry, to main map.
  [21200] = {TalkId = 2500, NextCond = IsPassPotatoTest, NextId = 21201},
  [21201] = {LevelId = UNDERWORLD_MAIN_LVL_ID},
  -- Under world main map, to entry.
  [21300] = {LevelId = UNDER_WORLD_ENTRANCE_LVL_ID},
  -- Under world main map, elder glass.
  [21400] = {TalkId = 2600, NextCond = IsHelpElderGlass, NextId = 21401},
  [21401] = {TalkId = 2603, NextCond = HasSuperNanoTowel, NextId = 21402},
  [21402] = {TalkId = 2604, NextId = 21403},
  [21403] = {TalkId = 2605},
  -- Under world main map, elder yellow.
  [21500] = {TalkId = 2610, NextCond = IsHelpElderYellow, NextId = 21501},
  [21501] = {TalkId = 2613, NextCond = HasCleanYellowSuit, NextId = 21502},
  [21502] = {TalkId = 2614, NextId = 21503},
  [21503] = {TalkId = 2615},
  -- Under world main map, elder white.
  [21600] = {TalkId = 2620, NextCond = IsHelpElderWhite, NextId = 21601},
  [21601] = {TalkId = 2623, NextCond = HasShaveBook, NextId = 21602},
  [21602] = {TalkId = 2624, NextId = 21603},
  [21603] = {TalkId = 2625},
  -- Under world main map, to trash field.
  [21700] = {LevelId = TRASH_FIELD_LVL_ID},
  -- Under world main map, to bat cave field,
  [21800] = {LevelId = BAT_CAVE_FIELD_LVL_ID},
  -- Trash field, old lady.
  [22000] = {TalkId = 2700, NextCond = HasSuperNanoTowelFlag, NextId = 22001},
  [22001] = {TalkId = 2702, NextId = 22002},
  [22002] = {TalkId = 2703},
  -- Trash field, magic mama.
  [23000] = {TalkId = 2800},
  -- Bat cave field, bat cave.
  [23100] = {TalkId = 3400, NextCond = HasSuperNanoTowelFlag, NextId = 23101},
  [23101] = {TalkId = 3401, NextCond = IsBatCaveOpened, NextId = 23102},
  [23102] = {TalkId = 3402},
  -- Janken planet, UFO.
  [24000] = {TalkId = 2209},
  -- Janken planet, Dipsy.
  [24100] = {TalkId = 2900, NextCond = IsFindTeletubbies, NextId = 24101},
  [24101] = {TalkId = 2901},
  -- Janken planet, Po.
  [24200] = {TalkId = 3000, NextCond = IsFindTeletubbies, NextId = 24201},
  [24201] = {TalkId = 3001},
  -- Janken planet, Laalaa.
  [24300] = {TalkId = 3100, NextCond = IsFindTeletubbies, NextId = 24301},
  [24301] = {TalkId = 3101},
  -- Janken planet, Tinky Winky.
  [24400] = {TalkId = 3200, NextCond = IsFindTeletubbies, NextId = 24401},
  [24401] = {TalkId = 3201},
  -- Janken planet, to lib.
  [24500] = {LevelId = janken_lib_lvl_id},
  -- Janken planet, to observatory.
  [24600] = {LevelId = JANKEN_OBSERVATORY_LVL_ID},
  -- Janken lib, to planet.
  [25000] = {LevelId = JANKEN_PLANET_LVL_ID},
  -- Janken lib, inside lib.
  [25050] = {LevelId = INSIDE_JANKEN_LIB_LVL_ID},
  -- Janken lib, bebe.
  [25100] = {TalkId = 3300, NextCond = HasFourFeathers, NextId = 25101},
  [25101] = {TalkId = 3301},
  -- Janken lib, computer.
  [25200] = {TalkId = 3350, NextCond = HasJewel, NextId = 25201},
  [25201] = {TalkId = 3351, NextId = 25202},
  [25202] = {TalkId = 3352},
  -- Janken observatory.
  [25300] = {TalkId = 3380},
  -- Dock, dock.
  [26000] = {TalkId = 3500, NextCond = HasShip, NextId = 26001},
  [26001] = {LevelId = FISH_FIELD_LVL_ID, TexId = SHIP_TEX_ID},
  -- Dock, fishman.
  [26100] = {TalkId = 3550, NextCond = HasSuperNanoTowelFlag, NextId = 26101},
  [26101] = {TalkId = 3551, NextCond = CanBuyShip, NextId = 26102},
  [26102] = {TalkId = 3552, NextId = 26103},
  [26103] = {TalkId = 3553},
  -- Fish field, fish.
  [27000] = {TalkId = 3600},
  -- Fish field, to island field.
  [27100] = {LevelId = island_field_lvl_id},
  -- Dq, main map.
  [28000] = {LevelId = COMPUTER_LVL_ID},
  [28100] = {TalkId = 3705, NextCond = HasKingPermission, NextId = 28101},
  [28101] = {LevelId = NORTH_NATION_LVL_ID},
  -- Dq, castle.
  [29000] = {TalkId = 3700, NextCond = HasKingPermission, NextId = 29001},
  [29001] = {TalkId = 3704},
  -- Dq, north nation.
  [29100] = {TalkId = 3750},
  [29200] = {TalkId = 3780},
  [29300] = {LevelId = DQ_LVL_ID},
  [29400] = {TalkId = 3790},
  [29500] = {TalkId = 3795},
  -- Island field, island.
  [31000] = {TalkId = 3800},
  -- Island field, to fish field.
  [31100] = {LevelId = FISH_FIELD_LVL_ID},
  -- Island, my papa.
  [32000] = {TalkId = 3900},
  -- Island, my mama.
  [32100] = {TalkId = 4000},
  -- Island, my guan.
  [32200] = {TalkId = 4100},
  -- Island, my ming.
  [32300] = {TalkId = 4200},
  -- Zoo, to zoo.
  [33000] = {LevelId = ZOO_LVL_ID},
  -- Zoo field, to zoo field.
  [33100] = {TalkId = 4300},
  -- Zoo field, worm cave.
  [33200] = {TalkId = 4400},
}
