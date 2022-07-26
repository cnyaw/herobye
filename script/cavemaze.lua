local dummy_obj_id = 123
local left_arrow_obj_id = 121
local right_arrow_obj_id = 122
local up_arrow_obj_id = 124
local down_arrow_obj_id = 125
local well_obj_id = 126
local mirror_obj_id = 185
local ladder_obj_id = 417

local arrow_obj = {left_arrow_obj_id, right_arrow_obj_id, up_arrow_obj_id, down_arrow_obj_id}
local arrow_dir = {0, SCR_H, 2 * SCR_W, SCR_H, SCR_W, 0, SCR_W, 2 * SCR_H}

local path_data = {                     -- See i_cave_maze_book for the path.(1left,2right,3up,4down)
  [1] = {well_obj_id, '23323323'},
  [2] = {mirror_obj_id, '333333'},
  [3] = {ladder_obj_id, '444'},
}

local curr_path = ''

CaveMaze = {}

CaveMaze.OnCreate = function(param)
  curr_path = ''
  param.x = {}
  param.y = {}
  for i = 1, #path_data do
    local p = path_data[i]
    param.x[i], param.y[i] = Good.GetPos(p[1])
    Good.SetVisible(p[1], Good.INVISIBLE)
  end
  CenterMaze(param)
  QuestOnCreate()
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
      CheckMovePath(param, i)
      CaveMazeScrollTo(param, i)
      return
    end
  end
  local lx,ly = Good.GetPos(param._id)
  if (PtInObj(lx + x, ly + y, ladder_obj_id)) then
    Good.GenObj(-1, CAVE_FIELD_LVL_ID)
    return
  end
  QuestOnStep(lx + x, ly + y)
end

function CaveMazeScrollTo(param, dir)
  param.tx, param.ty = GetMazeDirOffset(dir)
  Good.SetScript(param._id, 'AnimCaveMazeScroll')
end

function CheckMovePath_i(dir, o, x, y)
  Good.SetVisible(o, Good.VISIBLE)
  local ox, oy = GetMazeDirOffset(dir)
  Good.SetPos(o, x + ox, y + oy)
end

function CheckMovePath(param, dir)
  if (4 == dir) then                    -- Move down to exit maze.
    curr_path = path_data[3][2];
  else
    curr_path = curr_path .. tostring(dir)
  end
  for i = 1, #path_data do
    local p = path_data[i]
    if (p[2] == curr_path) then
      CheckMovePath_i(dir, p[1], param.x[i], param.y[i])
      return
    end
  end
end

function CenterMaze(param)
  if (IsWrongMazePath()) then
    curr_path = string.sub(curr_path, string.len(curr_path) - 1)
  else
    for i = 1, #path_data do
      local p = path_data[i]
      if (p[2] == curr_path) then
        Good.SetPos(p[1], param.x[i] + SCR_W, param.y[i] + SCR_H)
        break
      end
    end
  end
  Good.SetPos(param._id, SCR_W, SCR_H)
  Good.SetPos(dummy_obj_id, SCR_W, SCR_H)
end

function GetMazeDirOffset(dir)
  local x = arrow_dir[2 * (dir - 1) + 1]
  local y = arrow_dir[2 * (dir - 1) + 2]
  return x, y
end

function IsWrongMazePath_i(s)
  return string.len(curr_path) > string.len(s) or
         curr_path ~= string.sub(s, 1, string.len(curr_path))
end

function IsWrongMazePath()
  for i = 1, #path_data do
    local p = path_data[i]
    if (not IsWrongMazePath_i(p[2])) then
      return false
    else
      Good.SetVisible(p[1], Good.INVISIBLE)
    end
  end
  return true
end
