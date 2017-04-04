assert(Automaton, "Automaton not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("Automaton_Wuss")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
    ["Wuss"] = true,
	["Decline all incoming duels. Like the wuss you are."] = true,
    ["Canceling duel..."] = true,
} end)

L:RegisterTranslations("ruRU", function() return {
    ["Wuss"] = "Слабак",
	["Decline all incoming duels. Like the wuss you are."] = "Отмена всех входящих дуэлей.",
    ["Canceling duel..."] = "Отмена дуэли...",
} end)

L:RegisterTranslations("koKR", function() return {
    ["Wuss"] = "결투 거절",
	["Decline all incoming duels. Like the wuss you are."] = "모든 결투 신청을 거절합니다.",
    ["Canceling duel..."] = "결투 취소...",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

Automaton_Wuss = Automaton:NewModule("Wuss")
Automaton_Wuss.modulename = L["Wuss"]
Automaton_Wuss.moduledesc = L["Decline all incoming duels. Like the wuss you are."]
Automaton_Wuss.options = {}

------------------------------
--      Initialization      --
------------------------------

function Automaton_Wuss:OnInitialize()
	self.db = Automaton:AcquireDBNamespace("Wuss")
	Automaton:RegisterDefaults("Wuss", "profile", {
		disabled = true,
	})
	Automaton:SetDisabledAsDefault(self, "Wuss")
	
	self:RegisterOptions(self.options)
end

function Automaton_Wuss:OnEnable()
	self:RegisterEvent("DUEL_REQUESTED")
end

function Automaton_Wuss:OnDisable()
	self:UnregisterAllEvents()
end

------------------------------
--      Event Handlers      --
------------------------------

function Automaton_Wuss:DUEL_REQUESTED()
	self:Print(L["Canceling duel..."])
	CancelDuel()
	StaticPopup_Hide("DUEL_REQUESTED")
end