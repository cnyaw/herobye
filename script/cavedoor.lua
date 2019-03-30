local correct_input_code_talk_id = 2103

local CX_BLOCK = 30
local CX_MARGIN = 10
local OFFSET_X = (SCR_W - string.len(OPEN_CAVE_DOOR_CODE) * (CX_BLOCK + CX_MARGIN)) / 2
local OFFSET_Y = 300

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
  return s == OPEN_CAVE_DOOR_CODE
end

function GenInputCodeBlock(param, x, y)
  local o = GenColorObj(-1, CX_BLOCK, CX_BLOCK, 0xff000000)
  Good.SetPos(o, x, y)
  return o
end

function InitCaveDoor(param)
  InitRpsCode(param)
  InitRpsObj(param)
  InitInputCodeBlock(param)
end

function InitInputCodeBlock(param)
  param.block_obj = {}
  for i = 1, string.len(OPEN_CAVE_DOOR_CODE) do
    param.block_obj[i] = GenInputCodeBlock(param, OFFSET_X + (CX_BLOCK + CX_MARGIN) * (i - 1), OFFSET_Y)
  end
  param.input_code = ''
end

function InitRpsCode(param)
  local rps_code = {}
  rps_code[1] = '1'
  rps_code[2] = '2'
  rps_code[3] = '3'
  param.rps_code = rps_code
end

function InitRpsObj(param)
  local rps_obj = {}
  rps_obj[1] = 6
  rps_obj[2] = 9
  rps_obj[3] = 10
  param.rps_obj = rps_obj
end

function InputCodeFull(param)
  return string.len(param.input_code) == string.len(OPEN_CAVE_DOOR_CODE)
end

function ValidateInputCode(param)
  if (not CorrectInputCode(param.input_code)) then
    if (InputCodeFull(param)) then
      ClearInputCode(param)
    end
    return false
  end
  StartTalk(correct_input_code_talk_id) -- BINGO!!!
  return true
end
