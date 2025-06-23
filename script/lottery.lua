local LOTTERY_W, LOTTERY_H = 256, 256
local LOTTERY_X = (SCR_W - LOTTERY_W) / 2
local LOTTERY_Y = (SCR_H - LOTTERY_H) / 2
local DRAW_SIZE = 32
local TEXT_SIZE = 46
local WAIT_TIME = 30
local LOTTERY_TEX_NAME = 'lottery_tex'

local end_lottery_talk_id = 2802
local cash_tex_id = 170

local lottery_tex_id = nil
local lottery_canvas = nil
local lottery_str = nil
local lottery_price = nil

local function FillImageTex(lottery_canvas)
  Graphics.FillRect(lottery_canvas, 0, 0, LOTTERY_W, LOTTERY_H, COLOR_YELLOW)
  FillImage(lottery_canvas, 0, 0, cash_tex_id, LOTTERY_W, LOTTERY_H)
end

local function GenLotteryTex()
  if (nil == lottery_canvas) then
    lottery_canvas = Graphics.GenCanvas(LOTTERY_W, LOTTERY_H)
  end
  FillImageTex(lottery_canvas)
  lottery_tex_id = Resource.GenTex(lottery_canvas, LOTTERY_TEX_NAME)
end

local function ResetLotteryTex()
  if (nil == lottery_canvas) then
    lottery_canvas = Graphics.GenCanvas(LOTTERY_W, LOTTERY_H)
  end
  FillImageTex(lottery_canvas)
  Resource.UpdateTex(lottery_tex_id, 0, 0, lottery_canvas, 0, 0, LOTTERY_W, LOTTERY_H)
end

local function GenLottery()
  lottery_tex_id = Resource.GetTexId(LOTTERY_TEX_NAME)
  if (-1 == lottery_tex_id) then
    GenLotteryTex()
  else
    ResetLotteryTex()
  end
  if (1 == math.random(1, 100)) then
    lottery_price = 100                 -- 1% to win 100.
  else
    lottery_price = math.random(1, 10)
  end
  local s = string.format('%d', lottery_price)
  lottery_str = Good.GenTextObj(-1, s, TEXT_SIZE)
  SetTextObjColor(lottery_str, COLOR_RED)
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

local function OnLotteryEnd(param)
  if (WaitTime(param, WAIT_TIME)) then
    AddCoin(lottery_price)
    StartTalk(end_lottery_talk_id)
  end
end

local function LotteryNoDraw(param)
  param.lastx = 0
  param.lasty = 0
  if (param.mousedown) then
    param.mousedown = false
    if (IsLotteryEnd()) then
      param.step = OnLotteryEnd
    end
  end
end

local function OnLotteryDraw(param)
  if (Input.IsKeyDown(Input.LBUTTON)) then
    if (param.start_draw) then
      LotteryDraw(param)
    end
  else
    if (not param.start_draw) then
      param.start_draw = true
    else
      LotteryNoDraw(param)
    end
  end
end

Lottery = {}

Lottery.OnCreate = function(param)
  UpdateCoinInfo(param)
  GenLottery()
  param.step = OnLotteryDraw
  param.start_draw = false
end

Lottery.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, TRASH_FIELD_LVL_ID)
    return
  end
  param.step(param)
end
