
local SELL_ITEM_COST = 4

function ScriptAddBackScratcher()
  SetItem('i_back_scratcher', 1)
end

function ScriptAddBou1()
  SetItem('i_bou', 1)
end

function ScriptAddCaveDoorBook()
  SetItem('i_cave_door_book', 1)
end

function ScriptAddCaveMazeBookFlag()
  SetItem('f_cave_maze_book', 1)
  SetItem('f_open_cave_door', 0)
end

function ScriptAddCaveMazeBook()
  RemoveItem('f_cave_maze_book', 1)
  SetItem('i_cave_maze_book', 1)
end

function ScriptAddDipsyFeather()
  SetItem('i_dipsy_feather', 1)
end

function ScriptAddDrumStick()
  SetItem('i_drum_stick', 1)
end

function ScriptAddEarthWorm()
  SetItem('i_earthworm', 1)
end

function ScriptAddFish()
  SetItem('i_fish', 1)
end

function ScriptAddFrogTear()
  SetItem('i_frog_tear', 1)
end

function ScriptAddHeroHisBook()
  SetItem('i_hero_history_book', 1)
end

function ScriptAddJewel()
  SetItem('i_jewel', 1)
end

function ScriptAddKingPermission()
  SetItem('f_king_permission', 1)
end

function ScriptAddLaaLaaFeather()
  SetItem('i_laalaa_feather', 1)
end

function ScriptAddMellet()
  SetItem('f_mallet_code', 0)
  SetItem('i_mallet', 1)
end

function ScriptAddPoFeather()
  SetItem('i_po_feather', 1)
end

function ScriptAddPowerScissorBook()
  SetItem('i_power_scissor_book', 1)
end

function ScriptAddRope()
  SetItem('f_need_rope', 0)
  SetItem('i_rope', 1)
end

function ScriptAddRpsMedal()
  SetItem('i_rps_medal', 1)
end

function ScriptAddShaveBook()
  SetItem('i_shave_book', 1)
end

function ScriptAddSlapMouseBook()
  SetItem('i_slap_mouse_book', 1)
end

function ScriptAddSuperSoap()
  SetItem('i_frog_tear', 0)
  SetItem('i_green_mouse_tail', 0)
  SetItem('i_red_mouse_tail', 0)
  SetItem('i_yellow_mouse_tail', 0)
  SetItem('i_super_soap', 1)
end

function ScriptAddSuperSoapBook()
  SetItem('i_super_soap_book', 1)
end

function ScriptAddTinkyWinkyFeather()
  SetItem('i_tinky_winky_feather', 1)
end

function ScriptAddUfoPower()
  SetItem('i_ufo_power', 1)
  SetItem('f_find_ufo_power', 0)
end

function ScriptAddUfoPowerBook()
  SetItem('i_ufo_power_book', 1)
end

function ScriptBatCaveBlocked()
  SetItem('f_bat_cave_blocked', 1)
end

function ScriptBuildTemple()
  ConsumeCoin(CROWD_FUNDING_COST)
end

function ScriptBuyBou2()
  ConsumeCoin(BOU2_COST)
  SetItem('i_bou2', 1)
end

function ScriptBuyBou3()
  ConsumeCoin(BOU3_COST)
  SetItem('i_bou3', 1)
end

function ScriptBuyCandy()
  ConsumeCoin(CANDY_COST)
  SetItem('i_candy', 1)
  SetItem('f_buy_candy_loop', 0)
end

function ScriptBuyCandyLoop()
  SetItem('f_buy_candy_loop', 1)
end

function ScriptBuyFlashlight()
  ConsumeCoin(FLASHLIGHT_COST)
  SetItem('i_flashlight', 1)
  SetItem('i_flashlight_use_count', MAX_FLASH_LIGHT_USE_COUNT)
end

function ScriptBuyShip()
  ConsumeCoin(SHIP_COST)
  SetItem('f_ship', 1)
end

function ScriptChargeFlashlight()
  ScriptBuyFlashlight()
end

function ScriptCleanYellowSuit()
  SetItem('i_super_soap', 0)
  SetItem('i_dirty_yellow_suit', 0)
  SetItem('i_clean_yellow_suit', 1)
end

function ScriptConsumeUfoPower()
  SetItem('i_ufo_power', 0)
end

function ScriptEnterCave()
  AddItem('i_enter_cave_count', 1)
end

function ScriptExchangeCandyScissor()
  SetItem('i_candy', 0)
  SetItem('i_scissor', 1)
end

function ScriptFeedEarthWormToBird()
  SetItem('i_earthworm', 0)
end

function ScriptFindTeletubbies()
  SetItem('f_find_teletubbies', 1)
end

function ScriptFindUfoPower()
  SetItem('f_find_ufo_power', 1)
end

function ScriptGetMalletCode()
  SetItem('f_mallet_code', 1)
