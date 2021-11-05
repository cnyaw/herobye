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

function AcKillAstroid(param)
  local id = param._id
  local x, y = Good.GetPos(id)
  Stge.RunScript('fx_destroy', x, y)
  Good.KillObj(id)
end

function AcKillAnimScript(param)
  param.k = nil
  Good.SetScript(param._id, '')
end

function AcMoleBeginHit(param)
  param.hit = false
end

function AcMoleEndHit(param)
  param.hit = nil
end

function AcMoleHide(param)
  param.k = nil
  Good.SetScript(param._id, 'AnimMole')
  Good.SetBgColor(param._id, COLOR_WHITE)
end

function AcKillMusicalNoteObj(param)
  param.clear()
  AcKillAnimObj(param)
end

function AcResetAstroid(param)
  local id = param._id
  local x, y = Good.GetPos(id)
  Good.SetPos(id, x, -math.random(10, 320))
  param.k = nil
  param.clear()
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

BouncingTarget = {}

BouncingTarget.OnStep = function(param)
  if (nil == param.dirx) then
    param.dirx = 1.2
    if (math.random(2) == 1) then
      param.dirx = -1 * param.dirx
    end
    param.diry = 0
  end
  BouncingObj.OnStep(param)
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

AnimMole = {}

AnimMole.OnStep = function(param)
  if (nil == param.k) then
    local loop1 = ArAddLoop(nil, 1)
    ArAddCall(loop1, 'AcMoleBeginHit', 0)
    ArAddMoveBy(loop1, 'Pos', 0.5, 0, -80).ease = ArEaseOut
    ArAddDelay(loop1, 0.8)
    ArAddMoveBy(loop1, 'Pos', 0.5, 0, 80).ease = ArEaseOut
    ArAddCall(loop1, 'AcMoleEndHit', 0)
    ArAddCall(loop1, 'AcMoleHide', math.random(2, 6))
    param.k = ArAddAnimator({loop1})
  else
    ArStepAnimator(param, param.k)
  end
end

AnimMoleHit = {}

AnimMoleHit.OnStep = function(param)
  if (nil == param.k) then
    local loop1 = ArAddLoop(nil, 1)
    ArAddCall(loop1, 'AcKillAnimObj', 0.5)
    param.k = ArAddAnimator({loop1})
  else
    ArStepAnimator(param, param.k)
  end
end

AnimMoleInit = {}

AnimMoleInit.OnStep = function(param)
  if (nil == param.k) then
    local loop1 = ArAddLoop(nil, 1)
    ArAddCall(loop1, 'AcMoleHide', math.random(2, 6))
    param.k = ArAddAnimator({loop1})
  else
    ArStepAnimator(param, param.k)
  end
end

AnimMusicalNote = {}

AnimMusicalNote.OnStep = function(param)
  if (nil == param.k) then
    Good.SetAnchor(param._id, 0.7, 0.5)
    local loop1 = ArAddLoop(nil, 1)
    ArAddMoveTo(loop1, 'Pos', param.dt, param.target_x, param.target_y)
    ArAddCall(loop1, 'AcKillMusicalNoteObj', 0)
    local loop2 = ArAddLoop(nil, 1)
    ArAddMoveTo(loop2, 'Scale', param.dt, 2.5, 2.5)
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

AnimTree = {}

AnimTree.OnStep = function(param)
  if (nil == param.k) then
    local loop1 = ArAddLoop(nil, 1)
    ArAddMoveTo(loop1, 'Pos', param.dt, param.target_x, param.target_y)
    ArAddCall(loop1, 'AcKillAnimObj', 0)
    local loop2 = ArAddLoop(nil, 1)
    ArAddMoveTo(loop2, 'Scale', param.dt, 1, 1)
    param.k = ArAddAnimator({loop1, loop2})
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
    local delay = math.random() * 0.5
    ArAddMoveTo(loop1, 'Visible', 0, 0)
    ArAddDelay(loop1, delay)
    ArAddMoveTo(loop1, 'Visible', 0, 1)
    ArAddMoveBy(loop1, 'Pos', 0.2, dx, -64/2).ease = ArEaseOut
    ArAddMoveBy(loop1, 'Pos', 0.35, 0, 64).ease = ArEaseOutBounce
    ArAddCall(loop1, 'AcKillAnimObj', 0.3)
    local loop2 = ArAddLoop(nil)
    ArAddDelay(loop2, 0.75 + delay)
    ArAddMoveTo(loop2, 'Alpha', 0.1, 0)
    param.k = ArAddAnimator({loop1, loop2})
  else
    ArStepAnimator(param, param.k)
  end
