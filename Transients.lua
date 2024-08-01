---@type string, AddonNS
local _, addon = ...
local TRANSIENTS = {
    -- War Within
    DUNGEON_NORMAL_LOOT = 554, -- War Within
    DUNGEON_HEROIC_LOOT = 580, -- War Within
    DUNGEON_M0_LOOT = 597, -- War Within
    RAID_NORMAL_LOOT = 597, -- War Within
    RAID_HEROIC_LOOT = 610, -- War Within
    RAID_MYTHIC_LOOT = 623 -- War Within
}

addon.T = TRANSIENTS