---@class BetterBags: AceAddon
local BetterBags = LibStub("AceAddon-3.0"):GetAddon("BetterBags")
assert(BetterBags, "BetterBags_SnipersFilters requires BetterBags")

---@class Categories: AceModule
local categories = BetterBags:GetModule("Categories")

---@type string, AddonNS
local _, addon = ...

local CURRENT_EXPANSION = 9
local WOW = 0
local TBC = 1
local WRATH = 2
local CATA = 3
local MOP = 4
local WOD = 5
local LEGION = 6
local BFA = 7
local SHADOWLANDS = 8
local DRAGONFLIGHT = 9
local WARWITHIN = 10
local QUALITY_LEGENDARY = 5
local QUALITY_ARTIFACT = 6
local QUALITY_HEIRLOOM = 7
-- Transient Values
local DUNGEON_NORMAL_LOOT = 421

local function Debug(obj, desc)
    if ViragDevTool_AddData then
        ViragDevTool_AddData(obj, desc)
    end
end

local function CreateEmptyTooltip()
	local tip = CreateFrame('GameTooltip', "ItemLinkLevelTooltip", nil, "GameTooltipTemplate")
	tip:SetOwner(UIParent, 'ANCHOR_NONE')

	local leftside = {}
	local rightside = {}
	for i = 1, 99 do
		local leftLine = tip:CreateFontString("ItemLinkLevelTooltipTextLeft" .. i, nil, "GameTooltipText")
		leftLine:SetFontObject("GameFontNormal")

		local rightLine = tip:CreateFontString("ItemLinkLevelTooltipTextRight" .. i, nil, "GameTooltipText")
		rightLine:SetFontObject("GameFontNormal")

		tip:AddFontStrings(leftLine, rightLine)

		leftside[i] = leftLine
		rightside[i] = rightLine
	end
	tip.leftside = leftside
	tip.rightside = rightside
	return tip
end

-- function borrowed from PersonalLootHelper
local function SSF_GetRealILVL(item)
	local realILVL = nil

	if item ~= nil then
		tooltip = tooltip or CreateEmptyTooltip()
		tooltip:ClearLines()
		tooltip:SetHyperlink(item)

        if tooltip.processingInfo == nil then
            return 0
        end
        
        local lines = tooltip.processingInfo.tooltipData.lines

        for i, line in ipairs(lines) do
            if line.leftText ~= nil then
                local lvl = line.leftText:match('Item Level (%d+)')
                if lvl then
                    realILVL = lvl
                end
            end
        end
		tooltip:Hide()

		-- if realILVL is still nil, we couldn't find it in the tooltip - try grabbing it from getItemInfo, even though
		--   that doesn't return upgrade levels
		if realILVL == nil then
			return 0
		end
	end

	if realILVL == nil then
		return 0
	else
		return tonumber(realILVL)
	end
end

local function SSF_ItemHasText(itemID, text)
    local hasText = false
    local tooltip = C_TooltipInfo.GetItemByID(itemID)

    for k,v in pairs(tooltip.lines) do
        if v.leftText ~= nil then
            if v.leftText:match(text) then
                hasText = true
                return true
            end
        end
        if v.rightText ~= nil then
            if v.rightText:match(text) then
                hasText = true
                return true
            end
        end
    end

    return hasText
end

-- Neck/Ring/Cloak
local function IsJewelry(itemInfo)
    if itemInfo.itemType == "Armor" then
        if itemInfo.itemEquipLoc == "INVTYPE_FINGER" then
            return true
        end
        if itemInfo.itemEquipLoc == "INVTYPE_NECK" then
            return true
        end
        if itemInfo.itemEquipLoc == "INVTYPE_TRINKET" then
            return true
        end
    else
        return false
    end
end

