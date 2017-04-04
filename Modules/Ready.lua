assert(Automaton, "Automaton not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("Automaton_Ready")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["Ready"] = true,
	["Auto ready when checking raid"] = true,
} end)

L:RegisterTranslations("ruRU", function() return {
	["Ready"] = "Готовность",
	["Auto ready when checking raid"] = "Автоматическая готовность при проверке рейда",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

Automaton_Ready = Automaton:NewModule("Ready")
Automaton_Ready.modulename = L["Ready"]
Automaton_Ready.moduledesc = L["Auto ready when checking raid"]
Automaton_Ready.options = {}

------------------------------
--      Initialization      --
------------------------------

function Automaton_Ready:OnInitialize()
    self.db = Automaton:AcquireDBNamespace("Ready")
	Automaton:RegisterDefaults("Ready", "profile", {
		disabled = true,
	})
	Automaton:SetDisabledAsDefault(self, "Ready")
	
	self:RegisterOptions(self.options)
end

function Automaton_Ready:OnEnable()
    self:RegisterEvent("READY_CHECK", function() ConfirmReadyCheck(true) end)
    if ShowReadyCheck then
        self:Hook("ShowReadyCheck", function() if self.db.profile.sound then PlaySound("ReadyCheck") end end)
	else
        self:RegisterEvent("RAID_ROSTER_UPDATE",
            function()
                if ShowReadyCheck then
                    self:UnregisterEvent("RAID_ROSTER_UPDATE")
                    self:Hook("ShowReadyCheck", function() if self.db.profile.sound then PlaySound("ReadyCheck") end end)
				end
			end
		)
	end
end

function Automaton_Ready:OnDisable()
	self:UnregisterAllEvents()
end