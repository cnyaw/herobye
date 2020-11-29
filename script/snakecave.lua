local MAX_SNAKE = 4

local hero_obj_id = 395
local move_down_btn_obj_id = 403
local move_up_btn_obj_id = 396
local pass_talk_id = 3404
local snake_tex_id = 391

local hero_init_x, hero_init_y

local function HittestSnake(param)
  local l,t,w,h = Good.GetDim(hero_obj_id)
  local x, y = Good.GetPos(hero_obj_id)
  x = x + w/2
  y = y + h/2
  for i = 1, MAX_SNAKE do
    local o = param.obj[i]
    if (nil ~= o and PtInObj(x, y, o)) then
      return true
    end
  end
  return false
end

local function HeroReachGoal()
  local x, y = Good.GetPos(hero_obj_id)
  return 5 >= y
end

local function InitSnake(o)
  local param = Good.GetParam(o)
  if (0 > param.dirx) then
    Good.SetScale(o, -1, 1)
  end
  Good.SetScript(o, 'AnimFish')
end

local function MoveHeroDown()
  local x, y = Good.GetPos(hero_obj_id)
  local l,t,w,h = Good.GetDim(hero_obj_id)
  if (y + h >= SCR_H) then
    return
  end
  y = y + 1
  Good.SetPos(hero_obj_id, x, y)
end

local function MoveHeroUp()
  local x, y = Good.GetPos(hero_obj_id)
  if (0 >= y) then
    return
  end
  y = y - 1
  Good.SetPos(hero_obj_id, x, y)
end

local function MoveHero()
  if (Input.IsKeyDown(Input.LBUTTON)) then
    local x, y = Input.GetMousePos()
    if (PtInObj(x, y, move_down_btn_obj_id)) then
      MoveHeroDown()
    end
    if (PtInObj(x, y, move_up_btn_obj_id)) then
      MoveHeroUp()
    end
  end
end

local function ResetHeroPos()
  Good.SetPos(hero_obj_id, hero_init_x, hero_init_y)
end

SnakeCave = {}

SnakeCave.OnCreate = function(param)
  BounceGameInit(param, MAX_SNAKE, snake_tex_id, InitSnake)
  hero_init_x, hero_init_y = Good.GetPos(hero_obj_id)
end

SnakeCave.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, BAT_CAVE_FIELD_LVL_ID)
    return
  end
  MoveHero()
  if (HittestSnake(param)) then
    ResetHeroPos()
    return
  end
  if (HeroReachGoal()) then
    StartTalk(pass_talk_id)
  end
end
