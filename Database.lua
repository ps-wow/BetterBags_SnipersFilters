assert(LibStub("AceAddon-3.0"):GetAddon("BetterBags"), "BetterBags_SnipersFilters requires BetterBags")

---@type string, AddonNS
local _, addon = ...

local items = {}

-- Categories
items.openables = {}
items.dfKnowledge = {}
items.lockboxes = {}

-- Openables
items.openables[17965]  = true -- Yellow Sack of Gems
items.openables[49294]  = true -- Ashen Sack of Gems
items.openables[171305] = true -- Salvaged Cache of Goods
  -- Random Dungeons
items.openables[156683] = true -- Satchel of Helpful Goods
items.openables[156682] = true -- Otherworldly Satchel of Helpful Goods
items.openables[156698] = true -- Tranquil Satchel of Helpful Goods

-- Lockboxes
items.lockboxes[4633]   = true -- Heavy Bronze Lockbox
items.lockboxes[4638]   = true -- Reinforced Steel Lockbox
items.lockboxes[6355]   = true -- Sturdy Locked Chest
items.lockboxes[116920] = true -- True Steel Lockbox

-- Dragonflight Profession Knowledge
items.dfKnowledge[198608] = true -- Alchemy Notes (Alchemy +3)
items.dfKnowledge[200677] = true -- Dreambloom Petal (Herbalism +1)

-- Initialise
addon.db = items