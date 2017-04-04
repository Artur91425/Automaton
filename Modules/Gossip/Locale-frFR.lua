local L = AceLibrary("AceLocale-2.2"):new("Automaton_Gossip")

L:RegisterTranslations("frFR", function() return {
	--------------
	-- Gossip Menu
	--------------
	["Gossip"] = "Gossip", -- Need translation
	["Automatically complete quests and skip gossip text"] = "Automatically complete quests and skip gossip text", -- Need translation
	["Enabled"] = "Enabled", -- Need translation
	["Suspend/resume this module"] = "Suspend/resume this module", -- Need translation

	--------------
	-- Gossip Text
	--------------
	["<Touch the unstable rift crystal.>"] = "<Touch the unstable rift crystal.>", -- MC entrance
	["<Place my hand on the orb.>"] = "<Placez ma main sur l'orbe.>", -- BWL entrance
	["Thank you, Stable Master. Please take the animal."] = "Thank you, Stable Master. Please take the animal.", -- Need translation, AV quest
	["With pleasure. These things stink!"] = "Avec plaisir ! Ces trucs-là sentent mauvais.", -- AV quest
	["Trick or Treat!"] = "Trick or Treat!", -- Need translation

	-------------
	-- Quest Text
	-------------
	-- Alterac Valley quests
	["Empty Stables"] = "Ecuries vides",
	["Ram Hide Harnesses"] = "Harnais en cuir de bélier",
	["Alterac Ram Hide"] = "Peau de bélier d'Alterac",
	["Ram Riding Harnesses"] = "Harnais pour béliers",
	["Frostwolf Hide"] = "Peau de loup des glaces",
	["More Booty!"] = "Plus de butin !",
	["More Armor Scraps"] = "Plus de morceaux d'armure !",
	["Armor Scraps"] = "Morceaux d'armures",
	["Coldtooth Supplies"] = "Fournitures de Froide-dent",
	["Irondeep Supplies"] = "Fournitures de Gouffrefer",
	["Lokholar the Ice Lord"] = "Lokholar le Seigneur des Glaces",
	["Stormpike Soldier's Blood"] = "Sang de soldat stormpike",
	["A Gallon of Blood"] = "Quelques litres de sang",
	["Ivus the Forest Lord"] = "Ivus le Seigneur des forêts",
	["Storm Crystal"] = "Cristal de tempête",
	["Crystal Cluster"] = "Grappes de cristaux",
	["Call of Air - Slidore's Fleet"] = "L'appel des airs - l'escadrille de Slidore",
	["Call of Air - Vipore's Fleet"] = "L'appel des airs - l'escadrille de Vipore",
	["Call of Air - Ichman's Fleet"] = "L'appel des airs - l'escadrille d'Ichman",
	["Frostwolf Soldier's Medal"] = "Médaille de soldat frostwolf",
	["Frostwolf Lieutenant's Medal"] = "Médaille de lieutenant frostwolf",
	["Frostwolf Commander's Medal"] = "	Médaille de commandant frostwolf",
	["Call of Air - Guse's Fleet"] = "L'appel des airs - l'escadrille de Guse",
	["Call of Air - Jeztor's Fleet"] = "L'appel des airs - l'escadrille de Jeztor",
	["Call of Air - Mulverick's Fleet"] = "L'appel des airs - l'escadrille de Mulverick",
	["Stormpike Soldier's Flesh"] = "Chair de soldat stormpike",
	["Stormpike Lieutenant's Flesh"] = "Chair de lieutenant stormpike",
	["Stormpike Commander's Flesh"] = "Chair de commandant stormpike",

	--Mark of Honor quests
	["For Great Honor"] = "Pour un grand honneur",
	["Concerted Efforts"] = "Des efforts concertés",
	["Conquering Arathi Basin"] = "La conquête du bassin d'Arathi",
	["Claiming Arathi Basin"] = "La revendication du bassin d'Arathi",
	["Invaders of Alterac Valley"] = "Les envahisseurs de la vallée d'Alterac",
	["Remember Alterac Valley!"] = "Souvenez-vous de la vallée d'Alterac !",
	["Battle of Warsong Gulch"] = "La bataille du goulet des Warsong",
	["Fight for Warsong Gulch"] = "La lutte pour le goulet des Warsong",
	["Alterac Valley Mark of Honor"] = "Marque d'honneur de la vallée d'Alterac",
	["Arathi Basin Mark of Honor"] = "Marque d'honneur du bassin d'Arathi",
	["Warsong Gulch Mark of Honor"] = "Marque d'honneur du goulet des Warsong",

	-- Felwood salves
	["Salve via Gathering"] = "Du baume contre une récolte",
	["Fel Creep"] = "Gangrimpante",
	["Salve via Mining"] = "Du baume par la pioche",
	["Tainted Vitriol"] = "Vitriol contaminé",
	["Salve via Skinning"] = "Du baume contre des peaux",
	["Patch of Tainted Skin"] = "Morceau de peau contaminée",
	["Salve via Hunting"] = "Du baume en chassant",
	["Corrupted Soul Shard"] = "Fragment d'âme corrompue",
	["Salve via Disenchanting"] = "Du baume contre des désenchantements",
	["Lesser Nether Essence"] = "Essence du néant inférieure",

	-- Felwood plants
	["Corrupted Whipper Root"] = "La navetille corrompue",
	["Corrupted Songflower"] = "La fleur-de-chant corrompue",
	["Corrupted Windblossom"] = "La fleur-de-vent corrompue",
	["Corrupted Night Dragon"] = "Dragon nocturne corrompu",
	["Cenarion Plant Salve"] = "Baume végétal cénarien",

	-- Thorium Shells -> Thorium Arrows Quest
	["A Fair Trade"] = "Un marché honnête",
	["Thorium Shells"] = "Obus en thorium",

	-- Ravenholdt
	["Syndicate Emblems"] = "Emblèmes du Syndicat",
	["Syndicate Emblem"] = "Emblème du Syndicat",

	-- Cenarion
	["Encrypted Twilight Texts"] = "Les textes du crépuscule cryptés",
	["Encrypted Twilight Text"] = "Texte du crépuscule crypté",

	-- Argent Dawn
	["Minion's Scourgestones"] = "Pierre du Fléau des serviteurs",
	["Minion's Scourgestone"] = "Pierre du Fléau des serviteurs",
	["Invader's Scourgestones"] = "Pierres du Fléau des envahisseurs",
	["Invader's Scourgestone"] = "Pierre du Fléau des envahisseurs",
	["Corruptor's Scourgestones"] = "Pierres du Fléau des corrupteurs",
	["Corruptor's Scourgestone"] = "Pierre du Fléau des corrupteurs",
	["Bone Fragments"] = "Fragments d'os",
	["Core of Elements"] = "Le noyau des éléments",
	["Crypt Fiend Parts"] = "Crypt Fiend Parts",
	["Dark Iron Scraps"] = "Des morceaux de démon des cryptes",
--	["Savage Fronds"] = "",
	["Savage Frond"] = "Palme sauvage",

	-- Timbermaw
	["Feathers for Grazle"] = "Des plumes pour Grifleur",
	["Feathers for Nafien"] = "Des plumes pour Nafien",
	["Beads for Salfa"] = "Des perles pour Salfa",
	["Deadwood Headdress Feather"] = "Coiffure de plumes mort-bois",
	["Winterfall Spirit Beads"] = "Perles d'esprit tombe-hiver",
	
	-- Cauldron quests
	["Gahrron's Withering Cauldron"] = "Chaudron de la Flétrissure de Gahrron",
	["Writhing Haunt Cauldron"] = "Le Chaudron du Repaire putride",
	["Felstone Field Cauldron"] = "Le Chaudron du champ de Felstone",
	["Dalson's Tears Cauldron"] = "Chaudron des Larmes de Dalson",
	["Arcane Quickener"] = "Catalyseur des arcanes",
	["Ectoplasmic Resonator"] = "Résonateur ectoplasmique",
	["Somatic Intensifier"] = "Intensificateur somatique",
	["Osseous Agitator"] = "Agitateur osseux",

	-- Gadgetzan
	["Water Pouch Bounty"] = "Prime de la poche à eau",
	["Wastewander Water Pouch"] = "Outre de Bat-le-désert",

	-- Thorium Brotherhood
	["Gaining Acceptance"] = "Se faire accepter",
	["Dark Iron Residue"] = "Résidu de sombrefer",
	["Restoring Fiery Flux Supplies via Kingsblood"] = "Réapprovisionnement en flux embrasé (Sang-royal)",
	["Kingsblood"] = "Sang-royal",
	["Restoring Fiery Flux Supplies via Iron"] = "Réapprovisionnement en flux embrasé (Fer)",
	["Iron Bar"] = "Barre de fer",
	["Restoring Fiery Flux Supplies via Heavy Leather"] = "Réapprovisionnement en flux embrasé (Cuir lourd)",
	["Heavy Leather"] = "Cuir lourd",
	["Incendosaur Scale"] = "Ecaille d'Incendosaure",
	["Coal"] = "Charbon",
	["Favor Amongst the Brotherhood, Dark Iron Ore"] = "Faveur auprès de la Confrérie, Minerai de sombre",
	["Dark Iron Ore"] = "Minerai de sombrefer",
	["Favor Amongst the Brotherhood, Blood of the Mountain"] = "Faveur auprès de la Confrérie, Sang de la montagne",
	["Blood of the Mountain"] = "Sang de la montagne",
	["Favor Amongst the Brotherhood, Core Leather"] = "Faveur auprès de la Confrérie, Cuir du Magma",
	["Core Leather"] = "Cuir du Magma",
	["Favor Amongst the Brotherhood, Fiery Core"] = "Faveur auprès de la Confrérie, Noyau de feu",
	["Fiery Core"] = "Noyau de feu",
	["Favor Amongst the Brotherhood, Lava Core"] = "Faveur auprès de la Confrérie, Noyau de lave",
	["Lava Core"] = "Noyau de lave",

	-- City faction
	["Additional Runecloth"] = "Encore de l'étoffe runique",
	["Runecloth"] = "Etoffe runique",

	-- Wildhammer faction
	["Troll Necklace Bounty"] = "Chasse aux colliers trolls",
	["Troll Tribal Necklace"] = "Collier tribal troll",

	-- E'ko quests
	["Chillwind E'ko Item"] = "E'ko de Noroît",
	["Chillwind E'ko Quest"] = "L'E'ko de Noroît",
	["Frostmaul E'ko Item"] = "E'ko de Cognegivre",
	["Frostmaul E'ko Quest"] = "L'E'ko de Cognegivre",
	["Frostsaber E'ko Item"] = "E'ko de sabre-de-givre",
	["Frostsaber E'ko Quest"] = "L'E'ko des sabres-de-givre",
	["Ice Thistle E'ko Item"] = "E'ko de Chardon de glace",
	["Ice Thistle E'ko Quest"] = "L'E'ko des Chardon de Glace",
	["Shardtooth E'ko Item"] = "E'ko de Croc acéré",
	["Shardtooth E'ko Quest"] = "L'E'ko des Crocs acérés",
	["Wildkin E'ko Item"] = "E'ko d'Indomptable",
	["Wildkin E'ko Quest"] = "L'E'ko des Indomptables",
	["Winterfall E'ko"] = "E'ko des Tombe-hiver",

	-- Zul'Gurub quests
	["Zulian, Razzashi, and Hakkari Coins"] = "Pièces zuliennes, razzashi et hakkari",
	["Zulian Coin"] = "Pièce zulienne",
	["Razzashi Coin"] = "Pièce Razzashi",
	["Hakkari Coin"] = "Pièce hakkari",
	["Gurubashi, Vilebranch, and Witherbark Coins"] = "Pièces Gurubashi, Vilebranch et Witherbark",
	["Gurubashi Coin"] = "Pièce Gurubashi",
	["Vilebranch Coin"] = "Pièce Vilebranch",
	["Witherbark Coin"] = "Pièce Witherbark",
	["Sandfury, Skullsplitter, and Bloodscalp Coins"] = "Pièces Sandfury, Skullsplitter et Bloodscalp",
	["Sandfury Coin"] = "Pièce Sandfury",
	["Skullsplitter Coin"] = "Pièce Skullsplitter",
	["Bloodscalp Coin"] = "Pièce Bloodscalp",
	
	-- AQ War Effort (Horde)
	["The Horde Needs More Runecloth Bandages!"] = "La Horde a besoin de plus de bandages en étoffe runique !",
	["The Horde Needs More Mageweave Bandages!"] = "La Horde a besoin de plus de bandages en tisse-mage",
	["The Horde Needs More Wool Bandages!"] = "La Horde a besoin de plus de bandages en laine !",
	["The Horde Needs More Rugged Leather!"] = "La Horde a besoin de plus de cuir robuste !",
	["The Horde Needs More Thick Leather!"] = "La Horde a besoin de plus de cuir épais !",
	["The Horde Needs More Heavy Leather!"] = "La Horde a besoin de plus de cuir lourd !",
	["The Horde Needs More Purple Lotus!"] = "La Horde a besoin de plus de lotus pourpre !",
	["The Horde Needs More Firebloom!"] = "La Horde a besoin de plus de fleur de feu !",
	["The Horde Needs More Mithril Bars!"] = "La Horde a besoin de plus de barres mithril !",
	["The Horde Needs More Tin Bars!"] = "La Horde a besoin de plus de barres d'étain !",
	["The Horde Needs More Copper Bars!"] = "La Horde a besoin de plus de barres de cuivre !",
	["The Horde Needs More Lean Wolf Steaks!"] = "La Horde a besoin de plus de steaks de loup !",
	["The Horde Needs More Spotted Yellowtail!"] = "La Horde a besoin de plus de jaune-queue tacheté !",
	["The Horde Needs More Baked Salmon!"] = "La Horde a besoin de plus de pain de saumon !",

	-- AQ War Effort (Alliance)
	["The Alliance Needs More Linen Bandages!"] = "L'Alliance a besoin de plus de bandages en lin !",
	["The Alliance Needs More Silk Bandages!"] = "L'Alliance a besoin de plus de bandages en soie !",
	["The Alliance Needs More Runecloth Bandages!"] = "L'Alliance a besoin de plus de bandages en étoffe runique !",
	["The Alliance Needs More Medium Leather!"] = "L'Alliance a besoin de plus de cuir moyen !",
	["The Alliance Needs More Thick Leather!"] = "L'Alliance a besoin de plus de cuir épais !",
	["The Alliance Needs More Stranglekelp!"] = "L'Alliance a besoin de plus d'étouffante !",
	["The Alliance Needs More Purple Lotus!"] = "L'Alliance a besoin de plus de lotus pourpre !",
	["The Alliance Needs More Arthas' Tears!"] = "L'Alliance a besoin de plus de l'armes d'Arthas !",
	["The Alliance Needs More Copper Bars!"] = "L'Alliance a besoin de plus de barres de cuivre !",
	["The Alliance Needs More Iron Bars!"] = "L'Alliance a besoin de plus de barres de fer !",
	["The Alliance Needs More Thorium Bars!"] = "L'Alliance a besoin de plus de barres de thorium !",
	["The Alliance Needs More Rainbow Fin Albacore!"] = "L'Alliance a besoin de plus de thon arc-en-ciel !",
	["The Alliance Needs More Roast Raptor!"] = "L'Alliance a besoin de plus de rôti de raptor !",
	["The Alliance Needs More Spotted Yellowtail!"] = "L'Alliance a besoin de plus de jaune-queue tacheté !",

	-- AQ War Effort Items
	["Linen Bandage"] = "Bandage en lin",
	["Wool Bandage"] = "Bandage en laine",
	["Silk Bandage"] = "Bandage en soie",
	["Mageweave Bandage"] = "Bandage en tisse-mage",
	["Runecloth Bandage"] = "Bandage en étoffe runique",
	["Light Leather"] = "Cuir léger",
	["Medium Leather"] = "Cuir moyen",
	["Heavy Leather"] = "Cuir lourd",
	["Thick Leather"] = "Cuir épais",
	["Rugged Leather"] = "Cuir robuste",
	["Purple Lotus"] = "Lotus pourpre",
	["Stranglekelp"] = "Etouffante",
	["Arthas' Tears"] = "Larmes d'Arthas",
	["Firebloom"] = "Fleur de feu",
	["Peacebloom"] = "Pacifique",
	["Copper Bar"] = "Barre de cuivre",
	["Tin Bar"] = "Barre d'étain",
	["Iron Bar"] = "Barre de fer",
	["Mithril Bar"] = "Barre de mithril",
	["Thorium Bar"] = "Barre de thorium",
	["Lean Wolf Steak"] = "Steak de loup",
	["Spotted Yellowtail"] = "Jaune-queue tacheté",
	["Baked Salmon"] = "Pain de saumon",
	["Roast Raptor"] = "Rôti de raptor",
	["Rainbow Fin Albacore"] = "Thon arc-en-ciel",
	
	-- Commendation Signets
	["One Commendation Signet"] = "Une chevalière de mérite",
	["Ten Commendation Signets"] = "Dix chevalières de mérite",
	["Horde Commendation Signet"] = "Chevalière de mérite de la Horde",
	["Alliance Commendation Signet"] = "Chevalière de mérite de l'Alliance",
} end )