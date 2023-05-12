local WAIT_TIME = 60

local beautiful_rainbow_talk_id = 3202

local rainbow_objs = {241,235,239,240,242,243,244}
local pal_objs = {247,248,249,250,251,252,253}

local rainbow_objs_org_clr = nil
local sel_pal_obj_idx = nil

local function SelPalette(idx)
  if (nil ~= sel_pal_obj_idx) then
    local id = pal_objs[sel_pal_obj_idx]
    Good.SetScript(id, '')
    local param = Good.GetParam(id)
    Good.SetPos(id, param.org_x, param.org_y)
    param.k = nil
  end
  sel_pal_obj_idx = idx
  Good.SetScript(pal_objs[idx], 'AnimTalkArrow')
end

local function HittestPalette(x, y)
  for i = 1, #pal_objs do
    if (PtInObj(x, y, pal_objs[i])) then
      if (sel_pal_obj_idx ~= i) then
        SelPalette(i)
      end
      return true
    end
  end
  return false
end

local function HittestRainbow(x, y)
  for i = 1, #rainbow_objs do
    if (PtInObj(x, y, rainbow_objs[i])) then
      local clr = Good.GetBgColor(pal_objs[sel_pal_obj_idx])
      Good.SetBgColor(rainbow_objs[i], clr)
      return true
    end
  end
  return false
end

local function InitPalette()
  for i = 1, 20 do
    local i2 = math.random(2, #pal_objs)
    local tmp = pal_objs[1]
    pal_objs[1] = pal_objs[i2]
    pal_objs[i2] = tmp
  end
  for i = 1, #pal_objs do
    Good.SetBgColor(pal_objs[i], Good.GetBgColor(rainbow_objs[i]))
  end
  for i = 1, #pal_objs do
    local param = Good.GetParam(pal_objs[i])
    param.org_x, param.org_y = Good.GetPos(pal_objs[i])
  end
end

local function InitRainbow()
  for i = 1, #rainbow_objs do
    local id = rainbow_objs[i]
    local l,t,w,h = Good.GetDim(id)
    Good.SetDim(id, l, t, w, SCR_H)
    local x,y = Good.GetPos(id)
    Good.SetPos(id, x, 0)
  end
  rainbow_objs_org_clr = {}
  for i = 1, #rainbow_objs do
    local id = rainbow_objs[i]
    local clr = Good.GetBgColor(id)
    rainbow_objs_org_clr[i] = clr
    Good.SetBgColor(id, COLOR_BLACK + (#rainbow_objs - i + 1) * 0x222222)
  end
end

local function IsBeautifulRainbow()
  for i = 1, #rainbow_objs do
    local clr = Good.GetBgColor(rainbow_objs[i])
    if (rainbow_objs_org_clr[i] ~= clr) then
      return false
    end
  end
  return true
end

RainbowGame = {}

RainbowGame.OnCreate = function(param)
  InitPalette()
  InitRainbow()
  SelPalette(1)
  param.step = RainbowGamePlay
end

RainbowGame.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, JANKEN_PLANET_LVL_ID)
    return
  end
  param.step(param)
end

RainbowGameDone = function(param)
  if (WaitTimer(param, WAIT_TIME)) then
    StartTalk(beautiful_rainbow_talk_id)
  end
end

RainbowGamePlay = function(param)
  if (Input.IsKeyPushed(Input.LBUTTON)) then
    local x, y = Input.GetMousePos()
    if (HittestPalette(x, y)) then
      return
    end
    if (HittestRainbow(x, y)) then
      if (IsBeautifulRainbow()) then
        param.step = RainbowGameDone
      end
      return
    end
  end
end
