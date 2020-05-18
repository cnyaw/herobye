local DICE_SZ = 64
local WAIT_TIME = 50
local TILE_SZ = 64
local NUM_TILE_POS = 20
local USER_MOVE_SPEED = 12

local TILE_POS = {0,0, 1,0, 2,0, 3,0, 4,0, 5,0, 6,0, 7,0, 7,1, 7,2, 7,3, 6,3, 5,3,
                  4,3, 3,3, 2,3, 1,3, 0,3, 0,2, 0,1}

local dice1_obj_id = 171
local dice2_obj_id = 174
local user_obj_id = 172

local user_sw, user_sh
local user_pos, new_user_pos
local user_move_time

local function CalCTilePos(p)
  return ((p - 1) % NUM_TILE_POS) + 1
end

local function GetTilePos(p)
  local i = 2 * (p - 1) + 1
  return TILE_SZ * TILE_POS[i], TILE_SZ * TILE_POS[i + 1]
end

local function RandDice(o)
  local n = math.random(1, 6)
  Good.SetDim(o, DICE_SZ * (n - 1), 0, DICE_SZ, DICE_SZ)
  return n
end

local function RandTilePos()
  return math.random(1, NUM_TILE_POS)
end

local function RollDice()
  local n1 = RandDice(dice1_obj_id)
  local n2 = RandDice(dice2_obj_id)
  return n1 + n2
end

local function SetUserMoveToPath()
  Good.SetScript(user_obj_id, 'AnimTempleMoveUser')
end

local function SetUserPos()
  local x, y = GetTilePos(user_pos)
  Good.SetPos(user_obj_id, x + (TILE_SZ-user_sw)/2, y + (TILE_SZ-user_sh)/2)
end

AnimTempleMoveUser = {}

AnimTempleMoveUser.OnStep = function(param)
  if (nil == param.k) then
    local loop1 = ArAddLoop(nil)
    local p = CalCTilePos(user_pos)
    while p ~= new_user_pos do
      p = CalCTilePos(p + 1)
      local x, y = GetTilePos(p)
      ArAddMoveTo(loop1, 'Pos', USER_MOVE_SPEED / 60, x + (TILE_SZ-user_sw)/2, y + (TILE_SZ-user_sh)/2)
    end
    ArAddCall(loop1, 'AcKillAnimScript', 0)
    param.k = ArAddAnimator({loop1})
  else
    ArStepAnimator(param, param.k)
  end
end

Temple = {}

Temple.OnCreate = function(param)
  UpdateCoinInfo(param)
  RollDice()
  user_sw, user_sh = ScaleToSize(user_obj_id, TILE_SZ, TILE_SZ)
  user_pos = RandTilePos()
  SetUserPos()
  param.step = TempleOnStep
end

Temple.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, MAIN_MAP_LVL_ID)
    return
  end
  param.step(param)
end

function TempleOnStep(param)
  if (Input.IsKeyPushed(Input.LBUTTON)) then
    param.step = TempleOnStepRollDice
  end
end

function TempleOnStepMoveUser(param)
  if (not WaitTimer(param, user_move_time)) then
    return
  end
  user_pos = new_user_pos
  param.step = TempleOnStep
end

function TempleOnStepRollDice(param)
  local n = RollDice()
  if (not WaitTimer(param, WAIT_TIME)) then
    return
  end
  user_move_time = n * USER_MOVE_SPEED
  new_user_pos = CalCTilePos(user_pos + n)
  SetUserMoveToPath()
  param.step = TempleOnStepMoveUser
end
