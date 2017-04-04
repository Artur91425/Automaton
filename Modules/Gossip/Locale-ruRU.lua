local L = AceLibrary("AceLocale-2.2"):new("Automaton_Gossip")

L:RegisterTranslations("ruRU", function() return {
	--------------
	-- Gossip Menu
	--------------
	["Gossip"] = "Болтовня",
	["Automatically complete quests and skip gossip text"] = "Автоматическое завершение заданий и пропуск текстовой болтовни",
	["Enabled"] = "Вкл./Выкл.",
	["Suspend/resume this module"] = "Приостановить/возобновить этот модуль",

	--------------
	-- Gossip Text
	--------------
	["<Touch the unstable rift crystal.>"] = "<Touch the unstable rift crystal.>", -- Need translation, MC entrance
	["<Place my hand on the orb.>"] = "<Place my hand on the orb.>", -- Need translation, BWL entrance
	["Thank you, Stable Master. Please take the animal."] = "Thank you, Stable Master. Please take the animal.", -- Need translation, AV quest
	["With pleasure. These things stink!"] = "With pleasure. These things stink!", -- Need translation, AV quest
	["Trick or Treat!"] = "Конфета или Жизнь!",

	-------------
	-- Quest Text
	-------------
	-- Alterac Valley quests
	["Empty Stables"] = "Пустые стойла",
	["Ram Hide Harnesses"] = "Упряжь из бараньей кожи",
	["Alterac Ram Hide"] = "Шкура альтеракского барана",
	["Ram Riding Harnesses"] = "Упряжь ездовых баранов",
	["Frostwolf Hide"] = "Шкура северного волка",
	["More Booty!"] = "Больше добычи!",
	["More Armor Scraps"] = "Больше обломков брони",
	["Armor Scraps"] = "Обломки брони",
	["Coldtooth Supplies"] = "Припасы Ледяного Зуба",
	["Irondeep Supplies"] = "Припасы Железного рудника",
	["Lokholar the Ice Lord"] = "Локолар Владыка Льда",
	["Stormpike Soldier's Blood"] = "Кровь солдата Грозовой Вершины",
	["A Gallon of Blood"] = "Галлон крови",
	["Ivus the Forest Lord"] = "Ивус Лесной Властелин",
	["Storm Crystal"] = "Кристалл Бури",
	["Crystal Cluster"] = "Гроздь кристаллов",
	["Call of Air - Slidore's Fleet"] = "Небо зовет – флот Макарча",
	["Call of Air - Vipore's Fleet"] = "Небо зовет – флот Сквороца",
	["Call of Air - Ichman's Fleet"] = "Небо зовет – флот Ромеона",
	["Frostwolf Soldier's Medal"] = "Жетон солдата Северного Волка",
	["Frostwolf Lieutenant's Medal"] = "Жетон лейтенанта Северного Волка",
	["Frostwolf Commander's Medal"] = "Жетон командира Северного Волка",
	["Call of Air - Guse's Fleet"] = "Небо зовет – флот Смуггла",
	["Call of Air - Jeztor's Fleet"] = "Небо зовет – флот Мааши",
	["Call of Air - Mulverick's Fleet"] = "Небо зовет – флот Маэстра",
	["Stormpike Soldier's Flesh"] = "Плоть солдата Грозовой Вершины",
	["Stormpike Lieutenant's Flesh"] = "Плоть лейтенанта Грозовой Вершины",
	["Stormpike Commander's Flesh"] = "Плоть командира Грозовой Вершины",

	--Mark of Honor quests
	["For Great Honor"] = "Великая честь",
	["Concerted Efforts"] = "В едином порыве",
	["Conquering Arathi Basin"] = "Завоевание Низины Арати",
	["Claiming Arathi Basin"] = "Завоевание Низины Арати",
	["Invaders of Alterac Valley"] = "Вторжение в Альтеракскую долину",
	["Remember Alterac Valley!"] = "Помни Альтеракскую долину!",
	["Battle of Warsong Gulch"] = "Битва за Ущелье Песни Войны",
	["Fight for Warsong Gulch"] = "Битва за Ущелье Песни Войны",
	["Alterac Valley Mark of Honor"] = "Почетный знак Альтеракской долины",
	["Arathi Basin Mark of Honor"] = "Почетный знак Низины Арати",
	["Warsong Gulch Mark of Honor"] = "Почетный знак Ущелья Песни Войны",

	-- Felwood salves
	["Salve via Gathering"] = "Лекарство из оскверненных трав",
	["Fel Creep"] = "Зародыш Скверны",
	["Salve via Mining"] = "Лекарство из минералов",
	["Tainted Vitriol"] = "Затронутый порчей купорос",
	["Salve via Skinning"] = "Лекарство из оскверненных шкур",
	["Patch of Tainted Skin"] = "Клочок порченой шкуры",
	["Salve via Hunting"] = "Лекарство из охотничьих трофеев",
	["Corrupted Soul Shard"] = "Оскверненный осколок души",
	["Salve via Disenchanting"] = "Лекарство из распыленных предметов",
	["Lesser Nether Essence"] = "Простая субстанция Пустоты",

	-- Felwood plants
	["Corrupted Whipper Root"] = "Оскверненный кнутокорень",
	["Corrupted Songflower"] = "Оскверненный песнецвет",
	["Corrupted Windblossom"] = "Оскверненный ветроцвет",
	["Corrupted Night Dragon"] = "Оскверненный Ночной дракон",
	["Cenarion Plant Salve"] = "Кенарийский бальзам исцеления растений",

	-- Thorium Shells -> Thorium Arrows Quest
	["A Fair Trade"] = "Честная сделка",
	["Thorium Shells"] = "Ториевые патроны",

	-- Ravenholdt
	["Syndicate Emblems"] = "Эмблемы Синдиката",
	["Syndicate Emblem"] = "Эмблема Синдиката",

	-- Cenarion
	["Encrypted Twilight Texts"] = "Зашифрованные Сумеречные тексты",
	["Encrypted Twilight Text"] = "Зашифрованный Сумеречный текст",

	-- Argent Dawn
	["Minion's Scourgestones"] = "Камни приспешников Плети",
	["Minion's Scourgestone"] = "Камень приспешника Плети",
	["Invader's Scourgestones"] = "Камни захватчиков Плети",
	["Invader's Scourgestone"] = "Камень захватчика Плети",
	["Corruptor's Scourgestones"] = "Камни осквернителей Плети",
	["Corruptor's Scourgestone"] = "Камень осквернителя Плети",
	["Bone Fragments"] = "Обломки костей",
	["Core of Elements"] = "Средоточие Стихий",
	["Crypt Fiend Parts"] = "Конечности и панцири некрорахнидов",
	["Dark Iron Scraps"] = "Пластины из темного железа",
	["Savage Fronds"] = "Дикие ростки",
	["Savage Frond"] = "Дикий росток",

	-- Timbermaw
	["Feathers for Grazle"] = "Перья для Гразла",
	["Feathers for Nafien"] = "Перья для Нафиэна",
	["Beads for Salfa"] = "Бусы для Сальфы",
	["Deadwood Headdress Feather"] = "Перо из головного убора Мертвого Леса",
	["Winterfall Spirit Beads"] = "Бусы духов Зимней Спячки",
	
	-- Cauldron quests
	["Gahrron's Withering Cauldron"] = "Котел пустоши Гаррона",
	["Writhing Haunt Cauldron"] = "Котел Удела Страданий",
	["Felstone Field Cauldron"] = "Котел поля Джанис",
	["Dalson's Tears Cauldron"] = "Котел Слез Далсона",
	["Arcane Quickener"] = "Чародейский ускоритель",
	["Ectoplasmic Resonator"] = "Эктоплазматический резонатор",
	["Somatic Intensifier"] = "Соматический усилитель",
	["Osseous Agitator"] = "Костяной катализатор",

	-- Gadgetzan
	["Water Pouch Bounty"] = "Награда за воду",
	["Wastewander Water Pouch"] = "Бурдюк с водой Скитальцев Пустыни",

	-- Thorium Brotherhood
	["Gaining Acceptance"] = "Завоевать еще большую благосклонность",
	["Dark Iron Residue"] = "Окалина черного железа",
	["Restoring Fiery Flux Supplies via Kingsblood"] = "Пополнение запасов огненного плавня – королевская кровь",
	["Kingsblood"] = "Королевская кровь",
	["Restoring Fiery Flux Supplies via Iron"] = "Пополнение запасов огненного плавня – железо",
	["Iron Bar"] = "Железный слиток",
	["Restoring Fiery Flux Supplies via Heavy Leather"] = "Пополнение запасов огненного плавня – толстая кожа",
	["Heavy Leather"] = "Толстая кожа",
	["Incendosaur Scale"] = "Чешуя пламезавра",
	["Coal"] = "Уголь",
	["Favor Amongst the Brotherhood, Dark Iron Ore"] = "Покровительство братства, черное железо",
	["Dark Iron Ore"] = "Руда черного железа",
	["Favor Amongst the Brotherhood, Blood of the Mountain"] = "Покровительство братства, кровь горы",
	["Blood of the Mountain"] = "Кровь Горы",
	["Favor Amongst the Brotherhood, Core Leather"] = "Покровительство братства, кожа Недр",
	["Core Leather"] = "Кожа Недр",
	["Favor Amongst the Brotherhood, Fiery Core"] = "Покровительство братства, огненное ядро",
	["Fiery Core"] = "Огненное ядро",
	["Favor Amongst the Brotherhood, Lava Core"] = "Покровительство братства, ядро лавы",
	["Lava Core"] = "Ядро лавы",

	-- City faction
	["Additional Runecloth"] = "Больше рунической ткани",
	["Runecloth"] = "Руническая ткань",

	-- Wildhammer faction
	["Troll Necklace Bounty"] = "Ожерелья троллей",
	["Troll Tribal Necklace"] = "Племенное троллье ожерелье",

	-- E'ko quests
	["Chillwind E'ko Item"] = "Э'ко хладнокрылов",
	["Chillwind E'ko Quest"] = "Э'ко хладнокрылов",
	["Frostmaul E'ko Item"] = "Э'ко великанов",
	["Frostmaul E'ko Quest"] = "Э'ко великанов",
	["Frostsaber E'ko Item"] = "Э'ко ледопарда",
	["Frostsaber E'ko Quest"] = "Э'ко ледопарда",
	["Ice Thistle E'ko Item"] = "Э'ко йети",
	["Ice Thistle E'ko Quest"] = "Э'ко йети",
	["Shardtooth E'ko Item"] = "Э'ко щербозубов",
	["Shardtooth E'ko Quest"] = "Э'ко щербозубов",
	["Wildkin E'ko Item"] = "Э'ко диких совухов",
	["Wildkin E'ko Quest"] = "Э'ко диких совухов",
	["Winterfall E'ko"] = "Э'ко фурболгов племени Зимней Спячки",

	-- Zul'Gurub quests
	["Zulian, Razzashi, and Hakkari Coins"] = "Монеты племен: Зулиан, Раззаши и Хаккари",
	["Zulian Coin"] = "Зулианская монета",
	["Razzashi Coin"] = "Монета Раззаши",
	["Hakkari Coin"] = "Монета Хаккари",
	["Gurubashi, Vilebranch, and Witherbark Coins"] = "Монеты племен: Гурубаши, Порочная Ветвь и Сухокожие",
	["Gurubashi Coin"] = "Монета Гурубаши",
	["Vilebranch Coin"] = "Монета Порочной Ветви",
	["Witherbark Coin"] = "Монета племени Сухокожих",
	["Sandfury, Skullsplitter, and Bloodscalp Coins"] = "Монеты племен: Песчаная Буря, Дробители Черепов и Кровавый Скальп",
	["Sandfury Coin"] = "Монета Песчаной Бури",
	["Skullsplitter Coin"] = "Монета клана Дробителей Черепов",
	["Bloodscalp Coin"] = "Монета Кровавого Скальпа",
	
	-- AQ War Effort (Horde)
	["The Horde Needs More Runecloth Bandages!"] = "Орде все еще не хватает бинтов из рунической ткани!",
	["The Horde Needs More Mageweave Bandages!"] = "Орде опять не хватает бинтов из магической ткани!",
	["The Horde Needs More Wool Bandages!"] = "Орде все еще не хватает шерстяных бинтов!",
	["The Horde Needs More Rugged Leather!"] = "Орде все еще не хватает грубой кожи!",
	["The Horde Needs More Thick Leather!"] = "Орде все еще не хватает плотной кожи!",
	["The Horde Needs More Heavy Leather!"] = "Орде все еще не хватает толстой кожи!",
	["The Horde Needs More Purple Lotus!"] = "Орде все еще не хватает лилового лотоса!",
	["The Horde Needs More Firebloom!"] = "Орде все еще не хватает огнецвета!",
	["The Horde Needs More Mithril Bars!"] = "Орде все еще не хватает мифриловых слитков!",
	["The Horde Needs More Tin Bars!"] = "Орде все еще нужны оловянные слитки!",
	["The Horde Needs More Copper Bars!"] = "Орде по-прежнему не хватает медных слитков!",
	["The Horde Needs More Lean Wolf Steaks!"] = "Орде все еще не хватает постных стейков из волчатины!",
	["The Horde Needs More Spotted Yellowtail!"] = "Орде все еще не хватает пятнистого желтохвоста!",
	["The Horde Needs More Baked Salmon!"] = "Орде все еще не хватает запеченного лосося!",
	
	-- AQ War Effort (Alliance)
	["The Alliance Needs More Linen Bandages!"] = "Альянсу по-прежнему не хватает льняных бинтов!",
	["The Alliance Needs More Silk Bandages!"] = "Альянсу по-прежнему не хватает шелковых бинтов!",
	["The Alliance Needs More Runecloth Bandages!"] = "Альянсу по-прежнему не хватает бинтов из рунической ткани!",
	["The Alliance Needs More Medium Leather!"] = "Альянсу по-прежнему не хватает средней кожи!",
	["The Alliance Needs More Thick Leather!"] = "Альянсу по-прежнему не хватает плотной кожи!",
	["The Alliance Needs More Stranglekelp!"] = "Альянсу по-прежнему не хватает удавника!",
	["The Alliance Needs More Purple Lotus!"] = "Альянсу по-прежнему не хватает лилового лотоса!",
	["The Alliance Needs More Arthas' Tears!"] = "Альянсу снова нужны слезы Артаса",
	["The Alliance Needs More Copper Bars!"] = "Альянсу все еще не хватает медных слитков!",
	["The Alliance Needs More Iron Bars!"] = "Альянсу по-прежнему не хватает железных слитков!",
	["The Alliance Needs More Thorium Bars!"] = "Альянсу по-прежнему не хватает ториевых слитков!",
	["The Alliance Needs More Rainbow Fin Albacore!"] = "Альянсу по-прежнему не хватает радужного тунца!",
	["The Alliance Needs More Roast Raptor!"] = "Альянсу по-прежнему не хватает жареного мяса ящера!",
	["The Alliance Needs More Spotted Yellowtail!"] = "Альянсу по-прежнему не хватает пятнистого желтохвоста!",

	-- AQ War Effort Items
	["Linen Bandage"] = "Льняные бинты",
	["Wool Bandage"] = "Шерстяные бинты",
	["Silk Bandage"] = "Шелковые бинты",
	["Mageweave Bandage"] = "Бинты из магической ткани",
	["Runecloth Bandage"] = "Бинты из рунической ткани",
	["Light Leather"] = "Тонкая кожа",
	["Medium Leather"] = "Жесткая кожа",
	["Heavy Leather"] = "Толстая кожа",
	["Thick Leather"] = "Плотная кожа",
	["Rugged Leather"] = "Грубая кожа",
	["Purple Lotus"] = "Лиловый лотос",
	["Stranglekelp"] = "Удавник",
	["Arthas' Tears"] = "Слезы Артаса",
	["Firebloom"] = "Огнецвет",
	["Peacebloom"] = "Мироцвет",
	["Copper Bar"] = "Медный слито",
	["Tin Bar"] = "Оловянный слиток",
	["Iron Bar"] = "Железный слиток",
	["Mithril Bar"] = "Мифриловый слиток",
	["Thorium Bar"] = "Ториевый слиток",
	["Lean Wolf Steak"] = "Постный стейк из волчатины",
	["Spotted Yellowtail"] = "Пятнистый желтохвост",
	["Baked Salmon"] = "Печеный лосось",
	["Roast Raptor"] = "Жареный ящер",
	["Rainbow Fin Albacore"] = "Радужный тунец",

	-- Commendation Signets
	["One Commendation Signet"] = "Один рекомендательный жетон",
	["Ten Commendation Signets"] = "Десять рекомендательных жетонов",
	["Horde Commendation Signet"] = "Рекомендательный жетон Орды",
	["Alliance Commendation Signet"] = "Рекомендательный жетон Альянса",
} end )