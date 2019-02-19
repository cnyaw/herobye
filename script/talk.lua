local SZ_TALK_TEXT = 40

local image_pos_dummy_id = 284
local arrow_tex_id = 261

local talk_mess_obj = nil
local talk_index = nil

Talk = {}

Talk.OnCreate = function(param)
  talk_mess_obj = nil
  talk_index = 1
  StepOneTalk(param)
end

Talk.OnStep = function(param)
  if (FadeBgColorTo(param)) then
    return
  end
  if (not Input.IsKeyPushed(Input.LBUTTON)) then
    return
  end
  StepOneTalk(param)
end

function FadeBgColorTo(param)
  if (nil == param.FadeTo) then
    return false
  end
  param.FadeTo[3] = param.FadeTo[3] + 1
  local t = param.FadeTo[3] / param.FadeTo[1]
  Good.SetBgColor(param._id, LerpARgb(param.FadeTo[4], param.FadeTo[2], t))
  if (param.FadeTo[3] >= param.FadeTo[1]) then
    param.FadeTo = nil
    StepOneTalk(param)
    return false
  else
    return true
  end
end

function HandleTalkFadeTo(param, talk)
  param.FadeTo = {unpack(talk.FadeTo)}
  param.FadeTo[3] = 0                   -- Init timer.
  param.FadeTo[4] = Good.GetBgColor(param._id) -- Save curr bgcolor.
end

function HandleTalkImage(param, talk)
  Good.KillAllChild(image_pos_dummy_id)
  if (-1 ~= talk.Image) then
    local o = Good.GenObj(image_pos_dummy_id, talk.Image)
    local l,t,w,h = Good.GetDim(o)
    Good.SetPos(o, (SCR_W - w)/2, 0)
  end
  StepOneTalk(param)
end

function HandlTalkText(param, talk)
  if (nil ~= talk_mess_obj) then
    Good.KillObj(talk_mess_obj)
    talk_mess_obj = nil
  end
  if (nil ~= talk.ScriptText) then
    talk.Text = talk.ScriptText(talk.Format)
  end
  if (0 >= string.len(talk.Text)) then
    StepOneTalk(param)
    return
  end
  talk_mess_obj = Good.GenTextObj(-1, talk.Text, SZ_TALK_TEXT)
  local w = GetTextObjWidth(talk_mess_obj)
  Good.SetPos(talk_mess_obj, (SCR_W - w)/2, 270)
  local o = Good.GenObj(talk_mess_obj, arrow_tex_id, 'AnimTalkArrow')
  Good.SetPos(o, w, -32)
  Good.SetBgColor(o, 0xff00ff00)
  Good.SetRot(o, 90)
end

function StepOneTalk(param)
  local talk_tbl = GetCurrTalk()
  local talk = talk_tbl[talk_index]
  talk_index = talk_index + 1
  if (nil ~= talk.Image) then
    HandleTalkImage(param, talk)
  elseif (nil ~= talk.Text or nil ~= talk.ScriptText) then
    HandlTalkText(param, talk)
  elseif (nil ~= talk.LevelId) then
    Good.GenObj(-1, talk.LevelId)
  elseif (nil ~= talk.Script) then
    talk.Script()
    StepOneTalk(param)
  elseif (nil ~= talk.FadeTo) then
    HandleTalkFadeTo(param, talk)
  end
end
