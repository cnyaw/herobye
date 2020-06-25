local SZ_TEXT = 32
local OFFSET_X, OFFSET_Y = 8, 8

local LVL_TITLE = {
'開張大吉',
'香油錢',
'光明燈',
'進香團',
'發財金',
'功德款',
'廟會',
'靈骨塔',
'基金會',
'發大財'
}

local cursor_obj_id = 160

TempleLevel = {}

TempleLevel.OnCreate = function(param)
  for i = 1, #LVL_TITLE do
    local s = string.format('Lv%d %s', i, LVL_TITLE[i])
    local o = Good.GenTextObj(-1, s, SZ_TEXT)
    Good.SetPos(o, 2 * OFFSET_X + SZ_TEXT, OFFSET_Y + (i - 1) * (SZ_TEXT + 5))
    if (GetTempleLevel() < i) then
      SetTextObjColor(o, COLOR_GRAY)
    end
  end
  Good.SetPos(cursor_obj_id, OFFSET_X, OFFSET_Y + (GetTempleLevel() - 1) * (SZ_TEXT + 5))
end

TempleLevel.OnStep = function(param)
  if (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, TEMPLE_LVL_ID)
    return
  end
end
