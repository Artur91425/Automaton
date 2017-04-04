assert(Automaton, "Automaton not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("Automaton_Clam")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
    ["Clam"] = true,
	["Search clam shells in inventory and open them after looting"] = true,
} end)

L:RegisterTranslations("ruRU", function() return {
    ["Clam"] = "Моллюск",
	["Search clam shells in inventory and open them after looting"] = "Находит раковины моллюска в сумке и открывает их",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

Automaton_Clam = Automaton:NewModule("Clam")
Automaton_Clam.modulename = L["Clam"]
Automaton_Clam.moduledesc = L["Search clam shells in inventory and open them after looting"]
Automaton_Clam.options = {}

------------------------------
--      Initialization      --
------------------------------

function Automaton_Clam:OnInitialize()
    self.db = Automaton:AcquireDBNamespace("Clam")
	Automaton:RegisterDefaults("Clam", "profile", {
		disabled = true,
	})
	Automaton:SetDisabledAsDefault(self, "Clam")
	
	self:RegisterOptions(self.options)
end

function Automaton_Clam:OnEnable()
	self:RegisterEvent("LOOT_CLOSED");
	self:RegisterEvent("MAIL_CLOSED");
	self:RegisterEvent("TRADE_CLOSED");
	self:RegisterEvent("BANKFRAME_CLOSED");
	self:RegisterEvent("BAG_UPDATE");
end

function Automaton_Clam:OnDisable()
	self:UnregisterAllEvents()
end

------------------------------
--      Event Handlers      --
------------------------------

local auto_clams  = {
	5523,  -- Small Barnacled Clam
	5524,  -- Thick-shelled Clam
	7973,  -- Big-mouth Clam
	15874  -- Soft-shelled Clam
}

function Automaton_Clam:ForbiddenFrame()
	local auctionframe = false;
	if (AuctionFrame and AuctionFrame:IsVisible()) then
		auctionframe = true;
	end
	if (LootFrame:IsVisible() or
	    TradeFrame:IsVisible() or
	    BankFrame:IsVisible() or
	    MailFrame:IsVisible() or
	    auctionframe or
	MerchantFrame:IsVisible()) then
	return true;
else
	return false;
	end
end

function Automaton_Clam:ExtractLinkID(link)
	_, _, id = string.find(link, "Hitem:(.+):%d+:%d+:%d+%\124");
	return tonumber(id);
end
function Automaton_Clam:LOOT_CLOSED()
	if (not self:ForbiddenFrame()) then
		self:Clam();
	end
end
function Automaton_Clam:MAIL_CLOSED()
	if (not self:ForbiddenFrame()) then
		self:Clam();
	end
end
function Automaton_Clam:TRADE_CLOSED()
	if (not self:ForbiddenFrame()) then
		self:Clam();
	end
end
function Automaton_Clam:BANKFRAME_CLOSED()
	if (not self:ForbiddenFrame()) then
		self:Clam();
	end
end
function Automaton_Clam:BAG_UPDATE()
	if (not self:ForbiddenFrame()) then
		self:Clam();
	end
end

function Automaton_Clam:IsClam(link)
	local index;
	for index = 1, table.getn(auto_clams) do
		if (self:ExtractLinkID(link) == auto_clams[index]) then
			return true;
		end
	end
	return false;
end

function Automaton_Clam:CanClam(bag, slot)
	Clam_Tooltip:SetBagItem(bag, slot);
	local text2 = Clam_TooltipTextLeft2:GetText();
	if (text2 and text2 == ITEM_OPENABLE) then
		--	print("CanClamtrue");
		return true;
	else
		--	print("CanClamfalse");
		return false;
	end
end

function Automaton_Clam:Clam()
	local bag, slot;
	for bag = 0, 4 do
		for slot = 1, GetContainerNumSlots(bag) do
			local link = GetContainerItemLink(bag, slot);
			if (link and self:IsClam(link) and self:CanClam(bag, slot)) then
				UseContainerItem(bag, slot);
				return true;
			end
		end
	end
	return false;
end