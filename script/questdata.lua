
local beg_money_lvl_id = 293
local alien_path_lvl_id = 356

QuestData = {
  -- Main map, hero mt.
  [1000] = {TalkId = {80, 180, 280}, NextCond = IsSendTeacherLetterValid, NextId = 1001},
  [1001] = {TalkId = {1100}, RedPt = 1, NextId = 1002},
  [1002] = {TalkId = {80, 180, 280}},
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
  [6001] = {LevelId = TRANINING_CLICK_LVL_ID, Cond = IsClickTrainingValid, NextCond = IsClickTrainingMaxLv, NextId = 6002},
  [6002] = {TalkId = {150}},
  -- Training map, brother 2.
  [7000] = {TalkId = {200}, NextId = 7001},
  [7001] = {LevelId = TRANINING_STICK_LVL_ID, Cond = IsStickTrainingValid, NextCond = IsStickTrainingMaxLv, NextId = 7002},
  [7002] = {TalkId = {250}},
  --- Main map, temple.
  [8000] = {TalkId = {1200}, NextCond = IsTempleCrowdFunding, NextId = 8001},
  [8001] = {TalkId = {1201}, RedPt = 1, NextId = 8002},
  [8002] = {TalkId = {1201}},
  -- Hero village, church.
  [9000] = {NextCond = IsInterviewUfo, NextId = 9001},
  [9001] = {LevelId = HERO_VILLAGE_CHURCH_LVL_ID, RedPt = 1, NextId = 9002},
  [9002] = {LevelId = HERO_VILLAGE_CHURCH_LVL_ID},
  -- Hero village church, grandpa.
  [9100] = {TalkId = {1300}, NextId = 9101},
  [9101] = {TalkId = {1301}, NextCond = IsEnterCaveTimes, NextId = 9102},
  [9102] = {TalkId = {1302}},
  -- Hero village church, shelf.
  [9200] = {TalkId = {1350}},
  -- Hero village, Zhang home.
  [10000] = {TalkId = {1500}, NextCond = IsEnterCaveTimes, NextId = 10001},
  [10001] = {TalkId = {1501}},
  -- Hero village, Shop.
  [11000] = {TalkId = {1600}},
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
  [17000] = {TalkId = {2100}},
}
