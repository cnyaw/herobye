local IMAGE_WIDTH = 100
local IMAGE_MARGIN = 20

BagScene = {}

BagScene.OnCreate = function(param)
  local x, y = IMAGE_MARGIN, IMAGE_MARGIN
  for k,v in pairs(bag) do
    if (0 < ItemCount(k)) then
      local item = ItemData[k]
      if (nil ~= item) then
        local img = item.Image
        if (nil ~= img) then
          x, y = GenBagImageObj(x, y, img)
        end
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

function GenBagImageObj(x, y, img)
  local o = Good.GenObj(-1, img)
  Good.SetPos(o, x, y)
  ScaleToSize(o, IMAGE_WIDTH, IMAGE_WIDTH)
  x = x + IMAGE_WIDTH + IMAGE_MARGIN
  if (SCR_W <= x) then
    x = IMAGE_MARGIN
    y = y + IMAGE_WIDTH + IMAGE_MARGIN
  end
  return x, y
end
