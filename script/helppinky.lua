local MAX_JOHN = 5

local john_tex_id = 317

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

HelpPinkyOnStepEnd = function(param)
  if (not WaitTimer(param, 40)) then
    return
  end
  StartTalk(1151)
end

HelpPinkyOnStepPlay = function(param)
  if (not Input.IsKeyPushed(Input.LBUTTON)) then
    return
  end
  local x, y = Input.GetMousePos()
  for i = 1, MAX_JOHN do
    if (nil ~= param.john[i] and PtInObj(x, y, param.john[i])) then
      GenFlyUpObj(param.john[i], john_tex_id)
      param.hit = param.hit + 1
      Good.KillObj(param.john[i])
      param.john[i] = nil
      if (MAX_JOHN == param.hit) then
        param.step = HelpPinkyOnStepEnd
        return
      end
      break
    end
  end
end
