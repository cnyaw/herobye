
HeroVillage = {}

HeroVillage.OnCreate = function(param)
  QuestOnCreate()
  EnterPlace(param._id)
end

HeroVillage.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, GetHeroVillageBackLvlId())
    return
  end
  if (Input.IsKeyPushed(Input.LBUTTON)) then
    local x, y = Input.GetMousePos()
    QuestOnStep(x, y)
  end
end

function GetHeroVillageBackLvlId()
  if (HERO_VILLAGE_CHURCH_LVL_ID == GetInPlaceLvlId()) then
    return HERO_VILLAGE_LVL_ID
  else
    return TITLE_LVL_ID
  end
end
