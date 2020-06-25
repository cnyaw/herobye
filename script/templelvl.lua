local SZ_TEXT = 32
local OFFSET_X, OFFSET_Y = 8, 8
local SZ_LVL_STATUS = 200

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

local function DrawLevelStatus(y)
  local score = GetTempleScore()
  local max_score = GetTempleMaxScore()
  if (score > max_score) then
    score = max_score
  end
  local o = GenColorObj(-1, SZ_LVL_STATUS, SZ_TEXT, COLOR_BLACK)
  Good.SetPos(o, SCR_W/2, y)
  local o2 = GenColorObj(-1, SZ_LVL_STATUS * score/max_score, SZ_TEXT, COLOR_RED)
  Good.SetPos(o2, SCR_W/2, y)
end

TempleLevel = {}

TempleLevel.OnCreate = function(param)
  for i = 1, #LVL_TITLE do
    local s = string.format('Lv%d %s', i, LVL_TITLE[i])
    local o = Good.GenTextObj(-1, s, SZ_TEXT)
    local y = OFFSET_Y + (i - 1) * (SZ_TEXT + 5)
    Good.SetPos(o, 2 * OFFSET_X + SZ_TEXT, y)
    if (GetTempleLevel() < i) then
      SetTextObjColor(o, COLOR_GRAY)
    end
    if (GetTempleLevel() == i) then
      DrawLevelStatus(y)
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
