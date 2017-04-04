assert(Automaton, "Automaton not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("Automaton_Group")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
    ["Group"] = true,
	["Options for accepting or declining group invites."] = true,
    ["Who"] = true,
    ["Perform a /who on incoming party invites from unknown sources."] = true,
    ["Decline"] = true,
    ["Decline party invites from unknown sources."] = true,
	["Delay"] = true,
	["With this option enabled, automatic joining or declining is delayed for 55 seconds."] = true,
    ["Declining party invitation..."] = true,
	["Accepting invite in 55..."] = true,
	["Declining invite in 55..."] = true,
} end)

L:RegisterTranslations("ruRU", function() return {
    ["Group"] = "Группа",
	["Options for accepting or declining group invites."] = "Настройки для принятия или отказа приглашений в группу.",
    ["Who"] = "Кто",
    ["Perform a /who on incoming party invites from unknown sources."] = "Выполнить /кто на входящие приглашения в группу от неизвестных источников.",
    ["Decline"] = "Отказать",
    ["Decline party invites from unknown sources."] = "Отказ приглашения в группу от неизвестных источников.",
	["Delay"] = "Задержка",
	["With this option enabled, automatic joining or declining is delayed for 55 seconds."] = "Когда эта опция включена, автоматическое принятие или отказ приглашений будет задержан на 55 секунд.",
    ["Declining party invitation..."] = "Отказ приглашения в группу...",    
	["Accepting invite in 55..."] = "Принятие приглашения через 55 секунд...",
	["Declining invite in 55..."] = "Отказ приглашения через 55 секунд...",
} end)

L:RegisterTranslations("koKR", function() return {
    ["Group"] = "그룹 초대",
	["Options for accepting or declining group invites."] = "그룹 초대에 관한 옵션을 설정합니다.",
    ["Who"] = "누구",
    ["Perform a /who on incoming party invites from unknown sources."] = "알수없는 파티 초대가 들어올때 '/누구'를 실행합니다.",
    ["Decline"] = "거절",
    ["Decline party invites from unknown sources."] = "알수없는 파티 초대시 거절합니다.",
	["Delay"] = "지연",
	["With this option enabled, automatic joining or declining is delayed for 55 seconds."] = true,
    ["Declining party invitation..."] = "파티 초대 거절...",   
	["Accepting invite in 55..."] = "초대 수락 55...",
	["Declining invite in 55..."] = "초대 거절 55...",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

Automaton_Group = Automaton:NewModule("Group")
Automaton_Group.modulename = L["Group"]
Automaton_Group.moduledesc = L["Options for accepting or declining group invites."]
Automaton_Group.options = {
	who = {
		type = 'toggle', name = L["Who"], desc = L["Perform a /who on incoming party invites from unknown sources."],
		get = function() return Automaton_Group.db.profile.who end,
		set = function(v) Automaton_Group.db.profile.who = v end,
	},
	decline = {
		type = 'toggle', name = L["Decline"], desc = L["Decline party invites from unknown sources."],
		get = function() return Automaton_Group.db.profile.decline end,
		set = function(v) Automaton_Group.db.profile.decline = v end,
	},
	delay = {
		type = 'toggle', name = L["Delay"], desc = L["With this option enabled, automatic joining or declining is delayed for 55 seconds."],
		get = function() return Automaton_Group.db.profile.delay end,
		set = function(v) Automaton_Group.db.profile.delay = v end,
	}
}

------------------------------
--      Initialization      --
------------------------------

function Automaton_Group:OnInitialize()
	self.db = Automaton:AcquireDBNamespace("Group")
	Automaton:RegisterDefaults("Group", "profile", {
		who = true,
		decline = false,
		delay = false,
		disabled = true,
	})
	Automaton:SetDisabledAsDefault(self, "Group")

	self:RegisterOptions(self.options)
end

function Automaton_Group:OnEnable()
	self:RegisterEvent("PARTY_INVITE_REQUEST")
end

function Automaton_Group:OnDisable()
	self:UnregisterAllEvents()
end

------------------------------
--      Event Handlers      --
------------------------------

function Automaton_Group:ProcessInvite(accept)
	if accept then
		self:Debug("Accepting an invite")
		AcceptGroup()
		self:RegisterEvent("PARTY_MEMBERS_CHANGED")
	else
		self:Print(L["Declining party invitation..."])
		DeclineGroup()
	end
end

function Automaton_Group:PARTY_MEMBERS_CHANGED()
	StaticPopup_Hide("PARTY_INVITE")
	self:Debug("Trying to close the window")
	self:UnregisterEvent("PARTY_MEMBERS_CHANGED")	
end

function Automaton_Group:PARTY_INVITE_REQUEST(from)
	self:Debug("Processing invite...")
	--local from = arg1
	local acceptFrom = {}
	GuildRoster()
	
	for i=1,GetNumGuildMembers() do
		local name = GetGuildRosterInfo(i)
		tinsert(acceptFrom,name)
	end
	
	for i=1,GetNumFriends() do
		local name = GetFriendInfo(i)
		tinsert(acceptFrom,name)
	end
	
	if foreachi(acceptFrom, function(i,v) if v==from then return true end end) then
		if self.db.profile.delay then
			self:Print(L["Accepting invite in 55..."])
			self:ScheduleEvent("Automaton_GroupAccept", self.ProcessInvite, 55, self, true)
		else
			self:ProcessInvite(true)
		end
		return
	end
	
	if self.db.profile.decline then
		if self.db.profile.delay then
			self:Print(L["Declining invite in 55..."])
			self:ScheduleEvent("Automaton_GroupDecline", self.ProcessInvite, 55, self, false)
		else
			self:ProcessInvite(false)
		end
	elseif self.db.profile.who then
		SendWho("n-\""..from.."\"")
	end
end