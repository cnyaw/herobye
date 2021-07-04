local MAX_BAT = 8
local BULLET_SPEED = 2.5

local bat_tex_id = 255
local net_tex_id = 286
local gun_obj_id = 299
local pass_talk_id = 3403

local BULLET_SIZE_X, BULLET_SIZE_Y

local bullet_obj = nil

local function OnHitBat(param, o)
  Good.KillObj(bullet_obj)
  bullet_obj = nil
end

local function BatGunBulletHitTest(param)
  if (nil == bullet_obj) then
    return false
  end
  local x, y = Good.GetPos(bullet_obj)
  return BounceGameHittest(param, x, y, OnHitBat)
end

local function FireBatGunBullet()
  if (nil ~= bullet_obj) then
    return
  end
  local o = Good.GenObj(-1, net_tex_id)
  Good.SetPos(o, (SCR_W - BULLET_SIZE_X)/2, SCR_H - 48 - BULLET_SIZE_Y)
  bullet_obj = o
end

local function MoveBatGunBullet()
  if (nil == bullet_obj) then
    return
  end
  local x, y = Good.GetPos(bullet_obj)
  y = y - BULLET_SPEED
  if (y - BULLET_SIZE_Y < -BULLET_SIZE_Y) then
    Good.KillObj(bullet_obj)
    bullet_obj = nil
    return
  end
  Good.SetPos(bullet_obj, x, y)
end

BatCave = {}

BatCave.OnCreate = function(param)
  bullet_obj = nil
  BounceGameInit(param, MAX_BAT, bat_tex_id)
  BULLET_SIZE_X, BULLET_SIZE_Y = Resource.GetTexSize(net_tex_id)
end

BatCave.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, BAT_CAVE_FIELD_LVL_ID)
    return
  end
  MoveBatGunBullet()
  if (Input.IsKeyPushed(Input.LBUTTON)) then
    local x,y = Input.GetMousePos()
    if (PtInObj(x, y, gun_obj_id)) then
      FireBatGunBullet()
    end
  end
  if (BatGunBulletHitTest(param)) then
    if (MAX_BAT == param.hit) then
      StartTalk(pass_talk_id)
    end
  end
end
