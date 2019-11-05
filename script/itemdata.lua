--[[
item: i_xxx, flag: f_xxx, enum: e_xxx.
i_coin = 1
i_bou = 2
i_bou2 = 3
i_bou3 = 4
i_letter = 5
f_finish_training = 7
f_last_lvl_id = 8
i_godzilla = 10
i_back_scratcher = 12
i_enter_cave_count = 13
i_hero_coin = 14
i_flashlight = 15
f_open_cave_door = 17
i_mallet = 18
f_mallet_code = 19
f_buy_candy_loop = 21
i_candy = 22
i_scissor = 23
f_powerup_scissor = 24
i_hero_history_book = 25,
i_cave_door_book = 26
i_power_scissor_book = 27
i_frog_tear = 28
i_flashlight_use_count = 29
i_slap_mouse_book = 31
i_drum_stick = 32
i_power_scissor = 33
--]]

local bou_desc_id = 600
local bou2_desc_id = 601
local bou3_desc_id = 602
local letter_desc_id = 603
local godzilla_desc_id = 604
local back_scratcher_desc_id = 605
local flashlight_desc_id = 606
local mallet_desc_id = 607
local candy_desc_id = 609
local scissor_desc_id = 610
local frog_tear_desc_id = 611
local drum_stick_desc_id = 612
local power_scissor_desc_id = 613

local hero_his_book_desc_id = 1350
local cave_door_book_desc_id = 1351
local power_scissor_book_desc_id = 1352
local slap_mouse_book_desc_id = 1353

e_main_bag = 1
e_hero_bag = 2
e_book_lib = 3

ItemData = {
  i_bou = {BagType = e_main_bag, Image = BOU_TEX_ID, TalkId = bou_desc_id},
  i_bou2 = {BagType = e_main_bag, Image = BOU2_TEX_ID, TalkId = bou2_desc_id},
  i_bou3 = {BagType = e_main_bag, Image = BOU3_TEX_ID, TalkId = bou3_desc_id},
  i_letter = {BagType = e_main_bag, Image = LETTER_TEX_ID, TalkId = letter_desc_id},
  i_godzilla = {BagType = e_main_bag, Image = GODZILLA_TEX_ID, TalkId = godzilla_desc_id},
  i_back_scratcher = {BagType = e_hero_bag, Image = BACK_SCRATCHER_TEX_ID, TalkId = back_scratcher_desc_id},
  i_flashlight = {BagType = e_hero_bag, Image = FLASHLIGHT_TEX_ID, TalkId = flashlight_desc_id},
  i_mallet = {BagType = e_hero_bag, Image = MALLET_TEX_ID, TalkId = mallet_desc_id},
  i_candy = {BagType = e_hero_bag, Image = CANDY_TEX_ID, TalkId = candy_desc_id},
  i_scissor = {BagType = e_hero_bag, Image = SCISSOR_TEX_ID, TalkId = scissor_desc_id},
  i_hero_history_book = {BagType = e_book_lib, Image = HERO_HIS_BOOK_TEX_ID, TalkId = hero_his_book_desc_id},
  i_cave_door_book = {BagType = e_book_lib, Image = CAVE_DOOR_BOOK_TEX_ID, TalkId = cave_door_book_desc_id},
  i_power_scissor_book = {BagType = e_book_lib, Image = POWER_SCISSOR_BOOK_TEX_ID, TalkId = power_scissor_book_desc_id},
  i_frog_tear = {BagType = e_hero_bag, Image = FROG_TEAR_TEX_ID, TalkId = frog_tear_desc_id},
  i_slap_mouse_book = {BagType = e_book_lib, Image = SLAP_MOUSE_BOOK_TEX_ID, TalkId = slap_mouse_book_desc_id},
  i_drum_stick = {BagType = e_hero_bag, Image = DRUM_STICK_TEX_ID, TalkId = drum_stick_desc_id},
  i_power_scissor = {BagType = e_hero_bag, Image = SCISSOR_TEX_ID, TalkId = power_scissor_desc_id},
}
