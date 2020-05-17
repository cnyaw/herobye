
Temple = {}

Temple.OnCreate = function(param)
end

Temple.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, MAIN_MAP_LVL_ID)
  end
end
