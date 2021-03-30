local WAIT_TIME = 80
local NUM_ASTROID_TO_DESTROY = 10
local NUM_ASTROID = 5

local astroid_tex_id = 196

Astroid = {}

Astroid.OnCreate = function(param)
  SetDestroyAstroidCount(param, 0)
  param.o = {}
  for i = 1, NUM_ASTROID do
    param.o[i] = GenNewAstroid(i)
  end
  param.step = OnDestroyAstroidStep
end

Astroid.OnNewParticle = function(param, particle, iMgr)
  local i = Stge.GetUserData(particle, 0, iMgr)
  local cx = Stge.GetUserData(particle, 1, iMgr)
  local cy = Stge.GetUserData(particle, 2, iMgr)
  local w,h = Resource.GetTexSize(astroid_tex_id)
  local o = Good.GenObj(-1, astroid_tex_id, 'AnimAstroidPiece')
  Good.SetAnchor(o, .5, .5)
  local px,py = w/cx, h/cy
  Good.SetDim(o, (i % cx) * px, math.floor(i / cy) * py, px, py)
  Stge.BindParticle(particle, o, iMgr)
end

Astroid.OnKillParticle = function(param, particle, iMgr)
  Good.KillObj(Stge.GetParticleBind(particle, iMgr))
end

Astroid.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, ALIEN_AREA_LVL_ID)
    return
  end
  param.step(param)
end

function GenNewAstroid(i)
  local w,h = Resource.GetTexSize(astroid_tex_id)
  local o = Good.GenObj(-1, astroid_tex_id, 'AnimAstroid')
  Good.SetPos(o, (i-1) * (SCR_W/NUM_ASTROID), -math.random(h, 4*h))
  Good.SetAnchor(o, .5, .5)
  return o
end

function HittestAstroid(param, x, y)
  for i = 1, NUM_ASTROID do
    local o = param.o[i]
    if (PtInObj(x, y, o)) then
      Good.SetScript(o, 'AnimDestroyAstroid')
      Good.GetParam(o).k = nil
      param.o[i] = GenNewAstroid(i)
      IncDestroyAstroidCount(param)
      return NUM_ASTROID_TO_DESTROY <= GetCounterUiCount(param)
    end
  end
  return false
end

function IncDestroyAstroidCount(param)
  SetDestroyAstroidCount(param, GetCounterUiCount(param) + 1)
end

function OnDestroyAstroidStep(param)
  if (not Input.IsKeyPushed(Input.LBUTTON)) then
    return
  end
  local x, y = Input.GetMousePos()
  if (HittestAstroid(param, x, y)) then
    param.step = OnPassAstroidStep
  end
end

function OnPassAstroidStep(param)
  if (not WaitTimer(param, WAIT_TIME)) then
    return
  end
  Good.GenObj(-1, JANKEN_PLANET_LVL_ID)
end

function SetDestroyAstroidCount(param, c)
  SetCounterUiCount(param, c)
  UpdateCounterUi(param, astroid_tex_id, NUM_ASTROID_TO_DESTROY)
end
