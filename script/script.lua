
local SELL_ITEM_COST = 4

Script = {}

function Script.AddBackScratcher()
  SetItem('i_back_scratcher', 1)
end

function Script.AddBou1()
  SetItem('i_bou', 1)
end

function Script.AddCaveDoorBook()
  SetItem('i_cave_door_book', 1)
end

function Script.AddCaveMazeBookFlag()
  SetItem('f_cave_maze_book', 1)
  SetItem('f_open_cave_door', 0)
end

function Script.AddCaveMazeBook()
  RemoveItem('f_cave_maze_book', 1)
  SetItem('i_cave_maze_book', 1)
end

function Script.AddDipsyFeather()
  SetItem('i_dipsy_feather', 1)
end

function Script.AddDrumStick()
  SetItem('i_drum_stick', 1)
end

function Script.AddEarthWorm()
  SetItem('i_earthworm', 1)
end

function Script.AddFish()
  SetItem('i_fish', 1)
end

function Script.AddFrogTear()
  SetItem('i_frog_tear', 1)
end

function Script.AddHeroHisBook()
  SetItem('i_hero_history_book', 1)
end

function Script.AddJewel()
  SetItem('i_jewel', 1)
end

function Script.AddKingPermission()
  SetItem('f_king_permission', 1)
end

function Script.AddLaaLaaFeather()
  SetItem('i_laalaa_feather', 1)
end

function Script.AddMellet()
  SetItem('f_mallet_code', 0)
  SetItem('i_mallet', 1)
end

function Script.AddPoFeather()
  SetItem('i_po_feather', 1)
end

function Script.AddPowerScissorBook()
  SetItem('i_power_scissor_book', 1)
end

function Script.AddRope()
  SetItem('f_need_rope', 0)
  SetItem('i_rope', 1)
end

function Script.AddRpsMedal()
  SetItem('i_rps_medal', 1)
end

function Script.AddShaveBook()
  SetItem('i_shave_book', 1)
end

function Script.AddSlapMouseBook()
  SetItem('i_slap_mouse_book', 1)
end

function Script.AddSuperSoap()
  SetItem('i_frog_tear', 0)
  SetItem('i_green_mouse_tail', 0)
  SetItem('i_red_mouse_tail', 0)
  SetItem('i_yellow_mouse_tail', 0)
  SetItem('i_super_soap', 1)
end

function Script.AddSuperSoapBook()
  SetItem('i_super_soap_book', 1)
end

function Script.AddTinkyWinkyFeather()
  SetItem('i_tinky_winky_feather', 1)
end

function Script.AddUfoPower()
  SetItem('i_ufo_power', 1)
  SetItem('f_find_ufo_power', 0)
end

function Script.AddUfoPowerBook()
  SetItem('i_ufo_power_book', 1)
end

function Script.BatCaveBlocked()
  SetItem('f_bat_cave_blocked', 1)
end

function Script.BuildTemple()
  ConsumeCoin(CROWD_FUNDING_COST)
end

function Script.BuyBou2()
  ConsumeCoin(BOU2_COST)
  SetItem('i_bou2', 1)
end

function Script.BuyBou3()
  ConsumeCoin(BOU3_COST)
  SetItem('i_bou3', 1)
end

function Script.BuyCandy()
  ConsumeCoin(CANDY_COST)
  SetItem('i_candy', 1)
  SetItem('f_buy_candy_loop', 0)
end

function Script.BuyCandyLoop()
  SetItem('f_buy_candy_loop', 1)
end

function Script.BuyFlashlight()
  ConsumeCoin(FLASHLIGHT_COST)
  SetItem('i_flashlight', 1)
  SetItem('i_flashlight_use_count', MAX_FLASH_LIGHT_USE_COUNT)
end

function Script.BuyShip()
  ConsumeCoin(SHIP_COST)
  SetItem('f_ship', 1)
end

function Script.ChargeFlashlight()
  Script.BuyFlashlight()
end

function Script.CleanYellowSuit()
  SetItem('i_super_soap', 0)
  SetItem('i_dirty_yellow_suit', 0)
  SetItem('i_clean_yellow_suit', 1)
end

function Script.ConsumeUfoPower()
  SetItem('i_ufo_power', 0)
end

function Script.EnterCave()
  AddItem('i_enter_cave_count', 1)
end

function Script.ExchangeCandyScissor()
  SetItem('i_candy', 0)
  SetItem('i_scissor', 1)
end

function Script.FeedEarthWormToBird()
  SetItem('i_earthworm', 0)
