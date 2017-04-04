assert(Automaton, "Automaton not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("Automaton_Attack")
local aura = AceLibrary("SpecialEvents-Aura-2.0")
local BS = AceLibrary("Babble-Spell-2.2")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["Attack"] = true,
	["Automatically attack."] = true,
} end)

L:RegisterTranslations("ruRU", function() return {
	["Attack"] = "Атака",
	["Automatically attack."] = "Автоматическая атака",
} end)

L:RegisterTranslations("koKR", function() return {
	["Attack"] = "자동 공격",
	["Automatically attack."] = "전투상태시 자동으로 공격합니다.",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

Automaton_Attack = Automaton:NewModule("Attack")
Automaton_Attack.modulename = L["Attack"]
Automaton_Attack.moduledesc = L["Automatically attack."]
Automaton_Attack.options = {}

------------------------------
--      Initialization      --
------------------------------

function Automaton_Attack:OnInitialize()
    self.db = Automaton:AcquireDBNamespace("Loner")
	Automaton:RegisterDefaults("Attack", "profile", {
		disabled = true,
	})
	Automaton:SetDisabledAsDefault(self, "Attack")

	self:RegisterOptions(self.options)
end

function Automaton_Attack:OnEnable()
	self:RegisterEvent("PLAYER_ENTER_COMBAT")
	self:RegisterEvent("PLAYER_LEAVE_COMBAT")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("START_AUTOREPEAT_SPELL")
	self:RegisterEvent("STOP_AUTOREPEAT_SPELL")
	
	self:RegisterEvent("SpecialEvents_AuraTargetChanged")
	self:RegisterEvent("SpecialEvents_PlayerBuffGained")
	self:RegisterEvent("SpecialEvents_PlayerBuffLost")
	self:RegisterEvent("SpecialEvents_UnitDebuffGained")
	self:RegisterEvent("SpecialEvents_UnitDebuffLost")
end

function Automaton_Attack:OnDisable()
	self:UnregisterAllEvents()
end

------------------------------
--      Event Handlers      --
------------------------------

local buffs = {
	BS["Vanish"],
	BS["Prowl"],
	BS["Feign Death"],
	BS["Shadowmeld"],
	BS["Food"],
	BS["Drink"],
	BS["Enriched Manna Biscuit"],
	BS["First Aid"],
}

local debuffs = {
	BS["Gouge"],
	BS["Sap"],
	BS["Seduction"],
	BS["Polymorph"],
	BS["Tame Beast"],
	BS["Scare Beast"],
	BS["Sleep"],
	BS["Hibernate"],
	BS["Fear"],
	BS["Mind Control"],
	BS["Blind"],
	BS["Scatter Shot"],
	BS["Enslave Demon"],
	BS["Shackle Undead"],
	BS["Reckless Charge"],
	BS["Freezing Trap Effect"],
	BS["Intimidating Shout"],
	BS["Cheap Shot"],
}

function Automaton_Attack:PLAYER_ENTER_COMBAT()
	if not self.inCombat then
		self.selfImposedCombat = true
	end
	self.attacking = true
end

function Automaton_Attack:PLAYER_LEAVE_COMBAT()
	self.attacking = false
	self.selfImposedCombat = false
end

function Automaton_Attack:PLAYER_REGEN_ENABLED()
	self.inCombat = false
	self.selfImposedCombat = false
	self:StopAttacking()
end

function Automaton_Attack:PLAYER_REGEN_DISABLED()
	self.selfImposedCombat = false
	self.inCombat = true
	self:Check()
end

function Automaton_Attack:START_AUTOREPEAT_SPELL()
	self.autoRepeating = true
	self:StopAttacking()
end

function Automaton_Attack:STOP_AUTOREPEAT_SPELL()
	self.autoRepeating = false
	self:Check()
end

function Automaton_Attack:SpecialEvents_AuraTargetChanged()
	self:Check()
end

function Automaton_Attack:SpecialEvents_PlayerBuffGained(buff)
	if buffs[buff] then
		self:StopAttacking()
	end
end

function Automaton_Attack:SpecialEvents_PlayerBuffLost(buff)
	if buffs[buff] then
		self:Check()
	end
end

function Automaton_Attack:SpecialEvents_UnitDebuffGained(unitID, debuff)
	if unitID == "target" and debuffs[debuff] then
		self:StopAttacking()
	end
end

function Automaton_Attack:SpecialEvents_UnitDebuffLost(unitID, debuff)
	if unitID == "target" and debuffs[debuff] then
		self:Check()
	end
end

function Automaton_Attack:Check()
	if (not self.inCombat and not self.selfImposedCombat) or self.autoRepeating or not UnitExists("target") or UnitIsUnit("target", "player") or UnitIsDeadOrGhost("target") or not UnitCanAttack("player", "target") or UnitIsFriend("player", "target") or self:PlayerHasSpecialBuff() or self:TargetIsCrowdControlled() then
		self:StopAttacking()
	else
		self:StartAttacking()
	end
end

function Automaton_Attack:StopAttacking()
	if self.attacking then
		AttackTarget()
	end
end

function Automaton_Attack:StartAttacking()
	if not self.attacking then
		AttackTarget()
	end
end

function Automaton_Attack:PlayerHasSpecialBuff()
	for buff in pairs(buffs) do
		if aura:UnitHasBuff("player", buff) then
			return true
		end
	end
	return false
end

function Automaton_Attack:TargetIsCrowdControlled()
	for debuff in pairs(debuffs) do
		if aura:UnitHasDebuff("target", debuff) then
			return true
		end
	end
	return false
end