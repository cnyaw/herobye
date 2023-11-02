local WAIT_TIME = 60
local PUZZLE_W, PUZZLE_H = 320, 320
local MAX_COL, MAX_ROW = 3, 3

local x,y = (SCR_W - PUZZLE_W)/2, (SCR_H - PUZZLE_H)/2
local w,h = PUZZLE_W/MAX_COL, PUZZLE_H/MAX_ROW

local universe_tex_id = 199
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
  if (nil ~= puzzle_tex_id) then
    return
  end
  local canvas = Graphics.GenCanvas(PUZZLE_W, PUZZLE_H)
  FillImage(canvas, 0, 0, universe_tex_id, PUZZLE_W, PUZZLE_H)
  FillImage(canvas, 0, 0, DIPSY_TEX_ID, PUZZLE_W, PUZZLE_H)
  local tw, th = PUZZLE_W/MAX_COL, PUZZLE_H/MAX_ROW
  for i = 0, MAX_COL-1 do
    for j = 0, MAX_ROW-1 do
      Graphics.DrawText(canvas, i *tw, j* th, string.format('%d', 1+i+j*MAX_COL))
    end
  end
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

local function PuzzleGameEnd(param)
  if (WaitTimer(param, WAIT_TIME)) then
    StartTalk(found_dipsy_talk_id)
  end
end

local function PuzzleGamePlay(param)
  if (Input.IsKeyPushed(Input.LBUTTON)) then
    local mx,my = Input.GetMousePos()
    local xx, yy = x + (1 + w) * (blank % MAX_COL), y + (1 + h) * math.floor(blank / MAX_COL)
    if (PtInRect(mx, my, xx - w, yy, xx, yy + h)) then
      MoveRight()
    elseif (PtInRect(mx, my, xx, yy - h, xx + w, yy)) then
      MoveDown()
    elseif (PtInRect(mx, my, xx + w, yy, xx + 2 * w, yy + h)) then
      MoveLeft()
    elseif (PtInRect(mx, my, xx, yy + h, xx + w, yy + 2 * h)) then
      MoveUp()
    end
    if (IsPuzzleComplete()) then
      param.step = PuzzleGameEnd
    end
  end
end

PuzzleGame = {}

PuzzleGame.OnCreate = function(param)
  GenPuzzleTex()
  GenPuzzle()
  param.step = PuzzleGamePlay
end

PuzzleGame.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, JANKEN_PLANET_LVL_ID)
    return
  end
  param.step(param)
end
