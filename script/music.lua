local CHECK_COUND = 12
local NOTE_ANIM_TIME = 4
local WAIT_TIME = 60
local WAIT_TIME_DONE = 180

local btn_obj_id = {528, 525, 533}
local note_snd_id = {538, 539, 540}
local note_tex_id = 534
local source_obj_id = 537
local talk_id = 4101

local function GetRandomTarget(param)
  local i = 0
  while true do
    i = math.random(#btn_obj_id)
    if (param.last ~= i) then
      break
    end
  end
  param.last = i
  return i
end

local function SetCheckCount(param, c)
  SetCounterUiCount(param, c)
  UpdateCounterUi(param, note_tex_id, CHECK_COUND)
end

local function GenMusicalNote(param)
  local btn = btn_obj_id[GetRandomTarget(param)]
  local o = Good.GenObj(param.dummy, note_tex_id, 'AnimMusicalNote')
  Good.SetPos(o, Good.GetPos(source_obj_id))
  local color = Good.GetBgColor(btn)
  Good.SetBgColor(o, color)
  local p = Good.GetParam(o)
  p.dt = NOTE_ANIM_TIME
  p.target_x, p.target_y = Good.GetPos(btn)
  local l,t,w,h = Good.GetDim(btn)
  p.target_x = p.target_x + w/2
  p.target_y = p.target_y + h/2
  p.clear = function() SetCheckCount(param, 0) end
end

local function HitTest(param)
  if (not Input.IsKeyPushed(Input.LBUTTON)) then
    return
  end
  local x, y = Input.GetMousePos()
  for i = 1, #btn_obj_id do
    if (PtInObj(x, y, btn_obj_id[i])) then
      Sound.PlaySound(note_snd_id[i])
      local c = Good.GetChildCount(param.dummy)
      local hit = false
      for j = 0, c - 1 do
        local o = Good.GetChild(param.dummy, j)
        if (PtInObj(x, y, o)) then
          Good.KillObj(o)
          hit = true
          break
        end
      end
      if (hit) then
        SetCheckCount(param, GetCounterUiCount(param) + 1)
        if (CHECK_COUND <= GetCounterUiCount(param)) then
          param.step = MusicGameOnStepDone
        end
      else
        SetCheckCount(param, 0)
      end
      break
    end
  end
end

MusicGame = {}

MusicGame.OnCreate = function(param)
  param.last = 0
  param.dummy = Good.GenDummy(-1)
  SetCheckCount(param, 0)
  param.step = MusicGameOnStepPlay
end

MusicGame.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, ISLAND_LVL_ID)
    return
  end
  param.step(param)
end

function MusicGameOnStepDone(param)
  if (not WaitTimer(param, WAIT_TIME_DONE)) then
    return
  end
  StartTalk(talk_id)
end

function MusicGameOnStepPlay(param)
  HitTest(param)
  if (not WaitTimer(param, WAIT_TIME)) then
    return
  end
  GenMusicalNote(param)
end
