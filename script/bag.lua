
BagScene = {}

BagScene.OnCreate = function(param)
  local quest_id = curr_stage_id.o_bag
  local v = QuestData[quest_id].IconId
  local x = 10
  for i = 1, #v do
    local o = Good.GenObj(-1, v[i])
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
