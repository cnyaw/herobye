local CX_BLOCK = 30
local CX_MARGIN = 10
local CX_BLOCK_MARGIN = (CX_BLOCK + CX_MARGIN)
local OFFSET_Y = 275
local COLOR_INPUT_RIGHT = COLOR_GREEN
local COLOR_INPUT_WRONG = COLOR_RED
local WAIT_TIME = 30

local btn_back_obj_id = 411
local btn_scissor_obj_id = 6
local btn_stone_obj_id = 9
local btn_paper_obj_id = 10

local input_code_right_talk_id = 2104
local input_code_right_small_chest_talk_id = 2108

local rps_code = {'1', '2', '3'}
local rps_obj = {btn_scissor_obj_id, btn_stone_obj_id, btn_paper_obj_id}

local function AddInputCode(param, code)
  param.input_code = param.input_code .. code
  local idx = string.len(param.input_code)
  Good.SetBgColor(param.block_obj[idx], COLOR_GRAY)
end

local ValidateInputCode                 -- Forward decl.

local function CaveDoorInput(param)
  if (not Input.IsKeyPushed(Input.LBUTTON)) then
    return
  end
  local x, y = Input.GetMousePos()
  if (PtInObj(x, y, btn_back_obj_id)) then
    Good.GenObj(-1, CAVE_FIELD_LVL_ID)
    return
  end
  for i = 1, #rps_obj do
    if (PtInObj(x, y, rps_obj[i])) then
      AddInputCode(param, rps_code[i])
      ValidateInputCode(param)
      return
    end
  end
end

local function CaveDoorInputRight(param)
  if (not WaitTime(param, WAIT_TIME)) then
    return
  end
  Script.OpenCaveDoor()
  if (HasPowerScissor() and HasMallet()) then
    StartTalk(input_code_right_small_chest_talk_id)
  else
    StartTalk(input_code_right_talk_id)
  end
end

local function ClearInputCode(param)
  for i = 1, #param.block_obj do
    Good.SetBgColor(param.block_obj[i], COLOR_BLACK)
  end
  param.input_code = ''
end

local function CaveDoorInputWrong(param)
  if (WaitTime(param, WAIT_TIME)) then
    ClearInputCode(param)
    param.step = CaveDoorInput
  end
end

local function CorrectInputCode(s)
  return GetOpenCaveDoorCode() == s
end

local function GenInputCodeBlock(param, x, y)
  local o = GenColorObj(-1, CX_BLOCK, CX_BLOCK, COLOR_BLACK)
  Good.SetPos(o, x, y)
  return o
end

local function InitCaveDoor(param)
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

local function InputCodeFull(code)
  return string.len(code) == string.len(GetOpenCaveDoorCode())
end

local function SetInputCodeBlockColor(param, color)
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
    param.step = CaveDoorInputWrong
  else
    SetInputCodeBlockColor(param, COLOR_INPUT_RIGHT)
    param.step = CaveDoorInputRight
  end
end

CaveDoor = {}

CaveDoor.OnCreate = function(param)
  InitCaveDoor(param)
  param.step = CaveDoorInput
end

CaveDoor.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, CAVE_FIELD_LVL_ID)
    return
  end
  param.step(param)
end
