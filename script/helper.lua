
local OPEN_CHURCH_COST = 50
local GIVE_GODZILLA_COST = 100
local CROWD_FUNDING_COST = 1000
local MAX_FLASH_LIGHT_USE_COUNT = 5

local tex_sandglass_id = 273
local red_point_tex_id = 313
local talk_lvl_id = 275
local teacher_init_talk_id = 1

local SAV_FILE_NAME = "herobye.sav"

-- Data.

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
  o_cave = 17000,
  o_back = 18000
}

obj_state = {
}

local init_bag = {                      -- [item_id] = count
  i_coin = 0,
  i_hero_coin = 0,
  i_bou = 0,
  i_hero_history_book = 1
}

bag = {
}

local open_cave_door_code = '1231'

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

function BuyCandyLoop()
  return not HasCandy() and HasItem('f_buy_candy_loop')
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
  return ItemCount('i_enter_cave_count')
end

function EnterPlace(id)
  SetItem('f_last_lvl_id', id)
  SaveGame()
end

function FlashlightCharged()
  return 0 < FlashlightUseCount()
end

function FlashlightOutOfPower()
  if (0 == FlashlightUseCount()) then
    RemoveItem('i_flashlight', 1)
    SetItem('i_flashlight_nopower', 1)
    return true
  else
    return false
  end
end

function FlashlightUseCount()
  return ItemCount('i_flashlight_use_count')
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
  elseif (GetLastLvlId() == HERO_VILLAGE_CHURCH_LVL_ID) then
    return e_book_lib
  else
    return e_hero_bag
  end
end

function GetHeroVillageBackLvlId()
  if (GetLastLvlId() == HERO_VILLAGE_CHURCH_LVL_ID) then
    return HERO_VILLAGE_LVL_ID
  elseif (GetLastLvlId() == CAVE_DOOR_LVL_ID) then
    return CAVE_FIELD_LVL_ID
  else
    return TITLE_LVL_ID
  end
end

function GetOpenCaveDoorCode()
  return open_cave_door_code
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
  return ItemCount('f_last_lvl_id')
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

function HasCandy()
  return HasItem('i_candy')
end

function HasFlashlight()
  return HasItem('i_flashlight') or HasItem('i_flashlight_nopower')
end

function HasFrogTear()
  return HasItem('i_frog_tear')
end

function HasGetMalletCode()
  return HasItem('f_mallet_code')
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

function HasMallet()
  return HasItem('i_mallet')
end

function HasScissor()
  return HasItem('i_scissor')
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

function IsBuyCandyValid()
  return not HasCandy() and HasCoin(CANDY_COST)
end

function IsChurch2ndDreamValid()
  return HasCoin(CHURCH_2ND_DREAM_COST)
end

function IsClickTrainingMaxLv()
  return TrainingIsClickTrainingMaxLv()
end

function IsEnterCave()
  return 0 < EnterCaveCount()
end

function IsEnterCave2Times()
  return 2 <= EnterCaveCount()
end

function IsFinishTraining()
  return HasItem('f_finish_training')
end

function IsFlashlightBuyable()
  return HasCoin(FLASHLIGHT_COST)
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

function IsPowerupScissorLoop()
  return HasItem('f_powerup_scissor')
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

function IsTempleCrowdFunding()
  return HasItem('i_godzilla')
end

function IsTempleCrowdFundingDone()
  return GetCoin() >= CROWD_FUNDING_COST
end

function IsTransLetterToPriestValid()
  return HasLetter() and HasCoin(CHURCH_RECV_LETTER_COST)
end

function IsUnlockTraining()
  AddItem('i_unlock_training_count', 1)
  return 10 <= ItemCount('i_unlock_training_count')
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

function OpenCaveDoor()
  return HasItem('f_open_cave_door')
end

