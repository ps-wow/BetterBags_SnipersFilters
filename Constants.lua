---@type string, AddonNS
local _, addon = ...
local CONSTANTS = {
    WOW = {
        EXPANSIONS = {
            WOW = 0,
            TBC = 1,
            WRATH = 2,
            CATA = 3,
            MOP = 4,
            WOD = 5,
            LEGION = 6,
            BFA = 7,
            SHADOWLANDS = 8,
            DRAGONFLIGHT = 9,
            WARWITHIN = 10,
            CURRENT = 9
        }
    },
    ITEM = {
        QUALITY = {
            LEGENDARY = 5,
            ARTIFACT = 6,
            HEIRLOOM = 7,
        }
    }
}

addon.C = CONSTANTS