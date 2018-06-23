local SCR_W, SCR_H = Good.GetWindowSize()
local MAX_USER = 5
local MAX_BOA_BEG_TIME = 30

local user_tex_id = 296

BegMoney = {}

BegMoney.OnCreate = function(param)
  param.hit = 0
  param.user = {}
  local w, h = Resource.GetTexSize(user_tex_id)
  for i = 1, MAX_USER do
    local o = Good.GenObj(-1, user_tex_id, 'BegMoneyUser')
    local x = math.random(SCR_W - w)
    local y = math.random(SCR_H - h)
    Good.SetPos(o, x, y)
    param.user[i] = o
  end
  UpdateCoinInfo(param)
  param.step = BegMoneyOnStep
end

BegMoney.OnStep = function(param)
  param.step(param)
end

BegMoneyUser = {}

BegMoneyUser.OnCreate = function(param)
  param.dirx = 1
  if (math.random(2) == 1) then
    param.dirx = -1 * param.dirx
  end
  param.diry = 1
  if (math.random(2) == 1) then
    param.diry = -1 * param.diry
  end
end

BegMoneyUser.OnStep = function(param)
  local id = param._id
  local x,y = Good.GetPos(id)
  x = x + param.dirx
  y = y + param.diry
  Good.SetPos(id, x, y)
  local l,t,w,h = Good.GetDim(id)
  if (SCR_W <= x + w or 0 >= x) then
    param.dirx = -1 * param.dirx
  end
  if (SCR_H <= y + h or 0 >= y) then
    param.diry = -1 * param.diry
  end
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

function BegMoneyOnStep(param)
  if (not Input.IsKeyPushed(Input.LBUTTON)) then
    return
  end

  local x, y = Input.GetMousePos()
  if (nil == param.boa) then
    param.boa = GenBegMoneyBoa(x, y)
    BeggingMoney(x, y, param)
  end
end

function BegMoneyOnStepDone(param)
  if (nil == param.boa) then
    Good.GenObj(-1, MAIN_MAP_LVL_ID)
    return
  end
end

function BeggingMoney(x, y, param)
  for i = 1, MAX_USER do
    if (nil ~= param.user[i] and PtInObj(x, y, param.user[i])) then
      GenAnimCoinObj(param.user[i])
      param.hit = param.hit + 1
      Good.KillObj(param.user[i])
      param.user[i] = nil
      curr_coin = curr_coin + GetCurrBouGain()
      UpdateCoinInfo(param)
      if (MAX_USER == param.hit) then
        param.step = BegMoneyOnStepDone
        return
      end
      break
    end
  end
end

function GenBegMoneyBoa(x, y)
  local o = Good.GenObj(-1, GetCurrBouTexId(), 'BegMoneyBou')
  local l,t,w,h = Good.GetDim(o)
  Good.SetAnchor(o, 0.5, 0.5)
  Good.SetScale(o, 0.4, 0.4)
  Good.SetPos(o, x - w/2, y - h/2)
  return o
end
