local dummy_obj_id = 123
local left_arrow_obj_id = 121
local right_arrow_obj_id = 122
local up_arrow_obj_id = 124
local down_arrow_obj_id = 125
local well_obj_id = 126
local mirror_obj_id = 185

local arrow_obj = {left_arrow_obj_id, right_arrow_obj_id, up_arrow_obj_id, down_arrow_obj_id}
local arrow_dir = {0, SCR_H, 2 * SCR_W, SCR_H, SCR_W, 0, SCR_W, 2 * SCR_H}

local exit_path = '23323323'            -- See i_cave_maze_book for the path.(1left,2right,3up,4down)
local mirror_path = '333333'
local curr_path = ''
CaveMaze = {}

CaveMaze.OnCreate = function(param)
  curr_path = ''
  param.well_x, param.well_y = Good.GetPos(well_obj_id)
  Good.SetVisible(well_obj_id, 0)
  param.mirror_x, param.mirror_y = Good.GetPos(mirror_obj_id)
  Good.SetVisible(mirror_obj_id, 0)
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
  QuestOnStep(lx + x, ly + y)
end

function CaveMazeScrollTo(param, dir)
  param.tx, param.ty = GetMazeDirOffset(dir)
  Good.SetScript(param._id, 'AnimCaveMazeScroll')
end

function CheckMovePath_i(dir, o, x, y)
  Good.SetVisible(o, 1)
  local ox, oy = GetMazeDirOffset(dir)
  Good.SetPos(o, x + ox, y + oy)
end

function CheckMovePath(param, dir)
  curr_path = curr_path .. tostring(dir)
  if (IsExitMazePath()) then
    CheckMovePath_i(dir, well_obj_id, param.well_x, param.well_y)
  elseif (IsMirrorPath()) then
    CheckMovePath_i(dir, mirror_obj_id, param.mirror_x, param.mirror_y)
  end
end

function CenterMaze(param)
  if (IsWrongMazePath()) then
    curr_path = string.sub(curr_path, string.len(curr_path - 1))
    Good.SetVisible(well_obj_id, 0)
    Good.SetVisible(mirror_obj_id, 0)
  elseif (IsExitMazePath()) then
    Good.SetPos(well_obj_id, param.well_x + SCR_W, param.well_y + SCR_H)
  elseif (IsMirrorPath()) then
    Good.SetPos(mirror_obj_id, param.mirror_x + SCR_W, param.mirror_y + SCR_H)
  end
  Good.SetPos(param._id, SCR_W, SCR_H)
  Good.SetPos(dummy_obj_id, SCR_W, SCR_H)
end

function GetMazeDirOffset(dir)
  local x = arrow_dir[2 * (dir - 1) + 1]
  local y = arrow_dir[2 * (dir - 1) + 2]
  return x, y
end

function IsExitMazePath()
  return curr_path == exit_path
end

function IsMirrorPath()
  return curr_path == mirror_path
end

function IsWrongMazePath_i(s)
  return string.len(curr_path) > string.len(s) or
         curr_path ~= string.sub(s, 1, string.len(curr_path))
end

function IsWrongMazePath()
  return IsWrongMazePath_i(exit_path) and IsWrongMazePath_i(mirror_path)
end
