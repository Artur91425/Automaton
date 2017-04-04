assert(Automaton, "Automaton not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("Automaton_LootBOP")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["LootBOP"] = true,
	["Ignore BOP confirm message when not in a party or raid"] = true,
} end)

L:RegisterTranslations("ruRU", function() return {
	["LootBOP"] = "Добыча",
	["Ignore BOP confirm message when not in a party or raid"] = "Игнорировать подтверждения поднятия добычи, когда не в группе или рейде",
} end)

L:RegisterTranslations("koKR", function() return {
	["LootBOP"] = "LootBOP",
	["Ignore BOP confirm message when not in a party or raid"] = "파티 또는 공격대시 아이템 획득 확인 메시지를 무시합니다.",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

Automaton_LootBOP = Automaton:NewModule("LootBOP")
Automaton_LootBOP.modulename = L["LootBOP"]
Automaton_LootBOP.moduledesc = L["Ignore BOP confirm message when not in a party or raid"]
Automaton_LootBOP.options = {}

------------------------------
--      Initialization      --
------------------------------

function Automaton_LootBOP:OnInitialize()
    self.db = Automaton:AcquireDBNamespace("LootBOP")
	Automaton:RegisterDefaults("LootBOP", "profile", {
		disabled = true,
	})
	Automaton:SetDisabledAsDefault(self, "LootBOP")

	self:RegisterOptions(self.options)
end

function Automaton_LootBOP:OnEnable()
	self:RegisterEvent("LOOT_BIND_CONFIRM")
end

function Automaton_LootBOP:OnDisable()
	self:UnregisterAllEvents()
	end

------------------------------
--      Event Handlers      --
------------------------------

function Automaton_LootBOP:LOOT_BIND_CONFIRM(slot)
	if GetNumPartyMembers() == 0 then
		self:Debug("Looting...")
		LootSlot(slot)
		StaticPopup_Hide("LOOT_BIND")
	end
end