function QuestOnCreate()
  local lvl_id = Good.GetLevelId()
  for obj_name, quest_id in pairs(obj_state) do
    local id = Good.FindChild(lvl_id, obj_name, 1)
    if (-1 ~= id) then
      local NextCondNames = {'NextCond', 'NextCond2', 'NextCond3'}
      local NextIdNames = {'NextId', 'NextId2', 'NextId3'}
      local q = QuestData[quest_id]
      for i = 1, #NextCondNames do
        local NextId = NextIdNames[i]
        local NextCond = NextCondNames[i]
        if (nil ~= q[NextId] and nil ~= q[NextCond] and q[NextCond]()) then
          local next_id = q[NextId]
          obj_state[obj_name] = next_id
          q = QuestData[next_id]
          break
        end
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
      if (nil ~= q.TalkId) then
        local rand_talk_id = math.random(#q.TalkId)
        StartTalk(q.TalkId[rand_talk_id])
      elseif (nil ~= q.LevelId or nil ~= q.ScriptLevelId) then
        HandleTalkLevelId(nil, q)
      end
      if (nil == q.NextCond and nil ~= q.NextId) then
        obj_state[obj_name] = q.NextId
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
  ResetOpenCaveDoorCode()
end

function ResetOpenCaveDoorCode()
  local len = string.len(open_cave_door_code)
  open_cave_door_code = ''
  local idx = math.random(3)
  for i = 1, len do
    open_cave_door_code = open_cave_door_code .. tostring(1 + (i + idx) % 3)
  end
end

function SaveGame()
  local outf = io.open(SAV_FILE_NAME, "w")
  WriteStrTable(outf, 'obj_state', obj_state)
  WriteStrTable(outf, 'bag', bag)
  outf:close()
end

function ScriptAddBackScratcher()
  SetItem('i_back_scratcher', 1)
end

function ScriptAddBou1()
  SetItem('i_bou', 1)
end

function ScriptAddCaveDoorBook()
  SetItem('i_cave_door_book', 1)
end

function ScriptAddFrogTear()
  SetItem('i_frog_tear', 1)
end

function ScriptAddMellet()
  SetItem('i_mallet', 1)
end

function ScriptAddPowerScissorBook()
  SetItem('i_power_scissor_book', 1)
end

function ScriptBuildTemple()
  ConsumeCoin(CROWD_FUNDING_COST)
  RemoveItem('i_godzilla', 1)
end

function ScriptBuyBou2()
  ConsumeCoin(BOU2_COST)
  SetItem('i_bou2', 1)
end

function ScriptBuyBou3()
  ConsumeCoin(BOU3_COST)
  SetItem('i_bou3', 1)
end

function ScriptBuyCandy()
  SetItem('i_candy', 1)
  SetItem('f_buy_candy_loop', 0)
end

function ScriptBuyCandyLoop()
  SetItem('f_buy_candy_loop', 1)
end

function ScriptBuyFlashlight()
  ConsumeCoin(FLASHLIGHT_COST)
  SetItem('i_flashlight', 1)
  SetItem('i_flashlight_use_count', MAX_FLASH_LIGHT_USE_COUNT)
end

function ScriptChargeFlashlight()
  RemoveItem('i_flashlight_nopower', 1)
  ScriptBuyFlashlight()
end

function ScriptEnterCave()
  AddItem('i_enter_cave_count', 1)
end

function ScriptExchangeCandyScissor()
  SetItem('i_candy', 0)
  SetItem('i_scissor', 1)
end

function ScriptGetMalletCode()
  SetItem('f_mallet_code', 1)
end

function ScriptGiveAllowance()
  AddCoin(10)
end

function ScriptGiveGodzilla()
  SetItem('i_godzilla', 1);
end

function ScriptInterviewUfo()
  SetItem('f_interview_ufo', 1)
end

function ScriptOpenCaveDoor()
  SetItem('f_open_cave_door', 1)
end

function ScriptPowerupScissorLoop()
  SetItem('f_powerup_scissor', 1)
end

function ScriptSellFrogTear()
  SetItem('i_frog_tear', 0)
  AddCoin(4)
end

function ScriptSendTeacherLetter()
  SetItem('i_letter', 1)
end

function ScriptTextCrowdFunding(fmt)
  return string.format(fmt, CROWD_FUNDING_COST - GetCoin())
end

function ScriptTextFlashlightUseCount(fmt)
  return string.format(fmt, FlashlightUseCount())
end

function ScriptTransLetterToPriest()
  ConsumeCoin(CHURCH_RECV_LETTER_COST)
  RemoveItem('i_letter', 1)
  SetItem('f_letter_sent', 1)
end

function ScriptUseFlashlight()
  RemoveItem('i_flashlight_use_count', 1)
end

function SetItem(id, count)
  if (0 < count) then
    bag[id] = count
  else
    bag[id] = nil
  end
end

function StartTalk(id)
  if (nil ~= id) then
    curr_talk_id = {id}
  end
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
