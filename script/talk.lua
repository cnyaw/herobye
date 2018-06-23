
local image_pos_dummy_id = 284
local arrow_tex_id = 261

local talk_mess_obj = nil

Talk = {}

Talk.OnCreate = function(param)
  talk_mess_obj = nil
  StepOneTalk()
end

Talk.OnStep = function(param)
  if (not Input.IsKeyPushed(Input.LBUTTON)) then
    return
  end

  StepOneTalk()
end

function StepOneTalk()
  local talk = GetCurrTalk(curr_talk_id)
  if (nil ~= talk.Image) then
    Good.KillAllChild(image_pos_dummy_id)
    local o = Good.GenObj(image_pos_dummy_id, talk.Image)
    local l,t,w,h = Good.GetDim(o)
    Good.SetPos(o, (SCR_W - w)/2, 0)
    StepOneTalk()
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
    StepOneTalk()
  end
end
