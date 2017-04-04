assert(Automaton, "Automaton not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("Automaton_Rez")
local abacus = AceLibrary("Abacus-2.0")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
    ["Rez"] = true,
	["Options for accepting resurrection requests."] = true,
    ["Persist"] = true,
	["With this option enabled, AutoRez will persist for every resurrection request."] = true,
	["Delay"] = true,
	["With this option enabled, automatic resurrection accept is delayed."] = true,
	["Delay Time"] = true,
	["Set the time, in seconds, to wait before automatically accepting resurrections."] = true,
	["Ignore Battle Resurrections"] = true,
	["With this option enabled, resurrections from druids will not be automatically accepted."] = true,
	["%s is a druid! Not auto-accepting this resurrection."] = true,
	["Accepting resurrect in %s..."] = true,
} end)

L:RegisterTranslations("ruRU", function() return {
    ["Rez"] = "Воскрешение",
	["Options for accepting resurrection requests."] = "Настройки принятия запроса воскрешения.",
	["Persist"] = "Оставаться",
	["With this option enabled, AutoRez will persist for every resurrection request."] = "Если эта опция включена, аддон будет отклонять каждый запрос воскрешения.",
	["Delay"] = "Задержка",
	["With this option enabled, automatic resurrection accept is delayed."] = "Когда эта опция включена, автоматическое воскрешение будет задержано.",
	["Delay Time"] = "Время задержки",
	["Set the time, in seconds, to wait before automatically accepting resurrections."] = "Установка времени, в секундах, для ожидания перед автоматическим принятием воскрешения.",
	["Ignore Battle Resurrections"] = "Игнорировать воскрешения в бою",
	["With this option enabled, resurrections from druids will not be automatically accepted."] = "Если эта опция включена, воскрешения от друидов не будут автоматически приняты.",
	["%s is a druid! Not auto-accepting this resurrection."] = "%s это друид! Не принимать автоматически это воскрешение.",
	["Accepting resurrect in %s..."] = "Принятие воскрешения через %s...",
} end)

L:RegisterTranslations("koKR", function() return {
    ["Rez"] = "부활",
	["Options for accepting resurrection requests."] = "부활에 관한 옵션을 설정합니다.",
	["Persist"] = "지속",
	["With this option enabled, AutoRez will persist for every resurrection request."] = "이 옵션이 활성화시, 모든 부활 요구가 지속됩니다.",
	["Delay"] = "지연",
	["With this option enabled, automatic resurrection accept is delayed."] = "이 옵션 사용시, 자동 부활 수락을 동안 지연시킵니다.",
	["Delay Time"] = "지연 시간",
	["Set the time, in seconds, to wait before automatically accepting resurrections."] = "자동 부활을 수락할 시간을 설정합니다.",
	["Ignore Battle Resurrections"] = "전투 부활 무시",
	["With this option enabled, resurrections from druids will not be automatically accepted."] = "이 옵션 사용시, 드루이드의 부활을 자동으로 수락하지 않습니다.",
	["%s is a druid! Not auto-accepting this resurrection."] = "%s is a druid! Not auto-accepting this resurrection.",
	["Accepting resurrect in %s..."] = "부활 수락 %s",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

Automaton_Rez = Automaton:NewModule("Rez")
Automaton_Rez.modulename = L["Rez"]
Automaton_Rez.moduledesc = L["Options for accepting resurrection requests."]
Automaton_Rez.options = {
	persist = {
		type = "toggle", name = L["Persist"], desc = L["With this option enabled, AutoRez will persist for every resurrection request."],
		get = function() return Automaton_Rez.db.profile.persist end,
		set = function(v) Automaton_Rez.db.profile.persist = v end,
	},
	delay = {
		type = "toggle", name = L["Delay"], desc = L["With this option enabled, automatic resurrection accept is delayed."],
		get = function() return Automaton_Rez.db.profile.delay end,
		set = function(v) Automaton_Rez.db.profile.delay = v end,
	},
	delayTime = {
		type = "range", name = L["Delay Time"], desc = L["Set the time, in seconds, to wait before automatically accepting resurrections."],
		get = function() return Automaton_Rez.db.profile.delayTime end,
		set = function(v) Automaton_Rez.db.profile.delayTime = v end,
		min = 5,
		max = 100,
		step = 1,
		bigStep = 5,
	},
	ignoreBattleRes = {
		type = "toggle", name = L["Ignore Battle Resurrections"], desc = L["With this option enabled, resurrections from druids will not be automatically accepted."],
		get = function() return Automaton_Rez.db.profile.ignoreBattleRes end,
		set = function(v) Automaton_Rez.db.profile.ignoreBattleRes = v end,
	}
}

------------------------------
--      Initialization      --
------------------------------

function Automaton_Rez:OnInitialize()
	self.db = Automaton:AcquireDBNamespace("Rez")
	Automaton:RegisterDefaults("Rez", "profile", {
		disabled = true,
		persist = false,
		delay = false,
		delayTime = 100,
		ignoreBattleRes = true,
	})
	Automaton:SetDisabledAsDefault(self, "Rez")
	
	self:RegisterOptions(self.options)
end

function Automaton_Rez:OnEnable()
	self:RegisterEvent("RESURRECT_REQUEST")
	
	StaticPopupDialogs["RESURRECT_NO_SICKNESS"].OnCancel = function()
		if Automaton_Rez:IsEventScheduled("Automaton_Rez") then
			Automaton_Rez:CancelScheduledEvent("Automaton_Rez")
		end
		DeclineResurrect()
		if UnitIsDead("player") then
			StaticPopup_Show("DEATH")
		end
	end
end

function Automaton_Rez:OnDisable()
	self:UnregisterAllEvents()
	
	StaticPopupDialogs["RESURRECT_NO_SICKNESS"].OnCancel = function()
		DeclineResurrect()
		if UnitIsDead("player") then
			StaticPopup_Show("DEATH")
		end
	end
end

------------------------------
--      Event Handlers      --
------------------------------

local n, class, seconds
function Automaton_Rez:RESURRECT_REQUEST(source)
	if Automaton_Rez.db.profile.ignoreBattleRes then
		n = GetNumRaidMembers()
		if n > 0 then
			for i = 1, n do
				if UnitName("raid"..i) == source then
					_, class = UnitClass("raid"..i)
					if class == "DRUID" and UnitAffectingCombat("raid"..i) then
						self:Print(L["%s is a druid! Not auto-accepting this resurrection."]:format(source))
						return
					end
					break
				end
			end
		else
			n = GetNumPartyMembers()
			if n > 0 then
				for i = 1, n do
					if UnitName("party"..i) == source then
						_, class = UnitClass("party"..i)
						if class == "DRUID" and UnitAffectingCombat("party"..i) then
							self:Print(L["%s is a druid! Not auto-accepting this resurrection."]:format(source))
							return
						end
						break
					end
				end
			end
		end
	end
	
	if Automaton_Rez.db.profile.delay and not self:IsEventScheduled("Automaton_Rez") then
		seconds = Automaton_Rez.db.profile.delayTime
		self:Print(L["Accepting resurrect in %s..."]:format(abacus:FormatDurationExtended(seconds):lower()))
		self:ScheduleEvent("Automaton_Rez", function()
			AcceptResurrect()
			StaticPopup_Hide("RESURRECT_NO_SICKNESS")
		end, seconds)
	elseif not self:IsEventScheduled("Automaton_Rez") then
		AcceptResurrect()
		StaticPopup_Hide("RESURRECT_NO_SICKNESS")
	end
	
	if not Automaton_Rez.db.profile.persist then
		Automaton:ToggleModuleActive("Rez",false)
	end
end