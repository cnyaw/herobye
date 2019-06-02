
-- item: i_xxx, flag: f_xxx, enum: e_xxx.

local bou_desc_id = 600
local bou2_desc_id = 601
local bou3_desc_id = 602
local letter_desc_id = 603
local godzilla_desc_id = 604
local back_scratcher_desc_id = 605
local flashlight_desc_id = 606
local mallet_desc_id = 607
local flashlight_nopower_desc_id = 608
local candy_desc_id = 609
local scissor_desc_id = 610

--[[
i_coin = 1
i_bou = 2
i_bou2 = 3
i_bou3 = 4
i_letter = 5
f_letter_sent = 6
f_finish_training = 7
f_last_lvl_id = 8
f_interview_ufo = 9
i_godzilla = 10
i_back_scratcher = 12
i_enter_cave_count = 13
i_hero_coin = 14
i_flashlight = 15
i_unlock_training_count = 16
f_open_cave_door = 17
i_mallet = 18
f_mallet_code = 19
i_flashlight_nopower = 20
f_buy_candy_loop = 21
i_candy = 22
i_scissor = 23
f_powerup_scissor = 24
--]]

e_main_bag = 1
e_hero_bag = 2

ItemData = {
  i_bou = {BagType = e_main_bag, Image = BOU_TEX_ID, TalkId = bou_desc_id},
  i_bou2 = {BagType = e_main_bag, Image = BOU2_TEX_ID, TalkId = bou2_desc_id},
  i_bou3 = {BagType = e_main_bag, Image = BOU3_TEX_ID, TalkId = bou3_desc_id},
  i_letter = {BagType = e_main_bag, Image = LETTER_TEX_ID, TalkId = letter_desc_id},
  i_godzilla = {BagType = e_main_bag, Image = GODZILLA_TEX_ID, TalkId = godzilla_desc_id},
  i_back_scratcher = {BagType = e_hero_bag, Image = BACK_SCRATCHER_TEX_ID, TalkId = back_scratcher_desc_id},
  i_flashlight = {BagType = e_hero_bag, Image = FLASHLIGHT_TEX_ID, TalkId = flashlight_desc_id},
  i_flashlight_nopower = {BagType = e_hero_bag, Image = FLASHLIGHT_TEX_ID, TalkId = flashlight_nopower_desc_id},
  i_mallet = {BagType = e_hero_bag, Image = MALLET_TEX_ID, TalkId = mallet_desc_id},
  i_candy = {BagType = e_hero_bag, Image = CANDY_TEX_ID, TalkId = candy_desc_id},
  i_scissor = {BagType = e_hero_bag, Image = SCISSOR_TEX_ID, TalkId = scissor_desc_id},
}
