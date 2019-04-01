local CX_BLOCK = 30
local CX_MARGIN = 10
local CX_BLOCK_MARGIN = (CX_BLOCK + CX_MARGIN)
local OFFSET_Y = 300
local COLOR_GRAY = 0xff808080
local COLOR_INPUT_RIGHT = COLOR_GREEN
local COLOR_INPUT_WRONG = COLOR_RED
local WAIT_TIME = 30

local input_code_right_talk_id = 2103
local add_mallet_talk_id = 2104
local has_mallet_talk_id = 2105

CaveDoor = {}

CaveDoor.OnCreate = function(param)
  EnterPlace(param._id)
  InitCaveDoor(param)
  param.step = CaveDoorOnStepInput
end

CaveDoor.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, GetHeroVillageBackLvlId())
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
  StartTalk(GetBingoTalkId())
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

function GetBingoTalkId()
  if (HasMallet()) then
    return has_mallet_talk_id
  elseif (HasGetMalletCode()) then
    return add_mallet_talk_id
  else
    return input_code_right_talk_id
  end
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
