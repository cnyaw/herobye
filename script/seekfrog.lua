local WAIT_TIME = 80

local frog_obj_id = 37
local back_obj_id = 38
local frog_tex_id = 357

SeekFrog = {}

SeekFrog.OnCreate = function(param)
  GetLeaf(param)
  RandomPickLeaf(param)
  param.step = OnSeekFrogStep
end

SeekFrog.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, COUNTRY_LVL_ID)
  else
    param.step(param)
  end
end

function CenterFrog(o)
  local x, y = Good.GetPos(o)
  local l,t,w,h = Good.GetDim(o)
  local fl,ft,fw,fh = Good.GetDim(frog_obj_id)
  Good.SetPos(frog_obj_id, x + (w-fw)/2, y + (h-fh)/2)
end

function GetLeaf(param)
  local id = param._id
  param.leaf = {}
  local lotus = Good.FindChild(id, 'lotus')
  local c = Good.GetChildCount(lotus)
  for i = 1, c do
    local o = Good.GetChild(lotus, i - 1)
    param.leaf[i] = o
  end
end

function FindFrogFail()
  Good.SetScript(frog_obj_id, 'AnimShowFrog')
end

function FindFrogSucc(id)
  ShowFrog(id)
  Good.SetScript(frog_obj_id, 'AnimTalkArrow')
end

function HideFrog(id)
  Good.AddChild(id, frog_obj_id, 0)
  AcKillAnimScript(Good.GetParam(frog_obj_id))
end

function HitFrog(x, y, param)
  for i = 1, #param.leaf do
    if (PtInObj(x, y, param.leaf[i])) then
      if (param.pos_frog == i) then
        return true
      else
        return false
      end
    end
  end
  return false
end

function OnSeekFrogDelay(param)
  if (not WaitTimer(param, WAIT_TIME)) then
    return
  end
  param.step = OnSeekFrogStep
  RandomPickLeaf(param)
end

function OnSeekFrogStep(param)
  if (not Input.IsKeyPushed(Input.LBUTTON)) then
    return
  end
  local x, y = Input.GetMousePos()
  if (PtInObj(x, y, back_obj_id)) then
    Good.GenObj(-1, COUNTRY_LVL_ID)
    return
  end
  if (HitFrog(x, y, param)) then
    FindFrogSucc(param._id)
  else
    FindFrogFail()
  end
  param.step = OnSeekFrogDelay
end

function RandomPickLeaf(param)
  local i = math.random(#param.leaf)
  local o = param.leaf[i]
  param.pos_frog = i
  CenterFrog(o)
  HideFrog(param._id)
end

function ShowFrog(id)
  Good.AddChild(id, frog_obj_id)
end
