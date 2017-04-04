assert(Automaton, "Automaton not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("Automaton_Release")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
    ["Release"] = true,
	["Automatically release to ghost after dying in a battleground"] = true,
} end)

L:RegisterTranslations("ruRU", function() return {
    ["Release"] = "Высвобождение",
	["Automatically release to ghost after dying in a battleground"] = "Автоматическое высвобождение духа после смерти на полях боя",
} end)

L:RegisterTranslations("koKR", function() return {
    ["Release"] = "전장 부활",
	["Automatically release to ghost after dying in a battleground"] = "전장에서 죽은 후에 유령상태시 자동으로 부활합니다.",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

Automaton_Release = Automaton:NewModule("Release")
Automaton_Release.modulename = L["Release"]
Automaton_Release.moduledesc = L["Automatically release to ghost after dying in a battleground"]
Automaton_Release.options = {}

------------------------------
--      Initialization      --
------------------------------

function Automaton_Release:OnInitialize()
    self.db = Automaton:AcquireDBNamespace("Release")
	Automaton:RegisterDefaults("Release", "profile", {
		disabled = true,
	})
	Automaton:SetDisabledAsDefault(self, "Release")
	
	self:RegisterOptions(self.options)
end

function Automaton_Release:OnEnable()
	self:RegisterEvent("PLAYER_DEAD")
end

function Automaton_Release:OnDisable()
	self:UnregisterAllEvents()
end

------------------------------
--      Event Handlers      --
------------------------------

function Automaton_Release:PLAYER_DEAD()
	if MiniMapBattlefieldFrame.status == "active" then
		self:Debug("Releasing...")
		RepopMe()
	end
end