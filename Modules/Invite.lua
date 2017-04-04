assert(Automaton, "Automaton not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("Automaton_Invite")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["Invite"] = true,
	["Options for sending out party invites."] = true,
	["Invite text"] = true,
	["The text users send to trigger an invite."] = true,
	["keyword invite"] = true,
	["Ignore case"] = true,
	["Disable case sensitivity for the invite text"] = true,
	["Accept from"] = true,
	["Accept invites from these people"] = true,
	["Friends"] = true,
	["Allow invite requests from players on your friends list"] = true,
	["Guildmates"] = true,
	["Allow invite requests from guildmates"] = true,
	["Custom list"] = true,
	["Specify a custom list to accept from"] = true,
	["List"] = true,
	["Print all names in the custom list."] = true,
	["Add Player"] = true,
	["Add a player to the custom list."] = true,
	["<player name>"] = true,
	["Remove Player"] = true,
	["Removes a player from the custom list."] = true,
	["Purge"] = true,
	["Remove all names from the custom list."] = true,
	["Everyone"] = true,
	["Allow invite requests from everyone"] = true,
} end)

L:RegisterTranslations("ruRU", function() return {
	["Invite"] = "Приглашение",
	["Options for sending out party invites."] = "Настройки для отправки приглашения в группу.",
	["Invite text"] = "Текст приглашения",
	["The text users send to trigger an invite."] = "Текст, который пользователи отправляют, чтобы инициировать приглашение.",
	["keyword invite"] = "ключевое слово приглашения",
	["Ignore case"] = "Игнорировать регистр",
	["Disable case sensitivity for the invite text"] = "Отключить чувствительность к регистру текста приглашения",
	["Accept from"] = "Принять от",
	["Accept invites from these people"] = "Принять приглашения от этих людей",
	["Friends"] = "Друзья",
	["Allow invite requests from players on your friends list"] = "Разрешить приглашать игроков из вашего списка друзей",
	["Guildmates"] = "Члены гильдии",
	["Allow invite requests from guildmates"] = "Разрешить приглашения от участников гильдии",
	["Custom list"] = "Пользовательский список",
	["Specify a custom list to accept from"] = "Укажите пользовательский список, чтобы принять приглашения от",
	["List"] = "Список",
	["Print all names in the custom list."] = "Печатать всех имен в пользовательском списке.",
	["Add Player"] = "Добавить игрока",
	["Add a player to the custom list."] = "Добавление игрока в пользовательский список.",
	["<player name>"] = "<имя игрока>",
	["Remove Player"] = "Удалить игрока",
	["Removes a player from the custom list."] = "Удаляет игрока из пользовательского листа.",
	["Purge"] = "Очистка",
	["Remove all names from the custom list."] = "Удалить все имена из пользовательского листа.",
	["Everyone"] = "Все",
	["Allow invite requests from everyone"] = "Разрешить приглашения от всех",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

Automaton_Invite = Automaton:NewModule("Invite")
Automaton_Invite.modulename = L["Invite"]
Automaton_Invite.moduledesc = L["Options for sending out party invites."]
Automaton_Invite.options = {
	keyword = {
		type = "text", name = L["Invite text"], desc = L["The text users send to trigger an invite."],
		order = 3, usage = L["keyword invite"],
		get = function() return Automaton_Invite.db.profile.inviteString end,
		set = function(v) Automaton_Invite.db.profile.inviteString = v end,
	},
	case = {
		type = "toggle", name = L["Ignore case"], desc = L["Disable case sensitivity for the invite text"],
		order = 2,
		get = function() return Automaton_Invite.db.profile.ignoreCase end,
		set = function(v) Automaton_Invite.db.profile.ignoreCase = v end,
	},
	accept = {
		type  = "group", name = L["Accept from"], desc = L["Accept invites from these people"],
		order = 4,
		args  = {
			friends = {
				type = "toggle", name = L["Friends"], desc = L["Allow invite requests from players on your friends list"],
				order = 2,
				get = function() return Automaton_Invite.db.profile.friends end,
				set = function(v) Automaton_Invite.db.profile.friends = v end,
				disabled = function() if Automaton_Invite.db.profile.anyone then return true end end,
			},
			guild = {
				type = "toggle", name = L["Guildmates"], desc = L["Allow invite requests from guildmates"],
				order = 3,
				get = function() return Automaton_Invite.db.profile.guild end,
				set = function(v) Automaton_Invite.db.profile.guild = v end,
				disabled = function() if Automaton_Invite.db.profile.anyone then return true end end,
			},
			custom = {
				type = "group", name = L["Custom list"], desc = L["Specify a custom list to accept from"],
				order = 20,
				disabled = function() if Automaton_Invite.db.profile.anyone then return true end end,
				args = {
					list = {
						type = "execute", name = L["List"], desc = L["Print all names in the custom list."],
						func = function() Automaton_Invite:ListCustom() end
					},
					add = {
						type  = "text", name = L["Add Player"], desc = L["Add a player to the custom list."],
						order = 1, usage = L["<player name>"],
						get   = false,
						set   = function(v) Automaton_Invite:AddCustomName(v) end,
					},
					remove = {
						type  = "text", name = L["Remove Player"], desc = L["Removes a player from the custom list."],
						order = 2, usage = L["<player name>"],
						get   = false,
						set   = function(v) Automaton_Invite:RemoveCustomName(v) end,
					},
					purge = {
						type = "execute", name = L["Purge"], desc = L["Remove all names from the custom list."],
						func = function() Automaton_Invite:PurgeCustomList() end
					}
				}
			},
			anyone = {
				type = "toggle", name = L["Everyone"], desc = L["Allow invite requests from everyone"],
				order = 1,
				get = function() return Automaton_Invite.db.profile.anyone end,
				set = function(v)
					Automaton_Invite.db.profile.anyone = v
					Automaton_Invite.options.accept.args.friends.disabled = v
					Automaton_Invite.options.accept.args.guild.disabled = v
					Automaton_Invite.options.accept.args.custom.disabled = v
				end,
			}
		}
	}
}

------------------------------
--      Initialization      --
------------------------------

function Automaton_Invite:OnInitialize()
	self.db = Automaton:AcquireDBNamespace("Invite")
	Automaton:RegisterDefaults("Invite", "profile", {
		disabled = true,
		inviteString = "invite",
		ignoreCase = true,
		friends = true,
		guild = true,
		custom = {}
	})
	Automaton:SetDisabledAsDefault(self, "Invite")
	
	self:RegisterOptions(self.options)
end

function Automaton_Invite:OnEnable()
	self:RegisterEvent("CHAT_MSG_WHISPER")
end

function Automaton_Invite:OnDisable()
	self:UnregisterAllEvents()
end

------------------------------
--      Event Handlers      --
------------------------------

function Automaton_Invite:CHAT_MSG_WHISPER(text,from)
	local keyword,msg
	local player = from
	local keyword = Automaton_Invite.db.profile.inviteString
	local msg = text
	if Automaton_Invite.db.profile.ignoreCase then
		keyword = string.lower(keyword)
		msg = string.lower(msg)
	end
	if string.find(msg,format("^%s$",keyword)) then
		if not self.db.profile.anyone then
			local acceptFrom = {}		
			if self.db.profile.guild then
				GuildRoster()
				for i=1,GetNumGuildMembers() do
					local name = GetGuildRosterInfo(i)
					tinsert(acceptFrom,name)
				end
			end
			if self.db.profile.friends then
				for i=1,GetNumFriends() do
					local name = GetFriendInfo(i)
					tinsert(acceptFrom,name)
				end
			end
			if not (table.getn{self.db.profile.custom} == 0) then
				for k,v in pairs(self.db.profile.custom) do
					tinsert(acceptFrom,v)
				end
			end
			
			if foreachi(acceptFrom, function(i,v) if v==player then return true end end) then
				InviteByName(player)
			end
			else
			InviteByName(player)
		end
	end
end

function Automaton_Invite:AddCustomName(name)
	tinsert(self.db.profile.custom,string.lower(name))
end

function Automaton_Invite:RemoveCustomName(name)
	for k,v in pairs(self.db.profile.custom) do
		if v == string.lower(name) then
			self.db.profile.custom[k] = nil
		end
	end
end

function Automaton_Invite:ListCustom()
	if table.getn{self.db.profile.custom} == 0 then
		self:Print("No players in custom list.")
	else
		self:Print("Accepting invites from these players:")
		for k,v in pairs(self.db.profile.custom) do
			self:Print(v)
		end
	end
end

function Automaton_Invite:PurgeCustomList()
	self:Print(table.getn{self.db.profile.custom} .. " names purged.")
	self.db.profile.custom = {}
end