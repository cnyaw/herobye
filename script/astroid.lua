local WAIT_TIME = 80
local CHECK_COUNT = 10
local NUM_ASTROID = 5

local astroid_tex_id = 196

local function SetCheckCount(param, c)
  SetCounterUiCount(param, c)
  UpdateCounterUi(param, astroid_tex_id, CHECK_COUNT)
end

local function GenNewAstroid(i, param)
  local w,h = Resource.GetTexSize(astroid_tex_id)
  local o = Good.GenObj(-1, astroid_tex_id, 'AnimAstroid')
  Good.SetPos(o, (i-1) * (SCR_W/NUM_ASTROID), -math.random(h, 4*h))
  Good.SetAnchor(o, .5, .5)
  Good.GetParam(o).clear = function() SetCheckCount(param, 0) end
  return o
end

local function IncDestroyAstroidCount(param)
  SetCheckCount(param, GetCounterUiCount(param) + 1)
end

local function HittestAstroid(param, x, y)
  for i = 1, NUM_ASTROID do
    local o = param.o[i]
    if (PtInObj(x, y, o)) then
      Good.SetScript(o, 'AnimDestroyAstroid')
      Good.GetParam(o).k = nil
      param.o[i] = GenNewAstroid(i, param)
      IncDestroyAstroidCount(param)
      return CHECK_COUNT <= GetCounterUiCount(param)
    end
  end
  return false
end

local function OnPassAstroidStep(param)
  if (WaitTime(param, WAIT_TIME)) then
    Good.GenObj(-1, JANKEN_PLANET_LVL_ID)
  end
end

local function OnDestroyAstroidStep(param)
  if (not Input.IsKeyPushed(Input.LBUTTON)) then
    return
  end
  if (HittestAstroid(param, Input.GetMousePos())) then
    param.step = OnPassAstroidStep
  end
end

Astroid = {}

Astroid.OnCreate = function(param)
  SetCheckCount(param, 0)
  param.o = {}
  for i = 1, NUM_ASTROID do
    param.o[i] = GenNewAstroid(i, param)
  end
  param.step = OnDestroyAstroidStep
end

Astroid.OnNewParticle = function(param, particle)
  local i = Stge.GetUserData(particle, 0)
  local cx = Stge.GetUserData(particle, 1)
  local cy = Stge.GetUserData(particle, 2)
  local w,h = Resource.GetTexSize(astroid_tex_id)
  local o = Good.GenObj(-1, astroid_tex_id, 'AnimAstroidPiece')
  Good.SetAnchor(o, .5, .5)
  local px,py = w/cx, h/cy
  Good.SetDim(o, (i % cx) * px, math.floor(i / cy) * py, px, py)
  Stge.BindParticle(particle, o)
end

Astroid.OnKillParticle = function(param, particle)
  Good.KillObj(Stge.GetParticleBind(particle))
end

Astroid.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, ALIEN_AREA_LVL_ID)
    return
  end
  param.step(param)
end
