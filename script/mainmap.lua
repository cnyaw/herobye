
MainMap = {}

MainMap.OnCreate = function(param)
  UpdateCoinInfo(param)
  QuestOnCreate()
  EnterMainMap()
end

MainMap.OnStep = function(param)
  if (Input.IsKeyPushed(Input.LBUTTON)) then
    local x, y = Input.GetMousePos()
    QuestOnStep(x, y)
  end
end
