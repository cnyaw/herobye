
local PREPARE_TIME = 3
local MAX_SAI_HOON = 5
local SAI_HOON_SCALE = 1.75
local COLOR = {0xffff00ff, 0xffff0000, 0xff00ff00, 0xff0000ff, 0xffffff00}

local tex_sandglass_id = 273
local sai_hoon_obj_id = 335

local sai_hoon_sz = 0

local bet_coin = {}
local bet_dummy = nil
local bet_coin_obj = {}

RacingGame = {}

RacingGame.OnCreate = function(param)
  bet_dummy = nil
  UpdateCoinInfo(param)
  param.stage = OnRacingGameInitStep
end

RacingGame.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
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
    for i = 1, MAX_SAI_HOON do
      Good.KillObj(param.h[i])
    end
    param.h = nil
  end
  local w,h = Resource.GetSpriteSize(sai_hoon_obj_id)
  sai_hoon_sz = h * SAI_HOON_SCALE
  param.h = {}
  for i = 1, MAX_SAI_HOON do
    local h = Good.GenObj(-1, sai_hoon_obj_id)
    Good.SetBgColor(h, COLOR[i])
    Good.SetScale(h, SAI_HOON_SCALE, SAI_HOON_SCALE)
    Good.SetPos(h, 0, (sai_hoon_sz + 5) * i)
    param.h[i] = h
  end
  if (nil ~= bet_dummy) then
    Good.KillObj(bet_dummy)
  end
  bet_dummy = Good.GenDummy(-1)
  bet_coin = {}
  bet_coin_obj = {}
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

  -- Hour glass count down.
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

  -- Handle bet.
  if (0 >= curr_coin) then              -- No coin.
    return
  end

  if (not Input.IsKeyPushed(Input.LBUTTON)) then
    return
  end

  local x, y = Input.GetMousePos()
  for i = 1, MAX_SAI_HOON do
    if (PtInObj(x, y, param.h[i])) then
      if (nil == bet_coin[i]) then
        bet_coin[i] = 1
      else
        bet_coin[i] = bet_coin[i] + 1
      end
      if (nil ~= bet_coin_obj[i]) then
        Good.KillObj(bet_coin_obj[i])
        bet_coin_obj[i] = nil
      end
      local o = GenNumObj(bet_coin[i], 32)
      Good.AddChild(bet_dummy, o)
      Good.SetPos(o, Good.GetPos(param.h[i]))
      bet_coin_obj[i] = o
      curr_coin = curr_coin - 1
      UpdateCoinInfo(param)
      break
    end
  end
end

OnRacingGameRunStep = function(param)
  local touch_end = false
  for i = 1, MAX_SAI_HOON do
    local o = param.h[i]
    local x, y = Good.GetPos(o)
    x = x + math.random() * math.random(1,2)
    Good.SetPos(o, x, y)
    touch_end = SCR_W - sai_hoon_sz <= x
    if (touch_end) then
      if (nil ~= bet_coin[i]) then
        curr_coin = curr_coin + 2 * bet_coin[i]
        UpdateCoinInfo(param)
      end
      Good.SetScript(o, 'AnimTalkArrow')
      param.cd = 3 * 60
      param.stage = OnRacingGameEndStep
      return
    end
  end
end
