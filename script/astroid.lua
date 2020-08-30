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
end

Astroid.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, ALIEN_AREA_LVL_ID)
    return
  end
  if (not Input.IsKeyPushed(Input.LBUTTON)) then
    return
  end
  local x, y = Input.GetMousePos()
  for i = 1, NUM_ASTROID do
    local o = param.o[i]
    if (PtInObj(x, y, o)) then
      Good.SetScript(o, 'AnimDestroyAstroid')
      Good.GetParam(o).k = nil
      param.o[i] = GenNewAstroid(i)
      return
    end
  end
end

function GenNewAstroid(i)
  local w,h = Resource.GetTexSize(astroid_tex_id)
  local o = Good.GenObj(-1, astroid_tex_id, 'AnimAstroid')
  Good.SetPos(o, (i-1) * (SCR_W/NUM_ASTROID), -math.random(h, 4*h))
  Good.SetAnchor(o, .5, .5)
  return o
end

function SetDestroyAstroidCount(param, c)
  param.counter_dummy_count = c
  UpdateCounterDummyUi(param, astroid_tex_id, NUM_ASTROID_TO_DESTROY)
end
