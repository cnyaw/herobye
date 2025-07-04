
local MAX_CLICK_LEVEL = 3
local MAX_STICK_LEVEL = 3
local MAX_CLICK = 5
local MAX_STICK = 5
local TIME_TRAINING_CD = 3
local WAIT_TIME = 40

local back_obj_id = 571
local click_back_obj_id = 572
local click_fish_obj_id = 269
local stick_tex_id = 292
local circle_tex_id = 326
local map_brother1_obj_id = 282
local map_brother2_obj_id = 283

local teacher_done_talk_id = 50

local hit_obj = nil

local click_training = {cd = 0, lv = 0, max_lv = MAX_CLICK_LEVEL, obj_id = map_brother1_obj_id}
local stick_training = {cd = 0, lv = 0, max_lv = MAX_STICK_LEVEL, obj_id = map_brother2_obj_id}
local all_training = {click_training, stick_training}
local training_cd_tick = 0

local function GenTrainingNumInfoObj(n)
  local o = GenNumObj(n, 64)
  local w = GetTextObjWidth(o)
  Good.SetPos(o, (SCR_W - w)/2, 20)
  return o
end

local function GenTrainingObj(training)
  local o = GenTrainingNumInfoObj(training.lv)
  local ow = GetTextObjWidth(o)
  local id = training.obj_id
  local x, y = Good.GetPos(id)
  local l,t,w,h = Good.GetDim(id)
  local sx, sh = Good.GetScale(id)
  local ox = x + (w * sx - ow)/2
  Good.SetPos(o, ox, 40)
  if (training.lv == training.max_lv) then
    SetTextObjColor(o, COLOR_GREEN)
  end
  if (0 < training.cd) then
    local sand_obj = GenSandGlassObj(training.cd)
    local l,t,w2,h2 = Good.GetDim(sand_obj)
    local ox = x + (w * sx - w2)/2
    Good.SetPos(sand_obj, ox, SCR_H - 100)
  end
end

local function GetTrainingMapBackLvlId()
  if (IsFinishTraining()) then
    return MAIN_MAP_LVL_ID
  else
    return TITLE_LVL_ID
  end
end

local function GetClickTrainingCount(param)
  if (IsFinishTraining()) then
    return ClickTrainingCount()
  else
    return MAX_CLICK - param.hit
  end
end

local function InitStick(o)
  Good.SetScript(o, '')
end

local function AdvanceTrainingLevel(training)
  training.lv = training.lv + 1
  if (training.max_lv > training.lv) then
    training.cd = TIME_TRAINING_CD
  end
end

local function AllTrainingComplete()
  for i = 1, #all_training do
    local training = all_training[i]
    if (training.lv ~= training.max_lv) then
      return false
    end
  end
  return true
end

local function GenClickFishEffect()
  local o = Good.GenObj(-1, circle_tex_id, 'AnimClickFish')
  Good.SetAnchor(o, 0.5, 0.5)
  Good.SetScale(o, 0, 0)
  local x, y = Good.GetPos(click_fish_obj_id)
  local l,t,w,h = Good.GetDim(click_fish_obj_id)
  local l2,t2,w2,h2 = Good.GetDim(o)
  Good.SetPos(o, x + (w - w2)/2, y + (h - h2)/2)
end

local function SetNextTrainingLevel(id)
  if (AllTrainingComplete()) then
    AddItem('f_finish_training', 1)
    StartTalk(teacher_done_talk_id)
  else
    Good.GenObj(-1, id)
  end
end

local function TrainingClickEnd(param)
  if (WaitTime(param, WAIT_TIME)) then
    AdvanceTrainingLevel(click_training)
    SetNextTrainingLevel(TRAINING_MAP_LVL_ID)
  end
end

