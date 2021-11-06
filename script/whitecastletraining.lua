local ANIM_TIME = 4
local WAIT_TIME = 60

local tree_tex_id = 563

local dummy_obj_id = {575, 574, 576}
local horse_obj_id = 566
local left_btn_obj_id = 567
local right_btn_obj_id = 569
local tree_obj_id = 565

local function GenTree(param)
  local o = Good.GenObj(param.dummy, tree_tex_id, 'AnimTree')
  Good.SetPos(o, Good.GetPos(tree_obj_id))
  Good.SetScale(o, Good.GetScale(tree_obj_id))
  Good.SetAnchor(o, 0.5, 0.5)
  local p = Good.GetParam(o)
  p.dt = ANIM_TIME
  local target = dummy_obj_id[GetRandomTarget(param, #dummy_obj_id)]
  p.target_x, p.target_y = Good.GetPos(target)
  p.clear = function() end
end

local function MoveHorse()
  if (Input.IsKeyDown(Input.LBUTTON)) then
    local x, y = Input.GetMousePos()
    if (PtInObj(x, y, left_btn_obj_id)) then
      if (param.dir_right) then
        param.dir_right = false
        Good.SetScale(horse_obj_id, -1, 1)
      end
      local hx, hy = Good.GetPos(horse_obj_id)
      Good.SetPos(horse_obj_id, hx - 1, hy)
    elseif (PtInObj(x, y, right_btn_obj_id)) then
      if (not param.dir_right) then
        param.dir_right = true
        Good.SetScale(horse_obj_id, 1, 1)
      end
      local hx, hy = Good.GetPos(horse_obj_id)
      Good.SetPos(horse_obj_id, hx + 1, hy)
    end
  end
end

WhiteCastleTraining = {}

WhiteCastleTraining.OnCreate = function(param)
  param.dir_right = true
  param.dummy = Good.GenDummy(-1)
end

WhiteCastleTraining.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, NORTH_NATION_LVL_ID)
    return
  end
  MoveHorse()
  if (not WaitTimer(param, WAIT_TIME)) then
    return
  end
  GenTree(param)
end
