
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
  [1] = {
    {Image = teacher_tex_id},
    {Text = '小秋徒兒你來啦！'},
    {Text = '勇者山上的修行己經告一段落'},
    {Text = '是時候下山磨練磨練了'},
    {Text = '跟師兄們作完功課後再來見我吧'},
    {LevelId = TRAINING_MAP_LVL_ID},
  },
  -- Teacher, training complete.
  [50] = {
    {Image = teacher_tex_id},
    {Text = '小秋徒兒你跟師兄們作完功課了啊'},
    {Image = BOU_TEX_ID},
    {Text = '這個缽你帶下山吧'},
    {Text = '下山後好好修行'},
    {Image = teacher_tex_id},
    {Text = '要常回來勇者山看看哪'},
    {LevelId = MAIN_MAP_LVL_ID},
  },
  -- Teacher, come back.
  [80] = {
    {Image = teacher_tex_id},
    {Text = '勇猛精進！'},
    {LevelId = MAIN_MAP_LVL_ID},
  },
  -- Brother 1, init.
  [100] = {
    {Image = brother1_tex_id},
    {Text = '大師兄和你一起認真作功課'},
    {Text = '下山後可要好好的修行'},
    {LevelId = TRANINING_CLICK_LVL_ID},
  },
  -- Brother 1, done.
  [150] = {
    {Image = brother1_tex_id},
    {Text = '自強不息'},
    {LevelId = TRAINING_MAP_LVL_ID},
  },
  -- Brother 1, come back.
  [180] = {
    {Image = brother1_tex_id},
    {Text = '遇到困難了嗎？'},
    {LevelId = MAIN_MAP_LVL_ID},
  },
  -- Brother 2, init.
  [200] = {
    {Image = brother2_tex_id},
    {Text = '師弟啊二師兄真替你開心'},
    {Text = '撿完材火後就可以下山去修練了'},
    {Text = '別太貪玩哪'},
    {LevelId = TRANINING_STICK_LVL_ID},
  },
  -- Brother 2, done.
  [250] = {
    {Image = brother2_tex_id},
    {Text = '終於作完啦'},
    {LevelId = TRAINING_MAP_LVL_ID},
  },
  -- Brother 2, come back.
  [280] = {
    {Image = brother2_tex_id},
    {Text = '怎麼這麼快就回來啦'},
    {LevelId = MAIN_MAP_LVL_ID},
  },
  -- Merchant, buy bou2.
  [300] = {
    {Image = merchant_tex_id},
    {Text = '小師父這裡有個好東西讓你看看'},
    {Image = BOU2_TEX_ID},
    {Text = '這個缽很棒吧'},
    {Text = string.format('有縁價算你%d塊錢', BOU2_COST)},
    {Script = ScriptMerchantBuyBou2},
    {Image = merchant_tex_id},
    {Text = '銘謝惠顧'},
    {LevelId = MAIN_MAP_LVL_ID},
  },
  -- Merchant, buy bou3.
  [400] = {
    {Image = merchant_tex_id},
    {Text = '小師父好久不見生意愈作愈大啦'},
    {Text = '今日向您推薦個絕世好缽'},
    {Image = BOU3_TEX_ID},
    {Text = '怎麼樣這個缽是不是很棒啊'},
    {Text = string.format('今日特價算你%d塊錢', BOU3_COST)},
    {Script = ScriptMerchantBuyBou3},
    {Image = merchant_tex_id},
    {Text = '銘謝惠顧'},
    {LevelId = MAIN_MAP_LVL_ID},
  },
  -- Merchant, reset 1 talk.
  [450] = {
    {Image = pinnote_tex_id},
    {Text = '補貨中下次再來'},
    {LevelId = MAIN_MAP_LVL_ID},
  },
  -- Merchant, reset 2 talk.
  [500] = {
    {Image = pinnote_tex_id},
    {Text = '今日公休'},
    {LevelId = MAIN_MAP_LVL_ID},
  },
  -- Church, out.
  [1000] = {
    {Image = pinnote_tex_id},
    {Text = '有事外出'},
    {LevelId = MAIN_MAP_LVL_ID},
  },
  -- Teacher, send mail to priest.
  [1100] = {
    {Image = teacher_tex_id},
    {Text = '小秋徒兒你回來的正好'},
    {Image = LETTER_TEX_ID},
    {Text = '將這封信送到山下教堂給吳神父'},
    {Text = '吳神父是我的老朋友了'},
    {Text = '將這封信交給他後有人會招待你'},
    {Text = '你就好好體驗一下'},
    {Script = ScriptSendTeacherMail},
    {LevelId = MAIN_MAP_LVL_ID},
  },
  -- Church, get mail from priest.
  [1150] = {
    {Image = priest_tex_id},
    {Text = '小兄弟你辛苦了啦'},
    {Text = '從勇者山帶來這封信應該累了'},
    {Text = '請到後面讓我們為你馬殺雞'},
    {Text = '好好休息休息'},
    {Script = ScriptTransMailToPriest},
    {Image = -1},
    {Text = ''},
    {FadeTo = {60, 0xff000000}},
    {Text = '「好舒服啊快要睡著了」'},
    {Text = 'ZZZ ZZZ ZZZ'},
    {Text = '救命啊'},
    {Text = '來人啊'},
    {FadeTo = {60, 0xff808000}},
    {Text = '救命啊'},
    {Text = '「哇塞有人在叫救命了」'},
    {Text = '「該是輪到勇者我出場的時候了」'},
    {Image = dog_tex_id},
    {Text = '汪汪汪！汪汪汪！'},
    {Text = '「噓～安靜不要吵！」'},
    {Text = '「我現在要過去看看」'},
    {Text = '「小白二號不要怕！」'},
    {Text = '「你在後面掩護我」'},
    {Image = pinky_tex_id},
    {Text = '「豬小妹原來是妳啊！」'},
    {Text = '「豬小妹妳怎麼了？」'},
    {Text = '救命啊有小強啊！'},
    {Image = dog_tex_id},
    {Text = '「來啊！進攻！」'},
    {Text = ''},
    {Image = -1},
    {FadeTo = {60, 0xff000000}},
    {FadeTo = {60, 0xff808000}},
    {Image = pinky_tex_id},
    {Text = '謝謝你小白^^'},
    {Text = '「呵呵呵我是勇者小白!」'},
    {Text = '「我的任務是維護世界的和平！」'},
    {LevelId = MAIN_MAP_LVL_ID},
  },
  -- Temple, site prepare.
  [1200] = {
    {Image = pinnote_tex_id},
    {Text = '整備中'},
    {LevelId = MAIN_MAP_LVL_ID},
  },
}
