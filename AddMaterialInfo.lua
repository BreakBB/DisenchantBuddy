---@class DisenchantBuddy
local DisenchantBuddy = select(2, ...)

local L = DisenchantBuddy.L
local Materials = DisenchantBuddy.Materials
local Colors = {
    STANDARD = "|cffffffff",
    GOOD = "|cff1eff00",
    RARE = "|cff0070dd",
    EPIC = "|cffa335ee",
}

---@class ItemLevelRange
---@field minItemLevel number
---@field maxItemLevel number

---@type table<number, {uncommon: ItemLevelRange?, rare: ItemLevelRange?, epic: ItemLevelRange?}>
local itemLevelRangesByMaterial = {
    [Materials.STRANGE_DUST] = { uncommon = { minItemLevel = 1, maxItemLevel = 25 } },
    [Materials.SOUL_DUST] = { uncommon = { minItemLevel = 26, maxItemLevel = 35 } },
    [Materials.VISION_DUST] = { uncommon = { minItemLevel = 36, maxItemLevel = 45 } },
    [Materials.DREAM_DUST] = { uncommon = { minItemLevel = 46, maxItemLevel = 55 } },
    [Materials.ILLUSION_DUST] = { uncommon = { minItemLevel = 56, maxItemLevel = 65 } },

    [Materials.LESSER_MAGIC_ESSENCE] = { uncommon = { minItemLevel = 1, maxItemLevel = 15 } },
    [Materials.GREATER_MAGIC_ESSENCE] = { uncommon = { minItemLevel = 16, maxItemLevel = 30 } },
    [Materials.LESSER_ASTRAL_ESSENCE] = { uncommon = { minItemLevel = 21, maxItemLevel = 25 } },
    [Materials.GREATER_ASTRAL_ESSENCE] = { uncommon = { minItemLevel = 26, maxItemLevel = 30 } },
    [Materials.LESSER_MYSTIC_ESSENCE] = { uncommon = { minItemLevel = 31, maxItemLevel = 35 } },
    [Materials.GREATER_MYSTIC_ESSENCE] = { uncommon = { minItemLevel = 36, maxItemLevel = 40 } },
    [Materials.LESSER_NETHER_ESSENCE] = { uncommon = { minItemLevel = 41, maxItemLevel = 45 } },
    [Materials.GREATER_NETHER_ESSENCE] = { uncommon = { minItemLevel = 46, maxItemLevel = 50 } },
    [Materials.LESSER_ETERNAL_ESSENCE] = { uncommon = { minItemLevel = 51, maxItemLevel = 55 } },
    [Materials.GREATER_ETERNAL_ESSENCE] = { uncommon = { minItemLevel = 56, maxItemLevel = 65 } },

    [Materials.SMALL_GLIMMERING_SHARD] = { uncommon = { minItemLevel = 16, maxItemLevel = 25 }, rare = { minItemLevel = 1, maxItemLevel = 25 } },
    [Materials.LARGE_GLIMMERING_SHARD] = { uncommon = { minItemLevel = 26, maxItemLevel = 30 }, rare = { minItemLevel = 26, maxItemLevel = 30 } },
    [Materials.SMALL_GLOWING_SHARD] = { uncommon = { minItemLevel = 31, maxItemLevel = 35 }, rare = { minItemLevel = 31, maxItemLevel = 35 } },
    [Materials.LARGE_GLOWING_SHARD] = { uncommon = { minItemLevel = 36, maxItemLevel = 40 }, rare = { minItemLevel = 36, maxItemLevel = 40 } },
    [Materials.SMALL_RADIANT_SHARD] = { uncommon = { minItemLevel = 41, maxItemLevel = 45 }, rare = { minItemLevel = 41, maxItemLevel = 45 } },
    [Materials.LARGE_RADIANT_SHARD] = { uncommon = { minItemLevel = 46, maxItemLevel = 50 }, rare = { minItemLevel = 46, maxItemLevel = 50 } },
    [Materials.SMALL_BRILLIANT_SHARD] = { uncommon = { minItemLevel = 51, maxItemLevel = 55 }, rare = { minItemLevel = 51, maxItemLevel = 55 } },
    [Materials.LARGE_BRILLIANT_SHARD] = { uncommon = { minItemLevel = 56, maxItemLevel = 65 }, rare = { minItemLevel = 56, maxItemLevel = 86 } },
    [Materials.NEXUS_CRYSTAL] = { rare = { minItemLevel = 56, maxItemLevel = 99 }, epic = { minItemLevel = 56, maxItemLevel = DisenchantBuddy.IsSoD and 100 or 92 } },
}

