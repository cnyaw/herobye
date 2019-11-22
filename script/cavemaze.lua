local dummy_obj_id = 123
local left_arrow_obj_id = 121
local right_arrow_obj_id = 122
local up_arrow_obj_id = 124
local down_arrow_obj_id = 125
local well_obj_id = 126

local under_world_talk_id = 2111

local arrow_obj = {left_arrow_obj_id, right_arrow_obj_id, up_arrow_obj_id, down_arrow_obj_id}
local arrow_dir = {0, SCR_H, 2 * SCR_W, SCR_H, SCR_W, 0, SCR_W, 2 * SCR_H}

local exit_path = '23323323'            -- See i_cave_maze_book for the path.
local curr_path = ''

CaveMaze = {}

CaveMaze.OnCreate = function(param)
  curr_path = ''
  param.wx, param.wy = Good.GetPos(well_obj_id)
  Good.SetVisible(well_obj_id, 0)
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
      CheckMovePath(param, i)
      CaveMazeScrollTo(param, i)
      return
    end
  end
  local lx,ly = Good.GetPos(param._id)
  if (PtInObj(lx + x, ly + y, well_obj_id)) then
    StartTalk(under_world_talk_id)
  end
end

function CaveMazeScrollTo(param, dir)
  param.tx, param.ty = GetMazeDirOffset(dir)
  Good.SetScript(param._id, 'AnimCaveMazeScroll')
end

function CheckMovePath(param, dir)
  curr_path = curr_path .. tostring(dir)
  if (IsCorrectMazePath()) then
    Good.SetVisible(well_obj_id, 1)
    local x, y = GetMazeDirOffset(dir)
    Good.SetPos(well_obj_id, param.wx + x, param.wy + y)
  end
end

function CenterMaze(param)
  if (IsWrongMazePath()) then
    curr_path = ''
    Good.SetVisible(well_obj_id, 0)
  elseif (IsCorrectMazePath()) then
    Good.SetPos(well_obj_id, param.wx + SCR_W, param.wy + SCR_H)
  end
  Good.SetPos(param._id, SCR_W, SCR_H)
  Good.SetPos(dummy_obj_id, SCR_W, SCR_H)
end

function GetMazeDirOffset(dir)
  local x = arrow_dir[2 * (dir - 1) + 1]
  local y = arrow_dir[2 * (dir - 1) + 2]
  return x, y
end

function IsCorrectMazePath()
  return curr_path == exit_path
end

function IsWrongMazePath()
  return string.len(curr_path) > string.len(exit_path) or
         curr_path ~= string.sub(exit_path, 1, string.len(curr_path))
end
