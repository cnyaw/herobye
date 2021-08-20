local WAIT_TIME = 80
local CHECK_COUND = 8

local frog_obj_id = 37
local frog_cry_talk_id = 2002

local function SetCheckCount(param, c)
  SetCounterUiCount(param, c)
  UpdateCounterUi(param, FROG_TEAR_TEX_ID, CHECK_COUND)
end

SeekFrog = {}

SeekFrog.OnCreate = function(param)
  GetLeaf(param)
  RandomPickLeaf(param)
  param.step = OnSeekFrogStep
  SetCheckCount(param, 0)
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

function FindFrogFail(param)
  Good.SetScript(frog_obj_id, 'AnimShowFrog')
  SetCheckCount(param, 0)
end

function FindFrogSucc(param)
  ShowFrog(param._id)
  Good.SetScript(frog_obj_id, 'AnimTalkArrow')
  SetCheckCount(param, GetCounterUiCount(param) + 1)
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
  if (CHECK_COUND <= GetCounterUiCount(param)) then
    StartTalk(frog_cry_talk_id)
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
  if (HitFrog(x, y, param)) then
    FindFrogSucc(param)
  else
    FindFrogFail(param)
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
