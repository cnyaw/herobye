local PUZZLE_W, PUZZLE_H = 320, 320
local MAX_COL, MAX_ROW = 3, 3

local x,y = (SCR_W - PUZZLE_W)/2, (SCR_H - PUZZLE_H)/2
local w,h = PUZZLE_W/MAX_COL, PUZZLE_H/MAX_ROW

local puzzle_tex_id = nil
local found_dipsy_talk_id = 2902

local blank = 8                         -- Position of blank piece.
local puzzle = {}
local puzzle_obj = nil

local function SwapPiece(i, j)
  local tmp = puzzle[i]
  puzzle[i] = puzzle[j]
  puzzle[j] = tmp
end

local function MovePiece(dir)
  local col = blank % MAX_COL
  local row = math.floor(blank / MAX_COL)
  if (1 == dir) then                    -- Up.
    if (MAX_ROW - 1 ~= row) then
      SwapPiece(blank, blank + MAX_COL)
      blank = blank + MAX_COL
    end
  elseif (2 == dir) then                -- Down.
    if (0 ~= row) then
      SwapPiece(blank, blank - MAX_COL)
      blank = blank - MAX_COL
    end
  elseif (3 == dir) then                -- Left.
    if (MAX_COL - 1 ~= col) then
      SwapPiece(blank, blank + 1)
      blank = blank + 1
    end
  elseif (4 == dir) then                -- Right
    if (0 ~= col) then
      SwapPiece(blank, blank - 1)
      blank = blank - 1
    end
  end
end

local function GenPuzzleObj()
  if (nil ~= puzzle_obj) then
    Good.KillObj(puzzle_obj)
    puzzle_obj = nil
  end
  puzzle_obj = Good.GenDummy(-1)
  for i = 0, MAX_COL * MAX_ROW - 1 do
    local p = puzzle[i]
    if (i == blank) then
      a = GenColorObj(puzzle_obj, w, h, COLOR_BLACK)
    else
      a = GenTexObj(puzzle_obj, puzzle_tex_id, w, h, w * (p % 3), h * math.floor(p / 3))
    end
    Good.SetPos(a, x + (1 + w) * (i % 3), y + (1 + h) * math.floor(i / 3))
  end
end

local function GenPuzzle()
  for i = 0, MAX_COL * MAX_ROW - 1 do
    puzzle[i] = i
  end
  for i = 1, 100 do
    MovePiece(math.random(1, 4))
  end
  GenPuzzleObj()
end

local function GenPuzzleTex()
  local canvas = Graphics.GenCanvas(PUZZLE_W, PUZZLE_H)
  Graphics.FillRect(canvas, 0, 0, PUZZLE_W, PUZZLE_H, COLOR_PURPLE)
  FillImage(canvas, 0, 0, DIPSY_TEX_ID, PUZZLE_W, PUZZLE_H)
  puzzle_tex_id = Resource.GenTex(canvas)
  Graphics.KillCanvas(canvas)
end

local function IsPuzzleComplete()
  for i = 0, MAX_COL * MAX_ROW - 1 do
    if (puzzle[i] ~= i) then
      return false
    end
  end
  return true
end

local function MoveDown()
  MovePiece(2)
  GenPuzzleObj()
end

local function MoveLeft()
  MovePiece(3)
  GenPuzzleObj()
end

local function MoveRight()
  MovePiece(4)
  GenPuzzleObj()
end

local function MoveUp()
  MovePiece(1)
  GenPuzzleObj()
end

PuzzleGame = {}

PuzzleGame.OnCreate = function(param)
  GenPuzzleTex()
  GenPuzzle()
end

PuzzleGame.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, JANKEN_PLANET_LVL_ID)
    return
  end
  if (Input.IsKeyPushed(Input.LBUTTON)) then
    local mx,my = Input.GetMousePos()
    local xx, yy = x + (1 + w) * (blank % MAX_COL), y + (1 + h) * math.floor(blank / MAX_COL)
    if (mx >= xx - w and mx < xx and my >= yy and my < yy + h) then
      MoveRight()
    elseif (mx >= xx and mx < xx + w and my >= yy - h and my < yy) then
      MoveDown()
    elseif (mx >= xx + w and mx < xx + 2 * w and my >= yy and my < yy + h) then
      MoveLeft()
    elseif (mx >= xx and mx < xx + w and my >= yy + h and my < yy + 2 * h) then
      MoveUp()
    end
    if (IsPuzzleComplete()) then
      StartTalk(found_dipsy_talk_id)
    end
  end
end
