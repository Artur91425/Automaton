assert(Automaton, "Automaton not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("Automaton_Summon")
local seconds

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["Summon"] = true,
	["Options for accepting summons."] = true,
	["Delay"] = true,
	["With this option enabled, automatic summons are delayed."] = true,
	["Delay Time"] = true,
	["Set the time in seconds to delay automatic summon acceptance."] = true,
	["Combat Delay"] = true,
	["If summoned while in combat, accept the summon after combat ends."] = true,
	["Combat Delay Time"] = true,
	["Set the time in seconds to delay automatic summon acceptance after combat ends."] = true,
	["Be Quiet!"] = true,
	["Suppress chat frame output from the Summon module."] = true,
	["Cancelling summon..."] = true,
	["In combat! Accepting summon after combat ends..."] = true,
	["Left combat. Accepting summon in %s..."] = true,
	["Summon expired!"] = true,
	["Accepting summon in %s..."] = true,
	["Accepting summon..."] = true,
} end)

L:RegisterTranslations("ruRU", function() return {
	["Summon"] = "Призыв",
	["Options for accepting summons."] = "Настройки принятия призывов",
	["Delay"] = "Задержка",
	["With this option enabled, automatic summons are delayed."] = "Если эта опция включена, автоматический призыв задержится.",
	["Delay Time"] = "Время задержки",
	["Set the time in seconds to delay automatic summon acceptance."] = "Установите время в секундах, чтобы задержать автоматическое принятие призыва.",
	["Combat Delay"] = "Задержка боя",
	["If summoned while in combat, accept the summon after combat ends."] = "Если призыв во время боя, принятие после выхода из него.",
	["Combat Delay Time"] = "Время задержки после боя",
	["Set the time in seconds to delay automatic summon acceptance after combat ends."] = "Установите время в секундах, чтобы задержать автоматическое принятие призыва после окончания боя.",
	["Be Quiet!"] = "Будь спокоен!",
	["Suppress chat frame output from the Summon module."] = "Подавить сообщения от модуля призыва.",
	["Cancelling summon..."] = "Отмена призыва...",
	["In combat! Accepting summon after combat ends..."] = "В бою! Принятие призыва после окончания боя...",
	["Left combat. Accepting summon in %s..."] = "Выход из боя. Принятие призыва через %s...",
	["Summon expired!"] = "Призыв закончен!",
	["Accepting summon in %s..."] = "Принятие призыва через %s...",
	["Accepting summon..."] = "Принятие призыва...",
} end)

