assert(LibStub("AceAddon-3.0"):GetAddon("BetterBags"), "BetterBags_SnipersFilters requires BetterBags")

---@type string, AddonNS
local _, addon = ...
local items = {}

-- Categories
items.openables = {
    [17965]  = true, -- Yellow Sack of Gems
    [49294]  = true, -- Ashen Sack of Gems

    -- Random Dungeons
    [156682] = true, -- Otherworldly Satchel of Helpful Goods
    [156683] = true, -- Satchel of Helpful Goods
    [156698] = true, -- Tranquil Satchel of Helpful Goods
    [171305] = true, -- Salvaged Cache of Goods
    [210063] = true, -- Invader's Satchel of Helpful Goods
    
    -- Assault NZoth
    [173372] = true, -- Cache of the Black Empire
    [174958] = true, -- Cache of the Fallen Mogu

    -- Dragonflight
    [200073] = true, -- Valdrakken Treasures
    [202172] = true, -- Overflowing Satchel of Coins
    [207582] = true, -- Box of Tampered Reality
    [207584] = true, -- Box of Volatile Reality
    [209837] = true, -- Faint Whispers of Dreaming
    -- Loamm
    [205257] = true, -- Clinking Dirt-Covered Pouch
    [205964] = true, -- Small Loammian Supply Pack
    [205983] = true, -- Scentsational Niffen Treasures
    -- Dream
    [210180] = true, -- Emerald Flightstone
    [210872] = true, -- Satchel of Dreams
    [210917] = true, -- Pouch of Whelping's Dreaming Crests
    [210992] = true, -- Overflowing Dream Warden Trove
    [211389] = true, -- Cache of Overblooming Treasures
    [211394] = true, -- Harvested Dreamseed Cache
    [211411] = true, -- Sprouting Dreamtrove
    [211413] = true, -- Budding Dreamtrove
    [211414] = true, -- Blossoming Dreamtrove

    -- PvP
    [201250] = true, -- Victorious Contender's Strongbox

    -- Clams
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

items.dragonflight = {
    sparks = {
        [206959] = true, -- Spark of Dreams (10.2)
    },
    -- Dragonflight Profession Knowledge
    knowledge = {
        -- Mining
        [194039] = true, -- Heated Ore Sample (+1)
        [194062] = true, -- Unyielding Stone Chunk (+1)
        [201300] = true, -- Iridescent Ore Fragments (+1)
        -- Herbalism
        [200677] = true, -- Dreambloom Petal (+1)
        -- Skinning
        [198837] = true, -- Curious Hide Scraps (+1)
        -- Alchemy
        [198608] = true, -- Alchemy Notes (+3)
        -- Tailoring
        [198684] = true, -- Miniature Bronze Dragonflight Banner (+3)
        [201715] = true, -- Notebook of Crafting Knowledge (+5)
        [205355] = true, -- Niffen Notebook of Tailoring Knowledge (+10)
        [206025] = true, -- Used Medical Wrap Kit (+3)
        -- Engineering
        [193902] = true, -- Eroded Titan Gizmo (+1)
        -- Enchanting
        [193900] = true, -- Prismatic Focusing Shard (+1)
        [198968] = true, -- Primalist Charm (+1)
        [205351] = true, -- Niffen Notebook of Enchanting Knowledge (+10)
    },
}



-- Darkmoon Faire
items.darkmoonFaire = {
    [71083] = true, -- Darkmoon Game Token
    [71634] = true, -- Darkmoon Adventurer's Guide
    [71635] = true, -- Imbued Crystal
    [71636] = true, -- Monstrous Egg
    [71637] = true, -- Mysterious Grimoire
    [71638] = true, -- Ornate Weapon
}

-- Account Bound Rep Items
items.accountBoundRep = {
    [208952] = true, -- Soridormi's Letter of Commendation
    [200454] = true, -- Maruuk Centaur Insignia
}

-- Initialise
addon.db = items