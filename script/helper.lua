
local OPEN_CHURCH_COST = 50
local GIVE_GODZILLA_COST = 100
local CROWD_FUNDING_COST = 1000

local tex_sandglass_id = 273
local red_point_tex_id = 313
local talk_lvl_id = 275
local teacher_init_talk_id = 1

local SAV_FILE_NAME = "herobye.sav"

-- Data.

local last_lvl_id = nil
local curr_talk_id = {teacher_init_talk_id}

local init_obj_state = {                -- [obj_name] = quest_id
  o_brother1 = 6000,
  o_brother2 = 7000,
  o_heroMount = 1000,
  o_mainMapShop = 2000,
  o_mainMapVillage = 3000,
  o_mainMapChurch = 4000,
  o_bag = 5000,
  o_mainMapTempleSite = 8000,
  o_heroVillageChurch = 9000,
  o_grandpa = 9100,
  o_churchShelf = 9200,
  o_ZhangHome = 10000,
  o_heroVillageShop = 11000,
  o_XiangHome = 12000,
  o_heroHome = 13000,
  o_toAlienPath = 14000,
  o_toCountry = 14100,
  o_toHeroVillage = 14200,
  o_toCaveField = 14300,
  o_KaiHome = 15000,
  o_pond = 16000,
  o_cave = 17000
}

obj_state = {
}

local init_bag = {                      -- [item_id] = count
  i_coin = 0,
  i_hero_coin = 0,
  i_bou = 0
}

bag = {
}

-- Helper.

function AddCoin(amount)
  AddItem(GetCoinId(), amount)
end

function AddItem(id, count)
  if (HasItem(id)) then
    bag[id] = bag[id] + count
  else
    bag[id] = count
  end
end

function AddMissingTableItem(tbl, init_tbl)
  for k,v in pairs(init_tbl) do
    if (nil == tbl[k]) then
      tbl[k] = v
    end
  end
end

function AddRedPoint(parent)
  local o = Good.GenObj(parent, red_point_tex_id, 'AnimTalkArrow')
  local l,t,w,h = Good.GetDim(o)
  local lp,tp,wp,hp = Good.GetDim(parent)
  Good.SetPos(o, wp - w/2, hp - h/2)
end

function Consume2ndDreamCost()
  ConsumeCoin(CHURCH_2ND_DREAM_COST)
end

function ConsumeCoin(cost)
  RemoveItem(GetCoinId(), cost)
end

function ConsumeRestCost()
  ConsumeCoin(REST_COST)
end

function EnterCaveCount()
  return ItemCount('i_enter_cave')
end

function EnterPlace(id)
  SetItem('f_in_place', id)
  SaveGame()
end

function GenFlyUpObj(parent, tex_id)
  local x, y = Good.GetPos(parent)
  local l,t,w,h = Good.GetDim(parent)
  local o = Good.GenObj(-1, tex_id, 'AnimFlyUpObj')
  local l2,t2,w2,h2 = Good.GetDim(o)
  Good.SetPos(o, x + (w - w2)/2, y)
end

function GetCoin()
  return ItemCount(GetCoinId())
end

function GetCoinId()
  if (GetCurrBagType() == e_main_bag) then
    return 'i_coin'
  else
    return 'i_hero_coin'
  end
end

function GetCurrBagType()
  if (GetLastLvlId() == MAIN_MAP_LVL_ID) then
    return e_main_bag
  else
    return e_hero_bag
  end
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
  if (IsTempleCrowdFunding() and HasGodzilla()) then
    return 20
  elseif (HasBou3()) then
    return 5
  elseif (HasBou2()) then
    return 3
  else
    return 1
  end
end

function GetCurrBouTexId()
  if (IsTempleCrowdFunding() and HasGodzilla()) then
    return GODZILLA_TEX_ID
  elseif (HasBou3()) then
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

function GetLastLvlId()
  return ItemCount('f_in_place')
end

function HasBackScratcher()
  return HasItem('i_back_scratcher')
end

function HasBou2()
  return HasItem('i_bou2')
end

function HasBou3()
  return HasItem('i_bou3')
end

function HasCoin(amount)
  return GetCoin() >= amount
end

function HasGodzilla()
  return HasItem('i_godzilla')
end

function HasItem(id)
  return nil ~= bag[id]
end

function HasLetter()
  return HasItem('i_letter')
end

function InitTable(init_tbl)
  local tbl = {}
  for k,v in pairs(init_tbl) do
    tbl[k] = v
  end
  return tbl
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
  return TrainingIsClickTrainingMaxLv()
end

function IsClickTrainingValid()
  return TrainingIsClickTrainingValid()
end

