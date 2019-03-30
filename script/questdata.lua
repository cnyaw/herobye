
local beg_money_lvl_id = 293
local alien_path_lvl_id = 356

QuestData = {
  -- Main map, hero mt.
  [1000] = {TalkId = {51, 180, 280}, NextCond = IsSendTeacherLetterValid, NextId = 1001},
  [1001] = {TalkId = {52}, RedPt = 1, NextId = 1002},
  [1002] = {TalkId = {51, 180, 280}, NextCond = IsTempleCrowdFunding, NextId = 1003},
  [1003] = {TalkId = {51, 180, 280}, NextCond = IsUnlockTraining, NextId = 1004},
  [1004] = {TalkId = {53}, RedPt = 1, NextId = 1005},
  [1005] = {TalkId = {53}},
  -- Main map, shop.
  [2000] = {TalkId = {450, 500}, NextCond = IsBuyBou2Valid, NextId = 2001},
  [2001] = {TalkId = {300}, RedPt = 1, NextId = 2002},
  [2002] = {TalkId = {450, 500}, NextCond = IsBuyBou3Valid, NextId = 2003},
  [2003] = {TalkId = {400}, RedPt = 1, NextId = 2004},
  [2004] = {TalkId = {450, 500}, NextCond = IsOpenRacingValid, NextId = 2005},
  [2005] = {TalkId = {510}, RedPt = 1, NextId = 2006},
  [2006] = {TalkId = {511}, NextCond = IsGiveGodzillaValid, NextId = 2007},
  [2007] = {TalkId = {512}, RedPt = 1, NextId = 2008},
  [2008] = {TalkId = {511}},
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
  [8004] = {TalkId = {1203}},
  -- Hero village, church.
  [9000] = {LevelId = HERO_VILLAGE_CHURCH_LVL_ID},
  -- Hero village church, grandpa.
  [9100] = {TalkId = {1300}, NextId = 9101},
  [9101] = {TalkId = {1301}, NextCond = IsEnterCave2Times, NextId = 9102},
  [9102] = {TalkId = {1302}, NextCond = IsEnterCave4Times, NextId = 9103},
  [9103] = {TalkId = {1303}, NextId = 9104},
  [9104] = {TalkId = {1302}},
  -- Hero village church, shelf.
  [9200] = {TalkId = {1350}, NextCond = HasFlashlight, NextId = 9201},
  [9201] = {TalkId = {1351}},
  -- Hero village, Zhang mama home.
  [10000] = {TalkId = {1500}, NextCond = IsEnterCave2Times, NextId = 10001},
  [10001] = {TalkId = {1501}, NextCond = IsEnterCave6Times, NextId = 10002},
  [10002] = {TalkId = {1502}, NextId = 10003},
  [10003] = {TalkId = {1501}},
  -- Hero village, Shop.
  [11000] = {TalkId = {1600}, NextCond = IsEnterCave4Times, NextId = 11001},
  [11001] = {TalkId = {1601}, NextCond = IsFlashlightBuyable, NextId = 11002},
  [11002] = {TalkId = {1602}, NextId = 11003},
  [11003] = {TalkId = {1600}},
  -- Hero village, Xiang home.
  [12000] = {TalkId = {1700}},
  -- Hero village, hero home.
  [13000] = {TalkId = {1800}, NextId = 13001},
  [13001] = {TalkId = {1801}},
  -- Hero village, to alien path.
  [14000] = {LevelId = alien_path_lvl_id},
  -- Hero village, to country.
  [14100] = {LevelId = COUNTRY_LVL_ID},
  -- Country, to hero village.
  [14200] = {LevelId = HERO_VILLAGE_LVL_ID},
  -- Country, to cave field.
  [14300] = {LevelId = CAVE_FIELD_LVL_ID},
  -- Cuntry, Kai home.
  [15000] = {TalkId = {1900}},
  -- Country, pond.
  [16000] = {TalkId = {2000}},
  -- Cave field, cave.
  [17000] = {TalkId = {2100}, NextCond = IsEnterCave4Times, NextId = 17001},
  [17001] = {TalkId = {2101}, NextCond = HasFlashlight, NextId = 17002},
  [17002] = {TalkId = {2102}},
}
