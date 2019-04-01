
local WAIT_TIME = 60
local BLINK_TIME = 120

local building_group_obj_id = 368

local ufo_coming_talk_id = 1400

InterviewHeroVillage = {}

InterviewHeroVillage.OnCreate = function(param)
  GenObjFromBuildingGroup()
  param.step = InterviewHeroVillageOnStepInit
end

InterviewHeroVillage.OnStep = function(param)
  param.step(param)
end

function GenObjFromBuildingGroup()
  Good.GenObj(-1, building_group_obj_id)
end

function InterviewHeroVillageOnStepBlink(param)
  if (nil == param.counter) then
    param.counter = 0
    param.flag = true
  end
  param.counter = param.counter + 1
  if (0 == math.mod(param.counter, 5)) then
    param.flag = not param.flag
    if (param.flag) then
      Good.SetBgColor(param._id, COLOR_BLACK)
    else
      Good.SetBgColor(param._id, COLOR_RED)
    end
  end
  if (BLINK_TIME <= param.counter) then
    StartTalk(ufo_coming_talk_id)
  end
end

function InterviewHeroVillageOnStepInit(param)
  if (not WaitTimer(param, WAIT_TIME)) then
    return
  end
  param.step = InterviewHeroVillageOnStepBlink
end
