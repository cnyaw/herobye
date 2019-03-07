
local MAX_CLICK_LEVEL = 3
local MAX_STICK_LEVEL = 3
local MAX_CLICK = 5
local MAX_STICK = 5
local TIME_TRAINING_CD = 3

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

TrainingMap = {}

TrainingMap.OnCreate = function(param)
  GenTrainingObj(click_training)
  GenTrainingObj(stick_training)
  QuestOnCreate()
end

TrainingMap.OnStep = function(param)
  UpdateTrainingCd()
  if (not Input.IsKeyPushed(Input.LBUTTON)) then
    return
  end
  local x, y = Input.GetMousePos()
  if (QuestOnStep(x, y)) then
    return
  end
end

TrainingClick = {}

TrainingClick.OnCreate = function(param)
  param.hit = 0
  hit_obj = GenTrainingNumInfoObj(MAX_CLICK - param.hit)
  param.step = TrainingClickOnStepPlay
end

TrainingClick.OnStep = function(param)
  UpdateTrainingCd()
  param.step(param)
end

TrainingStick = {}

TrainingStick.OnCreate = function(param)
  param.hit = 0
  param.stick = {}
  local w, h = Resource.GetTexSize(stick_tex_id)
  for i = 1, MAX_STICK do
    local o = Good.GenObj(-1, stick_tex_id)
    local x = math.random(SCR_W - w)
    local y = math.random(SCR_H - h)
    Good.SetPos(o, x, y)
    param.stick[i] = o
  end
  param.step = TrainingStickOnStepPlay
end

TrainingStick.OnStep = function(param)
  UpdateTrainingCd()
  param.step(param)
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

function GenClickFishEffect()
  local o = Good.GenObj(-1, circle_tex_id, 'AnimClickFish')
  Good.SetAnchor(o, 0.5, 0.5)
  Good.SetScale(o, 0, 0)
  local x, y = Good.GetPos(click_fish_obj_id)
  local l,t,w,h = Good.GetDim(click_fish_obj_id)
  local l2,t2,w2,h2 = Good.GetDim(o)
  Good.SetPos(o, x + (w - w2)/2, y + (h - h2)/2)
end

function GenTrainingNumInfoObj(n)
  local o = GenNumObj(n, 64)
  local w = GetTextObjWidth(o)
  Good.SetPos(o, (SCR_W - w)/2, 20)
  return o
end

function GenTrainingObj(training)
  local o = GenTrainingNumInfoObj(training.lv)
  local ow = GetTextObjWidth(o)
  local id = training.obj_id
  local x, y = Good.GetPos(id)
  local l,t,w,h = Good.GetDim(id)
  local sx, sh = Good.GetScale(id)
  local ox = x + (w * sx - ow)/2
  Good.SetPos(o, ox, 40)
  if (training.lv == training.max_lv) then
    SetTextObjColor(o, 0xff00ff00)
  end
  if (0 < training.cd) then
    local sand_obj = GenSandGlassObj(training.cd)
    local l,t,w2,h2 = Good.GetDim(sand_obj)
    local ox = x + (w * sx - w2)/2
    Good.SetPos(sand_obj, ox, SCR_H - 100)
  end
end

function SetNextTrainingLevel(id)
  if (AllTrainingComplete()) then
    AddItem(f_finish_training, 1)
    StartTalk(teacher_done_talk_id)
  else
    Good.GenObj(-1, id)
  end
end

function TrainingClickOnStepEnd(param)
  if (not WaitTimer(param, 40)) then
    return
  end
  AdvanceTrainingLevel(click_training)
  SetNextTrainingLevel(TRAINING_MAP_LVL_ID)
end

function TrainingClickOnStepPlay(param)
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
    hit_obj = GenTrainingNumInfoObj(MAX_CLICK - param.hit)
    if (MAX_CLICK == param.hit) then
      param.step = TrainingClickOnStepEnd
      return
    end
  end
end

function TrainingIsClickTrainingMaxLv()
  return click_training.max_lv <= click_training.lv
end

function TrainingIsClickTrainingValid()
  return 0 >= click_training.cd
end

function TrainingIsStickTrainingMaxLv()
  return stick_training.max_lv <= stick_training.lv
end

function TrainingIsStickTrainingValid()
  return 0 >= stick_training.cd
end

function TrainingStickOnStepEnd(param)
  if (not WaitTimer(param, 40)) then
    return
  end
  AdvanceTrainingLevel(stick_training)
  SetNextTrainingLevel(TRAINING_MAP_LVL_ID)
end

function TrainingStickOnStepPlay(param)
  if (not Input.IsKeyPushed(Input.LBUTTON)) then
    return
  end
  local x, y = Input.GetMousePos()
  for i = 1, MAX_STICK do
    if (nil ~= param.stick[i] and PtInObj(x, y, param.stick[i])) then
      GenFlyUpObj(param.stick[i], stick_tex_id)
      param.hit = param.hit + 1
      Good.KillObj(param.stick[i])
      param.stick[i] = nil
      if (MAX_STICK == param.hit) then
        param.step = TrainingStickOnStepEnd
        return
      end
      break
    end
  end
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