local function TrainingClickPlay(param)
  if (not Input.IsKeyPushed(Input.LBUTTON)) then
    return
  end
  local x, y = Input.GetMousePos()
  if (PtInObj(x, y, click_fish_obj_id)) then
    GenClickFishEffect()
    param.hit = param.hit + 1
    if (nil ~= hit_obj) then
      Good.KillObj(hit_obj)
      hit_obj = nil
    end
    if (not IsFinishTraining()) then
      hit_obj = GenTrainingNumInfoObj(GetClickTrainingCount(param))
      if (MAX_CLICK == param.hit) then
        param.step = TrainingClickEnd
        return
      end
    else
      IncClickTrainingCount()
      hit_obj = GenTrainingNumInfoObj(GetClickTrainingCount(param))
    end
  end
end

local function TrainingStickEnd(param)
  if (WaitTime(param, WAIT_TIME)) then
    AdvanceTrainingLevel(stick_training)
    SetNextTrainingLevel(TRAINING_MAP_LVL_ID)
  end
end

local function TrainingStickOnHitStick(param, o)
  GenFlyUpObj(o, stick_tex_id)
  if (MAX_STICK == param.hit) then
    param.step = TrainingStickEnd
  end
end

local function UpdateTrainingCd()
  training_cd_tick = training_cd_tick + 1
  if (ONE_SECOND_TICK <= training_cd_tick) then
    training_cd_tick = 0
    for i = 1, #all_training do
      local training = all_training[i]
      if (0 < training.cd) then
        training.cd = training.cd - 1
      end
    end
  end
end

local function TrainingOnStep(param)
  UpdateTrainingCd()
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, TRAINING_MAP_LVL_ID)
    return
  end
  param.step(param)
end

local function TrainingStickPlay(param)
  if (not Input.IsKeyPushed(Input.LBUTTON)) then
    return
  end
  local x, y = Input.GetMousePos()
  BounceGameHittest(param, x, y, TrainingStickOnHitStick)
end

TrainingMap = {}

TrainingMap.OnCreate = function(param)
  if (not IsFinishTraining()) then
    GenTrainingObj(click_training)
    GenTrainingObj(stick_training)
  else
    Good.SetVisible(back_obj_id, Good.VISIBLE)
  end
  QuestOnCreate()
end

TrainingMap.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, GetTrainingMapBackLvlId())
    return
  end
  UpdateTrainingCd()
  if (not Input.IsKeyPushed(Input.LBUTTON)) then
    return
  end
  local x, y = Input.GetMousePos()
  if (QuestOnStep(x, y)) then
    return
  end
  if (PtInObj(x, y, back_obj_id)) then
    Good.GenObj(-1, GetTrainingMapBackLvlId())
    return
  end
end

TrainingClick = {}

TrainingClick.OnCreate = function(param)
  param.hit = 0
  hit_obj = GenTrainingNumInfoObj(GetClickTrainingCount(param))
  param.step = TrainingClickPlay
  if (IsFinishTraining()) then
    Good.SetVisible(click_back_obj_id, Good.VISIBLE)
  end
end

TrainingClick.OnStep = function(param)
  if (Input.IsKeyPushed(Input.LBUTTON)) then
    local x, y = Input.GetMousePos()
    if (PtInObj(x, y, click_back_obj_id)) then
      Good.GenObj(-1, TRAINING_MAP_LVL_ID)
      return
    end
  end
  TrainingOnStep(param)
end

TrainingStick = {}

TrainingStick.OnCreate = function(param)
  BounceGameInit(param, MAX_STICK, stick_tex_id, InitStick)
  param.step = TrainingStickPlay
end

TrainingStick.OnStep = function(param)
  TrainingOnStep(param)
end

function ResetTraining()
  click_training.cd = 0
  click_training.lv = 0
  stick_training.cd = 0
  stick_training.lv = 0
  training_cd_tick = 0
end

function TrainingIsClickTrainingMaxLv()
  return click_training.max_lv <= click_training.lv
end

function TrainingIsStickTrainingMaxLv()
  return stick_training.max_lv <= stick_training.lv
end
