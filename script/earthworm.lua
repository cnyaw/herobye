local CHECK_COUNT = 5
local COLS, ROWS = 4, 3
local MARGIN_X, MARGIN_Y = 10, 16
local WAIT_TIME = 60

local crack_tex_id = 586
local fail_talk_id = 4401
local pass_talk_id = 4402
local shovel_tex_id = 579

local function IsFail(param)
  return COLS * ROWS == param.digcount
end

local function IsPass(param)
  return CHECK_COUNT <= GetCounterUiCount(param)
end

local function SetCheckCount(param, c)
  SetCounterUiCount(param, c)
  UpdateCounterUi(param, EARTHWORM_TEX_ID, CHECK_COUNT)
end

local function EarthWormDone(param)
  if (not WaitTime(param, WAIT_TIME)) then
    return
  end
  if (IsPass(param)) then
    StartTalk(pass_talk_id)
  elseif (IsFail(param)) then
    StartTalk(fail_talk_id)
  end
end

local function EarthWormPlay(param)
  if (not Input.IsKeyPushed(Input.LBUTTON)) then
    return
  end
  local x, y = Input.GetMousePos()
  GenHitObj(x, y, shovel_tex_id)
  for i = 1, #param.obj do
    local o = param.obj[i]
    if (-1 ~= o and PtInObj(x, y, o)) then
      param.digcount = param.digcount + 1
      local gotit = 1 == math.random(2)
      if (gotit and CHECK_COUNT > GetCounterUiCount(param)) then
        SetCheckCount(param, GetCounterUiCount(param) + 1)
        Good.SetTexId(o, EARTHWORM_TEX_ID)
        Good.SetBgColor(o, COLOR_WHITE)
        if (IsPass(param)) then
          param.step = EarthWormDone
          return
        end
      else
        Good.SetTexId(o, HOLE_TEX_ID)
      end
      param.obj[i] = -1
      if (IsFail(param)) then
        param.step = EarthWormDone
      end
    end
  end
end

EarthWorm = {}

EarthWorm.OnCreate = function(param)
  local cx = (SCR_W - 2 * MARGIN_X) / COLS
  local cy = (SCR_H - 2 * MARGIN_Y) / ROWS
  local cw, ch = Resource.GetTexSize(crack_tex_id)
  param.obj = {}
  for i = 1, COLS do
    for j = 1, ROWS do
      local o = Good.GenObj(-1, crack_tex_id)
      Good.SetPos(o, MARGIN_X + (i - 1) * cx + (cx - cw)/2, MARGIN_Y + (j - 1) * cy + (cy - ch)/2)
      Good.SetBgColor(o, COLOR_BLACK)
      param.obj[1 + #param.obj] = o
    end
  end
  SetCheckCount(param, 0)
  param.digcount = 0
  param.step = EarthWormPlay
end

EarthWorm.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, ZOO_FIELD_LVL_ID)
    return
  end
  param.step(param)
end
