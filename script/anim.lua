local bkgnd1_map_id = 162
local bkgnd2_map_id = 166

function AcCaveMazeScrollDone(param)
  param.k = nil
  Good.SetScript(param._id, 'CaveMaze')
  CenterMaze(param)
end

function AcKillAnimObj(param)
  Good.KillObj(param._id)
end

function AcKillAnimScript(param)
  param.k = nil
  Good.SetScript(param._id, '')
end

BouncingObj = {}

BouncingObj.OnCreate = function(param)
  param.dirx = 1
  if (math.random(2) == 1) then
    param.dirx = -1 * param.dirx
  end
  param.diry = 1
  if (math.random(2) == 1) then
    param.diry = -1 * param.diry
  end
end

BouncingObj.OnStep = function(param)
  local id = param._id
  local x,y = Good.GetPos(id)
  x = x + param.dirx
  y = y + param.diry
  Good.SetPos(id, x, y)
  local l,t,w,h = Good.GetDim(id)
  if (SCR_W <= x + w or 0 >= x) then
    param.dirx = -1 * param.dirx
  end
  if (SCR_H <= y + h or 0 >= y) then
    param.diry = -1 * param.diry
  end
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

AnimShowFrog = {}

AnimShowFrog.OnStep = function(param)
  if (nil == param.k) then
    local loop1 = ArAddLoop(nil)
    ArAddMoveBy(loop1, 'Pos', 0.25, 12, -55)
    ArAddDelay(loop1, 0.5)
    ArAddMoveBy(loop1, 'Pos', 0.25, 0, 40)
    ArAddCall(loop1, 'AcKillAnimScript', 0)
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

AnimCaveMazeScroll = {}

AnimCaveMazeScroll.OnStep = function(param)
  if (nil == param.k) then
    local loop1 = ArAddLoop(nil)
    ArAddMoveTo(loop1, 'Pos', 0.65, param.tx, param.ty).ease = ArEaseOut
    ArAddCall(loop1, 'AcCaveMazeScrollDone', 0)
    param.k = ArAddAnimator({loop1})
  else
    ArStepAnimator(param, param.k)
  end
end

AnimTempleBkgnd = {}

AnimTempleBkgnd.OnStep = function(param)
  if (nil == param.k) then
    local loop1 = ArAddLoop(nil)
    ArAddMoveTo(loop1, 'MapId', 0, bkgnd2_map_id)
    ArAddDelay(loop1, 0.5)
    ArAddMoveTo(loop1, 'MapId', 0, bkgnd1_map_id)
    ArAddDelay(loop1, 0.5)
    param.k = ArAddAnimator({loop1})
  else
    ArStepAnimator(param, param.k)
  end
end

AnimTempleGainCoin = {}

AnimTempleGainCoin.OnStep = function(param)
  if (nil == param.k) then
    local dx = math.random(64/3, 2*64/3)
    if (math.random(2) == 1) then
      dx = -1 * dx
    end
    local loop1 = ArAddLoop(nil)
    ArAddMoveBy(loop1, 'Pos', 0.2, dx, -64/2).ease = ArEaseOut
    ArAddMoveBy(loop1, 'Pos', 0.35, 0, 64).ease = ArEaseOutBounce
    ArAddCall(loop1, 'AcKillAnimObj', 0.3)
    local loop2 = ArAddLoop(nil)
    ArAddDelay(loop2, 0.75)
    ArAddMoveTo(loop2, 'Alpha', 0.1, 0)
    param.k = ArAddAnimator({loop1, loop2})
  else
    ArStepAnimator(param, param.k)
  end
end