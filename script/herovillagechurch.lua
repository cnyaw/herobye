
HeroVillageChurch = {}

HeroVillageChurch.OnCreate = function(param)
  QuestOnCreate()
end

HeroVillageChurch.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, HERO_VILLAGE_LVL_ID)
    return
  end
  if (Input.IsKeyPushed(Input.LBUTTON)) then
    local x, y = Input.GetMousePos()
    QuestOnStep(x, y)
  end
end
