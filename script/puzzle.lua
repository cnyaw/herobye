local PUZZLE_W, PUZZLE_H = 320, 320

local x,y = (SCR_W - PUZZLE_W)/2, (SCR_H - PUZZLE_H)/2
local w,h = PUZZLE_W/3, PUZZLE_H/3

local blank = 8 -- position of blank piece

local puzzle_tex_id = nil

local function GenPuzzle()
  local a
  for i= 1, 9 do
    local ii = i - 1
    if (9 == i) then
      a = GenColorObj(-1, w, h, COLOR_BLACK)
    else
      a = GenTexObj(-1, puzzle_tex_id, w, h, w * (ii % 3), h * math.floor(ii / 3))
    end
    Good.SetPos(a, x + (1 + w) * (ii % 3), y + (1 + h) * math.floor(ii / 3))
  end
end

local function GenPuzzleTex()
  local canvas = Graphics.GenCanvas(PUZZLE_W, PUZZLE_H)
  Graphics.FillRect(canvas, 0, 0, PUZZLE_W, PUZZLE_H, COLOR_PURPLE)
  FillImage(canvas, 0, 0, DIPSY_TEX_ID, PUZZLE_W, PUZZLE_H)
  puzzle_tex_id = Resource.GenTex(canvas)
  Graphics.KillCanvas(canvas)
end

local function MoveDown()
  if (0 == blank or 1 == blank or 2 == blank) then
    return
  end
  local xx, yy = x + (1 + w) * (blank % 3), y + (1 + h) * math.floor(blank / 3)
  local b = Good.PickObj(xx, yy, Good.COLBG)
  local a = Good.PickObj(xx, yy - h - 1, Good.TEXBG)
  Good.SetPos(b, xx, yy - h - 1)
  Good.SetPos(a, xx, yy)
  blank = blank - 3
end

local function MoveLeft()
  if (2 == blank or 5 == blank or 8 == blank) then
    return
  end
  local xx, yy = x + (1 + w) * (blank % 3), y + (1 + h) * math.floor(blank / 3)
  local b = Good.PickObj(xx, yy, Good.COLBG)
  local a = Good.PickObj(xx + w + 1, yy, Good.TEXBG)
  Good.SetPos(b, xx + w + 1, yy)
  Good.SetPos(a, xx, yy)
  blank = blank + 1
end

local function MoveRight()
  if (0 == blank or 3 == blank or 6 == blank) then
    return
  end
  local xx, yy = x + (1 + w) * (blank % 3), y + (1 + h) * math.floor(blank / 3)
  local b = Good.PickObj(xx, yy, Good.COLBG)
  local a = Good.PickObj(xx - w - 1, yy, Good.TEXBG)
  Good.SetPos(b, xx - w - 1, yy)
  Good.SetPos(a, xx, yy)
  blank = blank - 1
end

local function MoveUp()
  if (6 == blank or 7 == blank or 8 == blank) then
    return
  end
  local xx, yy = x + (1 + w) * (blank % 3), y + (1 + h) * math.floor(blank / 3)
  local b = Good.PickObj(xx, yy, Good.COLBG)
  local a = Good.PickObj(xx, yy + h + 1, Good.TEXBG)
  Good.SetPos(b, xx, yy + h + 1)
  Good.SetPos(a, xx, yy)
  blank = blank + 3
end

local function ShufflePuzzle()
  for i=1, 150 do
    local m = math.random(1,4)
    if (1 == m) then
      MoveLeft()
    elseif (2 == m) then
      MoveRight()
    elseif (3 == m) then
      MoveDown()
    else
      MoveUp()
    end
  end
end

PuzzleGame = {}

PuzzleGame.OnCreate = function(param)
  GenPuzzleTex()
  GenPuzzle()
  ShufflePuzzle()
end

PuzzleGame.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, JANKEN_PLANET_LVL_ID)
    return
  end
  if (Input.IsKeyPushed(Input.LBUTTON)) then
    local mx,my = Input.GetMousePos()
    local xx, yy = x + (1 + w) * (blank % 3), y + (1 + h) * math.floor(blank / 3) -- blank pos
    if (mx >= xx - w and mx < xx and my >= yy and my < yy + h) then
      MoveRight()
    elseif (mx >= xx and mx < xx + w and my >= yy - h and my < yy) then
      MoveDown()
    elseif (mx >= xx + w and mx < xx + 2 * w and my >= yy and my < yy + h) then
      MoveLeft()
    elseif (mx >= xx and mx < xx + w and my >= yy + h and my < yy + 2 * h) then
      MoveUp()
    end
  end
end
