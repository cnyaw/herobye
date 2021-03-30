
local NUM_FISH_BONE = 6
local WAIT_TIME = 60

local trash_can_tex_id = 112
local fish_bone_tex_id = 118

local clean_done_talk_id = 2701

local trash_can = nil
local fish_bone = nil

PickTrash = {}

PickTrash.OnCreate = function(param)
  trash_can = GenTrashCan()
  fish_bone = {}
  for i = 1, NUM_FISH_BONE do
    fish_bone[i] = GenFishBone()
  end
  SetPickTrashCount(param, 0)
  param.step = PickTrashOnStepPlay
end

PickTrash.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, TRASH_FIELD_LVL_ID)
  else
    param.step(param)
  end
end

function BeginDragFishBone(param)
  local x, y = Input.GetMousePos()
  for i = 1, NUM_FISH_BONE do
    local o = fish_bone[i]
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

function DraggingFishBone(param)
  local x, y = Input.GetMousePos()
  local new_x = param.orig_x + (x - param.click_x)
  local new_y = param.orig_y + (y - param.click_y)
  local o = fish_bone[param.drag_idx]
  Good.SetPos(o, new_x, new_y)
end

function DragFishBoneDone(param)
  if (not DropFishBoneToTrash(param)) then
    local o = fish_bone[param.drag_idx]
    Good.SetPos(o, param.orig_x, param.orig_y)
  else
    Good.KillObj(fish_bone[param.drag_idx])
    fish_bone[param.drag_idx] = nil
    SetPickTrashCount(param, GetCounterUiCount(param) + 1)
  end
end

function DropFishBoneToTrash(param)
  local o = fish_bone[param.drag_idx]
  local x, y = Good.GetPos(o)
  local w, h = Resource.GetTexSize(fish_bone_tex_id)
  return IntersectObj(x, y, w, h, trash_can)
end

function GenFishBone()
  local w, h = Resource.GetTexSize(fish_bone_tex_id)
  local o = Good.GenObj(-1, fish_bone_tex_id)
  local x, y
  while true do
    x = math.random(SCR_W - w)
    y = math.random(SCR_H - h)
    if (not IntersectObj(x, y, w, h, trash_can) and not IntersectFishBones(x, y, w, h)) then
      break
    end
  end
  Good.SetPos(o, x, y)
  return o
end

function GenTrashCan()
  local w, h = Resource.GetTexSize(trash_can_tex_id)
  local o = Good.GenObj(-1, trash_can_tex_id)
  local x = math.random(SCR_W - w)
  local y = math.random(SCR_H - h)
  Good.SetPos(o, x, y)
  return o
end

function IntersectFishBones(x, y, w, h)
  for i = 1, #fish_bone do
    if (IntersectObj(x, y, w, h, fish_bone[i])) then
      return true
    end
  end
  return false
end

function IntersectObj(x, y, w, h, o)
  local ox, oy = Good.GetPos(o)
  local ol, ot, ow, oh = Good.GetDim(o)
  return x + w > ox and y + h > oy and x < ox + ow and y < oy + oh
end

function PickTrashOnStepDone(param)
  if (not WaitTimer(param, WAIT_TIME)) then
    return
  end
  StartTalk(clean_done_talk_id)
end

function PickTrashOnStepPlay(param)
  if (NUM_FISH_BONE == GetCounterUiCount(param)) then
    param.step = PickTrashOnStepDone
    return
  end
  DragHandler(param, BeginDragFishBone, DraggingFishBone, DragFishBoneDone)
end

function SetPickTrashCount(param, c)
  SetCounterUiCount(param, c)
  UpdateCounterUi(param, trash_can_tex_id, NUM_FISH_BONE)
end
