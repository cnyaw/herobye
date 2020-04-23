local SZ_TALK_TEXT = 40

local image_pos_dummy_id = 284
local arrow_tex_id = 261

local talk_mess_obj = nil
local talk_index = nil
local on_create = false
local force_next_lvl = false
local fade_to = nil
local curr_lvl_id = nil
local talk_menu_obj = nil
local menu_sel = nil

Talk = {}

Talk.OnCreate = function(param)
  talk_mess_obj = nil
  talk_index = 1
  on_create = true
  force_next_lvl = false
  fade_to = nil
  talk_menu_obj = nil
  menu_sel = nil
  curr_lvl_id = param._id
  StepOneTalk()
end

Talk.OnStep = function()
  if (FadeBgColorTo()) then
    return
  end
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    SkipTalk()
    return
  end
  if (force_next_lvl or Input.IsKeyPushed(Input.LBUTTON)) then
    on_create = false
    if (not HandleTalkMenu()) then
      StepOneTalk()
    end
  end
end

function AddTalkMenuSelMessCursor(sel)
  local msg = Good.GetChild(talk_menu_obj, sel - 1)
  AddTalkMessCuror(msg)
end

function AddTalkMessCuror(msg)
  local tw, th = Resource.GetTexSize(arrow_tex_id)
  local o = Good.GenObj(msg, arrow_tex_id, 'AnimTalkArrow')
  local w = GetTextObjWidth(msg)
  Good.SetPos(o, w - tw, -SZ_TALK_TEXT)
  Good.SetBgColor(o, COLOR_GREEN)
  Good.SetRot(o, 90)
end

function FadeBgColorTo()
  if (nil == fade_to) then
    return false
  end
  fade_to[3] = fade_to[3] + 1
  local t = fade_to[3] / fade_to[1]
  Good.SetBgColor(curr_lvl_id, LerpARgb(fade_to[4], fade_to[2], t))
  if (fade_to[3] >= fade_to[1]) then
    fade_to = nil
    StepOneTalk()
    return false
  else
    return true
  end
end

function HandleTalkFadeTo(talk)
  fade_to = {unpack(talk.FadeTo)}
  fade_to[3] = 0                        -- Init timer.
  fade_to[4] = Good.GetBgColor(curr_lvl_id) -- Save curr bgcolor.
end

function HandleTalkImage(talk)
  Good.KillAllChild(image_pos_dummy_id)
  if (-1 ~= talk.Image) then
    local o = Good.GenObj(image_pos_dummy_id, talk.Image)
    local l,t,w,h = Good.GetDim(o)
    Good.SetPos(o, (SCR_W - w)/2, 0)
  end
  StepOneTalk()
end

function HandleTalkMenu()
  if (nil == talk_menu_obj) then
    return false
  end
  local mx, my = Input.GetMousePos()
  local cc = Good.GetChildCount(talk_menu_obj)
  for i = 0, cc - 1 do
    local o = Good.GetChild(talk_menu_obj, i)
    local x, y = Good.GetPos(o)
    local tw = GetTextObjWidth(o)
    if (PtInRect(mx, my, x, y, x + tw, y + SZ_TALK_TEXT)) then
      SelectMenuItem(1 + i)
      return true
    end
  end
  return true
end

