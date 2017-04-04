assert(Automaton, "Automaton not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("Automaton_Sell")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["Sell"] = true,
	["Automatically sell all grey inventory items when at merchant"] = true,
	["Ignore"] = true,
	["Items that should never be sold."] = true,
	["List"] = true,
	["Print all items being ignored by Sell to the screen."] = true,
	["Print all items being sold by Sell to the screen."] = true,
	["Add Item"] = true,
	["Add an item to be ignored, accepts item names or links. Name must be exact, and is case sensitive."] = true,
	["Add an item to always besold, accepts item names or links. Name must be exact, and is case sensitive."] = true,
	["<item name or link>"] = true,
	["Remove Item"] = true,
	["Removes an item from the ignore list. It must be entered exactly as it was added."] = true,
	["Removes an item from the always sell list. It must be entered exactly as it was added."] = true,
	["Purge"] = true,
	["Remove all items from the ignore list."] = true,
	["Remove all items from the always sell list."] = true,
	[" items purged."] = true,
	["Always sell"] = true,
	["Items that should always be sold."] = true,
	["Ignoring no items."] = true,
	["Ignoring these items:"] = true,
	["No items are specified to always be sold."] = true,
	["Always selling these items:"] = true,
} end)

L:RegisterTranslations("ruRU", function() return {
    ["Sell"] = "Продажа",
	["Automatically sell all grey inventory items when at merchant"] = "Автоматическая продажа всех серых вещей из инвентаря, когда у торговца",
	["Ignore"] = "Игнорирование",
	["Items that should never be sold."] = "Эти предметы никогда не будут проданы.",
	["List"] = "Список",
	["Print all items being ignored by Sell to the screen."] = "Вывод всех игнорируемых для продажи предметов.",
	["Print all items being sold by Sell to the screen."] = "Вывод всех обязательно продаваемых предметов.",
	["Add Item"] = "Добавить предмет",
	["Add an item to be ignored, accepts item names or links. Name must be exact, and is case sensitive."] = "Добавьте предмет, который нужно игнорировать, принимает имена предметов или ссылки. Имя должно быть точным и чувствительным к регистру.",
	["Add an item to always besold, accepts item names or links. Name must be exact, and is case sensitive."] = "Добавьте предмет, который всегда продается, принимает имена предметов или ссылки. Имя должно быть точным и чувствительным к регистру.",
	["<item name or link>"] = "<название предмета или ссылка>",
	["Remove Item"] = "Удалить предмет",
	["Removes an item from the ignore list. It must be entered exactly as it was added."] = "Удаляет предмет из списка игнорирования. Он должен вводиться точно так же, как он был добавлен.",
	["Removes an item from the always sell list. It must be entered exactly as it was added."] = "Удаляет предмет из списка 'Продавать всегда'. Он должен вводиться точно так же, как он был добавлен.",
	["Purge"] = "Очистить",
	["Remove all items from the ignore list."] = "Удалите все элементы из списка игнорирования.",
	["Remove all items from the always sell list."] = "Удалите все элементы из списка 'Продавать всегда'.",
	[" items purged."] = " предметов очищено.",
	["Always sell"] = "Продавать всегда",
	["Items that should always be sold."] = "Предметы, которые всегда должны продаваться.",
	["Ignoring no items."] = "Нет игнорируемых предметов.",
	["Ignoring these items:"] = "Игнорируются эти предметы:",
	["No items are specified to always be sold."] = "Товары для продажи не указаны.",
	["Always selling these items:"] = "Всегда продавать эти предметы:",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

Automaton_Sell = Automaton:NewModule("Sell")
Automaton_Sell.modulename = L["Sell"]
Automaton_Sell.moduledesc = L["Automatically sell all grey inventory items when at merchant"]
Automaton_Sell.options = {
	ignore = {
		type  = "group", name  = L["Ignore"], desc  = L["Items that should never be sold."],
		args  = {
			list = {
				type = "execute", name = L["List"], desc = L["Print all items being ignored by Sell to the screen."],
				func = function() Automaton_Sell:ListIgnored() end
			},
			add = {
				type  = "text", name = L["Add Item"], desc = L["Add an item to be ignored, accepts item names or links. Name must be exact, and is case sensitive."],
				order = 1, usage = L["<item name or link>"],
				get   = false,
				set   = function(v) Automaton_Sell:IgnoreItem(v) end,
			},
			remove = {
				type  = "text", name = L["Remove Item"], desc = L["Removes an item from the ignore list. It must be entered exactly as it was added."],
				order = 2, usage = L["<item name or link>"],
				get   = false,
				set   = function(v) Automaton_Sell:RemoveIgnore(v) end,
			},
			purge = {
				type = "execute", name = L["Purge"], desc = L["Remove all items from the ignore list."],
				func = function() Automaton_Sell:PurgeIgnored() end
			}
		},
	},
	custom = {
		type  = "group", name = L["Always sell"], desc = L["Items that should always be sold."],
		args  = {
			list = {
				type = "execute", name = L["List"], desc = L["Print all items being sold by Sell to the screen."],
				func = function() Automaton_Sell:ListAlwaysSell() end
			},
			add = {
				type  = "text", name = L["Add Item"], desc = L["Add an item to always besold, accepts item names or links. Name must be exact, and is case sensitive."],
				order = 1, usage = L["<item name or link>"],
				get   = false,
				set   = function(v) Automaton_Sell:AlwaysSellItem(v) end,
			},
			remove = {
				type  = "text", name = L["Remove Item"], desc = L["Removes an item from the always sell list. It must be entered exactly as it was added."],
				order = 2, usage = L["<item name or link>"],
				get   = false,
				set   = function(v) Automaton_Sell:RemoveAlwaysSell(v) end,
			},
			purge = {
				type = "execute", name = L["Purge"], desc = L["Remove all items from the always sell list."],
				func = function() Automaton_Sell:PurgeAlwaysSell() end
			}
		},
	},
}

------------------------------
--      Initialization      --
------------------------------

function Automaton_Sell:OnInitialize()
	self.db = Automaton:AcquireDBNamespace("Sell")
	Automaton:RegisterDefaults("Sell", "profile", {
		useGarbageFu = false,
		ignore = {},
		custom = {}
	})
	
	self:RegisterOptions(self.options)
end

function Automaton_Sell:OnEnable()
	self:RegisterEvent("MERCHANT_SHOW")
end

function Automaton_Sell:OnDisable()
	self:UnregisterAllEvents()
end

------------------------------
--      Event Handlers      --
------------------------------

local bag, slot
function Automaton_Sell:MERCHANT_SHOW()
	for bag = 0, 4 do
		if GetContainerNumSlots(bag) > 0 then
			for slot = 1, GetContainerNumSlots(bag) do
				local texture, itemCount, locked, quality = GetContainerItemInfo(bag, slot)
				if quality then
					local linkcolor = self:ProcessLink(GetContainerItemLink(bag, slot))
					if linkcolor == 1 and not self:IsDebugging() then
						UseContainerItem(bag, slot)
					end
				end
			end
		end
	end
end

local color, name
function Automaton_Sell:ProcessLink(link)
	for color, name in string.gmatch(link, "(|c%x+)|Hitem:.+|h%[(.-)%]|h|r") do
		for k,v in pairs(self.db.profile.ignore) do
			if (name == v) or (link == v) then
				self:Debug("ProcessLink: %s", name)
				return 0
			end
		end
		for k,v in pairs(self.db.profile.custom) do
			if (name == v) or (link == v) then
				self:Debug("ProcessLink: %s", name)
				return 1
			end
		end
		if color == ITEM_QUALITY_COLORS[0].hex then
			self:Debug("ProcessLink: %s", name)
			return 1
		end
	end
	return 0
end

function Automaton_Sell:IgnoreItem(item)
	tinsert(self.db.profile.ignore,item)
end

function Automaton_Sell:RemoveIgnore(item)
	for k,v in pairs(self.db.profile.ignore) do
		if v == item then
			self.db.profile.ignore[k] = nil
		end
	end
end

function Automaton_Sell:ListIgnored()
	if table.getn{self.db.profile.ignore} == 0 then
		self:Print(L["Ignoring no items."])
	else
		self:Print(L["Ignoring these items:"])
		for k,v in pairs(self.db.profile.ignore) do
			self:Print(v)
		end
	end
end

function Automaton_Sell:PurgeIgnored()
	self:Print(table.getn{self.db.profile.ignore} .. L[" items purged."])
	self.db.profile.ignore = {}
end

function Automaton_Sell:AlwaysSellItem(item)
	tinsert(self.db.profile.custom,item)
end

function Automaton_Sell:RemoveAlwaysSell(item)
	for k,v in pairs(self.db.profile.custom) do
		if v == item then
			self.db.profile.custom[k] = nil
		end
	end
end

function Automaton_Sell:ListAlwaysSell()
	if table.getn{self.db.profile.custom} == 0 then
		self:Print(L["No items are specified to always be sold."])
else
		self:Print(L["Always selling these items:"])
		for k,v in pairs(self.db.profile.custom) do
			self:Print(v)
		end
	end
end

function Automaton_Sell:PurgeAlwaysSell()
	self:Print(table.getn{self.db.profile.custom} .. L[" items purged."])
	self.db.profile.custom = {}
end