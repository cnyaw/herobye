local dummy_obj_id = 123
local left_arrow_obj_id = 121
local right_arrow_obj_id = 122
local up_arrow_obj_id = 124
local down_arrow_obj_id = 125

local arrow_obj = {left_arrow_obj_id, right_arrow_obj_id, up_arrow_obj_id, down_arrow_obj_id}
local arrow_dir = {0, SCR_H, 2 * SCR_W, SCR_H, SCR_W, 0, SCR_W, 2 * SCR_H}

CaveMaze = {}

CaveMaze.OnCreate = function(param)
  CenterMaze(param)
end

CaveMaze.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, CAVE_FIELD_LVL_ID)
    return
  end
  if (Input.IsKeyPressed(Input.LBUTTON)) then
    CaveMazeHittest(param)
  end
end

function CaveMazeHittest(param)
  local x,y = Input.GetMousePos()
  for i = 1, #arrow_obj do
    if (PtInObj(x, y, arrow_obj[i])) then
      CaveMazeScrollTo(param, i)
      return
    end
  end
end

function CaveMazeScrollTo(param, dir)
  param.tx = arrow_dir[2 * (dir - 1) + 1]
  param.ty = arrow_dir[2 * (dir - 1) + 2]
  Good.SetScript(param._id, 'AnimCaveMazeScroll')
end

function CenterMaze(param)
  Good.SetPos(param._id, SCR_W, SCR_H)
  Good.SetPos(dummy_obj_id, SCR_W, SCR_H)
end
