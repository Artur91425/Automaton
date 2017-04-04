assert(Automaton, "Automaton not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("Automaton_Queue")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
    ["Queue"] = true,
	["Options for accepting Battleground queues."] = true,
    ["Delay"] = true,
	["With this option enabled, automatic battleground entry is delayed for 100 seconds."] = true,
	["Join"] = true,
	["Joins battleground queues when the battlefield window is displayed."] = true,
	["Joining %s in 1:00..."] = true,
	["Joining %s..."] = true,
} end)

L:RegisterTranslations("ruRU", function() return {
    ["Queue"] = "Очередь",
	["Options for accepting Battleground queues."] = "Настройки для принятия очереди поля боя.",
    ["Delay"] = "Задержка",
	["With this option enabled, automatic battleground entry is delayed for 100 seconds."] = "Если эта опция включена, автоматический вход на поле боя задерживается на 100 секунд.",
	["Join"] = "Присоединение",
	["Joins battleground queues when the battlefield window is displayed."] = "Присоединение к очереди поля боя, когда его окно открыто.",
	["Joining %s in 1:00..."] = "Присоединение %s через 1:00...",
	["Joining %s..."] = "Присоединение %s...",
} end)

L:RegisterTranslations("koKR", function() return {
    ["Queue"] = "전장 대기",
	["Options for accepting Battleground queues."] = "전장 대기 옵션을 설정합니다.",
    ["Delay"] = "지연",
	["With this option enabled, automatic battleground entry is delayed for 100 seconds."] = "이 옵션이 활성화시, 전장 입장을 1분 40초동안 지연시킵니다.",  
	["Join"] = "참가",
	["Joins battleground queues when the battlefield window is displayed."] = "전장 신청 창이 열리면 전장 대기열에 자동 참가합니다.",
	["Joining %s in 1:00..."] = "1:00 초 동안 %s 입장 지연...",
	["Joining %s..."] = "%s 입장 지연...",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

Automaton_Queue = Automaton:NewModule("Queue")
Automaton_Queue.modulename = L["Queue"]
Automaton_Queue.moduledesc = L["Options for accepting Battleground queues."]
Automaton_Queue.options = {
	delay = {
		type = 'toggle', name = L["Delay"], desc = L["With this option enabled, automatic battleground entry is delayed for 100 seconds."],
		get = function() return Automaton_Queue.db.profile.delay end,
		set = function(v) Automaton_Queue.db.profile.delay = v end,
	},
	join = {
		type = 'toggle', name = L["Join"], desc = L["Joins battleground queues when the battlefield window is displayed."],
		get = function() return Automaton_Queue:IsEventRegistered("BATTLEFIELDS_SHOW") end,
		set = function(v)
			if v then
				Automaton_Queue:RegisterEvent("BATTLEFIELDS_SHOW")
			else
				Automaton_Queue:UnregisterEvent("BATTLEFIELDS_SHOW")
			end
			Automaton_Queue.db.profile.join = v
		end
	}
}

------------------------------
--      Initialization      --
------------------------------

function Automaton_Queue:OnInitialize()
	self.db = Automaton:AcquireDBNamespace("Queue")
	Automaton:RegisterDefaults("Queue", "profile", {
		disabled = true,
		join = true,
		delay = true,
	})
	Automaton:SetDisabledAsDefault(self, "Queue")
	
	self:RegisterOptions(self.options)
end

function Automaton_Queue:OnEnable()
	if Automaton_Queue.db.profile.join then
		Automaton_Queue:RegisterEvent("BATTLEFIELDS_SHOW")
	end
	self:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")
end

function Automaton_Queue:OnDisable()
	self:UnregisterAllEvents()
end

------------------------------
--      Event Handlers      --
------------------------------

function Automaton_Queue:UPDATE_BATTLEFIELD_STATUS()
	local active, confirm, map
	for i=1, MAX_BATTLEFIELD_QUEUES do
		local status, mapName, instanceID = GetBattlefieldStatus(i)
		if status == "active" then
			active = true
		elseif status == "confirm" then
			confirm = i
			map = mapName .. " " .. instanceID
		end
	end
	
	if not confirm then return end
	
	if Automaton_Queue.db.profile.delay or active then
		self:Print(L["Joining %s in 1:00..."], map)
		self:ScheduleEvent("Automaton_Queue" .. confirm, AcceptBattlefieldPort, 60, confirm, 1)
	elseif not self:IsEventScheduled("Automaton_Queue" .. confirm) then
		self:Print(L["Joining %s..."], map)
		AcceptBattlefieldPort(confirm, 1)
	end
end

function Automaton_Queue:BATTLEFIELDS_SHOW()
	if IsShiftKeyDown() then return end
	if IsPartyLeader() or IsRaidLeader() then
		JoinBattlefield(0, 1)
	else
		JoinBattlefield(0)
	end
	HideUIPanel(BattlefieldFrame)
end