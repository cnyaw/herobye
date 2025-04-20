
local BTN_PADDING = 5
local BTN_W, BTN_H = 48, 42
local CHAR_SIZE = 26
local MAX_CONSOLE_LINE = 4
local STR_BKSP = 'bksp'
local STR_ENTER = 'enter'
local STR_PROMPT = '$ '
local STR_INVALID_CMD = '無效指令'
local MAX_CMD_LEN = 28

local console_scr_obj_id = 451

local init_kbd_data = {
  [1] = '1234567890',
  [2] = 'QWERTYUIOP',
  [3] = 'ASDFGHJKL',
  [4] = 'ZXCVBNM',
}

local init_console_line = {
  '歡迎光臨虛擬遊戲世界系統',
  '由拳頭星比比博士設計製造',
  '請輸入HELP命令了解詳細資訊',
}

local help_message = {
  'HELP 顯示此訊息',
  'EXIT 退出系統',
  'DQ2 虛擬遊戲世界',
}

local kbd_data
local console_line
local cur_input
local obj_cursor

local function CompCheckScroll()
  if (MAX_CONSOLE_LINE > #console_line) then
    return
  end
  Good.KillObj(console_line[1])
  for i = 2, #console_line do
    local dummy = console_line[i]
    console_line[i - 1] = dummy
    Good.SetPos(dummy, BTN_PADDING, 4 * BTN_PADDING + (i - 2) * (CHAR_SIZE + 2 * BTN_PADDING))
  end
  console_line[#console_line] = nil
end

local function CompAddLine(s)
  CompCheckScroll()
  local i
  if (MAX_CONSOLE_LINE > #console_line) then
     i = #console_line + 1
  else
    i = 4
  end
  local dummy = Good.GenDummy(console_scr_obj_id)
  Good.SetPos(dummy, BTN_PADDING, 4 * BTN_PADDING + (i - 1) * (CHAR_SIZE + 2 * BTN_PADDING))
  local o = Good.GenTextObj(dummy, STR_PROMPT .. s, CHAR_SIZE)
  SetTextObjColor(o, COLOR_WHITE)
  console_line[i] = dummy
end

local function CompDqGame()
  Good.GenObj(-1, DQ_LVL_ID)
  return true
end

local function CompExitSys()
  Good.GenObj(-1, INSIDE_JANKEN_LIB_LVL_ID)
  return true
end

local function CompSetCursorPos()
  local dummy = console_line[#console_line]
  if (nil ~= obj_cursor) then
    Good.KillObj(obj_cursor)
  end
  obj_cursor = GenColorObj(dummy, CHAR_SIZE/2, BTN_PADDING, COLOR_WHITE, 'AnimConsoleCursor')
  local w = GetTextObjWidth(Good.GetChild(dummy, 0))
  Good.SetPos(obj_cursor, w, CHAR_SIZE - BTN_PADDING)
end

local function CompShowHelp()
  for i = 1, #help_message do
    CompAddLine(help_message[i])
  end
  return false
end

local function CompShowInitHelp()
  for i = 1, #init_console_line do
    CompAddLine(init_console_line[i])
  end
end

local function CompNewLine()
  cur_input = ''
  CompAddLine(cur_input)
  CompSetCursorPos()
end

local function CompCheckCmd()
  local valid_cmd_data = {
    [1] = {'HELP', CompShowHelp},
    [2] = {'EXIT', CompExitSys},
    [3] = {'DQ2', CompDqGame},
  }
  for i = 1, #valid_cmd_data do
    local cmd = valid_cmd_data[i]
    if (cur_input == cmd[1]) then
      if (cmd[2]()) then
        return
      end
      CompNewLine()
      return
    end
  end
  CompAddLine(STR_INVALID_CMD)
  CompNewLine()
end

local function CompGenKbdKey(parent, ch, x)
  local key = GenColorObj(parent, BTN_W, BTN_H, COLOR_WHITE)
  Good.SetName(key, ch)
  Good.SetPos(key, x, 0)
  local s = Good.GenTextObj(key, ch, CHAR_SIZE)
  SetTextObjColor(s, COLOR_BLACK)
  local w = GetTextObjWidth(s)
  Good.SetPos(s, (BTN_W - w)/2, (BTN_H - CHAR_SIZE)/2)
  return key
end

local function CompGenKbdCtrlKey(line, ch, name)
  local parent = kbd_data[line]
  local last_key = Good.GetChild(parent, Good.GetChildCount(parent) - 1)
  local lx, ly = Good.GetPos(last_key)
  local key = CompGenKbdKey(parent, ch, lx + BTN_W + BTN_PADDING)
  Good.SetName(key, name)
end

local function CompGenKbdBkspkey()
  CompGenKbdCtrlKey(1, '⌫', STR_BKSP)
end

local function CompGenKbdEnterkey()
  CompGenKbdCtrlKey(3, '↲', STR_ENTER)
end

local function CompGenKbd()
  kbd_data = {}
  local y = SCR_H - 4.7 * BTN_H
  for i = 1, #init_kbd_data do
    local s = init_kbd_data[i]
    local x = 0
    local dummy = Good.GenDummy(-1)
    for j = 1, #s do
      local ch = s:sub(j, j)
      CompGenKbdKey(dummy, ch, x)
      x = x + BTN_W + BTN_PADDING
    end
    Good.SetPos(dummy, (SCR_W - x)/2, y)
    kbd_data[i] = dummy
    y = y + BTN_H + BTN_PADDING
  end
  CompGenKbdBkspkey()
  CompGenKbdEnterkey()
end

local function CompInitConsole()
  console_line = {}
  CompShowInitHelp()
  CompNewLine()
end

local function CompUpdateCmdLine()
  local dummy = console_line[#console_line]
  local x, y = Good.GetPos(dummy)
  Good.KillObj(dummy)
  dummy = Good.GenDummy(console_scr_obj_id)
  Good.SetPos(dummy, x, y)
  local o = Good.GenTextObj(dummy, STR_PROMPT .. cur_input, CHAR_SIZE)
  SetTextObjColor(o, COLOR_WHITE)
  console_line[#console_line] = dummy
  CompSetCursorPos()
end

local function CompHandleCmd(ch)
  if (STR_BKSP == ch) then
    cur_input = cur_input:sub(1, #cur_input - 1)
    CompUpdateCmdLine()
  elseif (STR_ENTER == ch) then
    CompCheckCmd()
  elseif (MAX_CMD_LEN > #cur_input) then
    cur_input = cur_input .. ch
    CompUpdateCmdLine()
  end
end

Computer = {}

Computer.OnCreate = function(param)
  obj_cursor = nil
  CompGenKbd()
  CompInitConsole()
end

Computer.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, INSIDE_JANKEN_LIB_LVL_ID)
    return
  end
  if (not Input.IsKeyPushed(Input.LBUTTON)) then
    return
  end
  local x, y = Input.GetMousePos()
  for i = 1, #kbd_data do
    local dummy = kbd_data[i]
    local dx, dy = Good.GetPos(dummy)
    local c = Good.GetChildCount(dummy)
    for j = 0, c - 1 do
      local o = Good.GetChild(dummy, j)
      if (PtInObj(x - dx, y - dy, o)) then
        local ch = Good.GetName(o)
        CompHandleCmd(ch)
        return
      end
    end
  end
  QuestOnStep(x, y)                     -- Handle btn o_jankenLib.
end
