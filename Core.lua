---@class BetterBags: AceAddon
local BetterBags = LibStub("AceAddon-3.0"):GetAddon("BetterBags")
assert(BetterBags, "BetterBags_SnipersFilters requires BetterBags")

---@class Categories: AceModule
local categories = BetterBags:GetModule("Categories")

---@class AceDB-3.0: AceModule
local AceDB = LibStub("AceDB-3.0")

---@type string, AddonNS
local _, addon = ...

local C = addon.C
local T = addon.T

local suffix = " (SF)"

local CURRENT_EXPANSION = 9

-- Transient Values
local DUNGEON_NORMAL_LOOT = 554 -- War Within
local DUNGEON_HEROIC_LOOT = 580 -- War Within
local DUNGEON_M0_LOOT = 597 -- War Within
local RAID_NORMAL_LOOT = 597 -- War Within
local RAID_HEROIC_LOOT = 610 -- War Within
local RAID_MYTHIC_LOOT = 623 -- War Within

local function Debug(obj, desc)
    if DevTool then
        DevTool:AddData(obj, desc)
    end
end

---@class SnipersFilters: AceModule
local SnipersFilters = BetterBags:NewModule("Sniper's Filters")

---@class Config: AceModule
local Config = BetterBags:GetModule('Config')

---@class Events: AceModule
local Events = BetterBags:GetModule('Events')

---@class Localization: AceModule
local L = BetterBags:GetModule('Localization')

local function BuildCategoryName(prefix, name)
    return strtrim(prefix) .. " " .. strtrim(name) .. " " .. strtrim(suffix)
end

local defaults = {
    profile = {
        events = {
            darkmoonFaire = true,
            prefix = "01. ",
        },
        general = {
            lockboxes = {
                enabled = true,
                prefix = "00. "
            },
            openables = {
                prefix = "00. "
            }
        },
        legacy = {
            armor = "junk"
        },
        dragonflight = {
            sparks = true,
            renown = true,
            prefix = "10. ",
            warbound = true,
        },
        warwithin = {
            sparks = true,
            renown = true,
            prefix = "11. ",
            warbound = true,
        }
    },
}

local db

local wowGameEvents = {
    "Darkmoon Faire",
    "Love is in the Air"
}

local wowClasses = {
    -- Cloth
    "Mage",
    "Priest",
    "Warlock",
    -- Leather
    "Druid",
    "Monk",
    "Rogue",
    "Demon Hunter",
    -- Mail
    "Shaman",
    "Evoker",
    "Hunter",
    -- Plate
    "Paladin",
    "Death Knight",
    "Warrior"
}

local configOptions = {
    events = {
        name = L:G("Events"),
        type = "group",
        order = 1,
        inline = true,
        args = {
            darkmoonFaire = {
                type = "toggle",
                name = "Darkmoon Faire",
                desc = "Create filter for darkmoon faire",
                get = function(info)
                    return SnipersFilters.db.profile.dragonflight.renown
                end,
                set = function(info, value)
                    SnipersFilters.db.profile.dragonflight.renown = value
                    Events:SendMessage('bags/FullRefreshAll')
                end,
            },
            prefix = {
                type = "input",
                name = "Prefix",
                desc = "Prefix all items in this category",
                get = function(info)
                    return SnipersFilters.db.profile.events.prefix
                end,
                set = function(info, value)
                    for _, evt in ipairs(wowGameEvents) do
                        categories:WipeCategory(L:G(SnipersFilters.db.profile.events.prefix .. evt))
                    end
                    
                    SnipersFilters.db.profile.events.prefix = value
                    SnipersFilters:WoWGameEvents()
                    Events:SendMessage('bags/FullRefreshAll')
                end,
            }
        }
    },
    general = {
        name = L:G("General"),
        type = "group",
        order = 1,
        inline = true,
        args = {
            lockboxesEnabled = {
                type = "toggle",
                name = "Lockboxes",
                desc = "Create filter for lockboxes",
                get = function(info)
                    return SnipersFilters.db.profile.general.lockboxes.enabled
                end,
                set = function(info, value)
                    SnipersFilters.db.profile.general.lockboxes.enabled = value
                    Events:SendMessage('bags/FullRefreshAll')
                end,
            },
            lockboxesPrefix = {
                type = "input",
                name = "Lockboxes Prefix",
                desc = "Prefix for lockboxes filter",
                get = function(info)
                    return SnipersFilters.db.profile.general.lockboxes.prefix
                end,
                set = function(info, value)
                    SnipersFilters.db.profile.general.lockboxes.prefix = value
                    Events:SendMessage('bags/FullRefreshAll')
                end
            },
        }
    },
    legacy = {
        name = L:G("Legacy"),
        type = "group",
        order = 10,
        inline = true,
        args = {
            armor = {
                type = "select",
                name = "Armor",
                desc = "How should legacy armor appear in BetterBags.",
                values = {
                    armor = "Armor",
                    junk = "Junk",
                    classjunk = "Class or Junk"
                },
                style = "dropdown",
                get = function(info)
                    return db.legacy.armor
                end,
                set = function(info, value)
                    db.legacy.armor = value
                    Events:SendMessage('bags/FullRefreshAll')
                end
            }   
        }
    },
    expansionHeader = {
        type = "header",
        name = "Expansions"
    },
    dragonflight = {
        name = L:G("10. Dragonflight"),
        type = "group",
        order = 10,
        inline = true,
        args = {
            renown = {
                type = "toggle",
                name = "Renown",
                desc = "Create filter for dragonflight renown",
                get = function(info)
                    return SnipersFilters.db.profile.dragonflight.renown
                end,
                set = function(info, value)
                    SnipersFilters.db.profile.dragonflight.renown = value
                    Events:SendMessage('bags/FullRefreshAll')
                end,
            },
            warbound = {
                type = "toggle",
                name = "Warbound Armor",
                desc = "Create filter for dragonflight warbound armor",
                get = function(info)
                    return SnipersFilters.db.profile.dragonflight.warbound
                end,
                set = function(info, value)
                    SnipersFilters.db.profile.dragonflight.warbound = value
                    Events:SendMessage('bags/FullRefreshAll')
                end
            },
            prefix = {
                type = "input",
                name = "Prefix",
                desc = "Prefix for Dragonflight Filters",
                get = function(info)
                    return SnipersFilters.db.profile.dragonflight.prefix
                end,
                set = function(info, value)
                    SnipersFilters.db.profile.dragonflight.prefix = value
                    Events:SendMessage('bags/FullRefreshAll')
                end
            }
        }
    }
}

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

