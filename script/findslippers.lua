local WAIT_TIME = 40

local slippers_tex_id = 465

local found_slippers_talk_id = 4001

local function OnStepFoundSlippers(param)
  if (WaitTimer(param, WAIT_TIME)) then
    StartTalk(found_slippers_talk_id)
  end
end

local function BeginDragSlippers(param)
  local x, y = Input.GetMousePos()
  local o = Good.PickObj(x, y, Good.TEXBG, slippers_tex_id)
  if (-1 == o) then
    return false
  end
  Good.AddChild(-1, o)                  -- Make top-most.
  if (COLOR_RED == Good.GetBgColor(o)) then
    param.step = OnStepFoundSlippers
    return false
  end
  param.pick_obj = o
  param.orig_x, param.orig_y = Good.GetPos(o)
  param.click_x, param.click_y = x, y
  return true;
end

local function DraggingSlippers(param)
  local x, y = Input.GetMousePos()
  local new_x = param.orig_x + (x - param.click_x)
  local new_y = param.orig_y + (y - param.click_y)
  Good.SetPos(param.pick_obj, new_x, new_y)
end

local function DragSlippersDone(param)
  -- NOP.
end

local function GenSlipper(w, h, color)
  local o = Good.GenObj(-1, slippers_tex_id, '')
  Good.SetPos(o, math.random(0, SCR_W - w), math.random(h/2, SCR_H - 1.5 * h))
  Good.SetBgColor(o, color)
  return o
end

local function GenSlippers()
  local colors = {COLOR_BLUE, COLOR_GRAY, COLOR_GREEN, COLOR_PURPLE, COLOR_YELLOW, COLOR_WHITE}
  local w,h = Resource.GetTexSize(slippers_tex_id)
  local o = GenSlipper(w, h, COLOR_RED)
  local o2
  for i = 1, 64 do
    o2 = GenSlipper(w, h, colors[1 + (i % #colors)])
  end
  Good.SetPos(o, Good.GetPos(o2))
end

local function OnStepFindSlippers(param)
  DragHandler(param, BeginDragSlippers, DraggingSlippers, DragSlippersDone)
end

FindSlippers = {}

FindSlippers.OnCreate = function(param)
  GenSlippers()
  param.step = OnStepFindSlippers
end

FindSlippers.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, ISLAND_LVL_ID)
    return
  end
  param.step(param)
end
