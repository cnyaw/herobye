
local back_btn_obj_id = 422

local obj_list = {428, 430, 431, 429, 433, 434, 432, 435, 436}
local snd_list = {440, 446, 443, 444, 439, 438, 442, 445, 441}

HeroMtZoo = {}

HeroMtZoo.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE) or HittestBackButton(back_btn_obj_id)) then
    Good.GenObj(-1, MAIN_MAP_LVL_ID)
    return
  end
  if (not Input.IsKeyPushed(Input.LBUTTON)) then
    return
  end
  local x, y = Input.GetMousePos()
  for i = 1, #obj_list do
    if (PtInObj(x, y, obj_list[i])) then
      Sound.PlaySound(snd_list[i])
      break
    end
  end
end
