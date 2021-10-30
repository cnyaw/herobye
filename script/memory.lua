local WAIT_TIME = 80
local LEN_QUIZ = 5
local SZ_INPUT_COLOR_OBJ = 40

local green_obj_id = 230
local red_obj_id = 236
local yellow_obj_id = 237
local blue_obj_id = 238
local dummy_obj_id = 231

local memory_correct_talk_id = 3002

local colors = {green_obj_id, red_obj_id, yellow_obj_id, blue_obj_id}

local function IsMemoryCorrect(param)
  for i = 1, #param.input do
    if (param.input[i] ~= param.quiz[i]) then
      return false
    end
  end
  return true
end

MemoryGame = {}

MemoryGame.OnCreate = function(param)
  param.step = MemoryGameNewQuiz
end

MemoryGame.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, JANKEN_PLANET_LVL_ID)
    return
  end
  param.step(param)
end

function MemoryGameInitQuiz(param)
  if (not WaitTimer(param, WAIT_TIME)) then
    return
  end
  local n = math.random(#colors)
  local col_obj = colors[n]
  Good.SetScript(col_obj, 'AnimJump')
  table.insert(param.quiz, n)
  local o = GenColorObj(dummy_obj_id, SZ_INPUT_COLOR_OBJ, SZ_INPUT_COLOR_OBJ, Good.GetBgColor(col_obj), 'AnimFadeToBlack')
  Good.SetAnchor(o, .5, .5)
  Good.SetPos(o, 2 * SZ_INPUT_COLOR_OBJ * #param.quiz, 0)
  table.insert(param.quiz_obj, o)
  if (LEN_QUIZ == #param.quiz) then
    param.step = MemoryGamePlay
    Good.SetScript(param.quiz_obj[1], 'AnimCursor')
  end
end

function MemoryGameNewQuiz(param)
  param.quiz = {}
  if (nil ~= param.quiz_obj) then
    for i = 1, #param.quiz_obj do
      Good.KillObj(param.quiz_obj[i])
    end
  end
  param.quiz_obj = {}
  param.input = {}
  param.step = MemoryGameInitQuiz
end

function MemoryGamePlay(param)
  if (not Input.IsKeyPushed(Input.LBUTTON)) then
    return
  end
  local x, y = Input.GetMousePos()
  for i = 1, #colors do
    if (PtInObj(x, y, colors[i])) then
      local o = param.quiz_obj[1 + #param.input]
      Good.SetScript(o, '')
      Good.SetBgColor(o, Good.GetBgColor(colors[i]));
      Good.SetRot(o, 0)
      table.insert(param.input, i)
      if (#param.input < #param.quiz) then
        Good.SetScript(param.quiz_obj[1 + #param.input], 'AnimCursor')
      else
        if (IsMemoryCorrect(param)) then
          StartTalk(memory_correct_talk_id)
        else
          param.step = MemoryGameNewQuiz
        end
      end
      return
    end
  end
end
