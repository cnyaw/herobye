local CX_BLOCK = 30
local CX_MARGIN = 10
local CX_BLOCK_MARGIN = (CX_BLOCK + CX_MARGIN)

local input_code_right_talk_id = 2103
local add_mallet_talk_id = 2104
local has_mallet_talk_id = 2105

CaveDoor = {}

CaveDoor.OnCreate = function(param)
  EnterPlace(param._id)
  InitCaveDoor(param)
end

CaveDoor.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, GetHeroVillageBackLvlId())
    return
  end
  if (Input.IsKeyPushed(Input.LBUTTON)) then
    CaveDoorHittest(param)
  end
end

function AddInputCode(param, code)
  param.input_code = param.input_code .. code
  local idx = string.len(param.input_code)
  Good.SetBgColor(param.block_obj[idx], 0xff808080)
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

function ClearInputCode(param)
  for i = 1, #param.block_obj do
    Good.SetBgColor(param.block_obj[i], 0xff000000)
  end
  param.input_code = ''
end

function CorrectInputCode(s)
  return GetOpenCaveDoorCode() == s
end

function GenInputCodeBlock(param, x, y)
  local o = GenColorObj(-1, CX_BLOCK, CX_BLOCK, 0xff000000)
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
  local OFFSET_Y = 300
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

function ValidateInputCode(param)
  if (not CorrectInputCode(param.input_code)) then
    if (InputCodeFull(param.input_code)) then
      ClearInputCode(param)
    end
    return
  end
  StartTalk(GetBingoTalkId())
end
