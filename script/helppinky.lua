local MAX_JOHN = 5
local WAIT_TIME = 40

local help_pinky_done_talk_id = 1707
local help_pinky_done_dream_talk_id = 1151

local function HelpPinkyEnd(param)
  if (not WaitTimer(param, WAIT_TIME)) then
    return
  end
  if (HasPowerScissor()) then
    StartTalk(help_pinky_done_talk_id)
  else
    StartTalk(help_pinky_done_dream_talk_id)
  end
end

local function OnHitJohn(param, o)
  GenFlyUpObj(o, JOHN_TEX_ID)
  if (MAX_JOHN == param.hit) then
    param.step = HelpPinkyEnd
  end
end

local function HelpPinkyPlay(param)
  if (not Input.IsKeyPushed(Input.LBUTTON)) then
    return
  end
  local x, y = Input.GetMousePos()
  BounceGameHittest(param, x, y, OnHitJohn)
end

HelpPinky = {}

HelpPinky.OnCreate = function(param)
  BounceGameInit(param, MAX_JOHN, JOHN_TEX_ID)
  param.step = HelpPinkyPlay
end

HelpPinky.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    return
  end
  param.step(param)
end
