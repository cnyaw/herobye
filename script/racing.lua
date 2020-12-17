
local PREPARE_TIME = 3
local MAX_SAI_HOON = 5
local SAI_HOON_SCALE = 1.75
local COLOR = {COLOR_PURPLE, COLOR_RED, COLOR_GREEN, COLOR_BLUE, COLOR_YELLOW}

local tex_plus_id = 344
local sai_hoon_obj_id = 335
local back_btn_obj_id = 415

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
  if (Input.IsKeyPressed(Input.ESCAPE) or HittestBackButton(back_btn_obj_id)) then
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

function GenPrepareSanGlass(param)
  local dummy = Good.GenDummy(-1)
  Good.SetPos(dummy, SCR_W/2, 0)
  local o = GenSandGlassObj(PREPARE_TIME)
  Good.AddChild(dummy, o)
  param.glassdummy = dummy
  param.count_down = nil
end

function GenSaiHoon(param)
  if (nil ~= param.h) then
    for i = 1, MAX_SAI_HOON do
      Good.KillObj(param.h[i])
    end
    param.h = nil
  end
  local w,h = Resource.GetTileSize(sai_hoon_obj_id)
  sai_hoon_sz = h * SAI_HOON_SCALE
  param.h = {}
  param.n = {}
  for i = 1, MAX_SAI_HOON do
    local h = Good.GenObj(-1, sai_hoon_obj_id)
    Good.SetBgColor(h, COLOR[i])
    Good.SetScale(h, SAI_HOON_SCALE, SAI_HOON_SCALE)
    Good.SetPos(h, 0, (sai_hoon_sz + 5) * i)
    param.h[i] = h
    param.n[i] = 1
  end
end

function GenBetingBtns(param)
  local offsety = (sai_hoon_sz - 32)/2
  param.b1 = {}
  param.b2 = {}
  param.b3 = {}
  local dummy = Good.GenDummy(-1)
  for i = 1, MAX_SAI_HOON do
    local o = Good.GenObj(dummy, tex_plus_id)
    Good.SetPos(o, 80, (sai_hoon_sz + 5) * i + offsety)
    param.b1[i] = o
    local o2 = Good.GenObj(dummy, tex_plus_id)
    Good.SetPos(o2, 140, (sai_hoon_sz + 5) * i + offsety)
    param.b2[i] = o2
    local o3 = Good.GenObj(dummy, tex_plus_id)
    Good.SetPos(o3, 200, (sai_hoon_sz + 5) * i + offsety)
    param.b3[i] = o3
  end
  param.plusdummy = dummy
  if (nil ~= bet_dummy) then
    Good.KillObj(bet_dummy)
  end
  bet_dummy = Good.GenDummy(-1)
  bet_coin = {}
  bet_coin_obj = {}
end

OnRacingGameInitStep = function(param)
  param.cd = PREPARE_TIME * ONE_SECOND_TICK
  GenPrepareSanGlass(param)
  GenSaiHoon(param)
  GenBetingBtns(param)
  param.stage = OnRacingGamePrepareStep
end

OnRacingGamePrepareStep = function(param)
  param.cd = param.cd - 1
  if (0 >= param.cd) then
    if (nil ~= param.glassdummy) then
      Good.KillObj(param.glassdummy)
      param.glassdummy = nil
    end
    if (nil ~= param.plusdummy) then
      Good.KillObj(param.plusdummy)
      param.plusdummy = nil
    end
    param.stage = OnRacingGameRunStep
    return
  end

  CountDownPrepareTime(param)
  HandleBetting(param)
end

OnRacingGameRunStep = function(param)
  local mx, my = Input.GetMousePos()
  local down = Input.IsKeyPushed(Input.LBUTTON)
  local touch_end = false
  for i = 1, MAX_SAI_HOON do
    local o = param.h[i]
    local x, y = Good.GetPos(o)
    if (1 == param.n[i] and SCR_W/4 <= x and x <= SCR_W/2) then
      if (1 == math.random(200)) then
        param.n[i] = math.random(1, 2)
      end
    end
    x = x + math.random() * param.n[i]
    if (down and PtInObj(mx, my, o)) then
      x = x + 5
    end
    Good.SetPos(o, x, y)
    touch_end = SCR_W - sai_hoon_sz <= x
    if (touch_end) then
      if (nil ~= bet_coin[i]) then
        AddCoin(2 * bet_coin[i])
        UpdateCoinInfo(param)
      end
      Good.SetScript(o, 'AnimTalkArrow')
      param.cd = 3 * ONE_SECOND_TICK
      param.stage = OnRacingGameEndStep
      return
    end
  end
end

function CountDownPrepareTime(param)
  -- Hour glass count down.
  local n = math.floor(param.cd / ONE_SECOND_TICK) + 1
  if (nil == param.count_down or param.count_down_n ~= n) then
    if (nil ~= param.count_down) then
      Good.KillObj(param.count_down)
      param.count_down = nil
    end
    local o = GenNumObj(n, 32)
    Good.SetPos(o, 36, 12)
    Good.AddChild(param.glassdummy, o)
    param.count_down = o
    param.count_down_n = n
  end
end

function BetCoin(param, i, coin)
  if (nil == bet_coin[i]) then
    bet_coin[i] = coin
  else
    bet_coin[i] = bet_coin[i] + coin
  end
  if (nil ~= bet_coin_obj[i]) then
    Good.KillObj(bet_coin_obj[i])
    bet_coin_obj[i] = nil
  end
  local o = GenNumObj(bet_coin[i], 32)
  Good.AddChild(bet_dummy, o)
  Good.SetPos(o, Good.GetPos(param.h[i]))
  bet_coin_obj[i] = o
  ConsumeCoin(coin)
  UpdateCoinInfo(param)
end

function HandleBetting(param)
  if (0 >= GetCoin()) then              -- No coin.
    return
  end

  if (not Input.IsKeyPushed(Input.LBUTTON)) then
    return
  end

  local curr_coin = GetCoin()
  local x, y = Input.GetMousePos()
  for i = 1, MAX_SAI_HOON do
    if (1 <= curr_coin and PtInObj(x, y, param.b1[i])) then
      BetCoin(param, i, 1)
      break
    end
    if (5 <= curr_coin and PtInObj(x, y, param.b2[i])) then
      BetCoin(param, i, 5)
      break
    end
    if (10 <= curr_coin and PtInObj(x, y, param.b3[i])) then
      BetCoin(param, i, 10)
      break
    end
  end
end
