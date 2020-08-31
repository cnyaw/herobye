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
i_rps_medal = 34
f_cave_maze_book = 35
i_cave_maze_book = 36
f_pass_potato_test = 37
f_help_elder_white = 38
i_shave_book = 39
f_help_elder_yellow = 40
i_dirty_yellow_suit = 41
i_super_soap_book = 42
i_green_mouse_tail = 43
i_red_mouse_tail = 44
i_yellow_mouse_tail = 45
i_super_soap = 46
i_clean_yellow_suit = 47
f_need_rope = 48
i_rope = 49
i_temple_lvl = 50
i_temple_score = 51
f_help_elder_glass = 52
f_find_ufo_power = 53
i_ufo_power_book = 54
i_ufo_power = 55
i_click_training_count = 56
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
local rps_medal_desc_id = 614
local dirty_yellow_suit_desc_id = 615
local super_soap_book_desc_id = 616
local green_mouse_tail_desc_id = 617
local red_mouse_tail_desc_id = 618
local yellow_mouse_tail_desc_id = 619
local super_soap_desc_id = 620
local clean_yellow_suit_desc_id = 621
local rope_desc_id = 622
local ufo_power_desc_id = 623

local hero_his_book_desc_id = 1350
local cave_door_book_desc_id = 1351
local power_scissor_book_desc_id = 1352
local slap_mouse_book_desc_id = 1353
local cave_maze_book_desc_id = 1354
local shave_book_desc_id = 1355
local ufo_power_book_desc_id = 1356

local flash_light_obj_id = 92

e_main_bag = 1
e_hero_bag = 2
e_book_lib = 3

ItemData = {
  -- main.
  i_bou = {BagType = e_main_bag, Image = BOU_TEX_ID, TalkId = bou_desc_id},
  i_bou2 = {BagType = e_main_bag, Image = BOU2_TEX_ID, TalkId = bou2_desc_id},
  i_bou3 = {BagType = e_main_bag, Image = BOU3_TEX_ID, TalkId = bou3_desc_id},
  i_letter = {BagType = e_main_bag, Image = LETTER_TEX_ID, TalkId = letter_desc_id},
  i_godzilla = {BagType = e_main_bag, Image = GODZILLA_TEX_ID, TalkId = godzilla_desc_id},
  -- hero.
  i_back_scratcher = {BagType = e_hero_bag, Image = BACK_SCRATCHER_TEX_ID, TalkId = back_scratcher_desc_id},
  i_flashlight = {BagType = e_hero_bag, Image = flash_light_obj_id, TalkId = flashlight_desc_id},
  i_mallet = {BagType = e_hero_bag, Image = MALLET_TEX_ID, TalkId = mallet_desc_id},
  i_candy = {BagType = e_hero_bag, Image = CANDY_TEX_ID, TalkId = candy_desc_id},
  i_scissor = {BagType = e_hero_bag, Image = SCISSOR_TEX_ID, TalkId = scissor_desc_id},
  i_frog_tear = {BagType = e_hero_bag, Image = FROG_TEAR_TEX_ID, TalkId = frog_tear_desc_id},
  i_drum_stick = {BagType = e_hero_bag, Image = DRUM_STICK_TEX_ID, TalkId = drum_stick_desc_id},
  i_power_scissor = {BagType = e_hero_bag, Image = SCISSOR_TEX_ID, TalkId = power_scissor_desc_id},
  i_rps_medal = {BagType = e_hero_bag, Image = RPS_MEDAL_TEX_ID, TalkId = rps_medal_desc_id},
  i_dirty_yellow_suit = {BagType = e_hero_bag, Image = DIRTY_YELLOW_SUIT_OBJ_ID, TalkId = dirty_yellow_suit_desc_id},
  i_green_mouse_tail = {BagType = e_hero_bag, Image = GREEN_MOUSE_TAIL_OBJ_ID, TalkId = green_mouse_tail_desc_id},
  i_red_mouse_tail = {BagType = e_hero_bag, Image = RED_MOUSE_TAIL_OBJ_ID, TalkId = red_mouse_tail_desc_id},
  i_yellow_mouse_tail = {BagType = e_hero_bag, Image = YELLOW_MOUSE_TAIL_OBJ_ID, TalkId = yellow_mouse_tail_desc_id},
  i_super_soap = {BagType = e_hero_bag, Image = SUPER_SOAP_TEX_ID, TalkId = super_soap_desc_id},
  i_clean_yellow_suit = {BagType = e_hero_bag, Image = CLEAN_YELLOW_SUIT_OBJ_ID, TalkId = clean_yellow_suit_desc_id},
  i_rope = {BagType = e_hero_bag, Image = ROPE_TEX_ID, TalkId = rope_desc_id},
  i_ufo_power = {BagType = e_hero_bag, Image = UFO_POWER_TEX_ID, TalkId = ufo_power_desc_id},
  -- book.
  i_hero_history_book = {BagType = e_book_lib, Image = HERO_HIS_BOOK_TEX_ID, TalkId = hero_his_book_desc_id},
  i_cave_door_book = {BagType = e_book_lib, Image = CAVE_DOOR_BOOK_TEX_ID, TalkId = cave_door_book_desc_id},
  i_power_scissor_book = {BagType = e_book_lib, Image = POWER_SCISSOR_BOOK_TEX_ID, TalkId = power_scissor_book_desc_id},
  i_slap_mouse_book = {BagType = e_book_lib, Image = SLAP_MOUSE_BOOK_TEX_ID, TalkId = slap_mouse_book_desc_id},
  i_cave_maze_book = {BagType = e_book_lib, Image = CAVE_MAZE_BOOK_TEX_ID, TalkId = cave_maze_book_desc_id},
  i_shave_book = {BagType = e_book_lib, Image = SHAVE_BOOK_TEX_ID, TalkId = shave_book_desc_id},
  i_super_soap_book = {BagType = e_book_lib, Image = SUPER_SOAP_BOOK_TEX_ID, TalkId = super_soap_book_desc_id},
  i_ufo_power_book = {BagType = e_book_lib, Image = UFO_POWER_BOOK_TEX_ID, TalkId = ufo_power_book_desc_id},
}