end

function Script.FindTeletubbies()
  SetItem('f_find_teletubbies', 1)
end

function Script.FindUfoPower()
  SetItem('f_find_ufo_power', 1)
end

function Script.GetMalletCode()
  SetItem('f_mallet_code', 1)
end

function Script.GiveAllowance()
  AddCoin(10)
end

function Script.GiveGodzilla()
  SetItem('i_godzilla', 1);
end

function Script.HelpElderGlass()
  SetItem('f_help_elder_glass', 1)
end

function Script.HelpElderWhite()
  SetItem('f_help_elder_white', 1)
end

function Script.HelpElderYellow()
  SetItem('f_help_elder_yellow', 1)
  SetItem('i_dirty_yellow_suit', 1)
end

function Script.HelpElderGlassDone()
  SetItem('i_super_nano_towel', 0)
end

function Script.HelpElderYellowDone()
  SetItem('i_clean_yellow_suit', 0)
end

function Script.HeroMtNextId()
  local id = {51, 180, 280}
  return id[math.random(3)]
end

function Script.MakeSuperNanoTowel()
  SetItem('i_dipsy_feather', 0)
  SetItem('i_laalaa_feather', 0)
  SetItem('i_po_feather', 0)
  SetItem('i_tinky_winky_feather', 0)
  SetItem('f_find_teletubbies', 0)
  SetItem('i_super_nano_towel', 1)
end

function Script.OpenBatCave()
  SetItem('f_bat_cave_blocked', 0)
end

function Script.OpenCaveDoor()
  SetItem('f_open_cave_door', 1)
end

function Script.PassPotatoTest()
  SetItem('f_pass_potato_test', 1)
end

function Script.PlayLottery()
  ConsumeCoin(LOTTERY_COST)
end

function Script.PowerupScissor()
  RemoveItem('i_scissor', 1)
  RemoveItem('i_drum_stick', 1)
  RemoveItem('i_frog_tear', 1)
  RemoveItem('f_powerup_scissor', 1)
  SetItem('i_power_scissor', 1)
end

function Script.PowerupScissorLoop()
  SetItem('f_powerup_scissor', 1)
end

function Script.SellEarthWorm()
  SetItem('i_earthworm', 0)
  AddCoin(2 * SELL_ITEM_COST)
end

function Script.SellFeather()
  local item = {'i_po_feather', 'i_laalaa_feather', 'i_tinky_winky_feather', 'i_dipsy_feather'}
  Script.SellItems_i(item, 2 * SELL_ITEM_COST)
end

function Script.SellFish()
  SetItem('i_fish', 0)
  AddCoin(5 * SELL_ITEM_COST)
end

function Script.SellFishToFishman()
  SetItem('i_fish', 0)
  AddCoin(SELL_ITEM_COST)
end

function Script.SellFrogTear()
  SetItem('i_frog_tear', 0)
  AddCoin(SELL_ITEM_COST)
end

function Script.SellItems_i(item, num)
  for i = 1, #item do
    if (HasItem(item[i])) then
      SetItem(item[i], 0)
      AddCoin(num)
    end
  end
end

function Script.SellJewel()
  SetItem('i_jewel', 0)
  AddCoin(3 * SELL_ITEM_COST)
end

function Script.SellMouseTail()
  local item = {'i_green_mouse_tail', 'i_red_mouse_tail', 'i_yellow_mouse_tail'}
  Script.SellItems_i(item, SELL_ITEM_COST)
end

function Script.SellSuperNanoTowel()
  SetItem('i_super_nano_towel', 0)
  AddCoin(6 * SELL_ITEM_COST)
end

function Script.SendTeacherLetter()
  SetItem('i_letter', 1)
end

function Script.SetNeedRopeFlag()
  SetItem('f_need_rope', 1)
end

function Script.TakeJewel()
  SetItem('i_jewel', 0)
end

function Script.TempleCreated()
  SetItem('i_temple_lvl', 1)
end

function Script.TextAddMouseTail(fmt)
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

function Script.TextCrowdFunding(fmt)
  return string.format(fmt, CROWD_FUNDING_COST - GetCoin())
end

function Script.TextFlashlightUseCount(fmt)
  return string.format(fmt, FlashlightUseCount())
end

function Script.TransLetterToPriest()
  ConsumeCoin(CHURCH_RECV_LETTER_COST)
  RemoveItem('i_letter', 1)
end

function Script.UseFlashlight()
  RemoveItem('i_flashlight_use_count', 1)
end
