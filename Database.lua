assert(LibStub("AceAddon-3.0"):GetAddon("BetterBags"), "BetterBags_SnipersFilters requires BetterBags")

---@type string, AddonNS
local _, addon = ...
local items = {}

-- Categories
items.openables = {
    [17965]  = true, -- Yellow Sack of Gems
    [49294]  = true, -- Ashen Sack of Gems

    -- Random Dungeons
    [156683] = true, -- Satchel of Helpful Goods
    [156682] = true, -- Otherworldly Satchel of Helpful Goods
    [156698] = true, -- Tranquil Satchel of Helpful Goods
    [171305] = true, -- Salvaged Cache of Goods
}

-- Lockboxes
items.lockboxes = {
    [4633]   = true, -- Heavy Bronze Lockbox
    [4638]   = true, -- Reinforced Steel Lockbox
    [6355]   = true, -- Sturdy Locked Chest
    [116920] = true, -- True Steel Lockbox
}

-- Dragonflight Profession Knowledge
items.dfKnowledge = {
    [198608] = true, -- Alchemy Notes (Alchemy +3)
    [200677] = true, -- Dreambloom Petal (Herbalism +1)
}

-- Darkmoon Faire
items.darkmoonFaire = {
    [71634] = true, -- Darkmoon Adventurer's Guide
    [71635] = true, -- Imbued Crystal
    [71636] = true, -- Monstrous Egg
    [71637] = true, -- Mysterious Grimoire
    [71638] = true, -- Ornate Weapon
}

-- Initialise
addon.db = items