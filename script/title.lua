local CURSOR_SZ = 32
local OFFSET = CURSOR_SZ * 1.5
local TEXT_SZ = 32

local cursor_obj_id = 353

local function SelContinue(param)
  if (0 == param.cursor) then
    LoadGame()
    if (IsFinishTraining()) then
      Good.GenObj(-1, GetLastLvlId())
    else
      StartTalk()
    end
  else
    param.cursor = 0
    Good.SetPos(cursor_obj_id, param.cx, param.cy)
  end
end

local function SelNewGame(param)
  if (1 == param.cursor) then
    StartTalk()
  else
    param.cursor = 1
    Good.SetPos(cursor_obj_id, param.cx, param.cy + OFFSET)
  end
end

Title = {}

Title.OnCreate = function(param)
  local x, y = Good.GetPos(cursor_obj_id)
  local o = Good.GenTextObj(-1, 'Continue', TEXT_SZ)
  Good.SetPos(o, x + OFFSET, y)
  local o2 = Good.GenTextObj(-1, 'New Game', TEXT_SZ)
  Good.SetPos(o2, x + OFFSET, y + OFFSET)
  param.cx = x
  param.cy = y
  param.cw = GetTextObjWidth(o2)
  param.cursor = 0
  ResetGame()
end

Title.OnStep = function(param)
  if (not Input.IsKeyPushed(Input.LBUTTON)) then
    return
  end
  local cx, cy = param.cx, param.cy
  local x, y = Input.GetMousePos()
  if (PtInRect(x, y, cx + OFFSET, cy, cx + OFFSET + param.cw, cy + OFFSET)) then
    SelContinue(param)
  elseif (PtInRect(x, y, cx + OFFSET, cy + OFFSET, cx + OFFSET + param.cw, cy + 2 * OFFSET)) then
    SelNewGame(param)
  end
end
