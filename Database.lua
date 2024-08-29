assert(LibStub("AceAddon-3.0"):GetAddon("BetterBags"), "BetterBags_SnipersFilters requires BetterBags")

---@type string, AddonNS
local _, addon = ...
local items = {}

-- Categories
items.openables = {
    [17964]  = true, -- Gray Sack of Gems
    [17965]  = true, -- Yellow Sack of Gems
    [49294]  = true, -- Ashen Sack of Gems
    [89810]  = true, -- Bounty of a Sundered Land

    -- Random Dungeons
    [156682] = true, -- Otherworldly Satchel of Helpful Goods
    [156683] = true, -- Satchel of Helpful Goods (WoW)
    [156689] = true, -- Scorched Satchel of Helpful Goods (Cata)
    [156698] = true, -- Tranquil Satchel of Helpful Goods
    [171305] = true, -- Salvaged Cache of Goods
    [210063] = true, -- Invader's Satchel of Helpful Goods
    
    -- WoD Garrison
    [139593] = true, -- Sack of Salvaged Goods (Salvage Yard)
    [116980] = true, -- Invader's Forgotten Treasure
    [122163] = true, -- Routed Invader's Crate of Spoils
    [120319] = true, -- Invader's Damaged Cache
    [120320] = true, -- Invader's Abandoned Sack

    -- Assault NZoth
    [173372] = true, -- Cache of the Black Empire
    [174958] = true, -- Cache of the Fallen Mogu

    -- PvP
    [201250] = true, -- Victorious Contender's Strongbox

    -- Clams
    [24476]  = true, -- Jaggal Clam (TBC)
    [198395] = true, -- Dull Spined Clam
}

-- Lockboxes
items.lockboxes = {
    [4633]   = true, -- Heavy Bronze Lockbox
    [4638]   = true, -- Reinforced Steel Lockbox
    [5760]   = true, -- Eternium Lockbox
    [6355]   = true, -- Sturdy Locked Chest
    [31952]  = true, -- Khorium Lockbox
    [68729]  = true, -- Elementium Lockbox
    [88567]  = true, -- Ghost Iron Lockbox
    [116920] = true, -- True Steel Lockbox
    [121331] = true, -- Leystone Lockbox
    [179311] = true, -- Synvir Lockbox
    [190954] = true, -- Serevite Lockbox
}

-- Events
items.events = {
    darkmoonFaire = {
        [71083] = true, -- Darkmoon Game Token
        [71634] = true, -- Darkmoon Adventurer's Guide
        [71635] = true, -- Imbued Crystal
        [71636] = true, -- Monstrous Egg
        [71637] = true, -- Mysterious Grimoire
        [71638] = true, -- Ornate Weapon
    },
    loveIsInTheAir = {
        [49927] = true, -- Love Token
    }
}

-- Account Bound Rep Items
items.accountBoundRep = {
    [208952] = true, -- Soridormi's Letter of Commendation
    [200454] = true, -- Maruuk Centaur Insignia
    [210421] = true, -- Dream Wardens Insignia
}

items.travel = {
    [6948] = true, -- Hearthstone
}

-- Initialise
addon.db = items