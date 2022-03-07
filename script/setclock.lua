local CHECK_COUND = 10
local WAIT_TIME = 50

local ana_clock_btns = 515
local analog_clock_obj_id = 480
local clock_tex_id = 517
local dec_ana_obj_id = 497
local dec_ana2_obj_id = 512
local dec_dig_obj_id = 498
local dec_dig2_obj_id = 514
local dig_clock_btns = 516
local inc_ana_obj_id = 483
local inc_ana2_obj_id = 503
local inc_dig_obj_id = 502
local inc_dig2_obj_id = 513
local led_hr1_obj_id = 500
local led_hr2_obj_id = 510
local led_mn1_obj_id = 511
local led_mn2_obj_id = 481
local led_obj_id = {led_hr1_obj_id, led_hr2_obj_id, led_mn1_obj_id, led_mn2_obj_id}

local end_set_clock_talk_id = 4201

local anaClock, digClock
local anaHrDummy, anaMnDummy
local selAnaClock

local function CheckSetClockMatch()
  return anaClock[1] == digClock[1] and anaClock[2] == digClock[2]
end

local function DecClockHour(clk)
  clk[1] = clk[1] - 1
  if (0 >= clk[1]) then
    clk[1] = 12
  end
end

local function DecClockMin(clk)
  clk[2] = clk[2] - 1
  if (0 > clk[2]) then
    clk[2] = 59
    DecClockHour(clk)
  end
end

local function DecClock(clk, update_min)
  if (update_min) then
    DecClockMin(clk)
  else
    DecClockHour(clk)
  end
end

local function IncClockHour(clk)
  clk[1] = clk[1] + 1
  if (12 < clk[1]) then
    clk[1] = 1
  end
end

local function IncClockMin(clk)
  clk[2] = clk[2] + 1
  if (60 <= clk[2]) then
    clk[2] = 0
    IncClockHour(clk)
  end
end

local function IncClock(clk, update_min)
  if (update_min) then
    IncClockMin(clk)
  else
    IncClockHour(clk)
  end
end

local function Set7SegLed(id, n)
  local digit10 = {
    {1, 1, 1, 1, 1, 1, 0},              -- 0
    {0, 1, 1, 0, 0, 0, 0},              -- 1
    {1, 1, 0, 1, 1, 0, 1},              -- 2
    {1, 1, 1, 1, 0, 0, 1},              -- 3
    {0, 1, 1, 0, 0, 1, 1},              -- 4
    {1, 0, 1, 1, 0, 1, 1},              -- 5
    {1, 0, 1, 1, 1, 1, 1},              -- 6
    {1, 1, 1, 0, 0, 1, 0},              -- 7
    {1, 1, 1, 1, 1, 1, 1},              -- 8
    {1, 1, 1, 1, 0, 1, 1},              -- 9
  }
  local colors = {[1]=COLOR_RED, [0]=0xffffe0e0}
  local digit = digit10[n]
  for i = 1, #digit do
    local o = Good.GetChild(id, i - 1)
    Good.SetBgColor(o, colors[digit[i]])
  end
end

local function SetAnalogClockHand(ang, length, sz, gap)
  local l,t,w,h = Good.GetDim(analog_clock_obj_id)
  local ax = math.sin(ang * math.pi / 180)
  local ay = -math.cos(ang * math.pi / 180)
  local x = length * w/2 * ax + w/2
  local y = length * h/2 * ay + h/2
  local dummy = Good.GenDummy(analog_clock_obj_id)
  GenDotLineObj(dummy, w/2, h/2, x, y, sz, gap, COLOR_BLACK)
  return dummy
end

local function SetAnalogClock()
  local hour, minute = anaClock[1], anaClock[2]
  local angTick = 360 / 60
  local angHour = angTick * (5 * hour + minute / 12)
  local angMinute = angTick * minute
  if (nil ~= anaMnDummy) then
    Good.KillObj(anaMnDummy)
  end
  anaMnDummy = SetAnalogClockHand(angMinute, 0.8, 4, 6)
  if (nil ~= anaHrDummy) then
    Good.KillObj(anaHrDummy)
  end
  anaHrDummy = SetAnalogClockHand(angHour, 0.6, 6, 6)
end

local function SetCheckCount(param, c)
  SetCounterUiCount(param, c)
  UpdateCounterUi(param, clock_tex_id, CHECK_COUND)
end

local function SetDigitClock()
  local hour, minute = digClock[1], digClock[2]
  local s = string.format('%02d%02d', hour, minute)
  local digits = '0123456789'
  for i = 1, #s do
    local c = string.sub(s, i, i)
    local n = string.find(digits, c)
    Set7SegLed(led_obj_id[i], n)
  end
end

local function SetRandTime()
  anaClock = {math.random(1,12), math.random(0, 59)}
  SetAnalogClock()
  digClock = {math.random(1,12), math.random(0, 59)}
  SetDigitClock()
end

local function UpdateClock(inc_ana, dec_ana, inc_dig, dec_dig, update_min)
  local x, y = Input.GetMousePos()
  local curSelAnaClock = not selAnaClock
  if (curSelAnaClock) then
    if (PtInObj(x, y, inc_ana, 1)) then
      IncClock(anaClock, update_min)
      SetAnalogClock()
      return true
    elseif (PtInObj(x, y, dec_ana, 1)) then
      DecClock(anaClock, update_min)
      SetAnalogClock()
      return true
    end
  else
    if (PtInObj(x, y, inc_dig, 1)) then
      IncClock(digClock, update_min)
      SetDigitClock()
      return true
    elseif (PtInObj(x, y, dec_dig, 1)) then
      DecClock(digClock, update_min)
      SetDigitClock()
      return true
    end
  end
  return false
end

local function OnStepDone(param)
  if (not WaitTimer(param, WAIT_TIME)) then
    return
  end
  StartTalk(end_set_clock_talk_id)
end

local function NewTest(param)
  if (GetCounterUiCount(param) == CHECK_COUND) then
    param.step = OnStepDone
    return
  end
  SetRandTime()
  if (selAnaClock) then
    Good.SetVisible(ana_clock_btns, Good.VISIBLE)
    Good.SetVisible(dig_clock_btns, Good.INVISIBLE)
  else
    Good.SetVisible(ana_clock_btns, Good.INVISIBLE)
    Good.SetVisible(dig_clock_btns, Good.VISIBLE)
  end
  selAnaClock = not selAnaClock
end

local function OnStepSetClock(param)
  if (not Input.IsKeyPushed(Input.LBUTTON)) then
    return
  end
  if (UpdateClock(inc_ana_obj_id, dec_ana_obj_id, inc_dig_obj_id, dec_dig_obj_id, true)) then
    if (CheckSetClockMatch()) then
      SetCheckCount(param, GetCounterUiCount(param) + 1)
      NewTest(param)
    end
    return
  end
  if (UpdateClock(inc_ana2_obj_id, dec_ana2_obj_id, inc_dig2_obj_id, dec_dig2_obj_id, false)) then
    if (CheckSetClockMatch()) then
      SetCheckCount(param, GetCounterUiCount(param) + 1)
      NewTest(param)
    end
  end
end

SetClock = {}

SetClock.OnCreate = function(param)
  anaHrDummy = nil
  anaMnDummy = nil
  selAnaClock = true
  SetCheckCount(param, 0)
  NewTest(param)
  param.step = OnStepSetClock
end

SetClock.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, ISLAND_LVL_ID)
    return
  end
  param.step(param)
end
