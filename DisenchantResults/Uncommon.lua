---@type DisenchantBuddy
local _, DisenchantBuddy = ...

local Materials = DisenchantBuddy.Materials

---@param itemLevel number
---@return table<DisenchantResult>|nil Disenchant results
function DisenchantBuddy.GetMaterialsForUncommonArmor(itemLevel)
    if itemLevel <= 15 then
        return {
            {itemId = Materials.STRANGE_DUST, probability = 80, minQuantity = 1, maxQuantity = 2},
            {itemId = Materials.LESSER_MAGIC_ESSENCE, probability = 20, minQuantity = 1, maxQuantity = 2}
        }
    elseif itemLevel <= 20 then
        return {
            {itemId = Materials.STRANGE_DUST, probability = 75, minQuantity = 2, maxQuantity = 3},
            {itemId = Materials.GREATER_MAGIC_ESSENCE, probability = 20, minQuantity = 1, maxQuantity = 2},
            {itemId = Materials.SMALL_GLIMMERING_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
        }
    elseif itemLevel <= 25 then
        return {
            {itemId = Materials.STRANGE_DUST, probability = 75, minQuantity = 4, maxQuantity = 6},
            {itemId = Materials.LESSER_ASTRAL_ESSENCE, probability = 15, minQuantity = 1, maxQuantity = 2},
            {itemId = Materials.SMALL_GLIMMERING_SHARD, probability = 10, minQuantity = 1, maxQuantity = 1}
        }
    elseif itemLevel <= 30 then
        return {
            {itemId = Materials.SOUL_DUST, probability = 75, minQuantity = 1, maxQuantity = 2},
            {itemId = Materials.GREATER_ASTRAL_ESSENCE, probability = 20, minQuantity = 1, maxQuantity = 2},
            {itemId = Materials.LARGE_GLIMMERING_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
        }
    elseif itemLevel <= 35 then
        return {
            {itemId = Materials.SOUL_DUST, probability = 75, minQuantity = 2, maxQuantity = 5},
            {itemId = Materials.LESSER_MYSTIC_ESSENCE, probability = 20, minQuantity = 1, maxQuantity = 2},
            {itemId = Materials.SMALL_GLOWING_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
        }
    elseif itemLevel <= 40 then
        return {
            {itemId = Materials.VISION_DUST, probability = 75, minQuantity = 1, maxQuantity = 2},
            {itemId = Materials.GREATER_MYSTIC_ESSENCE, probability = 20, minQuantity = 1, maxQuantity = 2},
            {itemId = Materials.LARGE_GLOWING_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
        }
    elseif itemLevel <= 45 then
        return {
            {itemId = Materials.VISION_DUST, probability = 75, minQuantity = 2, maxQuantity = 5},
            {itemId = Materials.LESSER_NETHER_ESSENCE, probability = 20, minQuantity = 1, maxQuantity = 2},
            {itemId = Materials.SMALL_RADIANT_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
        }
    elseif itemLevel <= 50 then
        return {
            {itemId = Materials.DREAM_DUST, probability = 75, minQuantity = 1, maxQuantity = 2},
            {itemId = Materials.GREATER_NETHER_ESSENCE, probability = 20, minQuantity = 1, maxQuantity = 2},
            {itemId = Materials.LARGE_RADIANT_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
        }
    elseif itemLevel <= 55 then
        return {
            {itemId = Materials.DREAM_DUST, probability = 75, minQuantity = 2, maxQuantity = 5},
            {itemId = Materials.LESSER_ETERNAL_ESSENCE, probability = 20, minQuantity = 1, maxQuantity = 2},
            {itemId = Materials.SMALL_BRILLIANT_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
        }
    elseif itemLevel <= 60 then
        return {
            {itemId = Materials.ILLUSION_DUST, probability = 75, minQuantity = 1, maxQuantity = 2},
            {itemId = Materials.GREATER_ETERNAL_ESSENCE, probability = 20, minQuantity = 1, maxQuantity = 2},
            {itemId = Materials.LARGE_BRILLIANT_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
        }
    elseif itemLevel <= 65 then
        return {
            {itemId = Materials.ILLUSION_DUST, probability = 75, minQuantity = 2, maxQuantity = 5},
            {itemId = Materials.GREATER_ETERNAL_ESSENCE, probability = 20, minQuantity = 2, maxQuantity = 3},
            {itemId = Materials.LARGE_BRILLIANT_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
        }
    elseif itemLevel == 79 then
        return {
            {itemId = Materials.ARCANE_DUST, probability = 75, minQuantity = 1, maxQuantity = 2},
            {itemId = Materials.LESSER_PLANAR_ESSENCE, probability = 22, minQuantity = 1, maxQuantity = 2},
            {itemId = Materials.SMALL_PRISMATIC_SHARD, probability = 3, minQuantity = 1, maxQuantity = 1}
        }
    elseif itemLevel <= 99 then
        return {
            {itemId = Materials.ARCANE_DUST, probability = 75, minQuantity = 2, maxQuantity = 3},
            {itemId = Materials.LESSER_PLANAR_ESSENCE, probability = 22, minQuantity = 2, maxQuantity = 3},
            {itemId = Materials.SMALL_PRISMATIC_SHARD, probability = 3, minQuantity = 1, maxQuantity = 1}
        }
    elseif itemLevel <= 120 then
        return {
            {itemId = Materials.ARCANE_DUST, probability = 75, minQuantity = 2, maxQuantity = 5},
            {itemId = Materials.GREATER_PLANAR_ESSENCE, probability = 22, minQuantity = 1, maxQuantity = 2},
            {itemId = Materials.LARGE_PRISMATIC_SHARD, probability = 3, minQuantity = 1, maxQuantity = 1}
        }
    elseif itemLevel <= 151 then
        return {
            {itemId = Materials.INFINITE_DUST, probability = 75, minQuantity = 2, maxQuantity = 3},
            {itemId = Materials.LESSER_COSMIC_ESSENCE, probability = 22, minQuantity = 1, maxQuantity = 2},
            {itemId = Materials.SMALL_DREAM_SHARD, probability = 3, minQuantity = 1, maxQuantity = 1}
        }
    elseif itemLevel <= 200 then
        return {
            {itemId = Materials.INFINITE_DUST, probability = 75, minQuantity = 4, maxQuantity = 7},
            {itemId = Materials.GREATER_COSMIC_ESSENCE, probability = 22, minQuantity = 1, maxQuantity = 2},
            {itemId = Materials.DREAM_SHARD, probability = 3, minQuantity = 1, maxQuantity = 1}
        }
    elseif itemLevel <= 333 then
        return {
            {itemId = Materials.HYPNOTIC_DUST, probability = 75, minQuantity = 1, maxQuantity = 5},
            {itemId = Materials.LESSER_CELESTIAL_ESSENCE, probability = 25, minQuantity = 1, maxQuantity = 3}
        }
    else
        return nil
    end
end

---@param itemLevel number
---@return table<DisenchantResult>|nil Disenchant results
function DisenchantBuddy.GetMaterialsForUncommonWeapons(itemLevel)
    if itemLevel <= 15 then
        return {
            {itemId = Materials.LESSER_MAGIC_ESSENCE, probability = 80, minQuantity = 1, maxQuantity = 2},
            {itemId = Materials.STRANGE_DUST, probability = 20, minQuantity = 1, maxQuantity = 2}
        }
    elseif itemLevel <= 20 then
        return {
            {itemId = Materials.GREATER_MAGIC_ESSENCE, probability = 75, minQuantity = 1, maxQuantity = 2},
            {itemId = Materials.STRANGE_DUST, probability = 20, minQuantity = 2, maxQuantity = 3},
            {itemId = Materials.SMALL_GLIMMERING_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
        }
    elseif itemLevel <= 25 then
        return {
            {itemId = Materials.GREATER_MAGIC_ESSENCE, probability = 75, minQuantity = 1, maxQuantity = 2},
            {itemId = Materials.STRANGE_DUST, probability = 15, minQuantity = 4, maxQuantity = 6},
            {itemId = Materials.SMALL_GLIMMERING_SHARD, probability = 10, minQuantity = 1, maxQuantity = 1}
        }
    elseif itemLevel <= 30 then
        return {
            {itemId = Materials.GREATER_MAGIC_ESSENCE, probability = 75, minQuantity = 1, maxQuantity = 2},
            {itemId = Materials.SOUL_DUST, probability = 20, minQuantity = 1, maxQuantity = 2},
            {itemId = Materials.LARGE_GLIMMERING_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
        }
    elseif itemLevel <= 35 then
        return {
            {itemId = Materials.LESSER_MYSTIC_ESSENCE, probability = 75, minQuantity = 1, maxQuantity = 2},
            {itemId = Materials.SOUL_DUST, probability = 20, minQuantity = 2, maxQuantity = 5},
            {itemId = Materials.SMALL_GLOWING_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
        }
    elseif itemLevel <= 40 then
        return {
            {itemId = Materials.GREATER_MYSTIC_ESSENCE, probability = 75, minQuantity = 1, maxQuantity = 2},
            {itemId = Materials.VISION_DUST, probability = 20, minQuantity = 1, maxQuantity = 2},
            {itemId = Materials.LARGE_GLOWING_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
        }
    elseif itemLevel <= 45 then
        return {
            {itemId = Materials.LESSER_NETHER_ESSENCE, probability = 75, minQuantity = 1, maxQuantity = 2},
            {itemId = Materials.VISION_DUST, probability = 20, minQuantity = 2, maxQuantity = 5},
            {itemId = Materials.SMALL_RADIANT_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
        }
    elseif itemLevel <= 50 then
        return {
            {itemId = Materials.GREATER_NETHER_ESSENCE, probability = 75, minQuantity = 1, maxQuantity = 2},
            {itemId = Materials.DREAM_DUST, probability = 20, minQuantity = 1, maxQuantity = 2},
            {itemId = Materials.LARGE_RADIANT_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
        }
    elseif itemLevel <= 55 then
        return {
            {itemId = Materials.LESSER_ETERNAL_ESSENCE, probability = 75, minQuantity = 1, maxQuantity = 2},
            {itemId = Materials.DREAM_DUST, probability = 20, minQuantity = 2, maxQuantity = 5},
            {itemId = Materials.SMALL_BRILLIANT_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
        }
    elseif itemLevel <= 60 then
        return {
            {itemId = Materials.GREATER_ETERNAL_ESSENCE, probability = 75, minQuantity = 1, maxQuantity = 2},
            {itemId = Materials.ILLUSION_DUST, probability = 20, minQuantity = 1, maxQuantity = 2},
            {itemId = Materials.LARGE_BRILLIANT_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
        }
    elseif itemLevel <= 65 then
        return {
            {itemId = Materials.GREATER_ETERNAL_ESSENCE, probability = 75, minQuantity = 2, maxQuantity = 3},
            {itemId = Materials.ILLUSION_DUST, probability = 20, minQuantity = 2, maxQuantity = 5},
            {itemId = Materials.LARGE_BRILLIANT_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
        }
    elseif itemLevel <= 99 then
        return {
            {itemId = Materials.LESSER_PLANAR_ESSENCE, probability = 75, minQuantity = 2, maxQuantity = 3},
            {itemId = Materials.ARCANE_DUST, probability = 22, minQuantity = 2, maxQuantity = 3},
            {itemId = Materials.SMALL_PRISMATIC_SHARD, probability = 3, minQuantity = 1, maxQuantity = 1}
        }
    elseif itemLevel <= 120 then
        return {
            {itemId = Materials.GREATER_PLANAR_ESSENCE, probability = 75, minQuantity = 1, maxQuantity = 2},
            {itemId = Materials.ARCANE_DUST, probability = 22, minQuantity = 2, maxQuantity = 5},
            {itemId = Materials.LARGE_PRISMATIC_SHARD, probability = 3, minQuantity = 1, maxQuantity = 1}
        }
    elseif itemLevel <= 151 then
        return {
            {itemId = Materials.LESSER_COSMIC_ESSENCE, probability = 75, minQuantity = 1, maxQuantity = 2},
            {itemId = Materials.INFINITE_DUST, probability = 22, minQuantity = 2, maxQuantity = 3},
            {itemId = Materials.SMALL_DREAM_SHARD, probability = 3, minQuantity = 1, maxQuantity = 1}
        }
    elseif itemLevel <= 200 then
        return {
            {itemId = Materials.GREATER_COSMIC_ESSENCE, probability = 75, minQuantity = 1, maxQuantity = 2},
            {itemId = Materials.INFINITE_DUST, probability = 22, minQuantity = 4, maxQuantity = 7},
            {itemId = Materials.DREAM_SHARD, probability = 3, minQuantity = 1, maxQuantity = 1}
        }
    elseif itemLevel <= 289 then
        return {
            {itemId = Materials.LESSER_CELESTIAL_ESSENCE, probability = 20, minQuantity = 1, maxQuantity = 5},
            {itemId = Materials.HYPNOTIC_DUST, probability = 80, minQuantity = 1, maxQuantity = 5},
        }
    elseif itemLevel <= 305 then
        return {
            {itemId = Materials.LESSER_CELESTIAL_ESSENCE, probability = 20, minQuantity = 2, maxQuantity = 7},
            {itemId = Materials.HYPNOTIC_DUST, probability = 80, minQuantity = 1, maxQuantity = 6},
        }
    elseif itemLevel <= 317 then
        return {
            {itemId = Materials.GREATER_CELESTIAL_ESSENCE, probability = 20, minQuantity = 1, maxQuantity = 6},
            {itemId = Materials.HYPNOTIC_DUST, probability = 80, minQuantity = 2, maxQuantity = 8},
        }
    elseif itemLevel == 318 then
        return {
            {itemId = Materials.GREATER_CELESTIAL_ESSENCE, probability = 20, minQuantity = 2, maxQuantity = 6},
            {itemId = Materials.HYPNOTIC_DUST, probability = 80, minQuantity = 2, maxQuantity = 8},
        }
    else
        return nil
    end
end
