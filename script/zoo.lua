
local back_btn_obj_id = 422
local pinky_papa_obj_id = 435
local pinky_papa_talk_id = 1709

local obj_list = {428, 430, 431, 429, 433, 434, 432, pinky_papa_obj_id, 436}
local snd_list = {440, 446, 443, 444, 439, 438, 442, 445, 441}

HeroMtZoo = {}

HeroMtZoo.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE) or HittestBackButton(back_btn_obj_id)) then
    Good.GenObj(-1, ZOO_FIELD_LVL_ID)
    return
  end
  if (not Input.IsKeyPushed(Input.LBUTTON)) then
    return
  end
  local x, y = Input.GetMousePos()
  for i = 1, #obj_list do
    if (PtInObj(x, y, obj_list[i])) then
      Sound.PlaySound(snd_list[i])
      if (pinky_papa_obj_id == obj_list[i]) then
        StartTalk(pinky_papa_talk_id)
      end
      break
    end
  end
end
