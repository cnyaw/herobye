local MAX_ALIEN = 6
local RPS_SIZE = 42

local to_alien_area_obj_id = 70

local weapon_tex_id = {PAPER_TEX_ID, SCISSOR_TEX_ID, STONE_TEX_ID}

AlienPath = {}

AlienPath.OnCreate = function(param)
  GenAliens(param)
  GenWeaponIcons()
  QuestOnCreate()
end

AlienPath.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    return
  end
  if (Input.IsKeyPushed(Input.LBUTTON)) then
    local x, y = Input.GetMousePos()
    if (QuestOnStep(x, y)) then
      return
    end
    AlienPathHittest(param, x, y)
    return
  end
end

function AlienPathHittest(param, x, y)
  for i = 1, MAX_ALIEN do
    local o = param.obj[i]
    if (nil ~= o and PtInObj(x, y, o)) then
      if (not CanHitAlien(o)) then
        break
      end
      GenFlyUpObj(o, UFO_TEX_ID)
      param.hit = param.hit + 1
      Good.KillObj(o)
      param.obj[i] = nil
      if (MAX_ALIEN == param.hit) then
        Good.SetVisible(to_alien_area_obj_id, 1)
      end
      break
    end
  end
end

function CanHitAlien(o)
  local param = Good.GetParam(o)
  return param.can_hit
end

function GenAliens(param)
  BounceGameInit(param, MAX_ALIEN, UFO_TEX_ID, GenAlienSubobj)
end

function GenAlienSubobj(o, i)
  local can_hit = {HasPowerScissor(), HasMallet(), HasBackScratcher()}
  local w, h = Resource.GetTexSize(UFO_TEX_ID)
  local index = 1 + (i % #weapon_tex_id)
  local rps = Good.GenObj(o, weapon_tex_id[index])
  local sw, sh = ScaleToSize(rps, RPS_SIZE, RPS_SIZE)
  Good.SetPos(rps, (w - sw)/2, h - sh)
  Good.GetParam(o).can_hit = can_hit[index]
end

function GenWeaponIcon(x, y, tex_id, has)
  local o = Good.GenObj(-1, tex_id)
  Good.SetPos(o, x, y)
  local sz = RPS_SIZE / 1.5
  ScaleToSize(o, sz, sz)
  if (not has) then
    Good.SetBgColor(o, 0xff000000)
  end
  x = x + sz + 2
  return x, y
end

function GenWeaponIcons()
  local has = {HasBackScratcher(), HasPowerScissor(), HasMallet()}
  local x, y = 0, 0
  for i = 1, #weapon_tex_id do
    x, y = GenWeaponIcon(x, y, weapon_tex_id[i], has[i])
  end
end
