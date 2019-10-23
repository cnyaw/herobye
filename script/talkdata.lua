
local help_pinky_lvl_id = 318
local racing_lvl_id = 330
local interview_hero_village_lvl_id = 331
local clothes_drying_lvl_id = 340
local seek_frog_lvl_id = 24
local slap_mouse_lvl_id = 54

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
local ufo_tex_id = 343
local frog_tex_id = 357
local cave_door_tex_id = 0
local chest_tex_id = 13
local pinky_papa_tex_id = 20
local kai_tex_id = 49

local color_olive = 0xff808000

TalkData = {
  -- Teacher.
  [1] = {
    {FadeTo = {ONE_SECOND_TICK, COLOR_BLACK}},
    {Text = '唧唧啾啾'},
    {Text = '小鳥在講話'},
    {Text = '唧唧啾啾'},
    {FadeTo = {ONE_SECOND_TICK, color_olive}},
    {Text = '「哦哦天亮了去找師父吧」'},
    {Image = teacher_tex_id},
    {Text = '小秋徒兒你來啦'},
    {Text = '勇者山上的修行告一段落'},
    {Text = '你可以下山磨練磨練了'},
    {Text = '作完功課後再來見我吧'},
    {LevelId = TRAINING_MAP_LVL_ID},
  },
  [50] = {
    {Image = teacher_tex_id},
    {Text = '小秋徒兒你作完功課了啊'},
    {Image = BOU_TEX_ID},
    {Text = '這個缽你帶下山吧'},
    {Script = ScriptAddBou1},
    {Text = '下山後好好修行'},
    {Image = teacher_tex_id},
    {Text = '要常回來勇者山看看哪'},
    {LevelId = MAIN_MAP_LVL_ID},
  },
  [51] = {
    {Image = teacher_tex_id},
    {Text = '勇猛精進！'},
    {LevelId = MAIN_MAP_LVL_ID},
  },
  [52] = {
    {Image = teacher_tex_id},
    {Text = '小秋徒兒你回來的正好'},
    {Image = LETTER_TEX_ID},
    {Text = '山下教堂的吳神父是我的老朋友'},
    {Text = '替我將這封信交給他吧'},
    {Script = ScriptSendTeacherLetter},
    {LevelId = MAIN_MAP_LVL_ID},
  },
  [53] = {
    {Image = teacher_tex_id},
    {Text = '小秋徒兒你回來了啊'},
    {Text = '跟師兄們作作功課忘掉世間雜染'},
    {LevelId = TRAINING_MAP_LVL_ID},
  },
  -- Brother 1.
  [100] = {
    {Image = brother1_tex_id},
    {Text = '大師兄和你一起認真作功課'},
    {Text = '下山後可要好好的修行'},
    {LevelId = TRANINING_CLICK_LVL_ID},
  },
  [150] = {
    {Image = brother1_tex_id},
    {Text = '自強不息'},
    {LevelId = TRAINING_MAP_LVL_ID},
  },
  [180] = {
    {Image = brother1_tex_id},
    {Text = '遇到困難了嗎？'},
    {LevelId = MAIN_MAP_LVL_ID},
  },
  -- Brother 2.
  [200] = {
    {Image = brother2_tex_id},
    {Text = '二師兄真替你開心'},
    {Text = '撿完材火後就可以下山去修練了'},
    {Text = '別太貪玩哪'},
    {LevelId = TRANINING_STICK_LVL_ID},
  },
  [250] = {
    {Image = brother2_tex_id},
    {Text = '終於作完啦'},
    {LevelId = TRAINING_MAP_LVL_ID},
  },
  [280] = {
    {Image = brother2_tex_id},
    {Text = '怎麼這麼快就回來啦'},
    {LevelId = MAIN_MAP_LVL_ID},
  },
  -- Main map merchant.
  [300] = {
    {Image = merchant_tex_id},
    {Text = '小師父這裡有個好東西讓你看看'},
    {Image = BOU2_TEX_ID},
    {Text = '這個缽很棒吧'},
    {Text = string.format('有緣價算你%d塊錢', BOU2_COST)},
    {Script = ScriptBuyBou2},
    {Image = merchant_tex_id},
    {Text = '銘謝惠顧'},
    {LevelId = MAIN_MAP_LVL_ID},
  },
  [400] = {
    {Image = merchant_tex_id},
    {Text = '小師父好久不見'},
    {Text = '生意愈作愈大啦'},
    {Text = '今日向您推薦個絕世好缽'},
    {Image = BOU3_TEX_ID},
    {Text = '怎麼樣這個缽是不是很棒啊'},
    {Text = string.format('今日特價算你%d塊錢', BOU3_COST)},
    {Script = ScriptBuyBou3},
    {Image = merchant_tex_id},
    {Text = '銘謝惠顧'},
    {LevelId = MAIN_MAP_LVL_ID},
  },
  [450] = {
    {Image = pinnote_tex_id},
    {Text = '補貨中下次再來'},
    {LevelId = MAIN_MAP_LVL_ID},
  },
  [500] = {
    {Image = pinnote_tex_id},
    {Text = '今日公休'},
    {LevelId = MAIN_MAP_LVL_ID},
  },
  [510] = {
    {Image = merchant_tex_id},
    {Text = '小師父恭喜發財啊'},
    {Text = '今天有個好消息讓你知道'},
    {Text = '賽魂世界隆重開幕啦'},
    {Text = '只要下注猜中了包你贏大錢'},
    {Text = '有錢沒錢都來看看吧'},
    {LevelId = racing_lvl_id},
  },
  [511] = {
    {Image = merchant_tex_id},
    {Text = '歡迎來到賽魂世界'},
    {LevelId = racing_lvl_id},
  },
  [512] = {
    {Image = merchant_tex_id},
    {Text = '小師父恭喜發財啊'},
    {Text = '昨晚我家的龍神太子托夢給我'},
    {Text = '說祂發了大願讓我找到您'},
    {Text = '要蓋間廟讓善男信女們都發大財'},
    {Image = GODZILLA_TEX_ID},
    {Script = ScriptGiveGodzilla},
    {Text = '恭請金尊到鎮上募款蓋廟吧'},
    {LevelId = MAIN_MAP_LVL_ID},
  },
  -- Bag.
  [600] = {
    {Image = BOU_TEX_ID},
    {Text = '有點老舊的木缽'},
    {LevelId = BAG_LVL_ID},
  },
  [601] = {
    {Image = BOU2_TEX_ID},
    {Text = '銅製作的缽'},
    {LevelId = BAG_LVL_ID},
  },
  [602] = {
    {Image = BOU3_TEX_ID},
    {Text = '金光閃閃的缽'},
    {LevelId = BAG_LVL_ID},
  },
  [603] = {
    {Image = LETTER_TEX_ID},
    {Text = '師父給吳神父的書信'},
    {LevelId = BAG_LVL_ID},
  },
  [604] = {
    {Image = GODZILLA_TEX_ID},
    {Text = '龍神太子神像'},
    {LevelId = BAG_LVL_ID},
  },
  [605] = {
    {Image = BACK_SCRATCHER_TEX_ID},
    {Text = '擁有布的力量的無敵不求人'},
    {LevelId = BAG_LVL_ID},
  },
  [606] = {
    {Image = FLASHLIGHT_TEX_ID},
    {Text = '光線有點暗淡的手電筒'},
    {Text = '電力還能夠使用%d次', ScriptText = ScriptTextFlashlightUseCount},
    {LevelId = BAG_LVL_ID},
  },
  [607] = {
    {Image = MALLET_TEX_ID},
    {Text = '擁有石頭力量的神奇石頭棒'},
    {LevelId = BAG_LVL_ID},
  },
  [608] = {
    {Image = FLASHLIGHT_TEX_ID},
    {Text = '沒有電力的手電筒'},
    {LevelId = BAG_LVL_ID},
  },
  [609] = {
    {Image = CANDY_TEX_ID},
    {Text = '好吃的棒棒糖'},
    {LevelId = BAG_LVL_ID},
  },
  [610] = {
    {Image = SCISSOR_TEX_ID},
    {Text = '豬妹妹的美勞剪刀'},
    {LevelId = BAG_LVL_ID},
  },
  [611] = {
    {Image = FROG_TEAR_TEX_ID},
    {Text = '小青蛙的眼淚'},
    {LevelId = BAG_LVL_ID},
  },
  -- Church.
  [1000] = {
    {Image = pinnote_tex_id},
    {Text = '有事外出'},
    {LevelId = MAIN_MAP_LVL_ID},
  },
  [1150] = {
    {Image = priest_tex_id},
    {Text = '小兄弟辛苦你啦'},
    {Image = LETTER_TEX_ID},
    {Text = '從勇者山帶來這封信應該累了吧'},
    {Image = priest_tex_id},
    {Text = '請到後面讓我們為你馬殺雞'},
    {Text = string.format('友情價算你%d塊錢', CHURCH_RECV_LETTER_COST)},
    {Script = ScriptTransLetterToPriest},
    {Image = -1},
    {Text = ''},
    {FadeTo = {ONE_SECOND_TICK, COLOR_BLACK}},
    {Text = '「好舒服啊快要睡著了」'},
    {Text = 'ZZZ ZZZ ZZZ'},
    {Text = '救命啊'},
    {Text = '來人啊'},
    {Text = ''},
    {FadeTo = {ONE_SECOND_TICK, color_olive}},
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
    {FadeTo = {ONE_SECOND_TICK, COLOR_BLACK}},
    {FadeTo = {ONE_SECOND_TICK, color_olive}},
    {Image = priest_tex_id},
    {Text = '小兄弟你醒啦'},
    {Text = '看你睡的那麼熟'},
    {Text = '應該休息夠了吧'},
    {Text = '以後累了歡迎再來抓龍哦'},
    {Text = '再馬一次就可以升級為VIP哦'},
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
    {FadeTo = {ONE_SECOND_TICK, COLOR_BLACK}},
    {Text = '「好舒服啊快要睡著了」'},
    {Text = 'ZZZ ZZZ ZZZ'},
    {Text = ''},
    {FadeTo = {ONE_SECOND_TICK, color_olive}},
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
    {Text = '「......」'},
    {Text = '不多說了我要到教堂去'},
    {Text = '自己在外面玩要小心'},
    {Image = -1},
    {Text = ''},
    {Text = '「小白！小白！」'},
    {Text = '「奇怪？小白跑到那裡去了？」'},
    {Text = '「不管了我自己要出去玩了」'},
    {LevelId = interview_hero_village_lvl_id},
  },
  [1153] = {
    {Image = priest_tex_id},
    {Text = '你累了嗎抓個龍吧'},
    {Text = string.format('VIP特價%d塊錢哦', REST_COST)},
    {LevelId = MAIN_MAP_LVL_ID},
  },
  [1154] = {
    {Image = priest_tex_id},
    {Text = string.format('來抓個龍吧VIP只要%d塊錢哦', REST_COST)},
    {Script = ConsumeRestCost},
    {Image = -1},
    {Text = ''},
    {FadeTo = {ONE_SECOND_TICK, COLOR_BLACK}},
    {Text = '「好舒服啊快要睡著了」'},
    {Text = 'ZZZ ZZZ ZZZ'},
    {LevelId = HERO_VILLAGE_LVL_ID},
  },
  -- Main map temple site.
  [1200] = {
    {Image = pinnote_tex_id},
    {Text = '整備中'},
    {LevelId = MAIN_MAP_LVL_ID},
  },
  [1201] = {
    {Image = pinnote_tex_id},
    {Text = '募款蓋廟中'},
    {Text = '還需要$%d', ScriptText = ScriptTextCrowdFunding},
    {LevelId = MAIN_MAP_LVL_ID},
  },
  [1202] = {
    {Image = merchant_tex_id},
    {Text = '小兄弟您真行這麼快就募到錢了'},
    {Text = '蓋廟的事就交給我來辨吧'},
    {Script = ScriptBuildTemple},
    {LevelId = MAIN_MAP_LVL_ID},
  },
  [1203] = {
    {Image = GODZILLA_TEX_ID},
    {Text = '龍神太子財神廟建設中'},
    {LevelId = MAIN_MAP_LVL_ID},
  },
  [1204] = {
    {Image = GODZILLA_TEX_ID},
    {Text = '龍神太子財神廟建設完成'},
    {Text = '您成為龍神太子財神廟廟公'},
    {LevelId = MAIN_MAP_LVL_ID},
  },
  [1205] = {
    {Image = GODZILLA_TEX_ID},
    {Text = '龍神太子財神廟'},
    {LevelId = MAIN_MAP_LVL_ID},
  },
  -- Hero village church, grandpa.
  [1300] = {
    {Image = grandpa_tex_id},
    {Text = '外星人果然又來了'},
    {Text = '圖書館有本「勇者的故事」'},
    {Text = '你先去看看再來一下'},
    {Script = ScriptAddHeroHisBook},
    {LevelId = HERO_VILLAGE_CHURCH_LVL_ID},
  },
  [1301] = {
    {Image = grandpa_tex_id},
    {Text = '讀過祖先的記錄了吧'},
    {Text = '找到3把上古神兵打敗外星人吧'},
    {Text = ''},
    {Text = '「爺爺爺爺」'},
    {Text = '嗯嗯怎麼啦'},
    {Text = '「不求人不求人」'},
    {Text = '嗯嗯喔喔喔'},
    {Text = '沒錯!'},
    {Image = BACK_SCRATCHER_TEX_ID},
    {Text = '這就是擁有布的力量的無敵不求人'},
    {Text = '可以用來對抗石頭的力量'},
    {Text = '給你吧'},
    {Script = ScriptAddBackScratcher},
    {Image = grandpa_tex_id},
    {Text = '小白你現在是新一代的勇者了'},
    {Text = '「呵呵呵我是勇者小白!」'},
    {Text = '「我的任務是維護世界的和平！」'},
    {Text = '去把另外2把神兵找出來'},
    {Text = '打敗外星人拯救這個世界吧'},
    {LevelId = HERO_VILLAGE_CHURCH_LVL_ID},
  },
  [1302] = {
    {Image = grandpa_tex_id},
    {Text = '找到3把上古神兵打敗外星人吧'},
    {LevelId = HERO_VILLAGE_CHURCH_LVL_ID},
  },
  [1303] = {
    {Image = grandpa_tex_id},
    {Text = '張媽媽家擁有石頭的力量'},
    {Text = '去張媽媽家看看吧'},
    {LevelId = HERO_VILLAGE_CHURCH_LVL_ID},
  },
  [1304] = {
    {Image = grandpa_tex_id},
    {Text = '小白這是今天給你的零用錢'},
    {Text = '拿去買你喜歡的東西吧'},
    {Script = ScriptGiveAllowance},
    {Text = '「謝謝爺爺」'},
    {LevelId = HERO_VILLAGE_CHURCH_LVL_ID},
  },
  [1305] = {
    {Image = grandpa_tex_id},
    {Text = '圖書館裡有本書你可以看看'},
    {Text = '它記載著開啟洞穴之門的方法'},
    {Script = ScriptAddCaveDoorBook},
    {Text = '「好的謝謝爺爺」'},
    {LevelId = HERO_VILLAGE_CHURCH_LVL_ID},
  },
  [1306] = {
    {Image = grandpa_tex_id},
    {Text = '豬妹妹家擁有剪刀的力量'},
    {Text = '去豬妹妹家看看吧'},
    {LevelId = HERO_VILLAGE_CHURCH_LVL_ID},
  },
  -- Hero village church, books.
  [1350] = {
    {Image = HERO_HIS_BOOK_TEX_ID},
    {Text = '「勇者的故事」'},
    {Text = '很久很久以前'},
    {Text = '邪惡的外星人來到勇者村'},
    {Text = '想要征服這個世界'},
    {Text = '三個勇者拿著傳說的神兵'},
    {Text = '勇敢的去挑戰魔王'},
    {Text = '最後三位勇者打敗了魔王'},
    {Text = '拯救了這個世界'},
    {Text = '從此大家過著快快樂樂的日子'},
    {LevelId = BAG_LVL_ID},
  },
  [1351] = {
    {Image = CAVE_DOOR_BOOK_TEX_ID},
    {Text = '「開啟洞穴之門的方法」'},
    {Text = '勇者們打敗魔王後'},
    {Text = '將石頭的力量封印在洞穴'},
    {Text = '以下是開啟密門的方法'},
    {ScriptText = GetOpenCaveDoorCode},
    {LevelId = BAG_LVL_ID},
  },
  [1352] = {
    {Image = POWER_SCISSOR_BOOK_TEX_ID},
    {Text = '「超級剪刀手之書」'},
    {Text = '要想獲得超級剪刀手'},
    {Text = '首先準備一把美勞剪刀'},
    {Text = '還要一根打鼓棒'},
    {Text = '以及一滴青蛙眼淚'},
    {Text = '最後大聲說出魔法咒語'},
    {Text = '「超級剪刀手出來吧」'},
    {Text = '就能合成超級剪刀手了'},
    {LevelId = BAG_LVL_ID},
  },
  [1353] = {
    {Image = SLAP_MOUSE_BOOK_TEX_ID},
    {Text = '「超級老鼠拍打器 by 小明」'},
    {Text = '1.按下紅色按鈕 拍打器跑出來'},
    {Text = '2.按下綠色按鈕 球跑出來'},
    {Text = '3.按下黃色按鈕 起士跑出來'},
    {Text = '4.老鼠跑來吃起士'},
    {Text = '5.老鼠踩到球跌倒'},
    {Text = '6.拍打器打下來打死老鼠'},
    {LevelId = BAG_LVL_ID},
  },
  -- UFO coming.
  [1400] = {
    {FadeTo = {ONE_SECOND_TICK, COLOR_BLACK}},
    {Image = ufo_tex_id},
    {Text = '哇哈哈哇哈哈！我又來啦！'},
    {Text = '我是拳頭星的外星人魔王'},
    {Text = '我要征服勇者村'},
    {Text = '然後再征服這個世界'},
    {Text = '給你們3天時間'},
    {Text = '快把勇者們都交出來吧'},
    {Text = '否則就嘿嘿嘿嘿嘿嘿！'},
    {Script = ScriptInterviewUfo},
    {LevelId = HERO_VILLAGE_LVL_ID},
  },
  -- Hero village, Zhang mama home.
  [1500] = {
    {Image = zhang_mama_tex_id},
    {Text = '每天都要洗好多衣服啊'},
    {LevelId = HERO_VILLAGE_LVL_ID},
  },
  [1501] = {
    {Image = zhang_mama_tex_id},
    {Text = '我們家的傳家之寶神奇石頭棒'},
    {Text = '封印在洞穴內被祖先保護著'},
    {Text = '要通過考驗才能拿到'},
    {LevelId = HERO_VILLAGE_LVL_ID},
  },
  [1502] = {
    {Image = zhang_mama_tex_id},
    {Text = '每天都要洗好多衣服啊'},
    {Text = '小白你來的正好'},
    {Text = '請你幫我曬一下衣服'},
    {Text = '曬好了我再給你一些零用錢'},
    {LevelId = clothes_drying_lvl_id},
  },
  [1503] = {
    {Image = zhang_mama_tex_id},
    {Text = '小白謝謝你的幫忙'},
    {Text = '這是給你的零用錢'},
    {Text = '拿去買你喜歡的東西吧'},
    {Script = ScriptGiveAllowance},
    {Text = '「謝謝張媽媽」'},
    {LevelId = HERO_VILLAGE_LVL_ID},
  },
  [1504] = {
    {Image = zhang_mama_tex_id},
    {Text = '己經打門封印洞穴的門了嗎'},
    {Text = '小白你真是了不起'},
    {Text = '你只要對著空的寶箱說出咒語'},
    {Text = '「神奇石頭棒出來吧」'},
    {Text = '擁有石頭力量的寶物就會出現了'},
    {Script = ScriptGetMalletCode},
    {LevelId = HERO_VILLAGE_LVL_ID},
  },
  -- Hero village, Shop.
  [1600] = {
    {Image = pinnote_tex_id},
    {Text = '今日公休'},
    {LevelId = HERO_VILLAGE_LVL_ID},
  },
  [1601] = {
    {Image = merchant_tex_id},
    {Text = string.format('高級手電筒只賣%d塊錢', FLASHLIGHT_COST)},
    {Text = '要買要快哦'},
    {LevelId = HERO_VILLAGE_LVL_ID},
  },
  [1602] = {
    {Image = merchant_tex_id},
    {Text = '小白你運氣真好'},
    {Text = '這是最後一個高級手電筒了'},
    {Image = FLASHLIGHT_TEX_ID},
    {Text = string.format('收你%d塊錢謝謝惠顧', FLASHLIGHT_COST)},
    {Script = ScriptBuyFlashlight},
    {LevelId = HERO_VILLAGE_LVL_ID},
  },
  [1603] = {
    {Image = merchant_tex_id},
    {Text = string.format('手電筒充電一次只要%d塊錢', FLASHLIGHT_COST)},
    {LevelId = HERO_VILLAGE_LVL_ID},
  },
  [1604] = {
    {Image = merchant_tex_id},
    {Text = string.format('收你%d塊錢謝謝惠顧', FLASHLIGHT_COST)},
    {Script = ScriptChargeFlashlight},
    {Text = '手電筒充滿電了'},
    {LevelId = HERO_VILLAGE_LVL_ID},
  },
  [1605] = {
    {Image = merchant_tex_id},
    {Text = string.format('好吃的棒棒糖只賣%d塊錢', CANDY_COST)},
    {Text = '要買要快哦'},
    {LevelId = HERO_VILLAGE_LVL_ID},
  },
  [1606] = {
    {Image = merchant_tex_id},
    {Text = string.format('收你%d塊錢謝謝惠顧', CANDY_COST)},
    {Image = CANDY_TEX_ID},
    {Text = '這是給您的好吃的棒棒糖'},
    {Script = ScriptBuyCandy},
    {LevelId = HERO_VILLAGE_LVL_ID},
  },
  [1607] = {
    {Image = merchant_tex_id},
    {Text = '我正在收集青蛙眼淚製作藥劑'},
    {Text = '請你把青蛙眼淚賣給我吧'},
    {Image = FROG_TEAR_TEX_ID},
    {Script = ScriptSellFrogTear},
    {Text = '一手交錢一手交貨'},
    {Image = merchant_tex_id},
    {Text = '謝謝你小白'},
    {LevelId = HERO_VILLAGE_LVL_ID},
  },
  -- Hero village, Pinky home.
  [1700] = {
    {Image = pinky_tex_id},
    {Text = '小白要跟我一起玩哦'},
    {LevelId = HERO_VILLAGE_LVL_ID},
  },
  [1701] = {
    {Image = pinky_tex_id},
    {Text = '咔嚓咔嚓剪剪剪'},
    {Text = '哈哈哈勞作真好玩'},
    {Script = ScriptBuyCandyLoop},
    {LevelId = HERO_VILLAGE_LVL_ID},
  },
  [1702] = {
    {Image = pinky_tex_id},
    {Text = '咔嚓咔嚓剪剪剪'},
    {Text = '哈哈哈勞作真好玩'},
    {Text = '小白跟我一起作勞作'},
    {Image = CANDY_TEX_ID},
    {Text = '哇哇是好吃的棒棒糖ㄟ'},
    {Text = '可以給我吃嗎'},
    {Text = '謝謝你小白你真好^^'},
    {Image = SCISSOR_TEX_ID},
    {Text = '這個剪刀給你'},
    {Script = ScriptExchangeCandyScissor},
    {Image = pinky_tex_id},
    {Text = '小白要跟我一起玩哦'},
    {LevelId = HERO_VILLAGE_LVL_ID},
  },
  [1703] = {
    {Text = '哦哦糟糕'},
    {Text = '這把美勞剪刀好像對付不了外星人'},
    {Text = '要再想想其它辨法才行'},
    {Script = ScriptPowerupScissorLoop},
    {LevelId = ALIEN_PATH_LVL_ID},
  },
  [1704] = {
    {Image = pinky_papa_tex_id},
    {Text = '呵呵呵小白好久不見'},
    {Text = '你知道魔法咒語嗎?'},
    {Text = '要讓美勞剪刀變成超級剪刀手'},
    {Text = '你得去圖書館找找看'},
    {Script = ScriptAddPowerScissorBook},
    {LevelId = HERO_VILLAGE_LVL_ID},
  },
  -- Hero village, hero home.
  [1800] = {
    {Text = '「維護世界的和平也是挺累的」'},
    {Text = '「讓我睡一下下吧」'},
    {Text = ''},
    {FadeTo = {ONE_SECOND_TICK, COLOR_BLACK}},
    {FadeTo = {ONE_SECOND_TICK, color_olive}},
    {Image = priest_tex_id},
    {Text = '小兄弟你醒啦'},
    {Text = '恭喜你成為我們的VIP'},
    {Text = '以後累了歡迎再來抓龍哦'},
    {Image = -1},
    {Text = '「原來是個夢」'},
    {LevelId = MAIN_MAP_LVL_ID},
  },
  [1801] = {
    {Text = '「維護世界的和平也是挺累的」'},
    {Text = '「讓我睡一下下吧」'},
    {Text = ''},
    {FadeTo = {ONE_SECOND_TICK, COLOR_BLACK}},
    {FadeTo = {ONE_SECOND_TICK, color_olive}},
    {Text = '「原來是個夢」'},
    {LevelId = MAIN_MAP_LVL_ID},
  },
  -- Country, Kai home.
  [1900] = {
    {Image = kai_tex_id},
    {Text = '我是搖滾阿凱'},
    {Text = '又又又一起來搖滾吧'},
    {LevelId = COUNTRY_LVL_ID},
  },
  [1901] = {
    {Image = kai_tex_id},
    {Text = '小青蛙又偷跑出去玩了'},
    {LevelId = COUNTRY_LVL_ID},
  },
  [1902] = {
    {Image = kai_tex_id},
    {Text = '最近我買了超級老鼠拍打器'},
    {Text = '如果你能幫忙我抓老鼠'},
    {Text = '我就把打鼓棒送給你'},
    {Text = '你可以先到教堂圖書館去'},
    {Text = '研究研究一下使用說明書再來'},
    {Script = ScriptAddSlapMouseBook},
    {LevelId = COUNTRY_LVL_ID},
  },
  [1903] = {
    {Image = kai_tex_id},
    {Text = '請用超級老鼠拍打器幫我抓老鼠'},
    {LevelId = slap_mouse_lvl_id},
  },
  [1904] = {
    {Image = kai_tex_id},
    {Text = '真是太謝謝你了'},
    {Text = '幫我抓那麼多老鼠'},
    {LevelId = COUNTRY_LVL_ID},
  },
  -- Country, pond,
  [2000] = {
    {Image = frog_tex_id},
    {Text = '呱呱呱'},
    {Text = '「哦原來是偷跑的小青蛙」'},
    {Text = '「我們一起來玩躲貓貓吧」'},
    {LevelId = seek_frog_lvl_id},
  },
  [2001] = {
    {Image = frog_tex_id},
    {Text = '為什麼你都找的到我'},
    {Text = '呱呱呱嗚嗚嗚'},
    {Image = FROG_TEAR_TEX_ID},
    {Text = '得到了青蛙的眼淚'},
    {Script = ScriptAddFrogTear},
    {LevelId = COUNTRY_LVL_ID},
  },
  -- Cave field, cave.
  [2100] = {
    {FadeTo = {ONE_SECOND_TICK, COLOR_BLACK}},
    {Text = '黑漆漆的山洞什麼都看不見'},
    {Script = ScriptEnterCave},
    {LevelId = CAVE_FIELD_LVL_ID},
  },
  [2101] = {
    {FadeTo = {ONE_SECOND_TICK, COLOR_BLACK}},
    {Text = '黑漆漆的山洞什麼都看不見'},
    {Script = ScriptEnterCave},
    {Text = '慢慢的往前模索前進'},
    {Text = '好像摸到一扇門'},
    {Text = '如果有手電筒就好了'},
    {LevelId = CAVE_FIELD_LVL_ID},
  },
  [2102] = {
    {FadeTo = {ONE_SECOND_TICK, COLOR_BLACK}},
    {Text = '黑漆漆的山洞什麼都看不見'},
    {Text = '拿出手電筒打開開關'},
    {FadeTo = {ONE_SECOND_TICK, color_olive}},
    {Script = ScriptEnterCave},
    {Script = ScriptUseFlashlight},
    {Text = '光線有點暗淡不過可以看見了'},
    {Image = cave_door_tex_id},
    {Text = '走到盡頭發現一道門'},
    {Text = '需要密碼才能打開門'},
    {LevelId = CAVE_DOOR_LVL_ID},
  },
  [2103] = {
    {Text = '密碼輸入正確門開了'},
    {Script = ScriptOpenCaveDoor},
    {Image = chest_tex_id},
    {Text = '發現一個寶箱'},
    {Text = '打開寶箱裡面是空的!'},
    {LevelId = CAVE_FIELD_LVL_ID},
  },
  [2104] = {
    {Text = '密碼輸入正確門開了'},
    {Image = chest_tex_id},
    {Text = '對著空寶箱說出通關咒語'},
    {Text = '「神奇石頭棒出來吧」'},
    {Image = MALLET_TEX_ID},
    {Text = '得到擁有石頭力量的神奇石頭棒'},
    {Text = '可以用來對抗剪刀的力量'},
    {Script = ScriptAddMellet},
    {LevelId = CAVE_FIELD_LVL_ID},
  },
  [2105] = {
    {Text = '密碼輸入正確門開了'},
    {Image = chest_tex_id},
    {Text = '己經得到寶箱裡的神奇石頭棒了'},
    {LevelId = CAVE_FIELD_LVL_ID},
  },
  [2106] = {
    {FadeTo = {ONE_SECOND_TICK, COLOR_BLACK}},
    {Text = '黑漆漆的山洞什麼都看不見'},
    {Text = '手電筒沒電了無法使用'},
    {LevelId = CAVE_FIELD_LVL_ID},
  },
  [2107] = {
    {Text = '密碼輸入正確門開了'},
    {Image = chest_tex_id},
    {Text = '打開空寶箱'},
    {Text = '仔細一看箱子底部還有個門'},
    {Image = chest_tex_id, Scale = 0.5},
    {Text = '打開箱子底部發現一個小寶箱'},
    {Text = '打開小寶箱'},
    {Text = '裡面是空的!'},
    {LevelId = CAVE_FIELD_LVL_ID},
  },
}
