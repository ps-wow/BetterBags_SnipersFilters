---@class BetterBags: AceAddon
local BetterBags = LibStub("AceAddon-3.0"):GetAddon("BetterBags")
assert(BetterBags, "BetterBags_SnipersFilters requires BetterBags")

---@class Categories: AceModule
local categories = BetterBags:GetModule("Categories")

---@type string, AddonNS
local _, addon = ...


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

-- Event: Love is in the Air
categories:AddItemToCategory(49927, "Love is in the Air") -- Love Token

-- Event: Darkmoon Faire
categories:AddItemToCategory(71634, "Darkmoon Faire") -- Darkmoon Adventurer's Guide
categories:AddItemToCategory(71635, "Darkmoon Faire") -- Imbued Crystal
categories:AddItemToCategory(71636, "Darkmoon Faire") -- Monstrous Egg
categories:AddItemToCategory(71637, "Darkmoon Faire") -- Mysterious Grimoire
categories:AddItemToCategory(71638, "Darkmoon Faire") -- Ornate Weapon
