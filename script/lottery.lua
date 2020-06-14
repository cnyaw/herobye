local LOTTERY_W = 256
local LOTTERY_H = 256
local LOTTERY_X = (SCR_W - LOTTERY_W) / 2
local LOTTERY_Y = (SCR_H - LOTTERY_H) / 2
local DRAW_SIZE = 32
local TEXT_SIZE = 46
local WAIT_TIME = 30

local end_lottery_talk_id = 2802

local lottery_tex_id = nil
local lottery_canvas = nil
local lottery_str = nil
local lottery_price = nil

local function GenLotteryTex()
  if (nil == lottery_canvas) then
    lottery_canvas = Graphics.GenCanvas(LOTTERY_W, LOTTERY_H)
  end
  Graphics.FillRect(lottery_canvas, 0, 0, LOTTERY_W, LOTTERY_H, COLOR_RED)
  local idTex = Resource.GenTex(lottery_canvas)
  return idTex
end

local function ResetLotteryTex()
  if (nil == lottery_canvas) then
    lottery_canvas = Graphics.GenCanvas(LOTTERY_W, LOTTERY_H)
  end
  Graphics.FillRect(lottery_canvas, 0, 0, LOTTERY_W, LOTTERY_H, COLOR_RED)
  Resource.UpdateTex(lottery_tex_id, 0, 0, lottery_canvas, 0, 0, LOTTERY_W, LOTTERY_H)
end

local function GenLottery()
  if (nil == lottery_tex_id) then
    lottery_tex_id = GenLotteryTex()
  else
    ResetLotteryTex()
  end
  lottery_price = math.random(1, 10)
  local s = string.format('%d', lottery_price)
  lottery_str = Good.GenTextObj(-1, s, TEXT_SIZE)
  local sx = LOTTERY_X + math.random(TEXT_SIZE, LOTTERY_W - 2 * TEXT_SIZE)
  local sy = LOTTERY_Y + math.random(TEXT_SIZE, LOTTERY_H - 2 * TEXT_SIZE)
  Good.SetPos(lottery_str, sx, sy)
  local o = Good.GenObj(-1, lottery_tex_id)
  Good.SetPos(o, LOTTERY_X, LOTTERY_Y)
end

local function IsLotteryEnd()
  local sx, sy = Good.GetPos(lottery_str)
  local w = GetTextObjWidth(lottery_str)
  local c = 0
  for x = sx, sx + w do
    for y = sy, sy + TEXT_SIZE do
      if (0 == Graphics.GetPixel(lottery_canvas, x - LOTTERY_X, y - LOTTERY_Y)) then
        c = c + 1
      end
    end
  end
  return 0.85 * w * TEXT_SIZE <= c
end

local function LotteryDraw(param)
  local x, y = Input.GetMousePos()
  if ((param.lastsx ~= x or param.lasty ~= y) and PtInRect(x, y, LOTTERY_X, LOTTERY_Y, LOTTERY_X + LOTTERY_W, LOTTERY_Y + LOTTERY_H)) then
    Graphics.FillRect(lottery_canvas, x - LOTTERY_X, y - LOTTERY_Y, DRAW_SIZE, DRAW_SIZE, 0)
    Resource.UpdateTex(lottery_tex_id, 0, 0, lottery_canvas, 0, 0, LOTTERY_W, LOTTERY_H)
    param.lastx = x
    param.lasty = y
  end
  param.mousedown = true
end

local function LobberyNoDraw(param)
  param.lastx = 0
  param.lasty = 0
  if (param.mousedown) then
    param.mousedown = false
    if (IsLotteryEnd()) then
      param.step = LotteryOnStepEnd
    end
  end
end

Lottery = {}

Lottery.OnCreate = function(param)
  UpdateCoinInfo(param)
  GenLottery()
  param.step = LotterOnStepDraw
end

Lottery.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, TRASH_FIELD_LVL_ID)
    return
  end
  param.step(param)
end

LotterOnStepDraw = function(param)
  if (Input.IsKeyDown(Input.LBUTTON)) then
    LotteryDraw(param)
  else
    LobberyNoDraw(param)
  end
end

LotteryOnStepEnd = function(param)
  if (not WaitTimer(param, WAIT_TIME)) then
    return
  end
  AddCoin(lottery_price)
  StartTalk(end_lottery_talk_id)
end
