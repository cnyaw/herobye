
-- item: i_xxx, flag: f_xxx, enum: e_xxx.

local bou_desc_id = 600
local bou2_desc_id = 601
local bou3_desc_id = 602
local letter_desc_id = 603
local godzilla_desc_id = 604
local back_scratcher_desc_id = 605

i_coin = 1
i_bou = 2
i_bou2 = 3
i_bou3 = 4
i_letter = 5
f_letter_sent = 6
f_finish_training = 7
f_in_place = 8                          -- Last lvl id.
f_interview_ufo = 9
i_godzilla = 10
f_crowd_funding = 11
i_back_scratcher = 12
i_enter_cave = 13
i_coin_hero = 14

e_main_bag = 1
e_hero_bag = 2

ItemData = {
  [i_bou] = {BagType = e_main_bag, Image = BOU_TEX_ID, TalkId = bou_desc_id},
  [i_bou2] = {BagType = e_main_bag, Image = BOU2_TEX_ID, TalkId = bou2_desc_id},
  [i_bou3] = {BagType = e_main_bag, Image = BOU3_TEX_ID, TalkId = bou3_desc_id},
  [i_letter] = {BagType = e_main_bag, Image = LETTER_TEX_ID, TalkId = letter_desc_id},
  [i_godzilla] = {BagType = e_main_bag, Image = GODZILLA_TEX_ID, TalkId = godzilla_desc_id},
  [i_back_scratcher] = {BagType = e_hero_bag, Image = BACK_SCRATCHER_TEX_ID, TalkId = back_scratcher_desc_id}
}
