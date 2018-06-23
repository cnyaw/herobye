
local image_pos_dummy_id = 284
local arrow_tex_id = 261

local talk_mess_obj = nil

Talk = {}

Talk.OnCreate = function(param)
  talk_mess_obj = nil
  StepOneTalk()
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
  local color = param.FadeTo[2]
  local a,r,g,b = GetARgbFromColor(color)
  local ba,br,bg,bb = GetARgbFromColor(param.FadeTo[4])
  local t = param.FadeTo[3] / param.FadeTo[1]
  local na = Lerp(ba, a, t)
  local nr = Lerp(br, r, t)
  local ng = Lerp(bg, g, t)
  local nb = Lerp(bb, b, t)
  Good.SetBgColor(param._id, GetColorFromARgb(na, nr, ng, nb))
  if (param.FadeTo[3] >= param.FadeTo[1]) then
    param.FadeTo = nil
    return false
  else
    return true
  end
end

function StepOneTalk(param)
  local talk = GetCurrTalk(curr_talk_id)
  if (nil ~= talk.Image) then
    Good.KillAllChild(image_pos_dummy_id)
    if (-1 ~= talk.Image) then
      local o = Good.GenObj(image_pos_dummy_id, talk.Image)
      local l,t,w,h = Good.GetDim(o)
      Good.SetPos(o, (SCR_W - w)/2, 0)
    end
    StepOneTalk(param)
  elseif (nil ~= talk.Text) then
    if (nil ~= talk_mess_obj) then
      Good.KillObj(talk_mess_obj)
      talk_mess_obj = nil
    end
    talk_mess_obj = Good.GenTextObj(-1, talk.Text, 40)
    local w = GetTextObjWidth(talk_mess_obj)
    Good.SetPos(talk_mess_obj, (SCR_W - w)/2, 270)
    local o = Good.GenObj(talk_mess_obj, arrow_tex_id, 'AnimTalkArrow')
    Good.SetPos(o, w, -32)
    Good.SetBgColor(o, 0xff00ff00)
    Good.SetRot(o, 90)
  elseif (nil ~= talk.LevelId) then
    Good.GenObj(-1, talk.LevelId)
  elseif (nil ~= talk.Script) then
    talk.Script()
    StepOneTalk(param)
  elseif (nil ~= talk.FadeTo) then
    param.FadeTo = {unpack(talk.FadeTo)}
    param.FadeTo[3] = 0                 -- Init timer.
    param.FadeTo[4] = Good.GetBgColor(param._id) -- Save curr bgcolor.
    StepOneTalk(param)
  end
end
