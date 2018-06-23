Anim1_Old = {}

Anim1_Old.OnStep = function(param)
  if (nil == param.k) then
    local loop1 = ArAddLoop(nil)
    ArAddMoveBy(loop1, 'Pos', 0.2, 0, -40).ease = ArEaseInOut
--    ArAddDelay(loop1, 0.8)
    ArAddMoveBy(loop1, 'Pos', 0.1, 0, 40).ease = ArEaseOut
--    ArAddDelay(loop1, 0.8)
    param.k = ArAddAnimator({loop1})
  else
    ArStepAnimator(param, param.k)
  end
end

Title_Old = {}

Title_Old.OnStep = function(param)
  if (Input.IsKeyPushed(Input.ESCAPE)) then
    -- NOP.
  elseif (Input.IsKeyPushed(Input.LBUTTON)) then
    local x, y = Input.GetMousePos()
    if (PtInObj(x, y, 262)) then
      Good.GenObj(-1, 83)               -- Right: to town_1.
    elseif (PtInObj(x, y, 263)) then
      Good.GenObj(-1, 10)               -- Right: to town.
    end
  end
end
