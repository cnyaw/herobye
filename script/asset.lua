FlashlightCounter = {}

FlashlightCounter.OnCreate = function(param)
  local id = param._id
  for i = 1, MAX_FLASH_LIGHT_USE_COUNT do
    local clr = COLOR_GREEN
    if (FlashlightUseCount() < i) then
      clr = COLOR_BLACK
    end
    local o = GenColorObj(id, 8, 8, clr)
    Good.SetPos(o, 10 * i, 2)
  end
end
