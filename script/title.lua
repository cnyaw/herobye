local CURSOR_SZ = 32
local OFFSET = CURSOR_SZ * 1.5

local cursor_obj_id = 353

Title = {}

Title.OnCreate = function(param)
  local x, y = Good.GetPos(cursor_obj_id)
  local o = Good.GenTextObj(-1, 'Continue', 32)
  Good.SetPos(o, x + OFFSET, y)
  local o2 = Good.GenTextObj(-1, 'New Game', 32)
  Good.SetPos(o2, x + OFFSET, y + OFFSET)
  param.cx = x
  param.cy = y
  param.cw = GetTextObjWidth(o2)
  param.cursor = 0
end

Title.OnStep = function(param)
  if (not Input.IsKeyPushed(Input.LBUTTON)) then
    return
  end

  local cx, cy = param.cx, param.cy
  local x, y = Input.GetMousePos()
  if (PtInRect(x, y, cx + OFFSET, cy, cx + OFFSET + param.cw, cy + OFFSET)) then
    if (0 == param.cursor) then
      Good.GenObj(-1, TALK_LVL_ID)
    else
      param.cursor = 0
      Good.SetPos(cursor_obj_id, cx, cy)
    end
  elseif (PtInRect(x, y, cx + OFFSET, cy + OFFSET, cx + OFFSET + param.cw, cy + 2 * OFFSET)) then
    if (1 == param.cursor) then
      Good.GenObj(-1, TALK_LVL_ID)
    else
      param.cursor = 1
      Good.SetPos(cursor_obj_id, cx, cy + OFFSET)
    end
  end
end
