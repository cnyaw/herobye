local MAX_USER = 5
local MAX_BOA_BEG_TIME = 30

local user_tex_id = 296

local function GetCurrBouTexId()
  if (IsTempleCrowdFunding() and HasGodzilla()) then
    return GODZILLA_TEX_ID
  elseif (HasBou3()) then
    return BOU3_TEX_ID
  elseif (HasBou2()) then
    return BOU2_TEX_ID
  else
    return BOU_TEX_ID
  end
end

local function GenBegMoneyBoa(x, y)
  local o = Good.GenObj(-1, GetCurrBouTexId(), 'BegMoneyBou')
  local l,t,w,h = Good.GetDim(o)
  Good.SetAnchor(o, 0.5, 0.5)
  ScaleToSize(o, 60, 60)
  Good.SetPos(o, x - w/2, y - h/2)
  return o
end

local function GetCurrBouGain()
  if (IsTempleCrowdFunding() and HasGodzilla()) then
    return 20
  elseif (HasBou3()) then
    return 5
  elseif (HasBou2()) then
    return 3
  else
    return 1
  end
end

local function BegMoneyDone(param)
  if (nil == param.boa) then
    Good.GenObj(-1, MAIN_MAP_LVL_ID)
    return
  end
end

local function OnBegMoney(param, o)
  GenFlyUpObj(o, COIN_TEX_ID)
  AddCoin(GetCurrBouGain())
  UpdateCoinInfo(param)
  if (MAX_USER == param.hit) then
    param.step = BegMoneyDone
  end
end

local function BegMoneyPlay(param)
  if (not Input.IsKeyPushed(Input.LBUTTON)) then
    return
  end
  local x, y = Input.GetMousePos()
  if (nil == param.boa) then
    param.boa = GenBegMoneyBoa(x, y)
    BounceGameHittest(param, x, y, OnBegMoney)
  end
end

BegMoney = {}

BegMoney.OnCreate = function(param)
  BounceGameInit(param, MAX_USER, user_tex_id)
  UpdateCoinInfo(param)
  param.step = BegMoneyPlay
end

BegMoney.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, MAIN_MAP_LVL_ID)
    return
  end
  param.step(param)
end

BegMoneyBou = {}

BegMoneyBou.OnCreate = function(param)
  param.time = MAX_BOA_BEG_TIME
end

BegMoneyBou.OnStep = function(param)
  if (0 < param.time) then
    param.time = param.time - 1
  end
  if (0 >= param.time) then
    local idLvl = Good.GetLevelId()
    local p = Good.GetParam(idLvl)
    p.boa = nil
    Good.KillObj(param._id)
  end
end
