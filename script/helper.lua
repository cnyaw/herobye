local SCR_W, SCR_H = Good.GetWindowSize()

local MAX_CLICK_LEVEL = 3
local MAX_STICK_LEVEL = 3
local TIME_TRAINING_CD = 3
local OPEN_CHURCH_COST = 50

local tex_sandglass_id = 273
local map_brother1_obj_id = 282
local map_brother2_obj_id = 283
local red_point_tex_id = 313
local talk_lvl_id = 275

local teacher_init_talk_id = 1

BOU2_COST = 10
BOU3_COST = 30
CHURCH_RECV_MAIL_COST = 100
CHURCH_2ND_DREAM_COST = 100
REST_COST = 5

-- Data.

last_lvl_id = nil
curr_coin = 0

local lv_bou = 1
local flag_mail = 0

local curr_talk_id = {teacher_init_talk_id}

curr_stage_id = {                       -- [obj_name] = quest_id
  -- Training map.
  o_brother1 = 6000,
  o_brother2 = 7000,
  -- Main map.
  o_heroMount = 1000,
  o_mainMapShop = 2000,
  o_mainMapVillage = 3000,
  o_mainMapChurch = 4000,
  o_bag = 5000,
  o_mainMapTempleSite = 8000,
  -- Hero village.
  o_heroVillageChurch = 9000,
  o_ZhangHome = 10000,
  o_heroVillageShop = 11000,
  o_XiangHome = 12000,
  o_heroHome = 13000,
}

-- Training.

click_training = {cd = 0, lv = 0, max_lv = MAX_CLICK_LEVEL, obj_id = map_brother1_obj_id}
stick_training = {cd = 0, lv = 0, max_lv = MAX_STICK_LEVEL, obj_id = map_brother2_obj_id}
local all_training = {click_training, stick_training}
local training_cd_tick = 0

-- Helper.

function AddRedPoint(parent)
  local o = Good.GenObj(parent, red_point_tex_id, 'AnimTalkArrow')
  local l,t,w,h = Good.GetDim(o)
  local lp,tp,wp,hp = Good.GetDim(parent)
  Good.SetPos(o, wp - w/2, hp - h/2)
end

function AdvanceTrainingLevel(training)
  training.lv = training.lv + 1
  if (training.max_lv > training.lv) then
    training.cd = TIME_TRAINING_CD
  end
end

function AllTrainingComplete()
  for i = 1, #all_training do
    local training = all_training[i]
    if (training.lv ~= training.max_lv) then
      return false
    end
  end
  return true
end

function Consume2ndDreamCost()
  curr_coin = curr_coin - CHURCH_2ND_DREAM_COST
end

function ConsumeRestCost()
  curr_coin = curr_coin - REST_COST
end

function GenFlyUpObj(parent, tex_id)
  local x, y = Good.GetPos(parent)
  local l,t,w,h = Good.GetDim(parent)
  local o = Good.GenObj(-1, tex_id, 'AnimFlyUpObj')
  local l2,t2,w2,h2 = Good.GetDim(o)
  Good.SetPos(o, x + (w - w2)/2, y)
end

function GenNumObj(n, size)
  local s = string.format('%d', n)
  local o = Good.GenTextObj(-1, s, size)
  return o
end

function GenSandGlassObj(cd)
  local o = Good.GenObj(-1, tex_sandglass_id, 'AnimSandGlass')
  Good.SetAnchor(o, 0.5, 0.5)
  local p = Good.GetParam(o)
  p.cd = cd
  return o
end

function GetCurrBouGain()
  if (HasBou3()) then
    return 5
  end
  if (HasBou2()) then
    return 3
  end
  return 1
end

function GetCurrBouTexId()
  if (HasBou3()) then
    return BOU3_TEX_ID
  end
  if (HasBou2()) then
    return BOU2_TEX_ID
  end
  return BOU_TEX_ID
end

function GetCurrTalk()
  return TalkData[curr_talk_id[1]]
end

function GetBouLv()
  return lv_bou
end

function GetMail()
  return flag_mail
end

function HasBou2()
  return 2 == GetBouLv()
end

function HasBou3()
  return 3 == GetBouLv()
end

function HasMail()
  return 1 == flag_mail
end

function IsBuyBou2Valid()
  return BOU2_COST <= curr_coin
