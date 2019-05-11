local MAX_JOHN = 5
local WAIT_TIME = 40

local john_tex_id = 317

local help_pinky_done_talk_id = 1151

HelpPinky = {}

HelpPinky.OnCreate = function(param)
  param.hit = 0
  param.john = {}
  local w, h = Resource.GetTexSize(john_tex_id)
  for i = 1, MAX_JOHN do
    local o = Good.GenObj(-1, john_tex_id, 'BouncingObj')
    local x = math.random(SCR_W - w)
    local y = math.random(SCR_H - h)
    Good.SetPos(o, x, y)
    param.john[i] = o
  end
  param.step = HelpPinkyOnStepPlay
end

HelpPinky.OnStep = function(param)
  param.step(param)
end

function HelpPinkyOnStepEnd(param)
  if (not WaitTimer(param, WAIT_TIME)) then
    return
  end
  StartTalk(help_pinky_done_talk_id)
end

function HelpPinkyOnStepPlay(param)
  if (not Input.IsKeyPushed(Input.LBUTTON)) then
    return
  end
  local x, y = Input.GetMousePos()
  for i = 1, MAX_JOHN do
    local o = param.john[i]
    if (nil ~= o and PtInObj(x, y, o)) then
      GenFlyUpObj(o, john_tex_id)
      param.hit = param.hit + 1
      Good.KillObj(o)
      param.john[i] = nil
      if (MAX_JOHN == param.hit) then
        param.step = HelpPinkyOnStepEnd
      end
      break
    end
  end
end
