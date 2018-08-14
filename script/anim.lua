
function AcKillAnimObj(param)
  Good.KillObj(param._id)
end

AnimClickFish = {}

AnimClickFish.OnStep = function(param)
  if (nil == param.k) then
    local loop1 = ArAddLoop(nil)
    ArAddMoveTo(loop1, 'Scale', 0.5, 2.5, 2.5)
    ArAddCall(loop1, 'AcKillAnimObj', 0)
    local loop2 = ArAddLoop(nil)
    ArAddDelay(loop2, 0.1)
    ArAddMoveTo(loop2, 'Alpha', 0.4, 0)
    local loop3 = ArAddLoop(nil)
    ArAddMoveBy(loop3, 'Rot', 0.2, 90)
    param.k = ArAddAnimator({loop1, loop2, loop3})
  else
    ArStepAnimator(param, param.k)
  end
end

AnimCursor = {}

AnimCursor.OnStep = function(param)
  if (nil == param.k) then
    local loop1 = ArAddLoop(nil)
    ArAddMoveBy(loop1, 'Rot', 1, 90).ease = ArEaseOut
    param.k = ArAddAnimator({loop1})
  else
    ArStepAnimator(param, param.k)
  end
end

AnimFlyUpObj = {}

AnimFlyUpObj.OnStep = function(param)
  if (nil == param.k) then
    local loop1 = ArAddLoop(nil)
    ArAddMoveBy(loop1, 'Pos', 0.25, 0, -20)
    ArAddCall(loop1, 'AcKillAnimObj', 0)
    local loop2 = ArAddLoop(nil)
    ArAddDelay(loop2, 0.1)
    ArAddMoveTo(loop2, 'Alpha', 0.15, 0)
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

AnimUfo = {}

AnimUfo.OnStep = function(param)
  if (nil == param.k) then
    Good.SetAnchor(param._id, 0.5, 0.5)
    local loopn = ArAddLoop(nil)
    local loop2 = ArAddLoop(loopn, 2)
    ArAddMoveTo(loop2, 'Pos', 1, 450, 250)
    ArAddMoveTo(loop2, 'Pos', 2, 10, 200)
    ArAddMoveTo(loop2, 'Pos', 0.5, 450, 40)
    ArAddMoveTo(loopn, 'Pos', 1, 10, 250)
    ArAddMoveBy(loopn, 'Pos', 1, 40, 20)

    local loopn2 = ArAddLoop(nil)
    ArAddMoveBy(loopn2, 'Rot', 1, 150)

    local loopn3 = ArAddLoop(nil)
    ArAddMoveBy(loopn3, 'Scale', 2, 1.5, 0)
    ArAddMoveBy(loopn3, 'Scale', 2, 0, 1.5)
    ArAddDelay(loopn3, 5)
    ArAddMoveBy(loopn3, 'Scale', 2, 0, -1.5)
    ArAddMoveBy(loopn3, 'Scale', 2, -1.5, 0)
    ArAddDelay(loopn3, 5)

    param.k = ArAddAnimator({loopn, loopn2, loopn3})
  else
    ArStepAnimator(param, param.k)
  end
end