function SnipersFilters:WoWGameEvents()
    -- Events
    for itemID in pairs(addon.db.events.darkmoonFaire) do categories:AddItemToCategory(itemID, BuildCategoryName(db.events.prefix, "Darkmoon Faire")) end
    for itemID in pairs(addon.db.events.loveIsInTheAir) do categories:AddItemToCategory(itemID, BuildCategoryName(db.events.prefix, "Love is in the Air")) end
end

function SnipersFilters:addConfig()
    if not Config or not configOptions then
        print("Failed to load configurations for SnipersFilters plugin.")
        return
    end

    Config:AddPluginConfig("Snipers Filters", configOptions)
end



-- On plugin load, wipe the categories we've added
function SnipersFilters:OnInitialize()
    self.db = AceDB:New("BetterBags_SnipersFiltersDB", defaults)
    self.db:SetProfile("global")
    db = self.db.profile

    self:addConfig()

    -- Openables
    for itemID in pairs(addon.db.openables) do
        categories:AddItemToCategory(itemID, BuildCategoryName(db.general.openables.prefix, "Open"))
    end

    -- Account Bound Reputation
    for itemID in pairs(addon.db.accountBoundRep) do
        categories:AddItemToCategory(itemID, BuildCategoryName("00.", "Reputation"))
    end

    -- Lockboxes
    for itemID in pairs(addon.db.lockboxes) do
        categories:AddItemToCategory(itemID, BuildCategoryName(db.general.lockboxes.prefix, "Lockboxes"))
    end

    -- Game Events
    SnipersFilters:WoWGameEvents()

    -- Dragonflight
    --- Reputation
    for itemID in pairs(addon.dragonflight.renown) do categories:AddItemToCategory(itemID, BuildCategoryName(db.dragonflight.prefix, "Renown")) end
    --- Sparks
    for itemID in pairs(addon.dragonflight.sparks) do categories:AddItemToCategory(itemID, BuildCategoryName(db.dragonflight.prefix, "Sparks")) end
    --- Profession Knowledge
    for itemID in pairs(addon.dragonflight.knowledge) do categories:AddItemToCategory(itemID, BuildCategoryName(db.dragonflight.prefix, "Knowledge")) end
    --- Dream Seeds
    for itemID in pairs(addon.dragonflight.emeraldDream.seeds) do categories:AddItemToCategory(itemID, BuildCategoryName(db.dragonflight.prefix, "Seeds")) end
    --- Openables
    for itemID in pairs(addon.dragonflight.openables) do categories:AddItemToCategory(itemID, BuildCategoryName(db.general.openables.prefix, "Open")) end

    -- War Within
    --- Renown
    for itemID in pairs(addon.warwithin.renown) do categories:AddItemToCategory(itemID, BuildCategoryName(db.warwithin.prefix, "Renown")) end
    --- Profession Knowledge
    for itemID in pairs(addon.warwithin.knowledge) do categories:AddItemToCategory(itemID, BuildCategoryName(db.warwithin.prefix, "Knowledge")) end
    --- Openables
    for itemID in pairs(addon.warwithin.openables) do categories:AddItemToCategory(itemID, BuildCategoryName(db.general.openables.prefix, "Open")) end
