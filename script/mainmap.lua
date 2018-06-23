
MainMap = {}

MainMap.OnCreate = function(param)
  UpdateCoinInfo(param)
  QuestOnCreate(param._id)
end

MainMap.OnStep = function(param)
  if (not Input.IsKeyPushed(Input.LBUTTON)) then
    return
  end

  local x, y = Input.GetMousePos()
  QuestOnStep(x, y, param._id)
end
