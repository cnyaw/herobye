local analog_clock_obj_id = 480
local dec_ana_obj_id = 497
local dec_ana2_obj_id = 512
local dec_dig_obj_id = 498
local dec_dig2_obj_id = 514
local inc_ana_obj_id = 483
local inc_ana2_obj_id = 503
local inc_dig_obj_id = 502
local inc_dig2_obj_id = 513
local led_hr1_obj_id = 500
local led_hr2_obj_id = 510
local led_mn1_obj_id = 511
local led_mn2_obj_id = 481
local led_obj_id = {led_hr1_obj_id, led_hr2_obj_id, led_mn1_obj_id, led_mn2_obj_id}

local anaClock, digClock
local anaHrDummy, anaMnDummy

local function DecClockMin(clk)
  clk[2] = clk[2] - 1
  if (0 > clk[2]) then
    clk[2] = 59
    clk[1] = clk[1] - 1
    if (0 >= clk[1]) then
      clk[1] = 12
    end
  end
end

local function GenDotLineObj(parent, x1, y1, x2, y2, sz, gap, color)
  local len = math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2))
  local delta = 1 / (len / gap)
  local t = 0
  while (true) do
    local o = GenColorObj(parent, sz, sz, color)
    Good.SetPos(o, Lerp(x1, x2, t), Lerp(y1, y2, t))
    t = t + delta
    if (1 <= t) then
      break
    end
  end
end

local function IncClockMin(clk)
  clk[2] = clk[2] + 1
  if (60 <= clk[2]) then
    clk[2] = 0
    clk[1] = clk[1] + 1
    if (12 < clk[1]) then
      clk[1] = 1
    end
  end
end

local function Set7SegLen(id, n)
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
  local colors = {[1]=COLOR_RED, [0]=0xfffff0f0}
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

local function SetDigitClock()
  local hour, minute = digClock[1], digClock[2]
  local s = string.format('%02d%02d', hour, minute)
  local digits = '0123456789'
  for i = 1, #s do
    local c = string.sub(s, i, i)
    local n = string.find(digits, c)
    Set7SegLen(led_obj_id[i], n)
  end
end

local function SetRandTime()
  anaClock = {math.random(1,12), math.random(0, 59)}
  SetAnalogClock()
  digClock = {math.random(1,12), math.random(0, 59)}
  SetDigitClock()
end

local function UpdateClockTime(inc_ana, dec_ana, inc_dig, dec_dig)
  local x, y = Input.GetMousePos()
  if (PtInObj(x, y, inc_ana)) then
    IncClockMin(anaClock)
    SetAnalogClock()
    return true
  elseif (PtInObj(x, y, dec_ana)) then
    DecClockMin(anaClock)
    SetAnalogClock()
    return true
  elseif (PtInObj(x, y, inc_dig)) then
    IncClockMin(digClock)
    SetDigitClock()
    return true
  elseif (PtInObj(x, y, dec_dig)) then
    DecClockMin(digClock)
    SetDigitClock()
    return true
  end
  return false
end

SetClock = {}

SetClock.OnCreate = function(param)
  anaHrDummy = nil
  anaMnDummy = nil
  SetRandTime()
end

SetClock.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, ISLAND_LVL_ID)
    return
  end
  if (Input.IsKeyPushed(Input.LBUTTON)) then
    if (UpdateClockTime(inc_ana_obj_id, dec_ana_obj_id, inc_dig_obj_id, dec_dig_obj_id)) then
      return
    end
  end
  if (Input.IsKeyDown(Input.LBUTTON)) then
    UpdateClockTime(inc_ana2_obj_id, dec_ana2_obj_id, inc_dig2_obj_id, dec_dig2_obj_id)
  end
end
