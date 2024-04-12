assert(LibStub("AceAddon-3.0"):GetAddon("BetterBags"), "BetterBags_SnipersFilters requires BetterBags")

---@type string, AddonNS
local _, addon = ...

local items = {}

-- Categories
items.legionLegendaries = {}
items.legionArtefacts = {}
items.slLegendaries = {}
items.openables = {}
items.dfKnowledge = {}

-- Legion Legendaries
items.legionLegendaries[137095] = true -- Edraith
items.legionLegendaries[137026] = true -- Essence of Infusion
items.legionLegendaries[144242] = true -- X'oni's Caress

-- Legion Artefacts
-- items.legionArtefacts[128860] = true -- Fangs of Ashmane [Druid]
-- items.legionArtefacts[128306] = true -- G'hanir [Druid]
-- items.legionArtefacts[128858] = true -- Scythe of Elune [Druid]
-- items.legionArtefacts[128821] = true -- Claws of Ursoc [Druid]
-- items.legionArtefacts[128911] = true -- Sharas'dal [Shaman]

-- Shadowlands Legendaries
items.slLegendaries[172320] = true -- Umbrahide Waistguard / Lycara's Fleeting Glimpse

-- Openables
items.openables[156682] = true -- Otherworldly Satchel of Helpful Goods
items.openables[156683] = true -- Satchel of Helpful Goods
items.openables[171305] = true -- Salvaged Cache of Goods
items.openables[17965]  = true -- Yellow Sack of Gems

-- Dragonflight Profession Knowledge
items.dfKnowledge[198608] = true -- Alchemy Notes (+3)

-- Initialise
addon.db = items