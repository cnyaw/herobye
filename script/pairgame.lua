local ROW_COUNT = 3
local COL_COUNT = 4
local MARGIN = 20
local WAIT_TIME = 30

local jewel_tex_id = 105

local COLORS = {COLOR_RED, COLOR_GREEN, COLOR_BLUE}
local W, H, OFFSET_X, OFFSET_Y, WW, HH

local pass_talk_id = 2501

local function ClearPair(param, i, j)
  param.colors[i] = -1
  Good.SetBgColor(param.objs[i], COLOR_BLACK)
  param.colors[j] = -1
  Good.SetBgColor(param.objs[j], COLOR_BLACK)
  param.sel_obj = nil
  param.count = param.count - 2
  return 0 == param.count
end

PairGame = {}

PairGame.OnCreate = function(param)
  W, H = Resource.GetTexSize(jewel_tex_id)
  OFFSET_X = (SCR_W - (COL_COUNT * (W + MARGIN))) / 2
  OFFSET_Y = (SCR_H - (ROW_COUNT * (H + MARGIN))) / 2
  WW, HH = W + MARGIN, H + MARGIN
  local color_offset = math.random(100)
  local objs = {}
  local colors = {}
  local obj_index = color_offset
  for i = 0, ROW_COUNT - 1 do
    for j = 0, COL_COUNT - 1 do
      local o = Good.GenObj(-1, jewel_tex_id)
      Good.SetPos(o, OFFSET_X + j * WW, OFFSET_Y + i * HH)
      local color_index = 1 + obj_index % #COLORS
      Good.SetBgColor(o, COLORS[color_index])
      objs[obj_index] = o
      colors[obj_index] = color_index
      obj_index = obj_index + 1
    end
  end
  param.color_offset = color_offset
  param.objs = objs
  param.colors = colors
  param.count = ROW_COUNT * COL_COUNT
  param.step = PairGameOnStepGame
end

PairGame.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, UNDER_WORLD_ENTRANCE_LVL_ID)
    return
  end
  param.step(param)
end

PairGameOnStepEnd = function(param)
  if (not WaitTimer(param, WAIT_TIME)) then
    return
  end
  StartTalk(pass_talk_id)
end

PairGameOnStepGame = function(param)
  if (not Input.IsKeyPushed(Input.LBUTTON)) then
    return
  end
  local x, y = Input.GetMousePos()
  local obj_index = param.color_offset
  for i = 0, ROW_COUNT - 1 do
    for j = 0, COL_COUNT - 1 do
      local x0, y0 = OFFSET_X + j * WW, OFFSET_Y + i * HH
      if (PtInRect(x, y, x0, y0, x0 + WW, y0 + HH)) then
        local color1 = param.colors[obj_index]
        if (-1 == color1) then
          return
        end
        local o = param.objs[obj_index]
        if (nil ~= param.sel_obj and param.sel_obj ~= o) then
          Good.SetScript(param.sel_obj, '')
          if (color1 == param.colors[param.sel_index]) then
            if (ClearPair(param, obj_index, param.sel_index)) then
              param.step = PairGameOnStepEnd
            end
            return
          end
        end
        param.sel_obj = o
        param.sel_index = obj_index
        Good.SetScript(o, 'AnimTalkArrow')
        return
      end
      obj_index = obj_index + 1
    end
  end
end
