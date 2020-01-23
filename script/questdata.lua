
local beg_money_lvl_id = 293
local temple_tex_id = 50
local curcus_tex_id = 73

QuestData = {
  -- Main map, hero mt.
  [1000] = {TalkId = {51, 180, 280}, NextCond = IsSendTeacherLetterValid, NextId = 1001},
  [1001] = {TalkId = {52}, RedPt = 1, NextId = 1002},
  [1002] = {TalkId = {51, 180, 280}, NextCond = IsTempleCrowdFunding, NextId = 1003},
  [1003] = {TalkId = {51, 180, 280}, NextCond = HasBackScratcher, NextId = 1004},
  [1004] = {TalkId = {53}, RedPt = 1, NextId = 1005},
  [1005] = {TalkId = {53}},
  -- Main map, shop.
  [2000] = {TalkId = {450, 500}, NextCond = IsBuyBou2Valid, NextId = 2001},
  [2001] = {TalkId = {300}, RedPt = 1, NextId = 2002},
  [2002] = {TalkId = {450, 500}, NextCond = IsBuyBou3Valid, NextId = 2003},
  [2003] = {TalkId = {400}, RedPt = 1, NextId = 2004},
  [2004] = {TalkId = {450, 500}, NextCond = IsOpenRacingValid, NextId = 2005},
  [2005] = {TalkId = {510}, RedPt = 1, NextId = 2006},
  [2006] = {TalkId = {511}, TexId = curcus_tex_id, NextCond = IsGiveGodzillaValid, NextId = 2007},
  [2007] = {TalkId = {512}, TexId = curcus_tex_id, RedPt = 1, NextId = 2008},
  [2008] = {TalkId = {511}, TexId = curcus_tex_id},
  -- Main map, village.
  [3000] = {LevelId = beg_money_lvl_id},
  -- Main map, church.
  [4000] = {TalkId = {1000}, NextCond = IsTransLetterToPriestValid, NextId = 4001},
  [4001] = {TalkId = {1150}, RedPt = 1, NextId = 4002},
  [4002] = {TalkId = {1000}, NextCond = IsChurch2ndDreamValid, NextId = 4003},
  [4003] = {TalkId = {1152}, RedPt = 1, NextId = 4004},
  [4004] = {TalkId = {1153}, NextCond = IsRestValid, NextId = 4005},
  [4005] = {TalkId = {1154}, NextCond = NotRestValid, NextId = 4004},
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
  [6000] = {TalkId = {100}, NextId = 6001},
  [6001] = {LevelId = TRANINING_CLICK_LVL_ID, NextCond = IsClickTrainingMaxLv, NextId = 6002},
  [6002] = {TalkId = {150}, NextCond = IsTempleCrowdFunding, NextId = 6003},
  [6003] = {LevelId = TRANINING_CLICK_LVL_ID},
  -- Training map, brother 2.
  [7000] = {TalkId = {200}, NextId = 7001},
  [7001] = {LevelId = TRANINING_STICK_LVL_ID, NextCond = IsStickTrainingMaxLv, NextId = 7002},
  [7002] = {TalkId = {250}, NextCond = IsTempleCrowdFunding, NextId = 7003},
  [7003] = {LevelId = TRANINING_STICK_LVL_ID},
  --- Main map, temple.
  [8000] = {TalkId = {1200}, NextCond = IsTempleCrowdFunding, NextId = 8001},
  [8001] = {TalkId = {1201}, RedPt = 1, NextId = 8002},
  [8002] = {TalkId = {1201}, NextCond = IsTempleCrowdFundingDone, NextId = 8003},
  [8003] = {TalkId = {1202}, RedPt = 1, NextId = 8004},
  [8004] = {TalkId = {1203}, NextCond = HasMallet, NextId = 8005},
  [8005] = {TalkId = {1204}, RedPt = 1, NextId = 8006},
  [8006] = {TalkId = {1205}, TexId = temple_tex_id},
  -- Hero village, church.
  [9000] = {LevelId = HERO_VILLAGE_CHURCH_LVL_ID},
  -- Hero village church, grandpa.
  [9100] = {TalkId = {1300}, NextId = 9101},
  [9101] = {TalkId = {1301}, NextId = 9102},
  [9102] = {TalkId = {1302}, NextCond = IsEnterCave, NextId = 9103},
  [9103] = {TalkId = {1303}, NextCond = IsEnterCave2Times, NextId = 9104},
  [9104] = {TalkId = {1304}, NextId = 9105},
  [9105] = {TalkId = {1303}, NextCond = HasFlashlight, NextId = 9106},
  [9106] = {TalkId = {1305}, NextId = 9107},
  [9107] = {TalkId = {1303}, NextCond = HasMallet, NextId = 9108},
  [9108] = {TalkId = {1306}, NextCond = HasPowerScissor, NextId = 9109},
  [9109] = {TalkId = {1302}, NextCond = HasRpsMedal, NextId = 9110},
  [9110] = {TalkId = {1307}, NextCond = HasCaveMazeBookFlag, NextId = 9111},
  [9111] = {TalkId = {1308}, NextId = 9112},
  [9112] = {TalkId = {1307}},
  -- Hero village church, shelf.
  [9200] = {LevelId = BAG_LVL_ID},
  -- Hero village, Zhang mama home.
  [10000] = {TalkId = {1500}, NextCond = IsEnterCave, NextId = 10001},
  [10001] = {TalkId = {1501}, NextCond = IsEnterCave2Times, NextId = 10002},
  [10002] = {TalkId = {1502}, NextId = 10003},
  [10003] = {TalkId = {1501}, NextCond = OpenCaveDoor, NextId = 10004},
  [10004] = {TalkId = {1504}, NextCond = HasMallet, NextId = 10005},
  [10005] = {TalkId = {1502}},
  -- Hero village, Shop.
  [11000] = {TalkId = {1600}, NextCond = IsEnterCave, NextId = 11001},
  [11001] = {TalkId = {1601}, NextCond = IsFlashlightBuyable, NextId = 11002},
  [11002] = {TalkId = {1602}, NextId = 11003},
  [11003] = {TalkId = {1600}, NextCond = HasFrogTearToSell, NextId = 11007, NextCond2 = BuyCandyLoop, NextId2 = 11005, NextCond3 = FlashlightOutOfPower, NextId3 = 11004},
  [11004] = {TalkId = {1603}, NextId = 11003},
  [11005] = {TalkId = {1605}, NextCond = IsBuyCandyValid, NextId = 11006},
  [11006] = {TalkId = {1606}, NextId = 11003},
  [11007] = {TalkId = {1607}, NextId = 11003},
  -- Hero village, Pinky home.
  [12000] = {TalkId = {1700}, NextCond = HasMallet, NextId = 12001},
  [12001] = {TalkId = {1701}, NextCond = HasCandy, NextId = 12002},
  [12002] = {TalkId = {1702}, NextId = 12003},
  [12003] = {TalkId = {1700}, NextCond = IsPowerupScissorLoop, NextId = 12004},
  [12004] = {TalkId = {1704}, NextCond = IsPowerupScissorReady, NextId = 12005},
  [12005] = {TalkId = {1705}, NextId = 12006},
  [12006] = {TalkId = {1706}},
  -- Hero village, hero home.
  [13000] = {TalkId = {1800}, NextId = 13001},
  [13001] = {TalkId = {1801}},
  -- Hero village, to alien path.
  [14000] = {LevelId = ALIEN_PATH_LVL_ID, NextCond = HasScissor, NextId = 14001},
  [14001] = {TalkId = {1703}, NextCond = HasPowerScissor, NextId = 14002},
  [14002] = {LevelId = ALIEN_PATH_LVL_ID},
  -- Hero village, to country.
  [14100] = {LevelId = COUNTRY_LVL_ID},
  -- Country, to hero village.
  [14200] = {LevelId = HERO_VILLAGE_LVL_ID},
  -- Country, to cave field.
  [14300] = {LevelId = CAVE_FIELD_LVL_ID},
  -- Cuntry, Kai home.
  [15000] = {TalkId = {1900}, NextCond = IsEnterCave, NextId = 15001},
  [15001] = {TalkId = {1901}, NextCond = IsDrumStickLoop, NextId = 15002},
  [15002] = {TalkId = {1902}, NextId = 15003},
  [15003] = {TalkId = {1903}},
  -- Country, pond.
  [16000] = {TalkId = {2000}, NextCond = IsPowerupScissorLoop, NextId = 16001},
  [16001] = {TalkId = {2001}},
  -- Cave field, cave.
  [17000] = {TalkId = {2100}, NextId = 17001},
  [17001] = {TalkId = {2101}, NextCond = HasFlashlight, NextId = 17002},
  [17002] = {TalkId = {2102}, NextId = 17003},
  [17003] = {TalkId = {2103}, NextCond = HasRpsMedal, NextId = 17004},
  [17004] = {TalkId = {2109}, NextId = 17005},
  [17005] = {TalkId = {2110}},
  -- Back button.
  [18000] = {ScriptLevelId = GetHeroVillageBackLvlId},
  -- Alien path, to alien area.
  [19000] = {LevelId = ALIEN_AREA_LVL_ID},
  -- Alien area, ufo.
  [20000] = {TalkId = {2200}},
  -- Under world entry, well.
  [21000] = {TalkId = {2300}},
  -- Under world entry, dwarf potato.
  [21100] = {TalkId = {2400}, NextCond = IsPassPotatoTest, NextId = 21101},
  [21101] = {TalkId = {2401}},
  -- Under world entry, to main map.
  [21200] = {TalkId = {2500}, NextCond = IsPassPotatoTest, NextId = 21201},
  [21201] = {LevelId = UNDERWORLD_MAIN_LVL_ID},
  -- Under world main, to entry.
  [21300] = {LevelId = UNDER_WORLD_ENTRANCE_LVL_ID},
}