L:RegisterTranslations("koKR", function() return {
	["Summon"] = "Summon",
	["Options for accepting summons."] = "소환에 관한 옵션을 설정합니다",
	["Delay"] = "지연",
	["With this option enabled, automatic summons are delayed."] = "이 옵션이 활성화시, 자동 소환을 100초 동안 지연시킵니다.",
	["Delay Time"] = "지연 시간",
	["Set the time in seconds to delay automatic summon acceptance."] = "자동 소환을 수락할 시간을 설정합니다",
	["Combat Delay"] = "전투 지연",
	["If summoned while in combat, accept the summon after combat ends."] = "전투 종료후 소환을 받아드립니다.",
	["Combat Delay Time"] = "전투 지연 시간",
	["Set the time in seconds to delay automatic summon acceptance after combat ends."] = "전투 종료 후 자동 소환을 수락할 시간을 설정합니다.",
	["Be Quiet!"] = "알림 해제!",
	["Suppress chat frame output from the Summon module."] = "소환 모듈의 대화창 출력을 사용하지 않습니다.",
	["Cancelling summon..."] = "소환 취소...",
	["In combat! Accepting summon after combat ends..."] = "전투 중입니다! 전투 종료 후 소환을 수락합니다...",
	["Left combat. Accepting summon in %s..."] = "전투가 종료되었습니다. %s님의 소환을 수락합니다...",
	["Summon expired!"] = "소환 종료!",
	["Accepting summon in %s..."] = "%s님의 소환 수락...",
	["Accepting summon..."] = "소환 수락...",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

Automaton_Summon = Automaton:NewModule("Summon")
Automaton_Summon.modulename = L["Summon"]
Automaton_Summon.moduledesc = L["Options for accepting summons."]
Automaton_Summon.options = {
	delay = {
		type = "toggle", name = L["Delay"], desc = L["With this option enabled, automatic summons are delayed."],
		get = function() return Automaton_Summon.db.profile.delay end,
		set = function(v) Automaton_Summon.db.profile.delay = v end,
	},
	delayTime = {
		type = "range", name = L["Delay Time"], desc = L["Set the time in seconds to delay automatic summon acceptance."],
		get = function() return Automaton_Summon.db.profile.delayTime end,
		set = function(v) Automaton_Summon.db.profile.delayTime = v end,
		min = 5,
		max = 100,
		step = 1,
		bigStep = 5,
	},
	combatDelay = {
		type = "toggle", name = L["Combat Delay"], desc = L["If summoned while in combat, accept the summon after combat ends."],
		get = function() return Automaton_Summon.db.profile.combatDelay end,
		set = function(v) Automaton_Summon.db.profile.combatDelay = v end,
	},
	combatDelayTime = {
		type = "range", name = L["Combat Delay Time"], desc = L["Set the time in seconds to delay automatic summon acceptance after combat ends."],
		get = function() return Automaton_Summon.db.profile.combatDelayTime end,
		set = function(v) Automaton_Summon.db.profile.combatDelayTime = v end,
		min = 5,
		max = 30,
		step = 1,
		bigStep = 5,
	},
	quiet = {
		type = "toggle", name = L["Be Quiet!"], desc = L["Suppress chat frame output from the Summon module."],
		get = function() return Automaton_Summon.db.profile.quiet end,
		set = function(v) Automaton_Summon.db.profile.quiet = v end,
	}
}

------------------------------
--      Initialization      --
------------------------------

function Automaton_Summon:OnInitialize()
	self.db = Automaton:AcquireDBNamespace("Summon")
	Automaton:RegisterDefaults("Summon", "profile", {
		disabled = true,
		delay = true,
		delayTime = 100,
		combatDelay = true,
		combatDelayTime = 10,
		quiet = false,
	})
	Automaton:SetDisabledAsDefault(self, "Summon")
	
	self:RegisterOptions(self.options)
end

function Automaton_Summon:OnEnable()
	self:RegisterEvent("CONFIRM_SUMMON")
	
	StaticPopupDialogs["CONFIRM_SUMMON"].OnHide = function()
		if Automaton_Summon:IsEventScheduled("Automaton_SummonAccept") then
			Automaton_Summon:CancelScheduledEvent("Automaton_SummonAccept")
			Automaton_Summon:Print(L["Cancelling summon..."])
		end
		if Automaton_Summon:IsEventScheduled("Automaton_SummonTimeout") then
			Automaton_Summon:CancelScheduledEvent("Automaton_SummonTimeout")
		end
	end
end

function Automaton_Summon:OnDisable()
	self:UnregisterAllEvents()
	
	StaticPopupDialogs["CONFIRM_SUMMON"].OnHide = nil
end

------------------------------
--      Event Handlers      --
------------------------------

function Automaton_Summon:Spam(text)
	if not Automaton_Summon.db.profile.quiet then
		self:Print(text)
	end
end

function Automaton_Summon:Confirm()
	if UnitAffectingCombat("player") then
		self:Spam(L["In combat! Accepting summon after combat ends..."])
		self:RegisterEvent("PLAYER_REGEN_ENABLED", "LeaveCombat")
		self:ScheduleEvent("Automaton_SummonTimeout", self.Timeout, GetSummonConfirmTimeLeft(), self)
		return
	end
	if self:IsEventScheduled("Automaton_SummonTimeout") then
		self:CancelScheduledEvent("Automaton_SummonTimeout")
	end
	ConfirmSummon()
	StaticPopup_Hide("CONFIRM_SUMMON")
end

function Automaton_Summon:LeaveCombat()
	seconds = Automaton_Summon.db.profile.combatDelayTime
	self:Spam(L["Left combat. Accepting summon in %s..."]:format(abacus:FormatDurationExtended(seconds):lower()))
	self:ScheduleEvent("Automaton_SummonAccept", self.Confirm, seconds, self)
	if self:IsEventRegistered("PLAYER_REGEN_ENABLED") then
		self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	end
end

function Automaton_Summon:Timeout()
	self:Spam(L["Summon expired!"])
	if self:IsEventScheduled("Automaton_SummonAccept") then
		self:CancelScheduledEvent("Automaton_SummonAccept")
	end
	if self:IsEventRegistered("PLAYER_REGEN_ENABLED") then
		self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	end
end

function Automaton_Summon:CONFIRM_SUMMON()
	if Automaton_Summon.db.profile.delay and not self:IsEventScheduled("Automaton_SummonAccept") then
		seconds = Automaton_Summon.db.profile.delayTime
		self:Spam(L["Accepting summon in %s..."]:format(abacus:FormatDurationExtended(seconds):lower()))
		self:ScheduleEvent("Automaton_SummonAccept", self.Confirm, seconds, self)
	elseif not self:IsEventScheduled("Automaton_SummonAccept") then
		self:Spam(L["Accepting summon..."])
		self:Confirm()
	end
end