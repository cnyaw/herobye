
function AcKillAnimObj(param)
  Good.KillObj(param._id)
end

AnimBegMoney = {}

AnimBegMoney.OnStep = function(param)
  if (nil == param.k) then
    local loop1 = ArAddLoop(nil)
    ArAddMoveBy(loop1, 'Pos', 0.25, 0, -20)
    ArAddCall(loop1, 'AcKillAnimObj', 0)
    local loop2 = ArAddLoop(nil)
    ArAddMoveBy(loop2, 'Alpha', 0.25, 0)
    param.k = ArAddAnimator({loop1, loop2})
  else
    ArStepAnimator(param, param.k)
  end
end

AnimSandGlass = {}

AnimSandGlass.OnStep = function(param)
  if (nil == param.k) then
    local loop1 = ArAddLoop(nil, 1)
    local loop2 = ArAddLoop(loop1, param.cd)
    ArAddMoveTo(loop2, 'Rot', 1, 360).ease = ArEaseOut
    ArAddCall(loop1, 'AcKillAnimObj', 0)
    param.k = ArAddAnimator({loop1})
  else
    ArStepAnimator(param, param.k)
  end
end

AnimTalkArrow = {}

AnimTalkArrow.OnStep = function(param)
  if (nil == param.k) then
    local loop1 = ArAddLoop(nil)
    ArAddMoveBy(loop1, 'Pos', 0.25, 0, -10)
    ArAddMoveBy(loop1, 'Pos', 0.25, 0, 10)
    param.k = ArAddAnimator({loop1})
  else
    ArStepAnimator(param, param.k)
  end
end
