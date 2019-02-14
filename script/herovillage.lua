
HeroVillage = {}

HeroVillage.OnCreate = function(param)
  QuestOnCreate()
  EnterHeroVillage()
end

HeroVillage.OnStep = function(param)
  if (not Input.IsKeyPushed(Input.LBUTTON)) then
    return
  end
  local x, y = Input.GetMousePos()
  QuestOnStep(x, y)
end