categories:RegisterCategoryFunction("Sniper's Smart Filters", function (data)
    local item = data.itemInfo.itemLink
    local itemType = data.itemInfo.itemType
    local itemID = data.itemInfo.itemID
    local quality = data.itemInfo.itemQuality

    if quality == QUALITY_HEIRLOOM then
        return "Heirloom"
    end

    -- If item has expacID
    if data.itemInfo.expacID ~= nil then
        -- 07. Legion 
        if data.itemInfo.expacID == LEGION then
            -- Legendaries
            if data.itemInfo.itemQuality == QUALITY_LEGENDARY then
                return "Legion Legendary"
            end

            -- Artifact Weapons
            if data.itemInfo.itemQuality == QUALITY_ARTIFACT then
                return "Legion Artifact"
            end

            -- Artifact Relics => Junk
            if data.itemInfo.itemSubType == "Artifact Relic" then
                return "Junk"
            end
        end

        -- 09. Shadowlands
        if data.itemInfo.expacID == SHADOWLANDS then
            -- Legendaries
            if data.itemInfo.itemQuality == QUALITY_LEGENDARY then
                return "Shadowlands Legendary"
            end
        end

        -- All previous expansions
        if data.itemInfo.expacID < CURRENT_EXPANSION then
            if itemType == "Tradeskill" then
                return "Legacy Tradeskill"
            end

            if itemType == "Armor" then
                if SSF_ItemHasText(itemID, 'Priest') then return "Priest (Legacy)" end
                if SSF_ItemHasText(itemID, 'Mage') then return "Mage (Legacy)" end
                if SSF_ItemHasText(itemID, 'Warlock') then return "Warlock (Legacy)" end
                if SSF_ItemHasText(itemID, 'Druid') then return "Druid (Legacy)" end
                if SSF_ItemHasText(itemID, 'Rogue') then return "Rogue (Legacy)" end
                if SSF_ItemHasText(itemID, 'Demon Hunter') then return "Demon Hunter (Legacy)" end
                if SSF_ItemHasText(itemID, 'Monk') then return "Monk (Legacy)" end
                if SSF_ItemHasText(itemID, 'Hunter') then return "Hunter (Legacy)" end
                if SSF_ItemHasText(itemID, 'Shaman') then return "Shaman (Legacy)" end
                if SSF_ItemHasText(itemID, 'Evoker') then return "Evoker (Legacy)" end
                if SSF_ItemHasText(itemID, 'Death Knight') then return "Death Knight (Legacy)" end
                if SSF_ItemHasText(itemID, 'Warrior') then return "Warrior (Legacy)" end
                if SSF_ItemHasText(itemID, 'Paladin') then return "Paladin (Legacy)" end
            end

            -- All low ilvl items can go to junk if not mog
            local realILevel = SSF_GetRealILVL(item)
            if realILevel == 0 then
                return
            else
                if realILevel < DUNGEON_NORMAL_LOOT then
                    -- Low Item Level

                    -- Neck/Ring/Trinket -> Junk
                    if IsJewelry(data.itemInfo) then
                        return "Junk"
                    end
                end
            end
        end
    end
end)

-- Openables
for itemID in pairs(addon.db.openables) do
    categories:AddItemToCategory(itemID, "Open")
end

-- Account Bound Reputation
for itemID in pairs(addon.db.accountBoundRep) do
    categories:AddItemToCategory(itemID, "Reputation")
end

-- Lockboxes
for itemID in pairs(addon.db.lockboxes) do
    categories:AddItemToCategory(itemID, "Lockboxes")
end

-- Dragonflight Profession Sparks
for itemID in pairs(addon.db.dragonflight.sparks) do
    categories:AddItemToCategory(itemID, "DF Sparks")
end

-- Dragonflight Profession Knowledge
for itemID in pairs(addon.db.dragonflight.knowledge) do
    categories:AddItemToCategory(itemID, "DF Knowledge")
end

-- Event: Love is in the Air
categories:AddItemToCategory(49927, "Love is in the Air") -- Love Token

-- Darkmoon Faire
for itemID in pairs(addon.db.darkmoonFaire) do
    categories:AddItemToCategory(itemID, "Darkmoon Faire")
end