end

AnimAstroid = {}

AnimAstroid.OnStep = function(param)
  if (nil == param.k) then
    local t = math.random(4, 12)
    local x, y = Good.GetPos(param._id)
    local loop1 = ArAddLoop(nil)
    ArAddMoveTo(loop1, 'Pos', t, x, SCR_H)
    ArAddCall(loop1, 'AcResetAstroid', 0)
    local loop2 = ArAddLoop(nil)
    ArAddMoveTo(loop2, 'Rot', t, 360)
    param.k = ArAddAnimator({loop1, loop2})
  else
    ArStepAnimator(param, param.k)
  end
end

AnimDestroyAstroid = {}

AnimDestroyAstroid.OnStep = function(param)
  if (nil == param.k) then
    local loop1 = ArAddLoop(nil)
    ArAddMoveTo(loop1, 'Alpha', 0.1, 0)
    ArAddCall(loop1, 'AcKillAstroid', 0)
    param.k = ArAddAnimator({loop1})
  else
    ArStepAnimator(param, param.k)
  end
end

AnimAstroidPiece = {}

AnimAstroidPiece.OnStep = function(param)
  if (nil == param.k) then
    local loop1 = ArAddLoop(nil)
    ArAddMoveBy(loop1, 'Rot', 1, 90)
    param.k = ArAddAnimator({loop1})
  else
    ArStepAnimator(param, param.k)
  end
end

AnimJump = {}

AnimJump.OnStep = function(param)
  if (nil == param.k) then
    local loop1 = ArAddLoop(nil, 1)
    ArAddMoveBy(loop1, 'Pos', 0.25, 0, -64)
    ArAddMoveBy(loop1, 'Pos', 0.25, 0, 64).ease = ArEaseOutBounce
    ArAddCall(loop1, 'AcKillAnimScript', 0)
    param.k = ArAddAnimator({loop1})
  else
    ArStepAnimator(param, param.k)
  end
end

AnimFadeToColor = {}

AnimFadeToColor.OnStep = function(param)
  if (nil == param.k) then
    local loop1 = ArAddLoop(nil, 1)
    ArAddMoveTo(loop1, 'BgColor', 1, param.fade_to_color).lerp = LerpARgb
    ArAddCall(loop1, 'AcKillAnimScript', 0)
    param.k = ArAddAnimator({loop1})
  else
    ArStepAnimator(param, param.k)
  end
end

AnimFadeToBlack = {}

AnimFadeToBlack.OnStep = function(param)
  if (nil == param.fade_to_color) then
    param.fade_to_color = COLOR_BLACK
  end
  AnimFadeToColor.OnStep(param)
end

AnimFadeToWhite = {}

AnimFadeToWhite.OnStep = function(param)
  if (nil == param.fade_to_color) then
    param.fade_to_color = COLOR_WHITE
  end
  AnimFadeToColor.OnStep(param)
end

AnimShadow = {}

AnimShadow.OnStep = function(param)
  if (nil == param.k) then
    local loop1 = ArAddLoop(nil)
    ArAddMoveTo(loop1, 'Scale', 3 + 2 * math.random(), .8, .8).ease = ArEaseOutBounce
    ArAddCall(loop1, 'AcKillAnimScript', 0)
    param.k = ArAddAnimator({loop1})
  else
    ArStepAnimator(param, param.k)
  end
end

AnimFish = {}

AnimFish.OnStep = function(param)
  local prev_dirx = param.dirx
  BouncingObj.OnStep(param)
  if (prev_dirx ~= param.dirx) then
    local dir = 1
    if (0 > param.dirx) then
      dir = -1
    end
    Good.SetScale(param._id, dir, 1)
  end
end

AnimConsoleCursor = {}

AnimConsoleCursor.OnStep = function(param)
  if (nil == param.k) then
    local loop1 = ArAddLoop(nil)
    ArAddMoveTo(loop1, 'BgColor', 0.25, COLOR_BLACK).lerp = LerpARgb
    ArAddMoveTo(loop1, 'BgColor', 0.25, COLOR_WHITE).lerp = LerpARgb
    param.k = ArAddAnimator({loop1})
  else
    ArStepAnimator(param, param.k)
  end
end