end

function IsBuyBou3Valid()
  return BOU3_COST <= curr_coin
end

function IsChurch2ndDreamValid()
  return CHURCH_2ND_DREAM_COST <= curr_coin
end

function IsChurch2ndDreamed()
  return 4004 <= curr_stage_id.o_mainMapChurch
end

function IsChurchRecvMailValid()
  return HasMail() and CHURCH_RECV_MAIL_COST <= curr_coin
end

function IsClickTrainingMaxLv()
  return click_training.max_lv <= click_training.lv
end

function IsClickTrainingValid()
  return 0 >= click_training.cd
end

function IsRestValid()
  return REST_COST <= curr_coin
end

function IsSendTeacherMailValid()
  return 0 == flag_mail and HasBou3() and OPEN_CHURCH_COST <= curr_coin
end

function IsStickTrainingMaxLv()
  return stick_training.max_lv <= stick_training.lv
end

function IsStickTrainingValid()
  return 0 >= stick_training.cd
end

function LevelUpBou()
  lv_bou = lv_bou + 1
end

function MailSent()
  return 2 == flag_mail
end

function NotRestValid()
  return not IsRestValid()
end

function QuestOnCreate()
  local lvl_id = Good.GetLevelId()
  for obj_name, quest_id in pairs(curr_stage_id) do
    local id = Good.FindChild(lvl_id, obj_name)
    if (-1 ~= id) then
      local q = QuestData[quest_id]
      if (nil ~= q.NextId and nil ~= q.NextCond and q.NextCond()) then
        local next_id = q.NextId
        curr_stage_id[obj_name] = next_id
        q = QuestData[next_id]
      end
      if (nil ~= q.RedPt) then
        AddRedPoint(id)
      end
    end
  end
end

function QuestOnStep(x, y)
  local lvl_id = Good.GetLevelId()
  for obj_name, quest_id in pairs(curr_stage_id) do
    local id = Good.FindChild(lvl_id, obj_name)
    if (-1 ~= id and PtInObj(x, y, id)) then
      local q = QuestData[quest_id]
      if (nil == q.Cond or q.Cond()) then
        if (nil ~= q.TalkId) then
          local rand_talk_id = math.random(#q.TalkId)
          StartTalk(q.TalkId[rand_talk_id])
        elseif (nil ~= q.LevelId) then
          Good.GenObj(-1, q.LevelId)
        end
        if (nil == q.NextCond and nil ~= q.NextId) then
          curr_stage_id[obj_name] = q.NextId
        end
      end
      return true
    end
  end
  return false
end

function ScriptMerchantBuyBou2()
  curr_coin = curr_coin - BOU2_COST
  LevelUpBou()
end

function ScriptMerchantBuyBou3()
  curr_coin = curr_coin - BOU3_COST
  LevelUpBou()
end

function ScriptSendTeacherMail()
  flag_mail = 1
end

function ScriptTransMailToPriest()
  flag_mail = 2
  curr_coin = curr_coin - CHURCH_RECV_MAIL_COST
end

function SetNextTrainingLevel(id)
  if (AllTrainingComplete()) then
    StartTalk(teacher_done_talk_id)
  else
    Good.GenObj(-1, id)
  end
end

function StartTalk(id)
  if (nil ~= id) then
    curr_talk_id = {id}
  end
  last_lvl_id = Good.GetLevelId()
  Good.GenObj(-1, talk_lvl_id)
end

function UpdateCoinInfo(param)
  if (nil ~= param.coin_obj) then
    Good.KillObj(param.coin_obj)
    param.coin_obj = nil
  end
  local o = GenNumObj(curr_coin, 32)
  Good.SetPos(o, 32, 0)
  param.coin_obj = o
end

function UpdateTrainingCd()
  training_cd_tick = training_cd_tick + 1
  if (60 <= training_cd_tick) then
    training_cd_tick = 0
    for i = 1, #all_training do
      local training = all_training[i]
      if (0 < training.cd) then
        training.cd = training.cd - 1
      end
    end
  end
end

function WaitTimer(param, t)
  if (nil == param.wait_time) then
    param.wait_time = t
  end
  param.wait_time = param.wait_time - 1
  if (0 >= param.wait_time) then
    param.wait_time = nil
    return true
  else
    return false
  end
end
