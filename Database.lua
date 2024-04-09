assert(LibStub("AceAddon-3.0"):GetAddon("BetterBags"), "BetterBags_SnipersFilters requires BetterBags")

---@type string, AddonNS
local _, addon = ...

-- Retail
local isMainline = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE

local items = {}

-- Legion Legendaries
items.legionLegendaries = {}
items.legionLegendaries[137095] = true -- Edraith
items.legionLegendaries[137026] = true -- Essence of Infusion
items.legionLegendaries[144242] = true -- X'oni's Caress

-- Legion Artefacts
items.legionArtefacts = {}
items.legionArtefacts[128860] = true -- Fangs of Ashmane [Druid]
items.legionArtefacts[128306] = true -- G'hanir [Druid]
items.legionArtefacts[128858] = true -- Scythe of Elune [Druid]
items.legionArtefacts[128821] = true -- Claws of Ursoc [Druid]

-- Shadowlands Legendaries
items.slLegendaries = {}
items.slLegendaries[172320] = true -- Lycara's Fleeting Glimpse

-- Openables
items.openables = {}
items.openables[156682] = true -- Otherworldly Satchel of Helpful Goods
items.openables[156683] = true -- Satchel of Helpful Goods
items.openables[171305] = true -- Salvaged Cache of Goods
items.openables[17965]  = true -- Yellow Sack of Gems

-- Initialise
addon.db = items