assert(Automaton, "Automaton not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("Automaton_Repair")
local abacus = AceLibrary("Abacus-2.0")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
    ["Repair"] = true,
	["Automatically repair all inventory items when at merchant"] = true,
    ["Repairing all items for: %s"] = true,
} end)

L:RegisterTranslations("ruRU", function() return {
    ["Repair"] = "Ремонт",
	["Automatically repair all inventory items when at merchant"] = "Автоматический ремонт всех предметов инвентаря, когда у торговца",
    ["Repairing all items for: %s"] = "Ремонт всех предметов инвентаря: %s",
} end)

L:RegisterTranslations("koKR", function() return {
    ["Repair"] = "아이템 수리",
	["Automatically repair all inventory items when at merchant"] = "상인에게 모든 아이템을 자동으로 수리합니다.",
    ["Repairing all items for: %s"] = "모든 아이템 수리: %s",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

Automaton_Repair = Automaton:NewModule("Repair")
Automaton_Repair.modulename = L["Repair"]
Automaton_Repair.moduledesc = L["Automatically repair all inventory items when at merchant"]
Automaton_Repair.options = {}

------------------------------
--      Initialization      --
------------------------------

function Automaton_Repair:OnInitialize()
    self.db = Automaton:AcquireDBNamespace("Repair")
	Automaton:RegisterDefaults("Repair", "profile", {
		disabled = true,
	})
	Automaton:SetDisabledAsDefault(self, "Repair")
	
	self:RegisterOptions(self.options)
end

function Automaton_Repair:OnEnable()
	self:RegisterEvent("MERCHANT_SHOW")
end

function Automaton_Repair:OnDisable()
	self:UnregisterAllEvents()
end

------------------------------
--      Event Handlers      --
------------------------------

function Automaton_Repair:MERCHANT_SHOW()
	if not CanMerchantRepair() then return end
	local repairCost = GetRepairAllCost()
	if repairCost > 0 then
		self:Print(L["Repairing all items for: %s"], abacus:FormatMoneyFull(repairCost, true))
		if not self:IsDebugging() then
			RepairAllItems()
		end
	end
end