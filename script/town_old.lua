local MOV_SPD_X, MOV_SPD_Y = 8, 8

Town_Old = {}

Town_Old.OnCreate = function(param)
  param.MouseDown = false
end

Town_Old.OnStep = function(param)
  if (Input.IsKeyPushed(Input.ESCAPE)) then
    Good.GenObj(-1, 0)                  -- Back to title.
    return
  end

  local id = param._id
  local l,t,w,h = Good.GetDim(id)
  local x,y = Good.GetPos(id)

  -- Handle kbd scroll.
  if (Input.IsKeyDown(Input.LEFT)) then
    if (0 < x) then
      x = x - MOV_SPD_X
    end
  elseif (Input.IsKeyDown(Input.RIGHT)) then
    if (w - SCR_W > x) then
      x = x + MOV_SPD_X
    end
  end
  if (Input.IsKeyDown(Input.UP)) then
    if (0 < y) then
      y = y - MOV_SPD_Y
    end
  elseif (Input.IsKeyDown(Input.DOWN)) then
    if (h - SCR_H > y) then
      y = y + MOV_SPD_Y
    end
  end

  -- Handle drag scrool.
  if (Input.IsKeyDown(Input.LBUTTON)) then
    if (not param.MouseDown) then
      param.MouseDown = true
      param.lx, param.ly = Good.GetPos(id)
      param.mx, param.my = Input.GetMousePos()
    else
      local mx, my = Input.GetMousePos()
      x = param.lx + (param.mx - mx)
      y = param.ly + (param.my - my)
    end
  else
    param.MouseDown = false
  end

  -- Update level pos.
  if (0 > x) then
    x = 0
  end
  if (w - SCR_W <= x) then
    x = w - SCR_W - 1
  end
  if (0 > y) then
    y = 0
  end
  if (h - SCR_H <= y) then
    y = h - SCR_H - 1
  end

  Good.SetPos(id, x, y)
end

Town_1_Old = {}

Town_1_Old.OnStep = function(param)
  if (Input.IsKeyPushed(Input.ESCAPE)) then
    Good.GenObj(-1, 0)                  -- Back to title.
    return
  end
end

AnimScroll_Old = {}

AnimScroll_Old.OnStep = function(param)
  if (nil == param.k) then
    local loop1 = ArAddLoop(nil)
    ArAddMoveBy(loop1, 'Pos', 0.1, -1, 0)
    param.k = ArAddAnimator({loop1})
  else
    ArStepAnimator(param, param.k)
  end
end
