
local MAX_CLICK = 5
local MAX_STICK = 5

local click_fish_obj_id = 269
local tex_stick_id = 292

local hit_obj = nil

TrainingMap = {}

TrainingMap.OnCreate = function(param)
  GenTrainingObj(click_training)
  GenTrainingObj(stick_training)
  QuestOnCreate(param._id)
end

TrainingMap.OnStep = function(param)
  UpdateTrainingCd()
  if (not Input.IsKeyPushed(Input.LBUTTON)) then
    return
  end

  local x, y = Input.GetMousePos()
  if (QuestOnStep(x, y, param._id)) then
    return
  end
end

TrainingClick = {}

TrainingClick.OnCreate = function(param)
  param.hit = 0
  hit_obj = GenTrainingNumInfoObj(MAX_CLICK - param.hit)
end

TrainingClick.OnStep = function(param)
  UpdateTrainingCd()
  if (not Input.IsKeyPushed(Input.LBUTTON)) then
    return
  end

  local x, y = Input.GetMousePos()
  if (PtInObj(x, y, click_fish_obj_id)) then
    param.hit = param.hit + 1
    if (nil ~= hit_obj) then
      Good.KillObj(hit_obj)
      hit_obj = nil
    end
    hit_obj = GenTrainingNumInfoObj(MAX_CLICK - param.hit)
    if (MAX_CLICK == param.hit) then
      AdvanceTrainingLevel(click_training)
      SetNextTrainingLevel(TRAINING_MAP_LVL_ID)
      return
    end
  end
end

TrainingStick = {}

TrainingStick.OnCreate = function(param)
  param.hit = 0
  param.stick = {}
  local w, h = Resource.GetTexSize(tex_stick_id)
  for i = 1, MAX_STICK do
    local o = Good.GenObj(-1, tex_stick_id)
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
      GenFlyUpObj(param.stick[i], tex_stick_id)
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
