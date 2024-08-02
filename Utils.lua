assert(LibStub("AceAddon-3.0"):GetAddon("BetterBags"), "BetterBags_SnipersFilters requires BetterBags")

---@type string, AddonNS
local _, addon = ...

local Utils = {
    Item = {}
}

-- Used for Debugging
local function GetItemTooltipLines(itemID)
    local tooltip = C_TooltipInfo.GetItemByID(itemID)
    return tooltip.lines
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

local function GetCurrentExpansion()
    return GetExpansionLevel()
end

local function PrefixFromExpacID(expacID)
    local patchId = expacID + 1

    if patchId < 10 then
        return "0" .. patchId .. "."
    end
    return patchId .. "."
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

Utils.Item.HasText = SSF_ItemHasText
Utils.Item.IsJewelry = IsJewelry
Utils.GetCurrentExpansion = GetCurrentExpansion
Utils.GetItemTooltipLines = GetItemTooltipLines
Utils.PrefixFromExpacID = PrefixFromExpacID

addon.Utils = Utils