
MainMap = {}

MainMap.OnCreate = function(param)
  UpdateCoinInfo(param)
  QuestOnCreate()
  EnterPlace(param._id)
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
