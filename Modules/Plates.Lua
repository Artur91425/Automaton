assert(Automaton, "Automaton not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("Automaton_Plates")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["Plates"] = true,
	["Shows name plates in combat."] = true,
} end)

L:RegisterTranslations("ruRU", function() return {
	["Plates"] = "Индикаторы",
	["Shows name plates in combat."] = "Показывать индикаторы здоровья в бою",
} end)

L:RegisterTranslations("koKR", function() return {
	["Plates"] = "이름표 표시",
	["Shows name plates in combat."] = "전투상태시 이름을 표시합니다.",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

Automaton_Plates = Automaton:NewModule("Plates")
Automaton_Plates.modulename = L["Plates"]
Automaton_Plates.moduledesc = L["Shows name plates in combat."]
Automaton_Plates.options = {}

------------------------------
--      Initialization      --
------------------------------

function Automaton_Plates:OnInitialize()
    self.db = Automaton:AcquireDBNamespace("Plates")
	Automaton:RegisterDefaults("Plates", "profile", {
		disabled = true,
	})
	Automaton:SetDisabledAsDefault(self, "Plates")

	self:RegisterOptions(self.options)
end

function Automaton_Plates:OnEnable()
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
end

function Automaton_Plates:OnDisable()
	self:UnregisterAllEvents()
end

------------------------------
--      Event Handlers      --
------------------------------

function Automaton_Plates:PLAYER_REGEN_ENABLED()
	HideNameplates()
end

function Automaton_Plates:PLAYER_REGEN_DISABLED()
	ShowNameplates()
end	