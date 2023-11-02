local CHECK_COUNT = 10
local FLY_SPEED = 2.4
local HIT_OFFSET = 15
local WAIT_TIME = 180

local arrow_obj_id = 559
local arrow_tex_id = 555
local bow_obj_id = 558
local talk_id = 3791
local target_obj_id = 560

local arrow_w, arrow_h
local target_w, target_h

local function ArrowHitTarget()
  local ax, ay = Good.GetPos(arrow_obj_id)
  local tx, ty = Good.GetPos(target_obj_id)
  return PtInRect(ax, ay + math.random(30, 60), tx + HIT_OFFSET, ty + HIT_OFFSET, tx + target_w - HIT_OFFSET, ty + target_h - HIT_OFFSET)
end

local function ArrowOut()
  local x, y = Good.GetPos(arrow_obj_id)
  return 0 >= y + arrow_h
end

local function DupArrowOnTarget()
  local o = Good.GenObj(target_obj_id, arrow_tex_id)
  local ax, ay = Good.GetPos(arrow_obj_id)
  local tx, ty = Good.GetPos(target_obj_id)
  Good.SetPos(o, ax - tx, ay - ty)
end

local function FlyArrow()
  local x, y = Good.GetPos(arrow_obj_id)
  y = y - FLY_SPEED
  Good.SetPos(arrow_obj_id, x, y)
end

local function Reset(param)
  Good.SetPos(arrow_obj_id, param.arrow_orgx, param.arrow_orgy)
  param.arrow_fly = false
end

local function SetCheckCount(param, c)
  SetCounterUiCount(param, c)
  UpdateCounterUi(param, arrow_tex_id, CHECK_COUNT)
end

local function RedCastleTrainingDone(param)
  if (WaitTimer(param, WAIT_TIME)) then
    StartTalk(talk_id)
  end
end

local function RedCastleTrainingStep(param)
  if (param.arrow_fly) then
    FlyArrow()
    if (ArrowOut()) then
      SetCheckCount(param, 0)
      Good.KillAllChild(target_obj_id)
      Reset(param)
    elseif (ArrowHitTarget()) then
      DupArrowOnTarget()
      SetCheckCount(param, GetCounterUiCount(param) + 1)
      Reset(param)
      if (CHECK_COUNT <= GetCounterUiCount(param)) then
        param.step = RedCastleTrainingDone
        Good.KillObj(arrow_obj_id)
      end
    end
  elseif (Input.IsKeyPushed(Input.LBUTTON)) then
    local x, y = Input.GetMousePos()
    if (PtInObj(x, y, bow_obj_id)) then
      param.arrow_fly = true
    end
  end
end

RedCastleTraining = {}

RedCastleTraining.OnCreate = function(param)
  param.arrow_fly = false
  param.arrow_orgx, param.arrow_orgy = Good.GetPos(arrow_obj_id)
  arrow_w, arrow_h = Resource.GetTexSize(Good.GetTexId(arrow_obj_id))
  target_w, target_h = Resource.GetTexSize(Good.GetTexId(target_obj_id))
  SetCheckCount(param, 0)
  param.step = RedCastleTrainingStep
end

RedCastleTraining.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, NORTH_NATION_LVL_ID)
    return
  end
  param.step(param)
end
