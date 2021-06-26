
local CHECK_COUNT = 10

local hole_tex_id = 522
local mouse_tex_id = 519
local pass_talk_id = 3405

local function SetHitMoleCount(param, c)
  SetCounterUiCount(param, c)
  UpdateCounterUi(param, mouse_tex_id, CHECK_COUNT)
end

MouseCave = {}

MouseCave.OnCreate = function(param)
  param.obj = {}
  local texw, texh = Resource.GetTexSize(mouse_tex_id)
  local holew, holeh = Resource.GetTexSize(hole_tex_id)
  local tilew = SCR_W / 4
  for i = 0, 7 do
    local row = math.floor(i / 4)
    local col = i % 4
    local dummy = Good.GenDummy(-1)
    Good.SetPos(dummy, tilew * col + (tilew - texw)/2, 150 + row * (texh * 1.5))
    local hole = Good.GenObj(dummy, hole_tex_id)
    Good.SetPos(hole, 0, -holeh/2)
    local o = Good.GenObj(dummy, mouse_tex_id, 'AnimMoleInit')
    GenColorObj(dummy, texw, texh, COLOR_GRAY)
    hole = Good.GenObj(dummy, hole_tex_id)
    Good.SetDim(hole, 0, holeh/2, holew, holeh/2)
    param.obj[1 + i] = o
  end
  SetHitMoleCount(param, 0)
end

MouseCave.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, BAT_CAVE_FIELD_LVL_ID)
    return
  end
  if (not Input.IsKeyPushed(Input.LBUTTON)) then
    return
  end
  local x, y = Input.GetMousePos()
  for i = 1, 8 do
    local o = param.obj[i]
    local dx, dy = Good.GetPos(Good.GetParent(o))
    if (PtInObj(x - dx, y - dy, o)) then
      local p = Good.GetParam(o)
      if (nil ~= p.hit and not p.hit) then
        p.hit = true
        SetHitMoleCount(param, GetCounterUiCount(param) + 1)
        if (CHECK_COUNT <= GetCounterUiCount(param)) then
          StartTalk(pass_talk_id)
          return
        end
        return
      end
    end
  end
  SetHitMoleCount(param, 0)
end
