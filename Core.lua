---@class BetterBags: AceAddon
local BetterBags = LibStub("AceAddon-3.0"):GetAddon("BetterBags")
assert(BetterBags, "BetterBags_SnipersFilters requires BetterBags")

---@class Categories: AceModule
local categories = BetterBags:GetModule("Categories")

---@type string, AddonNS
local _, addon = ...

local CURRENT_EXPANSION = 9
local LEGION = 6
local SHADOWLANDS = 8
local QUALITY_LEGENDARY = 5
local QUALITY_ARTIFACT = 6

local function Debug(obj, desc)
    if ViragDevTool_AddData then
        ViragDevTool_AddData(obj, desc)
    end
end

categories:RegisterCategoryFunction("Sniper's Smart Filters", function (data)
    local itemID = data.itemInfo.itemID

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

    if itemID > 0 then
        Debug(data.itemInfo, 'data.itemInfo')
        Debug(data, 'data')
    end

    if data.itemInfo.expacID < CURRENT_EXPANSION then
        if data.itemInfo.itemType == "Tradeskill" then
            return "Legacy Tradeskill"
        end
    end

    -- Other Legacy
    -- if data.itemInfo.expacID < CURRENT_EXPANSION then
    --     return "Legacy"
    -- end
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

-- Dragonflight Profession Knowledge
for itemID in pairs(addon.db.dfKnowledge) do
    categories:AddItemToCategory(itemID, "DF Knowledge")
end

-- Event: Love is in the Air
categories:AddItemToCategory(49927, "Love is in the Air") -- Love Token

-- Darkmoon Faire
for itemID in pairs(addon.db.darkmoonFaire) do
    categories:AddItemToCategory(itemID, "Darkmoon Faire")
end
