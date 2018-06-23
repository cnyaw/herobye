
local brother1_tex_id = 280
local brother2_tex_id = 281
local merchant_tex_id = 305
local pinnote_tex_id = 314
local priest_tex_id = 304
local teacher_tex_id = 276

teacher_done_talk_id = 50

TalkData = {
 -- Teacher, ini.
 [1] = {Image = teacher_tex_id, Next = 2},
 [2] = {Text = '小秋徒兒你來啦！', Next = 3},
 [3] = {Text = '你在勇者山上的修行己經告一段落', Next = 4},
 [4] = {Text = '是時候下山磨練磨練了！', Next = 5},
 [5] = {Text = '跟師兄們作完功課後再來見我吧', Next = 6},
 [6] = {LevelId = TRAINING_MAP_LVL_ID},
 -- Teacher, training complete.
 [50] = {Image = teacher_tex_id, Next = 51},
 [51] = {Text = '小秋徒兒你跟師兄們作完功課了啊', Next = 52},
 [52] = {Image = BOU_TEX_ID, Next = 53},
 [53] = {Text = '這個缽你帶下山吧', Next = 54},
 [54] = {Text = '下山後好好修行', Next = 55},
 [55] = {Image = teacher_tex_id, Next = 56},
 [56] = {Text = '要常回來勇者山看看哪', Next = 57},
 [57] = {LevelId = MAIN_MAP_LVL_ID},
 -- Teacher, come back.
 [80] = {Image = teacher_tex_id, Next = 81},
 [81] = {Text = '勇猛精進！', Next = 82},
 [82] = {LevelId = MAIN_MAP_LVL_ID},
 -- Brother 1, init.
 [100] = {Image = brother1_tex_id, Next = 101},
 [101] = {Text = '大師兄和你一起認真作功課', Next = 102},
 [102] = {Text = '下山後你可要好好的修行', Next = 103},
 [103] = {LevelId = TRANINING_CLICK_LVL_ID},
 -- Brother 1, done.
 [150] = {Image = brother1_tex_id, Next = 151},
 [151] = {Text = '自強不息', Next = 152},
 [152] = {LevelId = TRAINING_MAP_LVL_ID},
 -- Brother 1, come back.
 [180] = {Image = brother1_tex_id, Next = 181},
 [181] = {Text = '遇到困難了嗎？', Next = 182},
 [182] = {LevelId = MAIN_MAP_LVL_ID},
 -- Brother 2, init.
 [200] = {Image = brother2_tex_id, Next = 201},
 [201] = {Text = '師弟啊二師兄真替你開心', Next = 202},
 [202] = {Text = '撿完材火後你就可以下山去修練了', Next = 203},
 [203] = {Text = '別太貪玩哪', Next = 204},
 [204] = {LevelId = TRANINING_STICK_LVL_ID},
 -- Brother 2, done.
 [250] = {Image = brother2_tex_id, Next = 251},
 [251] = {Text = '終於作完啦', Next = 252},
 [252] = {LevelId = TRAINING_MAP_LVL_ID},
 -- Brother 2, come back.
 [280] = {Image = brother2_tex_id, Next = 281},
 [281] = {Text = '怎麼這麼快就回來啦', Next = 282},
 [282] = {LevelId = MAIN_MAP_LVL_ID},
 -- Merchant, buy bou2.
 [300] = {Image = merchant_tex_id, Next = 301},
 [301] = {Text = '小帥父這裡有個好東西讓你看看', Next = 302},
 [302] = {Image = BOU2_TEX_ID, Next = 303},
 [303] = {Text = '這個缽很棒吧', Next = 304},
 [304] = {Text = string.format('有縁價算你%d塊錢', BOU2_COST), Next = 305},
 [305] = {Script = ScriptMerchantBuyBou2, Next = 306},
 [306] = {Image = merchant_tex_id, Next = 307},
 [307] = {Text = '銘謝惠顧', Next = 308},
 [308] = {LevelId = MAIN_MAP_LVL_ID},
 -- Merchant, buy bou3.
 [400] = {Image = merchant_tex_id, Next = 401},
 [401] = {Text = '小帥父好久不見生意愈作愈大啦', Next = 402},
 [402] = {Text = '今日向您推薦個絕世好缽', Next = 403},
 [403] = {Image = BOU3_TEX_ID, Next = 404},
 [404] = {Text = '怎麼樣這個缽是不是很棒啊', Next = 405},
 [405] = {Text = string.format('今日特價算你%d塊錢', BOU3_COST), Next = 406},
 [406] = {Script = ScriptMerchantBuyBou3, Next = 407},
 [407] = {Image = merchant_tex_id, Next = 408},
 [408] = {Text = '銘謝惠顧', Next = 409},
 [409] = {LevelId = MAIN_MAP_LVL_ID},
 -- Merchant, reset 1 talk.
 [450] = {Image = pinnote_tex_id, Next = 451},
 [451] = {Text = '補貨中下次再來', Next = 452},
 [452] = {LevelId = MAIN_MAP_LVL_ID},
 -- Merchant, reset 2 talk.
 [500] = {Image = pinnote_tex_id, Next = 501},
 [501] = {Text = '今日公休', Next = 502},
 [502] = {LevelId = MAIN_MAP_LVL_ID},
 -- Church, out.
 [1000] = {Image = pinnote_tex_id, Next = 1001},
 [1001] = {Text = '有事外出', Next = 1002},
 [1002] = {LevelId = MAIN_MAP_LVL_ID},
 -- Teacher, send mail to priest.
 [1100] = {Image = teacher_tex_id, Next = 1101},
 [1101] = {Text = '小秋徒兒你回來的正好', Next = 1102},
 [1102] = {Image = LETTER_TEX_ID, Next = 1103},
 [1103] = {Text = '將這封信送到山下教堂給吳神父', Next = 1104},
 [1104] = {Text = '其它沒什麼了你好好修行吧', Next = 1105},
 [1105] = {Script = ScriptSendTeacherMail, Next = 1106},
 [1106] = {LevelId = MAIN_MAP_LVL_ID},
 -- Church, get mail from priest.
 [1150] = {Image = priest_tex_id, Next = 1151},
 [1151] = {Text = '小兄弟辛苦了啦', Next = 1152},
 [1152] = {Text = '從勇者山帶來這封信應該累了', Next = 1153},
 [1153] = {Text = '請到後面讓專人為你馬一下', Next = 1154},
 [1154] = {Text = '好好休息休息', Next = 1155},
 [1155] = {Script = ScriptTransMailToPriest, Next = 1156},
 [1156] = {LevelId = MAIN_MAP_LVL_ID},
 -- Temple, site prepare.
 [1200] = {Image = pinnote_tex_id, Next = 1201},
 [1201] = {Text = '整備中', Next = 1202},
 [1202] = {LevelId = MAIN_MAP_LVL_ID},
}
