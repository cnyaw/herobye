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

local SAV_FILE_NAME = "herobye.sav"

BOU2_COST = 10
BOU3_COST = 30
CHURCH_RECV_LETTER_COST = 100
CHURCH_2ND_DREAM_COST = 100
REST_COST = 5

-- Data.

last_lvl_id = nil

local curr_talk_id = {teacher_init_talk_id}

obj_state = {                           -- [obj_name] = quest_id
}

bag = {                                 -- [item_id] = count
}

-- Training.

click_training = {cd = 0, lv = 0, max_lv = MAX_CLICK_LEVEL, obj_id = map_brother1_obj_id}
stick_training = {cd = 0, lv = 0, max_lv = MAX_STICK_LEVEL, obj_id = map_brother2_obj_id}
local all_training = {click_training, stick_training}
local training_cd_tick = 0

-- Helper.

function AddCoin(amount)
  AddItem(i_coin, amount)
end

function AddItem(id, count)
  if (HasItem(id)) then
    bag[id] = bag[id] + count
  else
    bag[id] = count
  end
end

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
  ConsumeCoin(CHURCH_2ND_DREAM_COST)
end

function ConsumeCoin(cost)
  RemoveItem(i_coin, cost)
end

function ConsumeRestCost()
  ConsumeCoin(REST_COST)
end

function GenFlyUpObj(parent, tex_id)
  local x, y = Good.GetPos(parent)
  local l,t,w,h = Good.GetDim(parent)
  local o = Good.GenObj(-1, tex_id, 'AnimFlyUpObj')
  local l2,t2,w2,h2 = Good.GetDim(o)
  Good.SetPos(o, x + (w - w2)/2, y)
end

function GetCoin()
  return ItemCount(i_coin)
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
  elseif (HasBou2()) then
    return 3
  else
    return 1
  end
end

function GetCurrBouTexId()
  if (HasBou3()) then
    return BOU3_TEX_ID
  elseif (HasBou2()) then
    return BOU2_TEX_ID
  else
    return BOU_TEX_ID
  end
end

function GetCurrTalk()
  return TalkData[curr_talk_id[1]]
end

function HasBou2()
  return HasItem(i_bou2)
end

function HasBou3()
  return HasItem(i_bou3)
end

function HasCoin(amount)
  return GetCoin() >= amount
end

function HasItem(id)
  return nil ~= bag[id]
end

function HasLetter()
  return HasItem(i_letter)
end

function IsBuyBou2Valid()
  return not HasBou2() and HasCoin(BOU2_COST)
end

function IsBuyBou3Valid()
  return not HasBou3() and HasCoin(BOU3_COST)
end

function IsChurch2ndDreamValid()
  return HasCoin(CHURCH_2ND_DREAM_COST)
end

function IsClickTrainingMaxLv()
  return click_training.max_lv <= click_training.lv
end

function IsClickTrainingValid()
  return 0 >= click_training.cd
end

function IsOpenRacingValid()
  return 4004 <= obj_state.o_mainMapChurch and HasCoin(10)
end

function IsRestValid()
  return HasCoin(REST_COST)
end

function IsSendTeacherLetterValid()
  return not LetterSent() and not HasLetter() and HasBou3() and HasCoin(OPEN_CHURCH_COST)
end

function IsStickTrainingMaxLv()
  return stick_training.max_lv <= stick_training.lv
end

function IsStickTrainingValid()
  return 0 >= stick_training.cd
end

function IsTransLetterToPriestValid()
  return HasLetter() and HasCoin(CHURCH_RECV_LETTER_COST)
end

function ItemCount(id)
  if (HasItem(id)) then
    return bag[id]
  else
    return 0
  end
end

function LetterSent()
  return HasItem(f_letter_sent)
end

function LoadGame()
  ResetGame()
  local inf = io.open(SAV_FILE_NAME, "r")
  if (nil == inf) then
    return
  end
  assert(loadstring(inf:read("*all")))()
  inf:close()
end

function NotRestValid()
  return not IsRestValid()
end

function QuestOnCreate()
  local lvl_id = Good.GetLevelId()
  for obj_name, quest_id in pairs(obj_state) do
    local id = Good.FindChild(lvl_id, obj_name)
    if (-1 ~= id) then
      local q = QuestData[quest_id]
      if (nil ~= q.NextId and nil ~= q.NextCond and q.NextCond()) then
        local next_id = q.NextId
        obj_state[obj_name] = next_id
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
  for obj_name, quest_id in pairs(obj_state) do
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
          obj_state[obj_name] = q.NextId
        end
      end
      return true
    end
  end
  return false
end

function RemoveItem(id, count)
  if (not HasItem(id)) then
    return
  end
  if (count < bag[id]) then
    bag[id] = bag[id] - count
  elseif (i_coin == id) then
    bag[id] = 0
  else
    bag[id] = nil
  end
end

function ResetGame()
  obj_state = {}
  obj_state.o_brother1 = 6000
  obj_state.o_brother2 = 7000
  obj_state.o_heroMount = 1000
  obj_state.o_mainMapShop = 2000
  obj_state.o_mainMapVillage = 3000
  obj_state.o_mainMapChurch = 4000
  obj_state.o_bag = 5000
  obj_state.o_mainMapTempleSite = 8000
  obj_state.o_heroVillageChurch = 9000
  obj_state.o_ZhangHome = 10000
  obj_state.o_heroVillageShop = 11000
  obj_state.o_XiangHome = 12000
  obj_state.o_heroHome = 13000
  bag = {}
  bag[i_coin] = 0
  bag[i_bou] = 0
end

function SaveGame()
  local outf = io.open(SAV_FILE_NAME, "w")
  WriteStrTable(outf, 'obj_state', obj_state)
  WriteIntTable(outf, 'bag', bag)
  outf:close()
end

function ScriptAddBou1()
  AddItem(i_bou, 1)
end

function ScriptMerchantBuyBou2()
  ConsumeCoin(BOU2_COST)
  AddItem(i_bou2, 1)
end

function ScriptMerchantBuyBou3()
  ConsumeCoin(BOU3_COST)
  AddItem(i_bou3, 1)
end

function ScriptSendTeacherLetter()
  AddItem(i_letter, 1)
end

function ScriptTransLetterToPriest()
  ConsumeCoin(CHURCH_RECV_LETTER_COST)
  RemoveItem(i_letter, 1)
  AddItem(f_letter_sent, 1)
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
  local o = GenNumObj(GetCoin(), 32)
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

function WriteIntTable(outf, name, t)
  WriteTable_i(outf, name, t, '[%s]=%s')
end

function WriteStrTable(outf, name, t)
  WriteTable_i(outf, name, t, '%s=%s')
end

function WriteTable_i(outf, name, t, fmt)
  outf:write(string.format('%s={', name))
  local tmp = {}
  for k,v in pairs(t) do
    table.insert(tmp, string.format(fmt, tostring(k), tostring(v)))
  end
  for i = 1, #tmp do
    if (#tmp == i) then
      outf:write(string.format('%s', tmp[i]))
    else
      outf:write(string.format('%s,', tmp[i]))
    end
  end
  outf:write(string.format('}\n'))
end

ResetGame()                             -- Init game.
