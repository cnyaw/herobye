local IMAGE_WIDTH = 100
local IMAGE_MARGIN = 20
local CX_BACK_BTN = 50

BagScene = {}

BagScene.OnCreate = function(param)
  local bag_type = GetCurrBagType()
  local x, y = IMAGE_MARGIN, IMAGE_MARGIN
  for k,v in pairs(bag) do
    if (0 < ItemCount(k)) then
      local item = ItemData[k]
      if (nil ~= item and item.BagType == bag_type) then
        x, y = GenBagItemObj(x, y, item.Image, k)
      end
    end
  end
end

BagScene.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, GetLastLvlId())
    return
  end
  if (Input.IsKeyPushed(Input.LBUTTON)) then
    local x, y = Input.GetMousePos()
    if (PtInBagItem(param._id, x, y)) then
      return
    end
    if (PtInBackBtn(x, y)) then
      Good.GenObj(-1, GetLastLvlId())
      return
    end
  end
end

function GenBagItemObj(x, y, img, item_id)
  local o = Good.GenObj(-1, img)
  Good.SetPos(o, x, y)
  ScaleToSize(o, IMAGE_WIDTH, IMAGE_WIDTH)
  Good.GetParam(o).item_id = item_id
  x = x + IMAGE_WIDTH + IMAGE_MARGIN
  if (SCR_W <= x) then
    x = IMAGE_MARGIN
    y = y + IMAGE_WIDTH + IMAGE_MARGIN
  end
  return x, y
end

function GetBagItemTalkId(o)
  local item_id = Good.GetParam(o).item_id
  local item = ItemData[item_id]
  if (nil ~= item) then
    local talk_id = item.TalkId
    if (nil ~= talk_id) then
      return talk_id
    end
  end
  return -1
end

function PtInBackBtn(x, y)
  return PtInRect(x, y, SCR_W - CX_BACK_BTN, SCR_H - CX_BACK_BTN, SCR_W, SCR_H)
end

function PtInBagItem(id, x, y)
  local c = Good.GetChildCount(id)
  for i = 0, c - 1 do
    local o = Good.GetChild(id, i)
    if (PtInObj(x, y, o)) then
      local talk_id = GetBagItemTalkId(o)
      if (-1 ~= talk_id) then
        StartTalk(talk_id)
      end
      return true
    end
  end
  return false
end
