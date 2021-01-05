local MAX_FISH = 5

local hook_obj_id = 398
local hook_down_btn_obj_id = 399
local hook_up_btn_obj_id = 400
local pass_talk_id = 3601

local fish_line_obj = nil

local function DrawFishLine()
  if (nil ~= fish_line_obj) then
    Good.KillObj(fish_line_obj)
    fish_line_obj = nil
  end
  local x, y = Good.GetPos(hook_obj_id)
  if (0 >= y) then
    return
  end
  fish_line_obj = GenColorObj(-1, 2, y, 0xffff6a00)
  Good.SetPos(fish_line_obj, x + 37, 0)
end

local function HittestFish(param)
  local l,t,w,h = Good.GetDim(hook_obj_id)
  local x, y = Good.GetPos(hook_obj_id)
  x = x + w/2
  y = y + h/2
  return BounceGameHittest(param, x, y)
end

local function InitFish(o)
  local param = Good.GetParam(o)
  if (0 > param.dirx) then
    Good.SetScale(o, -1, 1)
  end
  Good.SetScript(o, 'AnimFish')
end

local function MoveHookDown()
  local x, y = Good.GetPos(hook_obj_id)
  local l,t,w,h = Good.GetDim(hook_obj_id)
  if (y + h >= SCR_H) then
    return
  end
  y = y + 1
  Good.SetPos(hook_obj_id, x, y)
  DrawFishLine()
end

local function MoveHookUp()
  local x, y = Good.GetPos(hook_obj_id)
  if (0 >= y) then
    return
  end
  y = y - 1
  Good.SetPos(hook_obj_id, x, y)
  DrawFishLine()
end

local function MoveHook()
  if (Input.IsKeyDown(Input.LBUTTON)) then
    local x, y = Input.GetMousePos()
    if (PtInObj(x, y, hook_down_btn_obj_id)) then
      MoveHookDown()
    end
    if (PtInObj(x, y, hook_up_btn_obj_id)) then
      MoveHookUp()
    end
  end
end

Fishing = {}

Fishing.OnCreate = function(param)
  BounceGameInit(param, MAX_FISH, FISH_TEX_ID, InitFish)
end

Fishing.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, FISH_FIELD_LVL_ID)
    return
  end
  MoveHook()
  if (HittestFish(param)) then
    if (MAX_FISH == param.hit) then
      StartTalk(pass_talk_id)
    end
  end
end
