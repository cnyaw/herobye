local WAIT_TIME = 100
local RPS_SIZE = 48
local CHECK_FIGHT_COUND = 10

local ufo_obj_id = 76
local win_talk_id = 2201

local weapon_tex_id = {PAPER_TEX_ID, SCISSOR_TEX_ID, STONE_TEX_ID}

local curr_weapon_index = nil
local weapon_obj = nil
local btn_obj = {80, 81, 82}

AlienBoss = {}

AlienBoss.OnCreate = function(param)
  curr_weapon_index = math.random(#weapon_tex_id)
  weapon_obj = Good.GenObj(ufo_obj_id, weapon_tex_id[curr_weapon_index])
  local sw, sh = ScaleToSize(weapon_obj, RPS_SIZE, RPS_SIZE)
  local w, h = Resource.GetTexSize(UFO_TEX_ID)
  Good.SetPos(weapon_obj, (w - sw)/2, h - sh)
  SetUfoFightCount(param, 0)
  param.step = AlienBossOnStepInput
end

AlienBoss.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, ALIEN_AREA_LVL_ID)
    return
  end
  if (WaitTimer(param, WAIT_TIME)) then
    RandUfoWeapon()
  end
  param.step(param)
end

function AlienBossHittest(param)
  local x, y = Input.GetMousePos()
  for i = 1, #btn_obj do
    if (PtInObj(x, y, btn_obj[i])) then
      ValidateAlienBossHittest(param, i)
      RandUfoWeapon()
      param.wait_time = nil
      return
    end
  end
end

function AlienBossOnStepInput(param)
  if (Input.IsKeyPushed(Input.LBUTTON)) then
    AlienBossHittest(param)
  end
  if (CHECK_FIGHT_COUND <= param.counter_dummy_count) then
    param.step = AlienBossOnStepWin
  end
end

function AlienBossOnStepWin(param)
  if (not WaitTimer(param, WAIT_TIME)) then
    return
  end
  StartTalk(win_talk_id)
end

function RandUfoWeapon()
  local index = curr_weapon_index
  while (index == curr_weapon_index) do
    curr_weapon_index = math.random(#weapon_tex_id)
  end
  Good.SetTexId(weapon_obj, weapon_tex_id[curr_weapon_index])
end

function SetUfoFightCount(param, c)
  param.counter_dummy_count = c
  UpdateCounterDummyUi(param, UFO_TEX_ID, CHECK_FIGHT_COUND, 0.3)
end

function ValidateAlienBossHittest(param, btn_index)
  if (btn_index == curr_weapon_index) then
    SetUfoFightCount(param, param.counter_dummy_count + 1)
  else
    SetUfoFightCount(param, 0)
  end
end
