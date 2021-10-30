local WAIT_TIME = 80

local laalaa_obj_id = 38
local found_laalaa_talk_id = 3102

local objs = {26, laalaa_obj_id, 232, 233}

local function ResetShadowGame()
  for i = 1, #objs do
    Good.SetScale(objs[i], 30, 30)
    Good.SetScript(objs[i], 'AnimShadow')
  end
  for i = 1, 20 do
    local i2 = math.random(1,3)
    local x,y = Good.GetPos(objs[i2])
    local x2,y2 = Good.GetPos(objs[4])
    Good.SetPos(objs[i2], x2, y2)
    Good.SetPos(objs[4], x, y)
  end
end

local function ShadowAnimDone()
  for i = 1, #objs do
    local p = Good.GetParam(objs[i])
    if (nil ~= p.k) then
      return false
    end
  end
  return true
end

ShadowGame = {}

ShadowGame.OnCreate = function(param)
  ResetShadowGame()
  param.step = ShadowGamePlay
end

ShadowGame.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, JANKEN_PLANET_LVL_ID)
    return
  end
  param.step(param)
end

ShadowGameDone = function(param)
  if (not WaitTimer(param, WAIT_TIME)) then
    return
  end
  StartTalk(found_laalaa_talk_id)
end

ShadowGamePlay = function(param)
  if (Input.IsKeyPushed(Input.LBUTTON)) then
    if (not ShadowAnimDone()) then
      return
    end
    local x, y = Input.GetMousePos()
    if (PtInObj(x, y, laalaa_obj_id)) then
      Good.SetScript(laalaa_obj_id, 'AnimFadeToWhite')
      param.step = ShadowGameDone
    else
      ResetShadowGame()
    end
  end
end
