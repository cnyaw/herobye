
local CHECK_COUNT = 10
local NUM_MOUSE = 8
local NUM_MOUSE_PER_ROW = 4

local hit_tex_id = 523
local mouse_tex_id = 519
local pass_talk_id = 3405

local function SetCheckCount(param, c)
  SetCounterUiCount(param, c)
  UpdateCounterUi(param, mouse_tex_id, CHECK_COUNT)
end

MouseCave = {}

MouseCave.OnCreate = function(param)
  param.obj = {}
  local texw, texh = Resource.GetTexSize(mouse_tex_id)
  local holew, holeh = Resource.GetTexSize(HOLE_TEX_ID)
  local tilew = SCR_W / NUM_MOUSE_PER_ROW
  for i = 0, NUM_MOUSE - 1 do
    local row = math.floor(i / NUM_MOUSE_PER_ROW)
    local col = i % NUM_MOUSE_PER_ROW
    local dummy = Good.GenDummy(-1)
    Good.SetPos(dummy, tilew * col + (tilew - texw)/2, 150 + row * (texh * 1.5))
    local hole = Good.GenObj(dummy, HOLE_TEX_ID)
    Good.SetPos(hole, 0, -holeh/2)
    local o = Good.GenObj(dummy, mouse_tex_id, 'AnimMoleInit')
    GenColorObj(dummy, texw, texh, COLOR_GRAY)
    hole = Good.GenObj(dummy, HOLE_TEX_ID)
    Good.SetDim(hole, 0, holeh/2, holew, holeh/2)
    param.obj[1 + i] = o
  end
  SetCheckCount(param, 0)
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
  for i = 1, #param.obj do
    local o = param.obj[i]
    local dx, dy = Good.GetPos(Good.GetParent(o))
    if (PtInObj(x - dx, y - dy, o)) then
      local p = Good.GetParam(o)
      if (nil ~= p.hit and not p.hit) then
        Good.SetBgColor(o, COLOR_RED)
        GenHitObj(x, y, hit_tex_id)
        p.hit = true
        SetCheckCount(param, GetCounterUiCount(param) + 1)
        if (CHECK_COUNT <= GetCounterUiCount(param)) then
          StartTalk(pass_talk_id)
          return
        end
        return
      end
    end
  end
  SetCheckCount(param, 0)
end
