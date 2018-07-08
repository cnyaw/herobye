
local help_pinky_lvl_id = 318

local brother1_tex_id = 280
local brother2_tex_id = 281
local merchant_tex_id = 305
local pinnote_tex_id = 314
local priest_tex_id = 304
local teacher_tex_id = 276
local dog_tex_id = 2
local pinky_tex_id = 316
local grandpa_tex_id = 327
local zhang_mama_tex_id = 329

teacher_done_talk_id = 50

TalkData = {
  -- Teacher, ini.
  [1] = {
    {Image = teacher_tex_id},
    {Text = '小秋徒兒你來啦！'},
    {Text = '勇者山上的修行告一段落'},
    {Text = '你可以下山磨練磨練了'},
    {Text = '作完功課後再來見我吧'},
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
    {Text = '二師兄真替你開心'},
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
    {Text = '小師父好久不見'},
    {Text = '生意愈作愈大啦'},
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
    {Text = '吳神父是我的老朋友'},
    {Text = '將信交給他後他會招待你'},
    {Text = '你就好好體驗一下吧'},
    {Script = ScriptSendTeacherMail},
    {LevelId = MAIN_MAP_LVL_ID},
  },
  -- Church, get mail from priest.
  [1150] = {
    {Image = priest_tex_id},
    {Text = '小兄弟你辛苦了啦'},
    {Text = '從勇者山帶來這封信應該累了吧'},
    {Text = '請到後面讓我們為你馬殺雞'},
    {Text = string.format('友情價算你%d塊錢', CHURCH_RECV_MAIL_COST)},
    {Script = ScriptTransMailToPriest},
    {Image = -1},
    {Text = ''},
    {FadeTo = {60, 0xff000000}},
    {Text = '「好舒服啊快要睡著了」'},
    {Text = 'ZZZ ZZZ ZZZ'},
    {Text = '救命啊'},
    {Text = '來人啊'},
    {Text = ''},
    {FadeTo = {60, 0xff808000}},
    {Text = '救命啊'},
    {Text = '來人啊'},
    {Text = '「哇塞有人在喊救命了」'},
    {Text = '「該是輪到勇者我出場的時候了」'},
    {Image = dog_tex_id},
    {Text = '汪汪汪！汪汪汪！'},
    {Text = '「噓～安靜不要吵！」'},
    {Text = '「我現在要過去看看」'},
    {Text = '「小白二號不要怕！」'},
    {Text = '「你在後面掩護我」'},
    {Image = pinky_tex_id},
    {Text = '「豬小妹原來是妳啊！」'},
    {Text = '「豬小妹豬小妹妳怎麼了？」'},
    {Text = '救命啊有小強啊！'},
    {Image = dog_tex_id},
    {Text = '「來啊！進攻！」'},
    {LevelId = help_pinky_lvl_id},
  },
  [1151] = {
    {Image = pinky_tex_id},
    {Text = '謝謝你小白^^'},
    {Text = '「呵呵呵我是勇者小白!」'},
    {Text = '「我的任務是維護世界的和平！」'},
    {Text = ''},
    {Image = -1},
    {FadeTo = {60, 0xff000000}},
    {FadeTo = {60, 0xff808000}},
    {Image = priest_tex_id},
    {Text = '小兄弟你醒啦'},
    {Text = '看你睡的那麼熟'},
    {Text = '應該休息夠了吧'},
    {Text = '以後累了歡迎再來抓龍哦'},
    {Image = -1},
    {Text = '「原來是個夢」'},
    {LevelId = MAIN_MAP_LVL_ID},
  },
  [1152] = {
    {Image = priest_tex_id},
    {Text = '你累了嗎'},
    {Text = '請到後面讓我們為你馬殺雞'},
    {Text = string.format('特價算你%d塊錢', CHURCH_2ND_DREAM_COST)},
    {Script = Consume2ndDreamCost},
    {Image = -1},
    {Text = ''},
    {FadeTo = {60, 0xff000000}},
    {Text = '「好舒服啊快要睡著了」'},
    {Text = 'ZZZ ZZZ ZZZ'},
    {Text = ''},
    {FadeTo = {60, 0xff808000}},
    {Image = grandpa_tex_id},
    {Text = '「爺爺爺爺」'},
    {Text = '「為什麼我們村叫作勇者村？」'},
    {Text = '小白啊總有一天你會了解的'},
    {Text = '「什麼時候呢？」'},
    {Text = '總有一天啊'},
    {Text = '先不談這個了'},
    {Text = '去把我的無敵不求人拿來'},
    {Text = '讓我抓抓癢先'},
    {Text = '「不求人就不求人」'},
    {Text = '「為什麼叫無敵不求人？」'},
    {Text = '這是我們家的傳家之寶'},
    {Text = '總有一天你會了解的'},
    {Text = '「...」'},
    {Text = ''},
    {Image = -1},
    {FadeTo = {60, 0xff000000}},
    {FadeTo = {60, 0xff808000}},
    {Image = priest_tex_id},
    {Text = '小兄弟你醒啦'},
    {Text = '恭喜你成為我們的VIP'},
    {Text = '以後累了歡迎再來抓龍哦'},
    {Image = -1},
    {Text = '「原來是個夢」'},
    {LevelId = MAIN_MAP_LVL_ID},
  },
  [1153] = {
    {Image = priest_tex_id},
    {Text = '你累了嗎抓個龍吧'},
    {Text = string.format('VIP特價%d塊錢哦', REST_COST)},
    {LevelId = MAIN_MAP_LVL_ID},
  },
  [1154] = {
    {Image = priest_tex_id},
    {Text = '來抓個龍吧'},
    {Script = ConsumeRestCost},
    {Image = -1},
    {Text = ''},
    {FadeTo = {60, 0xff000000}},
    {LevelId = HERO_VILLAGE_LVL_ID},
  },
  -- Temple, site prepare.
  [1200] = {
    {Image = pinnote_tex_id},
    {Text = '整備中'},
    {LevelId = MAIN_MAP_LVL_ID},
  },
  -- Hero village, church.
  [9000] = {
    {Image = grandpa_tex_id},
    {Text = '不要太調皮哦'},
    {LevelId = HERO_VILLAGE_LVL_ID},
  },
  -- Hero village, Zhang home.
  [10000] = {
    {Image = zhang_mama_tex_id},
    {Text = '每天都要洗好多衣服啊'},
    {LevelId = HERO_VILLAGE_LVL_ID},
  },
  -- Hero village, Shop.
  [11000] = {
    {Image = merchant_tex_id},
    {Text = '隨便看看有興趣再買哦'},
    {LevelId = HERO_VILLAGE_LVL_ID},
  },
  -- Hero village, Xiang home.
  [12000] = {
    {Image = pinky_tex_id},
    {Text = '小白要跟我一起玩哦'},
    {LevelId = HERO_VILLAGE_LVL_ID},
  },
  -- Hero village, hero home.
  [13000] = {
    {Text = '「維護世界的和平也是挺累的」'},
    {Text = '「讓我睡一下下吧」'},
    {Image = -1},
    {Text = ''},
    {FadeTo = {60, 0xff000000}},
    {FadeTo = {60, 0xff808000}},
    {Text = '「原來是個夢」'},
    {LevelId = MAIN_MAP_LVL_ID},
  },
}
