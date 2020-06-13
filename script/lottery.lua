local LOTTERY_W = 256
local LOTTERY_H = 256
local LOTTERY_X = (SCR_W - LOTTERY_W) / 2
local LOTTERY_Y = (SCR_H - LOTTERY_H) / 2
local DRAW_SIZE = 32

local lottery_tex_id = nil
local lottery_canvas = nil

local function GenLotteryTex()
  if (nil == lottery_canvas) then
    lottery_canvas = Graphics.GenCanvas(LOTTERY_W, LOTTERY_H)
  end
  Graphics.FillRect(lottery_canvas, 0, 0, LOTTERY_W, LOTTERY_H, 0xff880000)
  local idTex = Resource.GenTex(lottery_canvas)
  return idTex
end

local function ResetLotteryTex()
  if (nil == lottery_canvas) then
    lottery_canvas = Graphics.GenCanvas(LOTTERY_W, LOTTERY_H)
  end
  Graphics.FillRect(lottery_canvas, 0, 0, LOTTERY_W, LOTTERY_H, 0xff008800)
  Resource.UpdateTex(lottery_tex_id, 0, 0, lottery_canvas, 0, 0, LOTTERY_W, LOTTERY_H)
end

local function GenLottery()
  if (nil == lottery_tex_id) then
    lottery_tex_id = GenLotteryTex()
  else
    ResetLotteryTex()
  end
  local s = string.format('%d', math.random(1,10))
  local so = Good.GenTextObj(-1, s, DRAW_SIZE)
  local sx = LOTTERY_X + math.random(DRAW_SIZE, LOTTERY_W - 2 * DRAW_SIZE)
  local sy = LOTTERY_Y + math.random(DRAW_SIZE, LOTTERY_H - 2 * DRAW_SIZE)
  Good.SetPos(so, sx, sy)
  local o = Good.GenObj(-1, lottery_tex_id)
  Good.SetPos(o, LOTTERY_X, LOTTERY_Y)
end

Lottery = {}

Lottery.OnCreate = function(param)
  UpdateCoinInfo(param)
  GenLottery()
end

Lottery.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, TRASH_FIELD_LVL_ID)
    return
  end
  if (Input.IsKeyDown(Input.LBUTTON)) then
    local x, y = Input.GetMousePos()
    if ((param.lastsx ~= x or param.lasty ~= y) and PtInRect(x, y, LOTTERY_X, LOTTERY_Y, LOTTERY_X + LOTTERY_W, LOTTERY_Y + LOTTERY_H)) then
      Graphics.FillRect(lottery_canvas, x - LOTTERY_X, y - LOTTERY_Y, DRAW_SIZE, DRAW_SIZE, 0)
      Resource.UpdateTex(lottery_tex_id, 0, 0, lottery_canvas, 0, 0, LOTTERY_W, LOTTERY_H)
      param.lastx = x
      param.lasty = y
    end
  else
    param.lastx = 0
    param.lasty = 0
  end
end
