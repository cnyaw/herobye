
CaveMaze = {}

CaveMaze.OnCreate = function(param)
end

CaveMaze.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, CAVE_FIELD_LVL_ID)
    return
  end
end
