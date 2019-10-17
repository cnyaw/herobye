local temple_tex_id = 50
local temple_site_obj_id = 315

MainMap = {}

MainMap.OnCreate = function(param)
  QuestOnCreate()
  EnterPlace(param._id)
  UpdateCoinInfo(param)
  if (HasTemple()) then
    Good.SetTexId(temple_site_obj_id, temple_tex_id)
  end
end

MainMap.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, TITLE_LVL_ID)
    return
  end
  if (Input.IsKeyPushed(Input.LBUTTON)) then
    local x, y = Input.GetMousePos()
    QuestOnStep(x, y)
  end
end
