---@class BetterBags: AceAddon
local BetterBags = LibStub("AceAddon-3.0"):GetAddon("BetterBags")
assert(BetterBags, "BetterBags_SnipersFilters requires BetterBags")

---@class Categories: AceModule
local categories = BetterBags:GetModule("Categories")

---@type string, AddonNS
local _, addon = ...

local function Debug(obj, desc)
    if ViragDevTool_AddData then
        ViragDevTool_AddData(obj, desc)
    end
end

categories:RegisterCategoryFunction("Sniper's Smart Filters", function (data)
    local itemID = data.itemInfo.itemID
    
    -- if data.itemInfo.itemID == 137463 then
    --     Debug(data.itemInfo, 'data.itemInfo')
    --     Debug(data, 'data')
    -- end

    -- Legion Artifact Relics => Junk
    if data.itemInfo.expacID == 6 then
        if data.itemInfo.itemSubType == "Artifact Relic" then
            return "Junk"
        end
    end

    if data.itemInfo.expacID < 9 then
        return "Legacy"
    end
end)

-- Openables
for itemID in pairs(addon.db.openables) do
    categories:AddItemToCategory(itemID, "Open")
end

-- Legion Artefact's
for itemID in pairs(addon.db.legionArtefacts) do
    categories:AddItemToCategory(itemID, "Legion Artefact")
end

-- Legion Legendaries
for itemID in pairs(addon.db.legionLegendaries) do
    categories:AddItemToCategory(itemID, "Legion Legendary")
end

-- Shadowlands Legendaries
for itemID in pairs(addon.db.slLegendaries) do
    categories:AddItemToCategory(itemID, "Shadowlands Legendary")
end

-- Dragonflight Profession Knowledge
for itemID in pairs(addon.db.dfKnowledge) do
    categories:AddItemToCategory(itemID, "DF Knowledge")
end

-- Event: Love is in the Air
categories:AddItemToCategory(49927, "Love is in the Air") -- Love Token

-- Event: Darkmoon Faire
categories:AddItemToCategory(71634, "Darkmoon Faire") -- Darkmoon Adventurer's Guide
categories:AddItemToCategory(71635, "Darkmoon Faire") -- Imbued Crystal
categories:AddItemToCategory(71636, "Darkmoon Faire") -- Monstrous Egg
categories:AddItemToCategory(71637, "Darkmoon Faire") -- Mysterious Grimoire
categories:AddItemToCategory(71638, "Darkmoon Faire") -- Ornate Weapon
