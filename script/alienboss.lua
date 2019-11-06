
AlienBoss = {}

AlienBoss.OnCreate = function(param)
end

AlienBoss.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, ALIEN_AREA_LVL_ID)
    return
  end
end
