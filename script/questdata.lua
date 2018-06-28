
local bag_lvl_id = 300
local beg_money_lvl_id = 293

QuestData = {
  -- Main map, hero mt.
  [1000] = {TalkId = {80, 180, 280}, NextCond = IsSendTeacherMailValid, NextId = 1001},
  [1001] = {TalkId = {1100}, RedPt = 1, NextId = 1002},
  [1002] = {TalkId = {80, 180, 280}},
  -- Main map, shop.
  [2000] = {TalkId = {450, 500}, NextCond = IsBuyBou2Valid, NextId = 2001},
  [2001] = {TalkId = {300}, RedPt = 1, NextId = 2002},
  [2002] = {TalkId = {450, 500}, NextCond = IsBuyBou3Valid, NextId = 2003},
  [2003] = {TalkId = {400}, RedPt = 1, NextId = 2004},
  [2004] = {TalkId = {450, 500}},
  -- Main map, village.
  [3000] = {LevelId = beg_money_lvl_id},
  -- Main map, church.
  [4000] = {TalkId = {1000}, NextCond = IsChurchRecvMailValid, NextId = 4001},
  [4001] = {TalkId = {1150}, RedPt = 1, NextId = 4002},
  [4002] = {TalkId = {1152}, NextCond = IsRestValid, NextId = 4003},
  [4003] = {TalkId = {1153}, NextCond = NotRestValid, NextId = 4002},
  -- Main map, bag.
  [5000] = {LevelId = bag_lvl_id, IconId = {277}, NextCond = HasBou2, NextId = 5001},
  [5001] = {LevelId = bag_lvl_id, IconId = {303}, NextCond = HasBou2, RedPt = 1, NextId = 5002},
  [5002] = {LevelId = bag_lvl_id, IconId = {303}, NextCond = HasBou3, NextId = 5003},
  [5003] = {LevelId = bag_lvl_id, IconId = {307}, NextCond = HasBou3, RedPt = 1, NextId = 5004},
  [5004] = {LevelId = bag_lvl_id, IconId = {307}, NextCond = HasMail, NextId = 5005},
  [5005] = {LevelId = bag_lvl_id, IconId = {307, 301}, NextCond = HasMail, RedPt = 1, NextId = 5006},
  [5006] = {LevelId = bag_lvl_id, IconId = {307, 301}, NextCond = MailSent, NextId = 5007},
  [5007] = {LevelId = bag_lvl_id, IconId = {307}},
  -- Training map, brother 1.
  [6000] = {TalkId = {100}, ForceNextId = 6001},
  [6001] = {LevelId = TRANINING_CLICK_LVL_ID, Cond = IsClickTrainingValid, NextCond = IsClickTrainingMaxLv, NextId = 6002},
  [6002] = {TalkId = {150}},
  -- Training map, brother 2.
  [7000] = {TalkId = {200}, ForceNextId = 7001},
  [7001] = {LevelId = TRANINING_STICK_LVL_ID, Cond = IsStickTrainingValid, NextCond = IsStickTrainingMaxLv, NextId = 7002},
  [7002] = {TalkId = {250}},
  --- Main map, temple.
  [8000] = {TalkId = {1200}},
}
