assert(Automaton, "Automaton not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("Automaton_Dismount")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
    ["Dismount"] = true,	
	["Automatically dismount, cancel forms druid, shaman, priest, when you receive the appropriate error"] = true,
} end)

L:RegisterTranslations("ruRU", function() return {
    ["Dismount"] = "Спешивание",
	["Automatically dismount, cancel forms druid, shaman, priest, when you receive the appropriate error"] = "Автоматическое спешивание, отмена форм друида шамана жреца, когда вы получаете соответствующую ошибку",
} end)

L:RegisterTranslations("koKR", function() return {
    ["Dismount"] = "탈것 내림",
	["Automatically dismount, cancel forms druid, shaman, priest, when you receive the appropriate error"] = "'탈것에서 내려야합니다' 오류시 자동으로 탈것에서 내립니다.",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

Automaton_Dismount = Automaton:NewModule("Dismount")
Automaton_Dismount.modulename = L["Dismount"]
Automaton_Dismount.moduledesc = L["Automatically dismount, cancel forms druid, shaman, priest, when you receive the appropriate error"]
Automaton_Dismount.options = {}

------------------------------
--      Initialization      --
------------------------------

function Automaton_Dismount:OnInitialize()
	self:RegisterOptions(self.options)
end

function Automaton_Dismount:OnEnable()
	self:RegisterEvent("UI_ERROR_MESSAGE")
	self:RegisterEvent("TAXIMAP_OPENED")
end

function Automaton_Dismount:OnDisable()
	self:UnregisterAllEvents()
end

------------------------------
--      Event Handlers      --
------------------------------

BuffsList = { 
	"spell_nature_swiftness", "_mount_", "_qirajicrystal_",
	"ability_racial_bearform", "ability_druid_catform", "ability_druid_travelform",
	"spell_nature_forceofnature", "ability_druid_aquaticform", "spell_nature_spiritwolf" 
}

ErrorsList = { 
	SPELL_FAILED_NOT_MOUNTED, ERR_ATTACK_MOUNTED, ERR_TAXIPLAYERALREADYMOUNTED,
	SPELL_FAILED_NOT_SHAPESHIFT, SPELL_FAILED_NO_ITEMS_WHILE_SHAPESHIFTED, SPELL_NOT_SHAPESHIFTED,
	SPELL_NOT_SHAPESHIFTED_NOSPACE, ERR_CANT_INTERACT_SHAPESHIFTED, ERR_NOT_WHILE_SHAPESHIFTED,
	ERR_NO_ITEMS_WHILE_SHAPESHIFTED, ERR_TAXIPLAYERSHAPESHIFTED,ERR_MOUNT_SHAPESHIFTED
}

function Automaton_Dismount:UI_ERROR_MESSAGE(msg)
    for id, errorstring in pairs(ErrorsList) do
		if arg1 == errorstring then
			for i=0,15,1 do
				currBuffTex = GetPlayerBuffTexture(i);
				if (currBuffTex) then
					for id, bufftype in pairs(BuffsList) do
						if string.find(string.lower(currBuffTex), bufftype) then
							CancelPlayerBuff(i);
						end
					end
				end
			end
		end
	end
end

function Automaton_Dismount:TAXIMAP_OPENED()
	for i=0,15,1 do
		currBuffTex = GetPlayerBuffTexture(i);
		if (currBuffTex) then
			for id, bufftype in pairs(BuffsList) do
				if string.find(string.lower(currBuffTex), bufftype) then
					CancelPlayerBuff(i);
				end
			end
		end
	end
end