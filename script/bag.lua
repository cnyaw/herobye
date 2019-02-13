
BagScene = {}

BagScene.OnCreate = function(param)
  local x = 10
  for k,v in pairs(bag) do
    if (0 < ItemCount(k)) then
      local img = ItemData[k].Image
      if (nil ~= img) then
        local o = Good.GenObj(-1, img)
        Good.SetPos(o, x, 10)
        local l,t,w,h = Good.GetDim(o)
        x = x + w + 10
      end
    end
  end
end

BagScene.OnStep = function(param)
  if (Input.IsKeyPushed(Input.LBUTTON)) then
    Good.GenObj(-1, MAIN_MAP_LVL_ID)
    return
  end
end
