MainMap = {}

MainMap.OnCreate = function(param)
  QuestOnCreate()
  EnterPlace(param._id)
  UpdateCoinInfo(param)
end

MainMap.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, GetHeroVillageBackLvlId())
    return
  end
  if (Input.IsKeyPushed(Input.LBUTTON)) then
    local x, y = Input.GetMousePos()
    QuestOnStep(x, y)
  end
end
