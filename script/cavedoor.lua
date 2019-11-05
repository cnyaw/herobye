local CX_BLOCK = 30
local CX_MARGIN = 10
local CX_BLOCK_MARGIN = (CX_BLOCK + CX_MARGIN)
local OFFSET_Y = 275
local COLOR_GRAY = 0xff808080
local COLOR_INPUT_RIGHT = COLOR_GREEN
local COLOR_INPUT_WRONG = COLOR_RED
local WAIT_TIME = 30

local back_obj_id = 22

local input_code_right_talk_id = 2104
local input_code_right_small_chest_talk_id = 2108

CaveDoor = {}

CaveDoor.OnCreate = function(param)
  InitCaveDoor(param)
  param.step = CaveDoorOnStepInput
end

CaveDoor.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, CAVE_FIELD_LVL_ID)
    return
  end
  param.step(param)
end

function AddInputCode(param, code)
  param.input_code = param.input_code .. code
  local idx = string.len(param.input_code)
  Good.SetBgColor(param.block_obj[idx], COLOR_GRAY)
end

function CaveDoorHittest(param)
  local x, y = Input.GetMousePos()
  if (PtInObj(x, y, back_obj_id)) then
    Good.GenObj(-1, CAVE_FIELD_LVL_ID)
    return
  end
  for i = 1, #param.rps_obj do
    if (PtInObj(x, y, param.rps_obj[i])) then
      AddInputCode(param, param.rps_code[i])
      ValidateInputCode(param)
      return
    end
  end
end

function CaveDoorOnStepInput(param)
  if (Input.IsKeyPushed(Input.LBUTTON)) then
    CaveDoorHittest(param)
  end
end

function CaveDoorOnStepInputRight(param)
  if (not WaitTimer(param, WAIT_TIME)) then
    return
  end
  ScriptOpenCaveDoor()
  if (HasPowerScissor() and HasMallet()) then
    StartTalk(input_code_right_small_chest_talk_id)
  else
    StartTalk(input_code_right_talk_id)
  end
end

function CaveDoorOnStepInputWrong(param)
  if (not WaitTimer(param, WAIT_TIME)) then
    return
  end
  ClearInputCode(param)
  param.step = CaveDoorOnStepInput
end

function ClearInputCode(param)
  for i = 1, #param.block_obj do
    Good.SetBgColor(param.block_obj[i], COLOR_BLACK)
  end
  param.input_code = ''
end

function CorrectInputCode(s)
  return GetOpenCaveDoorCode() == s
end

function GenInputCodeBlock(param, x, y)
  local o = GenColorObj(-1, CX_BLOCK, CX_BLOCK, COLOR_BLACK)
  Good.SetPos(o, x, y)
  return o
end

function InitCaveDoor(param)
  InitRpsCode(param)
  InitRpsObj(param)
  InitInputCodeBlock(param)
end

function InitInputCodeBlock(param)
  local code = GetOpenCaveDoorCode()
  local OFFSET_X = (SCR_W - string.len(code) * CX_BLOCK_MARGIN) / 2
  param.block_obj = {}
  local x = OFFSET_X
  for i = 1, string.len(code) do
    param.block_obj[i] = GenInputCodeBlock(param, x, OFFSET_Y)
    x = x + CX_BLOCK_MARGIN
  end
  param.input_code = ''
end

function InitRpsCode(param)
  param.rps_code = {'1', '2', '3'}
end

function InitRpsObj(param)
  param.rps_obj = {6, 9, 10}
end

function InputCodeFull(code)
  return string.len(code) == string.len(GetOpenCaveDoorCode())
end

function SetInputCodeBlockColor(param, color)
  for i = 1, #param.block_obj do
    Good.SetBgColor(param.block_obj[i], color)
  end
end

function ValidateInputCode(param)
  if (not InputCodeFull(param.input_code)) then
    return
  end
  if (not CorrectInputCode(param.input_code)) then
    SetInputCodeBlockColor(param, COLOR_INPUT_WRONG)
    param.step = CaveDoorOnStepInputWrong
  else
    SetInputCodeBlockColor(param, COLOR_INPUT_RIGHT)
    param.step = CaveDoorOnStepInputRight
  end
end
