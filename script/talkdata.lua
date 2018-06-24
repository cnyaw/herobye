
local brother1_tex_id = 280
local brother2_tex_id = 281
local merchant_tex_id = 305
local pinnote_tex_id = 314
local priest_tex_id = 304
local teacher_tex_id = 276
local dog_tex_id = 2
local pinky_tex_id = 316

teacher_done_talk_id = 50

TalkData = {
 -- Teacher, ini.
 [1] = {Image = teacher_tex_id},
 [2] = {Text = '小秋徒兒你來啦！'},
 [3] = {Text = '勇者山上的修行己經告一段落'},
 [4] = {Text = '是時候下山磨練磨練了'},
 [5] = {Text = '跟師兄們作完功課後再來見我吧'},
 [6] = {LevelId = TRAINING_MAP_LVL_ID},
 -- Teacher, training complete.
 [50] = {Image = teacher_tex_id},
 [51] = {Text = '小秋徒兒你跟師兄們作完功課了啊'},
 [52] = {Image = BOU_TEX_ID},
 [53] = {Text = '這個缽你帶下山吧'},
 [54] = {Text = '下山後好好修行'},
 [55] = {Image = teacher_tex_id},
 [56] = {Text = '要常回來勇者山看看哪'},
 [57] = {LevelId = MAIN_MAP_LVL_ID},
 -- Teacher, come back.
 [80] = {Image = teacher_tex_id},
 [81] = {Text = '勇猛精進！'},
 [82] = {LevelId = MAIN_MAP_LVL_ID},
 -- Brother 1, init.
 [100] = {Image = brother1_tex_id},
 [101] = {Text = '大師兄和你一起認真作功課'},
 [102] = {Text = '下山後可要好好的修行'},
 [103] = {LevelId = TRANINING_CLICK_LVL_ID},
 -- Brother 1, done.
 [150] = {Image = brother1_tex_id},
 [151] = {Text = '自強不息'},
 [152] = {LevelId = TRAINING_MAP_LVL_ID},
 -- Brother 1, come back.
 [180] = {Image = brother1_tex_id},
 [181] = {Text = '遇到困難了嗎？'},
 [182] = {LevelId = MAIN_MAP_LVL_ID},
 -- Brother 2, init.
 [200] = {Image = brother2_tex_id},
 [201] = {Text = '師弟啊二師兄真替你開心'},
 [202] = {Text = '撿完材火後就可以下山去修練了'},
 [203] = {Text = '別太貪玩哪'},
 [204] = {LevelId = TRANINING_STICK_LVL_ID},
 -- Brother 2, done.
 [250] = {Image = brother2_tex_id},
 [251] = {Text = '終於作完啦'},
 [252] = {LevelId = TRAINING_MAP_LVL_ID},
 -- Brother 2, come back.
 [280] = {Image = brother2_tex_id},
 [281] = {Text = '怎麼這麼快就回來啦'},
 [282] = {LevelId = MAIN_MAP_LVL_ID},
 -- Merchant, buy bou2.
 [300] = {Image = merchant_tex_id},
 [301] = {Text = '小帥父這裡有個好東西讓你看看'},
 [302] = {Image = BOU2_TEX_ID},
 [303] = {Text = '這個缽很棒吧'},
 [304] = {Text = string.format('有縁價算你%d塊錢', BOU2_COST)},
 [305] = {Script = ScriptMerchantBuyBou2},
 [306] = {Image = merchant_tex_id},
 [307] = {Text = '銘謝惠顧'},
 [308] = {LevelId = MAIN_MAP_LVL_ID},
 -- Merchant, buy bou3.
 [400] = {Image = merchant_tex_id},
 [401] = {Text = '小帥父好久不見生意愈作愈大啦'},
 [402] = {Text = '今日向您推薦個絕世好缽'},
 [403] = {Image = BOU3_TEX_ID},
 [404] = {Text = '怎麼樣這個缽是不是很棒啊'},
 [405] = {Text = string.format('今日特價算你%d塊錢', BOU3_COST)},
 [406] = {Script = ScriptMerchantBuyBou3},
 [407] = {Image = merchant_tex_id},
 [408] = {Text = '銘謝惠顧'},
 [409] = {LevelId = MAIN_MAP_LVL_ID},
 -- Merchant, reset 1 talk.
 [450] = {Image = pinnote_tex_id},
 [451] = {Text = '補貨中下次再來'},
 [452] = {LevelId = MAIN_MAP_LVL_ID},
 -- Merchant, reset 2 talk.
 [500] = {Image = pinnote_tex_id},
 [501] = {Text = '今日公休'},
 [502] = {LevelId = MAIN_MAP_LVL_ID},
 -- Church, out.
 [1000] = {Image = pinnote_tex_id},
 [1001] = {Text = '有事外出'},
 [1002] = {LevelId = MAIN_MAP_LVL_ID},
 -- Teacher, send mail to priest.
 [1100] = {Image = teacher_tex_id},
 [1101] = {Text = '小秋徒兒你回來的正好'},
 [1102] = {Image = LETTER_TEX_ID},
 [1103] = {Text = '將這封信送到山下教堂給吳神父'},
 [1104] = {Text = '吳神父我我是老友了'},
 [1105] = {Text = '你將這封信交給他後他會招待你'},
 [1106] = {Text = '你就好好體驗一下'},
 [1107] = {Script = ScriptSendTeacherMail},
 [1108] = {LevelId = MAIN_MAP_LVL_ID},
 -- Church, get mail from priest.
 [1150] = {Image = priest_tex_id},
 [1151] = {Text = '小兄弟你辛苦了啦'},
 [1152] = {Text = '從勇者山帶來這封信應該累了'},
 [1153] = {Text = '請到後面讓我們為你馬殺雞'},
 [1154] = {Text = '好好休息休息'},
 [1155] = {Script = ScriptTransMailToPriest},
 [1156] = {Image = -1},
 [1157] = {Text = ''},
 [1158] = {FadeTo = {60, 0xff000000}},
 [1159] = {Text = '「好舒服啊快要睡著了」'},
 [1160] = {Text = 'ZZZ ZZZ ZZZ'},
 [1161] = {Text = '救命啊'},
 [1162] = {Text = '來人啊'},
 [1163] = {FadeTo = {60, 0xff808000}},
 [1164] = {Text = '救命啊'},
 [1165] = {Text = '「哇塞有人在叫救命了」'},
 [1166] = {Text = '「該是輪到勇者我出場的時候了」'},
 [1167] = {Image = dog_tex_id},
 [1168] = {Text = '汪汪汪汪汪汪'},
 [1169] = {Text = '「噓～安靜不要吵！」'},
 [1170] = {Text = '「我現在要過去看看」'},
 [1171] = {Text = '「小白二號你在後面掩護我不要怕」'},
 [1172] = {Image = pinky_tex_id},
 [1173] = {Text = '「豬小妹原來是妳啊！」'},
 [1174] = {Text = '「豬小妹妳怎麼了？」'},
 [1175] = {Text = '救命啊有小強啊！'},
 [1176] = {Image = dog_tex_id},
 [1177] = {Text = '「來啊！進攻！」'},
 [1178] = {Text = ''},
 [1179] = {Image = -1},
 [1180] = {FadeTo = {60, 0xff000000}},
 [1181] = {FadeTo = {60, 0xff808000}},
 [1182] = {Image = pinky_tex_id},
 [1183] = {Text = '謝謝你小白'},
 [1184] = {Text = '「呵呵呵我是勇者小白」'},
 [1185] = {Text = '「我的任務是維護世界的和平！」'},
 [1186] = {LevelId = MAIN_MAP_LVL_ID},
 -- Temple, site prepare.
 [1200] = {Image = pinnote_tex_id},
 [1201] = {Text = '整備中'},
 [1202] = {LevelId = MAIN_MAP_LVL_ID},
}