if DisenchantBuddy.IsTBC or DisenchantBuddy.IsWotLK or DisenchantBuddy.IsCata or DisenchantBuddy.IsMoP then
    itemLevelRangesByMaterial[Materials.ARCANE_DUST] = { uncommon = { minItemLevel = 66, maxItemLevel = 120 } }
    itemLevelRangesByMaterial[Materials.LESSER_PLANAR_ESSENCE] = { uncommon = { minItemLevel = 66, maxItemLevel = 99 } }
    itemLevelRangesByMaterial[Materials.GREATER_PLANAR_ESSENCE] = { uncommon = { minItemLevel = 100, maxItemLevel = 120 } }
    itemLevelRangesByMaterial[Materials.SMALL_PRISMATIC_SHARD] = { uncommon = { minItemLevel = 56, maxItemLevel = 99 }, rare = { minItemLevel = 56, maxItemLevel = 92 } }
    itemLevelRangesByMaterial[Materials.LARGE_PRISMATIC_SHARD] = { uncommon = { minItemLevel = 100, maxItemLevel = 120 }, rare = { minItemLevel = 100, maxItemLevel = 115 } }
    itemLevelRangesByMaterial[Materials.VOID_CRYSTAL] = { epic = { minItemLevel = DisenchantBuddy.IsSoD and 101 or 93, maxItemLevel = 164 } }
end

if DisenchantBuddy.IsWotLK or DisenchantBuddy.IsCata or DisenchantBuddy.IsMoP then
    itemLevelRangesByMaterial[Materials.INFINITE_DUST] = { uncommon = { minItemLevel = 121, maxItemLevel = 200 } }
    itemLevelRangesByMaterial[Materials.LESSER_COSMIC_ESSENCE] = { uncommon = { minItemLevel = 121, maxItemLevel = 151 } }
    itemLevelRangesByMaterial[Materials.GREATER_COSMIC_ESSENCE] = { uncommon = { minItemLevel = 152, maxItemLevel = 200 } }
    itemLevelRangesByMaterial[Materials.SMALL_DREAM_SHARD] = { uncommon = { minItemLevel = 121, maxItemLevel = 151 }, rare = { minItemLevel = 116, maxItemLevel = 166 } }
    itemLevelRangesByMaterial[Materials.DREAM_SHARD] = { uncommon = { minItemLevel = 152, maxItemLevel = 200 }, rare = { minItemLevel = 167, maxItemLevel = 200 } }
    itemLevelRangesByMaterial[Materials.ABYSS_CRYSTAL] = { epic = { minItemLevel = 165, maxItemLevel = 284 } }
end

if DisenchantBuddy.IsCata or DisenchantBuddy.IsMoP then
    itemLevelRangesByMaterial[Materials.HYPNOTIC_DUST] = { uncommon = { minItemLevel = 201, maxItemLevel = 333 } }
    itemLevelRangesByMaterial[Materials.LESSER_CELESTIAL_ESSENCE] = { uncommon = { minItemLevel = 201, maxItemLevel = 289 } }
    itemLevelRangesByMaterial[Materials.GREATER_CELESTIAL_ESSENCE] = { uncommon = { minItemLevel = 290, maxItemLevel = 333 } }
    itemLevelRangesByMaterial[Materials.SMALL_HEAVENLY_SHARD] = { rare = { minItemLevel = 201, maxItemLevel = 316 } }
    itemLevelRangesByMaterial[Materials.HEAVENLY_SHARD] = { rare = { minItemLevel = 317, maxItemLevel = 377 } }
    itemLevelRangesByMaterial[Materials.MAELSTROM_CRYSTAL] = { epic = { minItemLevel = 285, maxItemLevel = 416 } }
end

if DisenchantBuddy.IsMoP then
    itemLevelRangesByMaterial[Materials.SPIRIT_DUST] = { uncommon = { minItemLevel = 334, maxItemLevel = 437 } }
    itemLevelRangesByMaterial[Materials.MYSTERIOUS_ESSENCE] = { uncommon = { minItemLevel = 334, maxItemLevel = 437 } }
    itemLevelRangesByMaterial[Materials.SMALL_ETHEREAL_SHARD] = { rare = { minItemLevel = 378, maxItemLevel = 424 } }
    itemLevelRangesByMaterial[Materials.ETHEREAL_SHARD] = { rare = { minItemLevel = 425, maxItemLevel = 476 } }
    itemLevelRangesByMaterial[Materials.SHA_CRYSTAL] = { rare = { minItemLevel = 417, maxItemLevel = 572 } }
end


---Adds the item level ranges to an enchanting material's tooltip
---@param tooltip GameTooltip
---@param itemId number
function DisenchantBuddy.AddMaterialInfo(tooltip, itemId)
    if (not itemLevelRangesByMaterial[itemId]) then
        return
    end

    tooltip:AddLine(L["Disenchanted from:"])
    local ranges = itemLevelRangesByMaterial[itemId]
    local uncommon = ranges.uncommon
    if (uncommon) then
        tooltip:AddDoubleLine(Colors.GOOD .. "  Item Level|r",
            uncommon.minItemLevel .. "-" .. uncommon.maxItemLevel)
    end
    local rare = ranges.rare
    if (rare) then
        tooltip:AddDoubleLine(Colors.RARE .. "  Item Level|r",
            rare.minItemLevel .. "-" .. rare.maxItemLevel)
    end
    local epic = ranges.epic
    if (epic) then
        tooltip:AddDoubleLine(Colors.EPIC .. "  Item Level|r",
            epic.minItemLevel .. "-" .. epic.maxItemLevel)
    end
    tooltip:Show()
end
