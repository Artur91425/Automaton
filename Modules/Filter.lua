assert(Automaton, "Automaton not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("Automaton_Filter")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
    ["Filter"] = true,
	["Show only available skills at trainers by default."] = true,
} end)

L:RegisterTranslations("ruRU", function() return {
    ["Filter"] = "Фильтр",
	["Show only available skills at trainers by default."] = "Показывать только доступные для обучения способности.",
} end)

L:RegisterTranslations("koKR", function() return {
    ["Filter"] = "필터",
	["Show only available skills at trainers by default."] = "상급자에게 스킬을 배울시 사용 가능한 기술만 표시합니다.",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

Automaton_Filter = Automaton:NewModule("Filter")
Automaton_Filter.modulename = L["Filter"]
Automaton_Filter.moduledesc = L["Show only available skills at trainers by default."]
Automaton_Filter.options = {}

------------------------------
--      Initialization      --
------------------------------

function Automaton_Filter:OnInitialize()	
	self:RegisterOptions(self.options)
end

function Automaton_Filter:OnEnable()
	self:RegisterEvent("TRAINER_SHOW")
end

function Automaton_Filter:OnDisable()
	self:UnregisterAllEvents()
end

------------------------------
--      Event Handlers      --
------------------------------

function Automaton_Filter:TRAINER_SHOW()
	SetTrainerServiceTypeFilter("unavailable", 0)
end