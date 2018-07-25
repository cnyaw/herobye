
RacingGame = {}

RacingGame.OnCreate = function(param)
  UpdateCoinInfo(param)
end

RacingGame.OnStep = function(param)
  if (Input.IsKeyPushed(Input.LBUTTON)) then
    Good.GenObj(-1, MAIN_MAP_LVL_ID)
    return
  end
end
