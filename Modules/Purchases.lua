assert(Automaton, "Automaton not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("Automaton_Purchases")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["Purchases"] = true,
	["Automatically restock items"] = true,
	["Reagent"] = true,
	["Set item to buy"] = true,
	["Quantity"] = true,
	["Set the number of purchased items"] = true,
--	["Other"] = true,
--	["Set other item to buy"] = true,
--	["<Enter item name>"] = true,
	["Bought "] = true,
	[" items."] = true,
	["Already have "] = true,
	
--	["Not chosen"] = true,
	["Ankh"] = true,
	["Arcane Powder"] = true,
	["Ashwood Seed"] = true,
	["Demonic Figurine"] = true,
	["Holy Candle"] = true,
	["Hornbeam Seed"] = true,
	["Infernal Stone"] = true,
	["Ironwood Seed"] = true,
	["Maple Seed"] = true,
	["Rune of Portals"] = true,
	["Rune of Teleportation"] = true, 
	["Sacred Candle"] = true,
	["Stranglethorn Seed"] = true,
	["Symbol of Divinity"] = true,
	["Symbol of Kings"] = true,
	["Wild Berries"] = true,
	["Wild Thornroot"] = true,
} end)

L:RegisterTranslations("ruRU", function() return {
	["Purchases"] = "Покупки",
	["Automatically restock items"] = "Автоматическое пополнение предметов.",
	["Reagent"] = "Реагент",
	["Set item to buy"] = "Установите предмет для покупки",
	["Quantity"] = "Количество",
	["Set the number of purchased items"] = "Установите количество покупаемых предметов",
--	["Other"] = "Другое",
--	["Set other item to buy"] = "Установите другой предмет для покупки",
--	["<Enter item name>"] = "<Введите название предмета>",
	["Bought "] = "Куплено ",
	[" items."] = " предметов.",
	["Already have "] = "Уже имеется ",
	
--	["Not chosen"] = "Ничего",
	["Ankh"] = "Крест",
	["Arcane Powder"] = "Порошок чар",
	["Ashwood Seed"] = "Семена ясеня",
	["Demonic Figurine"] = "Демоническая статуэтка",
	["Holy Candle"] = "Святая свеча",
	["Hornbeam Seed"] = "Семена граба",
	["Infernal Stone"] = "Камень инфернала",
	["Ironwood Seed"] = "Семена железного дерева",
	["Maple Seed"] = "Семена клена",
	["Rune of Portals"] = "Руна порталов",
	["Rune of Teleportation"] = "Руна телепортации",
	["Sacred Candle"] = "Священная свеча",
	["Stranglethorn Seed"] = "Семя из Тернистой долины",
	["Symbol of Divinity"] = "Знак божественности",
	["Symbol of Kings"] = "Знак королей",
	["Wild Berries"] = "Лесные ягоды",
	["Wild Thornroot"] = "Дикий шипокорень",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

Automaton_Purchases = Automaton:NewModule("Purchases")
Automaton_Purchases.modulename = L["Purchases"]
Automaton_Purchases.moduledesc = L["Automatically restock items"]
Automaton_Purchases.options = {
	reagent = {
		type = "text", name = L["Reagent"], desc = L["Set item to buy"], order = 2,
		get = function() return Automaton_Purchases.db.profile.reagent end,
		set = function(v) Automaton_Purchases.db.profile.reagent = v end,
		validate = {L["Ankh"], L["Arcane Powder"], L["Ashwood Seed"], L["Demonic Figurine"], L["Holy Candle"], L["Hornbeam Seed"], L["Infernal Stone"], L["Infernal Stone"], L["Maple Seed"], L["Rune of Portals"], L["Rune of Teleportation"], L["Sacred Candle"], L["Stranglethorn Seed"], L["Symbol of Divinity"], L["Symbol of Kings"], L["Wild Berries"], L["Wild Thornroot"]}
	},
	quantity = {
		type = "range", name = L["Quantity"], desc = L["Set the number of purchased items"], order = 3,
		get = function() return Automaton_Purchases.db.profile.quantity end,
		set = function(v) Automaton_Purchases.db.profile.quantity = v end,
		min = 0,
		max = 60,
		step = 5,
		bigStep = 10,
	},
--	other = {
--		type = 'text', name = L["Other"], desc = L["Set other item to buy"],
--		order = 4, usage = L["<Enter item name>"],
--		get = function() return Automaton_Purchases.db.profile.other end,
--		set = function(v) Automaton_Purchases.db.profile.other = v end,
--	}
}

------------------------------
--      Initialization      --
------------------------------

function Automaton_Purchases:OnInitialize()
	self.db = Automaton:AcquireDBNamespace("Purchases")
	Automaton:RegisterDefaults("Purchases", "profile", {
		disabled = true,
		quantity = 0,
		reagent = L["Ankh"],
	})
	Automaton:SetDisabledAsDefault(self, "Purchases")
	
	self:RegisterOptions(self.options)
end

function Automaton_Purchases:OnEnable()
	self:RegisterEvent("MERCHANT_SHOW")
end

function Automaton_Purchases:OnDisable()
	self:UnregisterAllEvents()
end

------------------------------
--      Event Handlers      --
------------------------------

function Automaton_Purchases:MERCHANT_SHOW()
	quantity = Automaton_Purchases.db.profile.quantity
	reagent = Automaton_Purchases.db.profile.reagent
--[[	other = Automaton_Purchases.db.profile.other
	local itemname
	if (other == not nil) then 
		reagent = L["Not chosen"]
		itemname = other
	else
		itemname = reagent
		other = nil
	end]]

	for i = 1, GetMerchantNumItems() do
		local MerchantItem = GetMerchantItemInfo(i)
		if MerchantItem == reagent then
			local amountInBag = tonumber(self:SearchItem(reagent))
			local needed = quantity - amountInBag
			if needed > 0 then
				BuyMerchantItem(i, needed)
				self:Print(L["Bought "]..needed..L[" items."])
				else
				self:Print(L["Already have "]..amountInBag..L[" items."])
			end
		end
	end
end



function Automaton_Purchases:SearchItem(itemname)
	local count = 0
	for bag = 0, 4 do
		if GetContainerNumSlots(bag) > 0 then
			for slot = 0, GetContainerNumSlots(bag) do
				if GetContainerItemLink(bag, slot) then
					local _,_,link = string.find(GetContainerItemLink(bag, slot), "(item:%d+:%d+:%d+:%d+)")
					local item = GetItemInfo(link)
					if item == itemname then
						local _,q = GetContainerItemInfo(bag, slot)
						count = count + q
					end
				end
			end
		end
	end
	return count
end