function HandleTalkMenuText(talk)
  talk_menu_obj = GenColorObj(-1, SCR_W, SCR_H, 0xb0000000)
  local lw = math.floor(SCR_W / #talk.MenuText)
  local x = 0
  for i = 1, #talk.MenuText do
    local o = Good.GenTextObj(talk_menu_obj, talk.MenuText[i], SZ_TALK_TEXT)
    local tw = GetTextObjWidth(o)
    local lx = x + (lw - tw) / 2
    Good.SetPos(o, lx, (SCR_H - SZ_TALK_TEXT) / 2)
    x = x + lw
  end
  KillTalkMessCursor(talk_mess_obj)
  SetTalkMenuSel(1)
end

function HandlTalkText(talk)
  if (nil ~= talk_mess_obj) then
    Good.KillObj(talk_mess_obj)
    talk_mess_obj = nil
  end
  local text = talk.Text
  if (nil ~= talk.ScriptText) then
    text = talk.ScriptText(talk.Text)
  end
  if (0 >= string.len(text)) then
    StepOneTalk()
    return
  end
  talk_mess_obj = Good.GenTextObj(-1, text, SZ_TALK_TEXT)
  local w = GetTextObjWidth(talk_mess_obj)
  Good.SetPos(talk_mess_obj, (SCR_W - w)/2, 270)
  AddTalkMessCuror(talk_mess_obj)
end

function HandleTalkLevelId(talk)
  if (on_create) then                   -- Skip gen next lvl to avoid app error.
    force_next_lvl = true
    talk_index = talk_index - 1
    return
  end
  local lvl_id = talk.LevelId
  if (nil ~= talk.ScriptLevelId) then
    lvl_id = talk.ScriptLevelId()
  end
  Good.GenObj(-1, lvl_id)
end

function HandleTalkNextId(talk)
  if (nil ~= talk.NextCond and not talk.NextCond()) then
    StepOneTalk()
    return
  end
  StartTalk(talk.NextId)
end

function KillTalkMenuSelMessCursor(sel)
  local msg = Good.GetChild(talk_menu_obj, sel - 1)
  KillTalkMessCursor(msg)
end

function KillTalkMessCursor(msg)
  local cc = Good.GetChildCount(msg)
  local cursor = Good.GetChild(msg, cc - 1)
  Good.KillObj(cursor)
end

function SelectMenuItem(sel)
  if (menu_sel == sel) then
    local talk_tbl = GetCurrTalk()
    local talk = talk_tbl[talk_index - 1]
    StartTalk(talk.MenuNextId[sel])
  else
    SetTalkMenuSel(sel)
  end
end

function SetTalkMenuSel(sel)
  if (sel == menu_sel) then
    return
  end
  if (nil ~= menu_sel) then
    KillTalkMenuSelMessCursor(menu_sel)
  end
  AddTalkMenuSelMessCursor(sel)
  menu_sel = sel
end

function SkipTalk()
  if (nil ~= talk_menu_obj) then
    return false
  end
  local talk_tbl = GetCurrTalk()
  while true do
    local talk = talk_tbl[talk_index]
    talk_index = talk_index + 1
    if (nil ~= talk.LevelId or nil ~= talk.ScriptLevelId) then
      HandleTalkLevelId(talk)
      return
    elseif (nil ~= talk.Script) then
      talk.Script()
    elseif (nil ~= talk.NextId) then
      HandleTalkNextId(talk)
    elseif (nil ~= talk.MenuText) then
      HandleTalkMenuText(talk)
      return
    end
  end
end

function StepOneTalk()
  local talk_tbl = GetCurrTalk()
  local talk = talk_tbl[talk_index]
  talk_index = talk_index + 1
  if (nil ~= talk.Image) then
    HandleTalkImage(talk)
  elseif (nil ~= talk.Text or nil ~= talk.ScriptText) then
    HandlTalkText(talk)
  elseif (nil ~= talk.LevelId or nil ~= talk.ScriptLevelId) then
    HandleTalkLevelId(talk)
  elseif (nil ~= talk.Script) then
    talk.Script()
    StepOneTalk()
  elseif (nil ~= talk.FadeTo) then
    HandleTalkFadeTo(talk)
  elseif (nil ~= talk.NextId) then
    HandleTalkNextId(talk)
  elseif (nil ~= talk.BgColor) then
    Good.SetBgColor(curr_lvl_id, talk.BgColor)
    StepOneTalk()
  elseif (nil ~= talk.MenuText) then
    HandleTalkMenuText(talk)
  end
end
