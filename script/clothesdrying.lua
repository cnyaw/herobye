local MAX_CLOTHES = 5

local tshirt_txt_id = 377
local pants_txt_id = 375

local clothes_tex_id = {tshirt_txt_id, pants_txt_id}

local clothes_drying_done_talk_id = 1503

ClothesDrying = {}

ClothesDrying.OnCreate = function(param)
  GenClothes(param)
  param.step = ClothesDryingOnStepPlay
end

ClothesDrying.OnStep = function(param)
  param.step(param)
end

ClothesDryingOnStepEnd = function(param)
  if (not WaitTimer(param, 40)) then
    return
  end
  StartTalk(clothes_drying_done_talk_id)
end

ClothesDryingOnStepPlay = function(param)
  if (Input.IsKeyDown(Input.LBUTTON)) then
    if (not param.mouse_down) then
      BeginDragClothes(param)
    else
      DraggingClothes(param)
    end
  else
    if (param.mouse_down) then
      DragClothesDone(param)
    end
  end
end

function BeginDragClothes(param)
  local x, y = Input.GetMousePos()
  for i = 1, MAX_CLOTHES do
    if (nil ~= param.obj[i] and PtInObj(x, y, param.obj[i])) then
      param.mouse_down = true
      local o = param.obj[i]
      Good.AddChild(-1, o)              -- Change zorder to topmost.
      param.drag_idx = i
      param.orig_x, param.orig_y = Good.GetPos(o)
      param.click_x, param.click_y = x, y
      break
    end
  end
end

function DraggingClothes(param)
  local x, y = Input.GetMousePos()
  local new_x = param.orig_x + (x - param.click_x)
  local new_y = param.orig_y + (y - param.click_y)
  local o = param.obj[param.drag_idx]
  Good.SetPos(o, new_x, new_y)
end

function DragClothesDone(param)
  if (not DropClotherCorrectSlot(param)) then
    local o = param.obj[param.drag_idx]
    Good.SetPos(o, param.orig_x, param.orig_y)
  end
  param.mouse_down = false
end

function DropClotherCorrectSlot(param)
  local x, y = Input.GetMousePos()
  if (SCR_H/3 < y) then
    return false
  end
  local i = 1 + math.floor(x / (SCR_W/MAX_CLOTHES))
  if (nil == param.slot[i]) then
    return false
  end
  if (SameClothesType(i, param.drag_idx)) then
    IncHitClothes(param, i)
    return true
  end
  return false
end

function GenClothes(param)
  param.hit = 0
  param.obj = {}
  param.slot = {}
  for i = 1, MAX_CLOTHES do
    local index = 1 + (i % #clothes_tex_id)
    local tex = clothes_tex_id[index]
    local w, h = Resource.GetTexSize(tex)
    local o = Good.GenObj(-1, tex)
    local x = math.random(SCR_W - w)
    local y = SCR_H/3 + math.random((SCR_H - SCR_H/3) - h)
    Good.SetPos(o, x, y)
    param.obj[i] = o
    param.slot[i] = GenClothesShade(SCR_W/MAX_CLOTHES * (i - 1), 20, tex)
  end
end

function GenClothesShade(x, y, tex)
  local o = Good.GenObj(-1, tex)
  local w, h = Resource.GetTexSize(tex)
  Good.SetPos(o, x + (SCR_W/MAX_CLOTHES - w)/2, y)
  Good.SetBgColor(o, 0xff000000)
  return o
end

function IncHitClothes(param, slot_idx)
  local i = param.drag_idx
  Good.SetPos(param.obj[i], Good.GetPos(param.slot[slot_idx]))
  param.obj[i] = nil
  param.slot[slot_idx] = nil
  param.hit = param.hit + 1
  if (MAX_CLOTHES == param.hit) then
    param.step = ClothesDryingOnStepEnd
  end
end

function SameClothesType(a, b)
  local ntype = #clothes_tex_id
  return a % ntype == b % ntype
end
