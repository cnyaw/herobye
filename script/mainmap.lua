
MainMap = {}

MainMap.OnCreate = function(param)
  UpdateCoinInfo(param)
  QuestOnCreate()
end

MainMap.OnStep = function(param)
  if (not Input.IsKeyPushed(Input.LBUTTON)) then
    return
  end

  local x, y = Input.GetMousePos()
  QuestOnStep(x, y)
end
