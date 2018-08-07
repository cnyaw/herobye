
InterviewHeroVillage = {}

InterviewHeroVillage.OnCreate = function(param)
  param.step = InterviewHeroVillageOnStepInit
end

InterviewHeroVillage.OnStep = function(param)
  param.step(param)
end

InterviewHeroVillageOnStepBlink = function(param)
  if (nil == param.counter) then
    param.counter = 0
    param.flag = true
  end
  param.counter = param.counter + 1
  if (0 == math.mod(param.counter, 5)) then
    param.flag = not param.flag
    if (param.flag) then
      Good.SetBgColor(param._id, 0xff000000)
    else
      Good.SetBgColor(param._id, 0xffff0000)
    end
  end
  if (120 <= param.counter) then
    curr_talk_id = {9999}
    Good.GenObj(-1, TALK_LVL_ID)
  end
end

InterviewHeroVillageOnStepInit = function(param)
  if (not WaitTimer(param, 60)) then
    return
  end
  param.step = InterviewHeroVillageOnStepBlink
end