end

categories:RegisterCategoryFunction("Sniper's Smart Filters", function (data)
    local item = data.itemInfo.itemLink
    local itemType = data.itemInfo.itemType
    local subType = data.itemInfo.itemSubType
    local itemID = data.itemInfo.itemID
    local quality = data.itemInfo.itemQuality
    local equipLoc = data.itemInfo.itemEquipLoc
    local currentExpansion = GetServerExpansionLevel()

    -- Debug
    -- if itemID == 218080 then
    --     Debug(item, "item")
    --     Debug(data.itemInfo, "data.itemInfo")
    --     Debug(data.itemInfo.itemEquipLoc, "data.itemInfo.itemEquipLoc")
    --     Debug(itemType, "itemType")
    --     Debug(subType, "subType")
    --     Debug(addon.Utils.GetItemTooltipLines(itemID), "GetItemTooltipLines(itemID)")
    --     Debug(item, "item")
    -- end

    if equipLoc == "INVTYPE_TABARD" then
        return BuildCategoryName("00. ", "Tabards")
    end

    if quality == C.ITEM.QUALITY.HEIRLOOM then
        return BuildCategoryName("00. ", "Heirloom")
    end

    if addon.Utils.Item.HasText(itemID, "Cosmetic") then
        return BuildCategoryName("00. ", "Cosmetic")
    end

    if data.itemInfo.itemSubType == "Artifact Relic" then
        return "Junk"
    end

    -- Legendaries by Expansion
    if data.itemInfo.expacID ~= nil then
        if itemType == "Armor" then
            -- Legendaries
            if data.itemInfo.itemQuality == C.ITEM.QUALITY.LEGENDARY then
                return BuildCategoryName(addon.Utils.PrefixFromExpacID(data.itemInfo.expacID), "Legendary")
            end
            -- Artifacts
            if data.itemInfo.itemQuality == C.ITEM.QUALITY.ARTIFACT then
                return BuildCategoryName(addon.Utils.PrefixFromExpacID(data.itemInfo.expacID), "Artifact")
            end
        end
    end

    -- If item has expacID
    if data.itemInfo.expacID ~= nil then
        -- 11. War Within

        -- 10. Dragonflight
        if data.itemInfo.expacID == DRAGONFLIGHT then
            if itemType == "Armor" then
                if SnipersFilters.db.profile.dragonflight.warbound == true then
                    if addon.Utils.Item.HasText(itemID, "Binds to Warband") then
                        return BuildCategoryName(db.dragonflight.prefix, "Warbound")
                    end
                end
            end
        end

        -- All previous expansions
        if data.itemInfo.expacID < currentExpansion then
            if itemType == "Tradeskill" then
                return BuildCategoryName("99. ", "Legacy Tradeskill")
            end

            if itemType == "Armor" then
                for _, wowclass in ipairs(wowClasses) do
                    if addon.Utils.Item.HasText(itemID, wowclass) then
                        if db.legacy.armor == "classjunk" then
                            return BuildCategoryName(addon.Utils.PrefixFromExpacID(data.itemInfo.expacID), wowclass .. " (Legacy)")
                        end
                        if db.legacy.armor == "junk" then
                            return "Junk"
                        end
                        return BuildCategoryName(addon.Utils.PrefixFromExpacID(data.itemInfo.expacID), "Armor (Legacy)")
                    end
                end
            end

            -- All low ilvl items can go to junk if not mog
            local realILevel = SSF_GetRealILVL(item)
            if realILevel == 0 then
                return
            else
                if realILevel < T.DUNGEON_NORMAL_LOOT then
                    -- Neck/Ring/Trinket -> Junk
                    if addon.Utils.Item.IsJewelry(data.itemInfo) then
                        return "Junk"
                    end

                    -- Low Item Level
                    if itemType == "Armor" then
                        if db.legacy.armor == "armor" then
                            return BuildCategoryName("01. ", "Legacy Armor")
                        end
                        if db.legacy.armor == "junk" then 
                            return "Junk"
                        end
                    end


                    return BuildCategoryName("01. ", "Legacy")
                end
            end
        end
    end
end)