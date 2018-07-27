
local PREPARE_TIME = 3
local COLOR = {0xffff00ff, 0xffff0000, 0xff00ff00, 0xff0000ff, 0xffffff00}

local tex_sandglass_id = 273
local sai_hoon_obj_id = 335

RacingGame = {}

RacingGame.OnCreate = function(param)
  UpdateCoinInfo(param)
  param.stage = OnRacingGameInitStep
end

RacingGame.OnStep = function(param)
  if (Input.IsKeyPushed(Input.LBUTTON)) then
    Good.GenObj(-1, MAIN_MAP_LVL_ID)
    return
  end
  param.stage(param)
end

OnRacingGameEndStep = function(param)
  param.cd = param.cd - 1
  if (0 >= param.cd) then
    param.stage = OnRacingGameInitStep
    return
  end
end

OnRacingGameInitStep = function(param)
  param.cd = PREPARE_TIME * 60
  local dummy = Good.GenDummy(-1)
  Good.SetPos(dummy, SCR_W/2, 0)
  local o = GenSandGlassObj(PREPARE_TIME)
  Good.AddChild(dummy, o)
  param.dummy = dummy
  param.count_down = nil
  if (nil ~= param.h) then
    for i = 1, #param.h do
      Good.KillObj(param.h[i])
    end
    param.h = nil
  end
  param.h = {}
  for i = 1,5 do
    local h = Good.GenObj(-1, sai_hoon_obj_id)
    Good.SetBgColor(h, COLOR[i])
    Good.SetPos(h, 0, 36 * i)
    param.h[i] = h
  end
  param.stage = OnRacingGamePrepareStep
end

OnRacingGamePrepareStep = function(param)
  param.cd = param.cd - 1
  if (0 >= param.cd) then
    if (nil ~= param.dummy) then
      Good.KillObj(param.dummy)
      param.dummy = nil
    end
    param.stage = OnRacingGameRunStep
    return
  end

  local n = math.floor(param.cd / 60) + 1
  if (nil == param.count_down or param.count_down_n ~= n) then
    if (nil ~= param.count_down) then
      Good.KillObj(param.count_down)
      param.count_down = nil
    end
    local o = GenNumObj(n, 32)
    Good.SetPos(o, 36, 12)
    Good.AddChild(param.dummy, o)
    param.count_down = o
    param.count_down_n = n
  end
end

OnRacingGameRunStep = function(param)
  local touch_end = false
  for i = 1, #param.h do
    local o = param.h[i]
    local x, y = Good.GetPos(o)
    x = x + math.random() * math.random(1,2)
    Good.SetPos(o, x, y)
    touch_end = SCR_W - 32 <= x
    if (touch_end) then
      Good.SetScript(o, 'AnimTalkArrow')
      param.cd = 3 * 60
      param.stage = OnRacingGameEndStep
      return
    end
  end
end
