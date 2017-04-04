assert(Automaton, "Automaton not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("Automaton_Loner")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
    ["Loner"] = true,
	["Decline all incoming guild requests and petitions."] = true,
	["Canceling guild invite..."] = true,
	["Canceling petition..."] = true,
} end)

L:RegisterTranslations("ruRU", function() return {
    ["Loner"] = "Одиночка",
	["Decline all incoming guild requests and petitions."] = "Отмена всех входящих петиций и приглашений в гильдию.",
	["Canceling guild invite..."] = "Отмена приглашения в гильдию...",
} end)

L:RegisterTranslations("koKR", function() return {
    ["Loner"] = "길드 초대",
	["Decline all incoming guild requests and petitions."] = "모든 길드 초대 요구를 거절합니다.",
	["Canceling guild invite..."] = "길드 초대 거절...",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

Automaton_Loner = Automaton:NewModule("Loner")
Automaton_Loner.modulename = L["Loner"]
Automaton_Loner.moduledesc = L["Decline all incoming guild requests and petitions."]
Automaton_Loner.options = {}

------------------------------
--      Initialization      --
------------------------------

function Automaton_Loner:OnInitialize()
    self.db = Automaton:AcquireDBNamespace("Loner")
	Automaton:RegisterDefaults("Loner", "profile", {
		disabled = true,
	})
	Automaton:SetDisabledAsDefault(self, "Loner")

	self:RegisterOptions(self.options)
end

function Automaton_Loner:OnEnable()
	self:RegisterEvent("GUILD_INVITE_REQUEST")
	self:RegisterEvent("PETITION_SHOW")
end

function Automaton_Loner:OnDisable()
	self:UnregisterAllEvents()
end

------------------------------
--      Event Handlers      --
------------------------------

function Automaton_Loner:GUILD_INVITE_REQUEST()
	self:Print(L["Canceling guild invite..."])
	DeclineGuild()
	StaticPopup_Hide("GUILD_INVITE")
end

function Automaton_Loner:PETITION_SHOW()
	self:Print(L["Canceling petition..."])
	ClosePetition()
end