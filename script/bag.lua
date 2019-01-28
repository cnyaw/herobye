
BagScene = {}

BagScene.OnCreate = function(param)
  local x = 10
  for i = 2, #bag do
    local o = Good.GenObj(-1, ItemData[i].Image)
    Good.SetPos(o, x, 10)
    local l,t,w,h = Good.GetDim(o)
    x = x + w + 10
  end
end

BagScene.OnStep = function(param)
  if (Input.IsKeyPushed(Input.LBUTTON)) then
    Good.GenObj(-1, MAIN_MAP_LVL_ID)
    return
  end
end
