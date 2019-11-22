local SZ_TALK_TEXT = 40

local image_pos_dummy_id = 284
local arrow_tex_id = 261

local talk_mess_obj = nil
local talk_index = nil
local on_create = false
local force_next_lvl = false
local fade_to = nil
local curr_lvl_id = nil

Talk = {}

Talk.OnCreate = function(param)
  talk_mess_obj = nil
  talk_index = 1
  on_create = true
  force_next_lvl = false
  fade_to = nil
  curr_lvl_id = param._id
  StepOneTalk()
end

Talk.OnStep = function()
  if (FadeBgColorTo()) then
    return
  end
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    SkipTalk()
    return
  end
  if (force_next_lvl or Input.IsKeyPushed(Input.LBUTTON)) then
    on_create = false
    StepOneTalk()
  end
end

function FadeBgColorTo()
  if (nil == fade_to) then
    return false
  end
  fade_to[3] = fade_to[3] + 1
  local t = fade_to[3] / fade_to[1]
  Good.SetBgColor(curr_lvl_id, LerpARgb(fade_to[4], fade_to[2], t))
  if (fade_to[3] >= fade_to[1]) then
    fade_to = nil
    StepOneTalk()
    return false
  else
    return true
  end
end

function HandleTalkFadeTo(talk)
  fade_to = {unpack(talk.FadeTo)}
  fade_to[3] = 0                        -- Init timer.
  fade_to[4] = Good.GetBgColor(curr_lvl_id) -- Save curr bgcolor.
end

function HandleTalkImage(talk)
  Good.KillAllChild(image_pos_dummy_id)
  if (-1 ~= talk.Image) then
    local o = Good.GenObj(image_pos_dummy_id, talk.Image)
    local l,t,w,h = Good.GetDim(o)
    Good.SetPos(o, (SCR_W - w)/2, 0)
  end
  StepOneTalk()
end

function HandlTalkText(talk)
  if (nil ~= talk_mess_obj) then
    Good.KillObj(talk_mess_obj)
    talk_mess_obj = nil
  end
  local text = talk.Text
  if (nil ~= talk.ScriptText) then
    text = talk.ScriptText(talk.Text)
  end
  if (0 >= string.len(text)) then
    StepOneTalk()
    return
  end
  talk_mess_obj = Good.GenTextObj(-1, text, SZ_TALK_TEXT)
  local w = GetTextObjWidth(talk_mess_obj)
  Good.SetPos(talk_mess_obj, (SCR_W - w)/2, 270)
  local o = Good.GenObj(talk_mess_obj, arrow_tex_id, 'AnimTalkArrow')
  Good.SetPos(o, w, -32)
  Good.SetBgColor(o, COLOR_GREEN)
  Good.SetRot(o, 90)
end

function HandleTalkLevelId(talk)
  if (on_create) then                   -- Skip gen next lvl to avoid app error.
    force_next_lvl = true
    talk_index = talk_index - 1
    return
  end
  local lvl_id = talk.LevelId
  if (nil ~= talk.ScriptLevelId) then
    lvl_id = talk.ScriptLevelId()
  end
  Good.GenObj(-1, lvl_id)
end

function HandleTalkNextId(talk)
  if (nil ~= talk.NextCond and not talk.NextCond()) then
    StepOneTalk()
    return
  end
  StartTalk(talk.NextId)
end

function SkipTalk()
  local talk_tbl = GetCurrTalk()
  while true do
    local talk = talk_tbl[talk_index]
    talk_index = talk_index + 1
    if (nil ~= talk.LevelId or nil ~= talk.ScriptLevelId) then
      HandleTalkLevelId(talk)
      return
    elseif (nil ~= talk.Script) then
      talk.Script()
    elseif (nil ~= talk.NextId) then
      HandleTalkNextId(talk)
    end
  end
end

function StepOneTalk()
  local talk_tbl = GetCurrTalk()
  local talk = talk_tbl[talk_index]
  talk_index = talk_index + 1
  if (nil ~= talk.Image) then
    HandleTalkImage(talk)
  elseif (nil ~= talk.Text or nil ~= talk.ScriptText) then
    HandlTalkText(talk)
  elseif (nil ~= talk.LevelId or nil ~= talk.ScriptLevelId) then
    HandleTalkLevelId(talk)
  elseif (nil ~= talk.Script) then
    talk.Script()
    StepOneTalk()
  elseif (nil ~= talk.FadeTo) then
    HandleTalkFadeTo(talk)
  elseif (nil ~= talk.NextId) then
    HandleTalkNextId(talk)
  elseif (nil ~= talk.BgColor) then
    Good.SetBgColor(curr_lvl_id, talk.BgColor)
    StepOneTalk()
  end
end
