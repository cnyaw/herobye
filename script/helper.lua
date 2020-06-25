
local OPEN_CHURCH_COST = 50
local GIVE_GODZILLA_COST = 100
local CROWD_FUNDING_COST = 1000
local LOTTERY_COST = 5
local SELL_ITEM_COST = 4

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
  o_back = 18000,
  o_toAlienArea = 19000,
  o_alien = 20000,
  o_well = 21000,
  o_dwarfpotato = 21100,
  o_toUnderMain = 21200,
  o_toUnderEntry = 21300,
  o_elderGlass = 21400,
  o_elderYellow = 21500,
  o_elderWhite = 21600,
  o_toTrashField = 21700,
  o_oldLady = 22000,
  o_magicmama = 23000,
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

function AddTempleScore(amount)
  AddItem('i_temple_score', amount)
  if (GetTempleMaxScore() < GetTempleScore() and 10 > GetTempleLevel()) then
    AddItem('i_temple_lvl', 1)
    SetItem('i_temple_score', 0)
  end
end

function BounceGameInit(param, nobj, tex, genobj)
  param.hit = 0
  param.obj = {}
  local w, h = Resource.GetTexSize(tex)
  for i = 1, nobj do
    local x = math.random(SCR_W - w)
    local y = math.random(SCR_H - h)
    local o = Good.GenObj(-1, tex, 'BouncingObj')
    Good.SetPos(o, x, y)
    if (nil ~= genobj) then
      genobj(o, i)
    end
    param.obj[i] = o
  end
end

function BuyCandyLoop()
  return not HasCandy() and HasItem('f_buy_candy_loop')
end

function CanPlayLottery()
  return HasCoin(LOTTERY_COST)
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

function FlashlightOutOfPower()
  return 0 == FlashlightUseCount()
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

function GetTempleLevel()
  return ItemCount('i_temple_lvl')
end

function GetTempleMaxScore()
  return 1000 * GetTempleLevel()
end

function GetTempleScore()
  return ItemCount('i_temple_score')
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

function HasCaveMazeBookFlag()
  return HasItem('f_cave_maze_book')
end

function HasCleanYellowSuit()
  return HasItem('i_clean_yellow_suit')
end

function HasDrumStick()
  return HasItem('i_drum_stick')
end

function HasFlashlight()
  return HasItem('i_flashlight')
end

function HasFrogTear()
  return HasItem('i_frog_tear')
end

function HasFrogTearToSell()
  return HasFrogTear() and HasPowerScissor()
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

function HasMouseTailToSell()
  return HasItem('i_green_mouse_tail') or HasItem('i_red_mouse_tail') or HasItem('i_yellow_mouse_tail')
end

function HasPowerScissor()
  return HasItem('i_power_scissor')
end

function HasRope()
  return HasItem('i_rope')
end

function HasRpsMedal()
  return HasItem('i_rps_medal')
end

function HasScissor()
  return HasItem('i_scissor')
end

function HasShaveBook()
  return HasItem('i_shave_book')
end

function HasSuperSoap()
  return HasItem('i_super_soap')
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

function IsDrumStickLoop()
  return IsPowerupScissorLoop() and HasFrogTear()
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
  return HasMallet() and HasCoin(GIVE_GODZILLA_COST)
end

function IsHelpElderWhite()
  return HasItem('f_help_elder_white')
end

function IsHelpElderYellow()
  return HasItem('f_help_elder_yellow')
end

function IsNeedRope()
  return HasItem('f_need_rope')
end

function IsOpenRacingValid()
  return HasBackScratcher() and HasCoin(10)
end

function IsPowerupScissorLoop()
  return HasItem('f_powerup_scissor')
end

function IsPassPotatoTest()
  return HasItem('f_pass_potato_test')
end

function IsPowerupScissorReady()
  return HasFrogTear() and HasScissor() and HasDrumStick()
end

function IsRestValid()
  return HasCoin(REST_COST)
end

function IsSendTeacherLetterValid()
  return HasBou3() and HasCoin(OPEN_CHURCH_COST)
end

function IsStickTrainingMaxLv()
  return TrainingIsStickTrainingMaxLv()
end

function IsSuperSoapMaterialReady()
  return HasFrogTear() and HasItem('i_green_mouse_tail') and HasItem('i_red_mouse_tail') and HasItem('i_yellow_mouse_tail')
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
      local q = QuestData[quest_id]
      if (nil ~= q.NextId and nil ~= q.NextCond and q.NextCond()) then
        local next_id = q.NextId
        obj_state[obj_name] = next_id
        q = QuestData[next_id]
      end
      if (nil ~= q.RedPt) then
        AddRedPoint(id)
      end
      if (nil ~= q.TexId) then
        Good.SetTexId(id, q.TexId)
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
        HandleTalkLevelId(q)
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

function ScriptAddCaveMazeBookFlag()
  SetItem('f_cave_maze_book', 1)
end

function ScriptAddCaveMazeBook()
  RemoveItem('f_cave_maze_book', 1)
  SetItem('i_cave_maze_book', 1)