function IsEnterCave2Times()
  return 2 <= EnterCaveCount()
end

function IsEnterCave4Times()
  return 4 <= EnterCaveCount()
end

function IsEnterCave6Times()
  return 6 <= EnterCaveCount()
end

function IsGiveGodzillaValid()
  return IsInterviewUfo() and HasCoin(GIVE_GODZILLA_COST)
end

function IsInterviewUfo()
  return HasItem('f_interview_ufo')
end

function IsOpenRacingValid()
  return IsInterviewUfo() and HasCoin(10)
end

function IsRestValid()
  return HasCoin(REST_COST)
end

function IsSendTeacherLetterValid()
  return not LetterSent() and not HasLetter() and HasBou3() and HasCoin(OPEN_CHURCH_COST)
end

function IsStickTrainingMaxLv()
  return TrainingIsStickTrainingMaxLv()
end

function IsStickTrainingValid()
  return TrainingIsStickTrainingValid()
end

function IsTempleCrowdFunding()
  return HasItem('i_godzilla')
end

function IsTempleCrowdFundingDone()
  return GetCoin() >= CROWD_FUNDING_COST
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
  return HasItem('f_letter_sent')
end

function LoadGame()
  ResetGame()
  local inf = io.open(SAV_FILE_NAME, "r")
  if (nil == inf) then
    return
  end
  assert(loadstring(inf:read("*all")))()
  inf:close()
  AddMissingTableItem(obj_state, init_obj_state)
  AddMissingTableItem(bag, init_bag)
end

function NotRestValid()
  return not IsRestValid()
end

function QuestOnCreate()
  local lvl_id = Good.GetLevelId()
  for obj_name, quest_id in pairs(obj_state) do
    local id = Good.FindChild(lvl_id, obj_name, 1)
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
    local id = Good.FindChild(lvl_id, obj_name, 1)
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
  elseif ('i_coin' == id or 'i_hero_coin' == id) then
    bag[id] = 0
  else
    bag[id] = nil
  end
end

function ResetGame()
  obj_state = InitTable(init_obj_state)
  bag = InitTable(init_bag)
  curr_talk_id = {teacher_init_talk_id}
  ResetTraining()
end

function SaveGame()
  local outf = io.open(SAV_FILE_NAME, "w")
  WriteStrTable(outf, 'obj_state', obj_state)
  WriteStrTable(outf, 'bag', bag)
  outf:close()
end

function ScriptAddBackScratcher()
  AddItem('i_back_scratcher', 1)
end

function ScriptAddBou1()
  AddItem('i_bou', 1)
end

function ScriptBuildTemple()
  ConsumeCoin(CROWD_FUNDING_COST)
  RemoveItem('i_godzilla', 1)
end

function ScriptBuyBou2()
  ConsumeCoin(BOU2_COST)
  AddItem('i_bou2', 1)
end

function ScriptBuyBou3()
  ConsumeCoin(BOU3_COST)
  AddItem('i_bou3', 1)
end

function ScriptEnterCave()
  AddItem('i_enter_cave', 1)
end

function ScriptGiveAllowance()
  AddCoin(10)
end

function ScriptGiveGodzilla()
  AddItem('i_godzilla', 1);
end

function ScriptInterviewUfo()
  AddItem('f_interview_ufo', 1)
end

function ScriptSendTeacherLetter()
  AddItem('i_letter', 1)
end

function ScriptTextCrowdFunding(fmt)
  return string.format(fmt, CROWD_FUNDING_COST - GetCoin())
end

function ScriptTransLetterToPriest()
  ConsumeCoin(CHURCH_RECV_LETTER_COST)
  RemoveItem('i_letter', 1)
  AddItem('f_letter_sent', 1)
end

function SetItem(id, count)
  bag[id] = count
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
  if (-1 == Good.FindChild(param._id, 'coin')) then
    return
  end
  local o = GenNumObj(GetCoin(), 32)
  Good.SetPos(o, 32, 0)
  param.coin_obj = o
end

function TrueCond()
  return true
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

function WriteStrTable(outf, name, t)
  WriteTable_i(outf, name, t, '%s=%s')
end

function WriteTable_i(outf, name, t, fmt)
  outf:write(string.format('%s={', name))
  local tmp = {}
  for k,v in pairs(t) do
    table.insert(tmp, string.format(fmt, tostring(k), tostring(v)))
  end
  table.sort(tmp)
  for i = 1, #tmp do
    if (#tmp == i) then
      outf:write(string.format('%s\n', tmp[i]))
    else
      outf:write(string.format('%s,\n', tmp[i]))
    end
  end
  outf:write(string.format('}\n'))
end
