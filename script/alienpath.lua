local MAX_ALIEN = 6
local RPS_SIZE = 42

local ufo_tex_id = 66
local paper_tex_id = 358
local scissor_tex_id = 359
local stone_tex_id = 360

local weapon_tex_id = {paper_tex_id, scissor_tex_id, stone_tex_id}

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
    if (nil ~= param.obj[i] and PtInObj(x, y, param.obj[i])) then
      if (not CanHitAlien(param.obj[i])) then
        break
      end
      GenFlyUpObj(param.obj[i], ufo_tex_id)
      param.hit = param.hit + 1
      Good.KillObj(param.obj[i])
      param.obj[i] = nil
      if (MAX_ALIEN == param.hit) then
        -- TODO: pass to next scene.
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
  local can_hit = {false, false, HasBackScratcher()}
  param.hit = 0
  param.obj = {}
  local w, h = Resource.GetTexSize(ufo_tex_id)
  for i = 1, MAX_ALIEN do
    local o = Good.GenObj(-1, ufo_tex_id, 'BouncingObj')
    local x = math.random(SCR_W - w)
    local y = math.random(SCR_H - h)
    Good.SetPos(o, x, y)
    local index = 1 + (i % #weapon_tex_id)
    local rps = Good.GenObj(o, weapon_tex_id[index])
    local sw, sh = ScaleToSize(rps, RPS_SIZE, RPS_SIZE)
    Good.SetPos(rps, (w - sw)/2, h - sh)
    Good.GetParam(o).can_hit = can_hit[index]
    param.obj[i] = o
  end
end

function GenWeaponIcon(x, y, tex_id, has)
  local o = Good.GenObj(-1, tex_id)
  Good.SetPos(o, x, y)
  local sz = RPS_SIZE / 1.5
  ScaleToSize(o, sz, sz)
  if (not has) then
    Good.SetAlpha(o, 100)
  end
  x = x + sz + 2
  return x, y
end

function GenWeaponIcons()
  local has = {HasBackScratcher(), false, false}
  local x, y = 0, 0
  for i = 1, #weapon_tex_id do
    x, y = GenWeaponIcon(x, y, weapon_tex_id[i], has[i])
  end
end