end

function ScriptAddDrumStick()
  SetItem('i_drum_stick', 1)
end

function ScriptAddFrogTear()
  SetItem('i_frog_tear', 1)
end

function ScriptAddHeroHisBook()
  SetItem('i_hero_history_book', 1)
end

function ScriptAddMellet()
  RemoveItem('f_mallet_code', 1)
  SetItem('i_mallet', 1)
end

function ScriptAddPowerScissorBook()
  SetItem('i_power_scissor_book', 1)
end

function ScriptAddRope()
  SetItem('f_need_rope', 0)
  SetItem('i_rope', 1)
end

function ScriptAddRpsMedal()
  SetItem('i_rps_medal', 1)
end

function ScriptAddShaveBook()
  SetItem('i_shave_book', 1)
end

function ScriptAddSlapMouseBook()
  SetItem('i_slap_mouse_book', 1)
end

function ScriptAddSuperSoap()
  SetItem('i_frog_tear', 0)
  SetItem('i_green_mouse_tail', 0)
  SetItem('i_red_mouse_tail', 0)
  SetItem('i_yellow_mouse_tail', 0)
  SetItem('i_super_soap', 1)
end

function ScriptAddSuperSoapBook()
  SetItem('i_super_soap_book', 1)
end

function ScriptBuildTemple()
  ConsumeCoin(CROWD_FUNDING_COST)
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
  ConsumeCoin(CANDY_COST)
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
  ScriptBuyFlashlight()
end

function ScriptCleanYellowSuit()
  SetItem('i_super_soap', 0)
  SetItem('i_dirty_yellow_suit', 0)
  SetItem('i_clean_yellow_suit', 1)
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

function ScriptHelpElderWhite()
  SetItem('f_help_elder_white', 1)
end

function ScriptHelpElderYellow()
  SetItem('f_help_elder_yellow', 1)
  SetItem('i_dirty_yellow_suit', 1)
end

function ScriptHelpElderYellowDone()
  SetItem('i_clean_yellow_suit', 0)
end

function ScriptOpenCaveDoor()
  SetItem('f_open_cave_door', 1)
end

function ScriptPassPotatoTest()
  SetItem('f_pass_potato_test', 1)
end

function ScriptPlayLottery()
  ConsumeCoin(LOTTERY_COST)
end

function ScriptPowerupScissor()
  RemoveItem('i_scissor', 1)
  RemoveItem('i_drum_stick', 1)
  RemoveItem('i_frog_tear', 1)
  RemoveItem('f_powerup_scissor', 1)
  SetItem('i_power_scissor', 1)
end

function ScriptPowerupScissorLoop()
  SetItem('f_powerup_scissor', 1)
end

function ScriptSellFrogTear()
  SetItem('i_frog_tear', 0)
  AddCoin(SELL_ITEM_COST)
end

function ScriptSellMouseTail()
  local item = {'i_green_mouse_tail', 'i_red_mouse_tail', 'i_yellow_mouse_tail'}
  for i = 1, 3 do
    if (HasItem(item[i])) then
      SetItem(item[i], 0)
      AddCoin(SELL_ITEM_COST)
    end
  end
end

function ScriptSendTeacherLetter()
  SetItem('i_letter', 1)
end

function ScriptSetNeedRopeFlag()
  SetItem('f_need_rope', 1)
end

function ScriptTempleCreated()
  SetItem('i_temple_lvl', 1)
end

function ScriptTextAddMouseTail(fmt)
  local i = math.random(3)
  if (1 == i) then
    SetItem('i_red_mouse_tail', 1)
  elseif (2 == i) then
    SetItem('i_green_mouse_tail', 1)
  else
    SetItem('i_yellow_mouse_tail', 1)
  end
  local s = {'紅', '綠', '黃'}
  return string.format(fmt, s[i])
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

function TrueCond()
  return true
end

function UpdateCoinInfo(param)
  if (nil ~= param.coin_obj) then
    Good.KillObj(param.coin_obj)
    param.coin_obj = nil
  end
  if (-1 == Good.FindChild(param._id, 'coin', 1)) then
    return
  end
  local o = GenNumObj(GetCoin(), 32)
  Good.SetPos(o, 32, 0)
  param.coin_obj = o
end

function UpdateCounterDummyUi(param, tex, count)
  if (nil ~= param.counter_dummy) then
    Good.KillObj(param.counter_dummy)
    param.counter_dummy = nil
  end
  local scale = 0.4
  local tw, th = Resource.GetTexSize(tex)
  local ox = 0
  local dummy = Good.GenDummy(param._id)
  for i = 1, count do
    local o = Good.GenObj(dummy, tex)
    Good.SetScale(o, scale, scale)
    Good.SetPos(o, ox, 0)
    ox = ox + tw * scale
    if (i > param.counter_dummy_count) then
      Good.SetBgColor(o, COLOR_BLACK)
    end
  end
  param.counter_dummy = dummy
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