end

function ScriptGiveAllowance()
  AddCoin(10)
end

function ScriptGiveGodzilla()
  SetItem('i_godzilla', 1);
end

function ScriptHelpElderGlass()
  SetItem('f_help_elder_glass', 1)
end

function ScriptHelpElderWhite()
  SetItem('f_help_elder_white', 1)
end

function ScriptHelpElderYellow()
  SetItem('f_help_elder_yellow', 1)
  SetItem('i_dirty_yellow_suit', 1)
end

function ScriptHelpElderGlassDone()
  SetItem('i_super_nano_towel', 0)
end

function ScriptHelpElderYellowDone()
  SetItem('i_clean_yellow_suit', 0)
end

function ScriptHeroMtNextId()
  local id = {51, 180, 280}
  return id[math.random(3)]
end

function ScriptMakeSuperNanoTowel()
  SetItem('i_dipsy_feather', 0)
  SetItem('i_laalaa_feather', 0)
  SetItem('i_po_feather', 0)
  SetItem('i_tinky_winky_feather', 0)
  SetItem('f_find_teletubbies', 0)
  SetItem('i_super_nano_towel', 1)
end

function ScriptOpenBatCave()
  SetItem('f_bat_cave_blocked', 0)
end

function ScriptOpenCaveDoor()
  SetItem('f_open_cave_door', 1)
end

function ScriptPassPotatoTest()
  SetItem('f_pass_potato_test', 1)
end

function ScriptPlayLottery()
  ConsumeCoin(LOTTERY_COST)
end

function ScriptPowerupScissor()
  RemoveItem('i_scissor', 1)
  RemoveItem('i_drum_stick', 1)
  RemoveItem('i_frog_tear', 1)
  RemoveItem('f_powerup_scissor', 1)
  SetItem('i_power_scissor', 1)
end

function ScriptPowerupScissorLoop()
  SetItem('f_powerup_scissor', 1)
end

function ScriptSellEarthWorm()
  SetItem('i_earthworm', 0)
  AddCoin(2 * SELL_ITEM_COST)
end

function ScriptSellFeather()
  local item = {'i_po_feather', 'i_laalaa_feather', 'i_tinky_winky_feather', 'i_dipsy_feather'}
  ScriptSellItems_i(item, 2 * SELL_ITEM_COST)
end

function ScriptSellFish()
  SetItem('i_fish', 0)
  AddCoin(5 * SELL_ITEM_COST)
end

function ScriptSellFishToFishman()
  SetItem('i_fish', 0)
  AddCoin(SELL_ITEM_COST)
end

function ScriptSellFrogTear()
  SetItem('i_frog_tear', 0)
  AddCoin(SELL_ITEM_COST)
end

function ScriptSellItems_i(item, num)
  for i = 1, #item do
    if (HasItem(item[i])) then
      SetItem(item[i], 0)
      AddCoin(num)
    end
  end
end

function ScriptSellJewel()
  SetItem('i_jewel', 0)
  AddCoin(3 * SELL_ITEM_COST)
end

function ScriptSellMouseTail()
  local item = {'i_green_mouse_tail', 'i_red_mouse_tail', 'i_yellow_mouse_tail'}
  ScriptSellItems_i(item, SELL_ITEM_COST)
end

function ScriptSellSuperNanoTowel()
  SetItem('i_super_nano_towel', 0)
  AddCoin(6 * SELL_ITEM_COST)
end

function ScriptSendTeacherLetter()
  SetItem('i_letter', 1)
end

function ScriptSetNeedRopeFlag()
  SetItem('f_need_rope', 1)
end

function ScriptTakeJewel()
  SetItem('i_jewel', 0)
end

function ScriptTempleCreated()
  SetItem('i_temple_lvl', 1)
end

function ScriptTextAddMouseTail(fmt)
  local i = 1
  if (HasItem('i_red_mouse_tail')) then
    i = 2
  end
  if (HasItem('i_green_mouse_tail')) then
    i = 3
  end
  if (1 == i) then
    SetItem('i_red_mouse_tail', 1)
  elseif (2 == i) then
    SetItem('i_green_mouse_tail', 1)
  else
    SetItem('i_yellow_mouse_tail', 1)
  end
  local s = {'紅', '綠', '黃'}
  return string.format(fmt, s[i])
end

function ScriptTextCrowdFunding(fmt)
  return string.format(fmt, CROWD_FUNDING_COST - GetCoin())
end

function ScriptTextFlashlightUseCount(fmt)
  return string.format(fmt, FlashlightUseCount())
end

function ScriptTransLetterToPriest()
  ConsumeCoin(CHURCH_RECV_LETTER_COST)
  RemoveItem('i_letter', 1)
end

function ScriptUseFlashlight()
  RemoveItem('i_flashlight_use_count', 1)
end
