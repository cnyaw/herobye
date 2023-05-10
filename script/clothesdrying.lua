local MAX_CLOTHES = 5
local CX_SLOT = SCR_W/MAX_CLOTHES
local CY_SLOT = SCR_H/3
local WAIT_TIME = 40

local tshirt_txt_id = 377
local pants_txt_id = 375
local clothes_tex_id = {tshirt_txt_id, pants_txt_id}

local clothes_drying_done_talk_id = 1503

ClothesDrying = {}

ClothesDrying.OnCreate = function(param)
  GenClothes(param)
  param.step = ClothesDryingPlay
end

ClothesDrying.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, HERO_VILLAGE_LVL_ID)
  else
    param.step(param)
  end
end

ClothesDryingEnd = function(param)
  if (WaitTimer(param, WAIT_TIME)) then
    StartTalk(clothes_drying_done_talk_id)
  end
end

ClothesDryingPlay = function(param)
  DragHandler(param, BeginDragClothes, DraggingClothes, DragClothesDone)
end

function BeginDragClothes(param)
  local x, y = Input.GetMousePos()
  for i = 1, MAX_CLOTHES do
    local o = param.obj[i]
    if (nil ~= o and PtInObj(x, y, o)) then
      Good.AddChild(-1, o)              -- Change zorder to topmost.
      param.drag_idx = i
      param.orig_x, param.orig_y = Good.GetPos(o)
      param.click_x, param.click_y = x, y
      return true
    end
  end
  return false
end

function DraggingClothes(param)
  local x, y = Input.GetMousePos()
  local new_x = param.orig_x + (x - param.click_x)
  local new_y = param.orig_y + (y - param.click_y)
  local o = param.obj[param.drag_idx]
  Good.SetPos(o, new_x, new_y)
end

function DragClothesDone(param)
  if (not DropClothesMatchSlot(param)) then
    local o = param.obj[param.drag_idx]
    Good.SetPos(o, param.orig_x, param.orig_y)
  end
end

function DropClothesMatchSlot(param)
  local x, y = Input.GetMousePos()
  if (CY_SLOT < y) then
    return false
  end
  local i = 1 + math.floor(x / CX_SLOT)
  if (nil == param.slot[i]) then
    return false
  end
  if (SameClothesType(i, param.drag_idx)) then
    IncMatchClothes(param, i)
    return true
  end
  return false
end

function GenClothes(param)
  param.match = 0
  param.obj = {}
  param.slot = {}
  for i = 1, MAX_CLOTHES do
    local index = 1 + (i % #clothes_tex_id)
    local tex = clothes_tex_id[index]
    local w, h = Resource.GetTexSize(tex)
    local o = Good.GenObj(-1, tex)
    local x = math.random(SCR_W - w)
    local y = CY_SLOT + math.random((SCR_H - CY_SLOT) - h)
    Good.SetPos(o, x, y)
    param.obj[i] = o
    param.slot[i] = GenClothesShade(CX_SLOT * (i - 1), 20, tex)
  end
end

function GenClothesShade(x, y, tex)
  local o = Good.GenObj(-1, tex)
  local w, h = Resource.GetTexSize(tex)
  Good.SetPos(o, x + (CX_SLOT - w)/2, (CY_SLOT - h)/2)
  Good.SetBgColor(o, COLOR_BLACK)
  return o
end

function IncMatchClothes(param, slot_idx)
  local i = param.drag_idx
  Good.SetPos(param.obj[i], Good.GetPos(param.slot[slot_idx]))
  param.obj[i] = nil
  param.slot[slot_idx] = nil
  param.match = param.match + 1
  if (MAX_CLOTHES == param.match) then
    param.step = ClothesDryingEnd
  end
end

function SameClothesType(a, b)
  local ntype = #clothes_tex_id
  return a % ntype == b % ntype
end
