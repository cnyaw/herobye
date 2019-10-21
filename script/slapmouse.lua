local WAIT_TIME = 60

local btn1_obj_id = 58
local btn2_obj_id = 59
local btn3_obj_id = 60
local racket_obj_id = 57
local ball_obj_id = 69
local cheese_obj_id = 67
local mouse_obj_id = 68

SlapMouse = {}

SlapMouse.OnCreate = function(param)
  param.orig_mouse_x, param.orig_mouse_y = Good.GetPos(mouse_obj_id)
  param.btn = {btn1_obj_id, btn2_obj_id, btn3_obj_id}
  param.obj = {racket_obj_id, ball_obj_id, cheese_obj_id}
  RandButtonColor(param)
  param.step = SlapMouseOnStepInput
end

SlapMouse.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, COUNTRY_LVL_ID)
    return
  end
  param.step(param)
end

function RandButtonColor(param)
  local color = {COLOR_RED, COLOR_GREEN, COLOR_YELLOW}
  local ri = math.random(3) % 3
  for i = 0, 2 do
    local index = 1 + (i + 3 - ri) % 3
    Good.SetBgColor(param.btn[i + 1], color[index])
    Good.SetBgColor(param.obj[i + 1], COLOR_BLACK)
  end
  param.btn_i = ri
  param.obj_i = 1
end

function SlapMouseHittest(param)
  if (4 == param.obj_i) then
    RandButtonColor(param)
    return
  end
  local x, y = Input.GetMousePos()
  for i = 1, #param.btn do
    if (PtInObj(x, y, param.btn[i])) then
      ValidateMachineButton(param, i)
      return
    end
  end
end

function SlapMouseOnStepInput(param)
  if (Input.IsKeyPushed(Input.LBUTTON)) then
    SlapMouseHittest(param)
  end
end

function SlapMouseOnStepMouse(param)
  if (not WaitTimer(param, WAIT_TIME)) then
    return
  end
  param.obj_i = param.obj_i - 1
  if (0 == param.obj_i) then
    RandButtonColor(param)
    Good.SetPos(mouse_obj_id, param.orig_mouse_x, param.orig_mouse_y)
    param.step = SlapMouseOnStepInput
    return
  end
  local x,y = Good.GetPos(param.obj[param.obj_i])
  Good.SetPos(mouse_obj_id, x, y)
end

function ValidateMachineButton(param, i)
  if (param.btn_i == i - 1) then
    -- Correct step.
    local clr = Good.GetBgColor(param.btn[i])
    Good.SetBgColor(param.obj[param.obj_i], clr)
    param.btn_i = (param.btn_i + 1) % 3
    param.obj_i = param.obj_i + 1
    if (4 == param.obj_i) then
      param.step = SlapMouseOnStepMouse
      return
    end
  else
    -- Wrong step.
    RandButtonColor(param)
  end
end
