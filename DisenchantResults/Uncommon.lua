---@type DisenchantBuddy
local _, DisenchantBuddy = ...

local Materials = DisenchantBuddy.Materials

---@param itemLevel number
---@return table<DisenchantResult>|nil Disenchant results
function DisenchantBuddy.GetMaterialsForUncommonArmor(itemLevel)
    if itemLevel <= 15 then
        return {
            {itemId = Materials.STRANGE_DUST, probability = 80},
            {itemId = Materials.LESSER_MAGIC_ESSENCE, probability = 20}
        }
    elseif itemLevel <= 20 then
        return {
            {itemId = Materials.STRANGE_DUST, probability = 75},
            {itemId = Materials.GREATER_MAGIC_ESSENCE, probability = 20},
            {itemId = Materials.SMALL_GLIMMERING_SHARD, probability = 5}
        }
    elseif itemLevel <= 25 then
        return {
            {itemId = Materials.STRANGE_DUST, probability = 75},
            {itemId = Materials.LESSER_ASTRAL_ESSENCE, probability = 15},
            {itemId = Materials.SMALL_GLIMMERING_SHARD, probability = 10}
        }
    elseif itemLevel <= 30 then
        return {
            {itemId = Materials.SOUL_DUST, probability = 75},
            {itemId = Materials.GREATER_ASTRAL_ESSENCE, probability = 20},
            {itemId = Materials.LARGE_GLIMMERING_SHARD, probability = 5}
        }
    elseif itemLevel <= 35 then
        return {
            {itemId = Materials.SOUL_DUST, probability = 75},
            {itemId = Materials.LESSER_MYSTIC_ESSENCE, probability = 20},
            {itemId = Materials.SMALL_GLOWING_SHARD, probability = 5}
        }
    elseif itemLevel <= 40 then
        return {
            {itemId = Materials.VISION_DUST, probability = 75},
            {itemId = Materials.GREATER_MYSTIC_ESSENCE, probability = 20},
            {itemId = Materials.LARGE_GLOWING_SHARD, probability = 5}
        }
    elseif itemLevel <= 45 then
        return {
            {itemId = Materials.VISION_DUST, probability = 75},
            {itemId = Materials.LESSER_NETHER_ESSENCE, probability = 20},
            {itemId = Materials.SMALL_RADIANT_SHARD, probability = 5}
        }
    elseif itemLevel <= 50 then
        return {
            {itemId = Materials.DREAM_DUST, probability = 75},
            {itemId = Materials.GREATER_NETHER_ESSENCE, probability = 20},
            {itemId = Materials.LARGE_RADIANT_SHARD, probability = 5}
        }
    elseif itemLevel <= 55 then
        return {
            {itemId = Materials.DREAM_DUST, probability = 75},
            {itemId = Materials.LESSER_ETERNAL_ESSENCE, probability = 20},
            {itemId = Materials.SMALL_BRILLIANT_SHARD, probability = 5}
        }
    elseif itemLevel <= 60 then
        return {
            {itemId = Materials.ILLUSION_DUST, probability = 75},
            {itemId = Materials.GREATER_ETERNAL_ESSENCE, probability = 20},
            {itemId = Materials.LARGE_BRILLIANT_SHARD, probability = 5}
        }
    elseif itemLevel <= 65 then
        return {
            {itemId = Materials.ILLUSION_DUST, probability = 75},
            {itemId = Materials.GREATER_ETERNAL_ESSENCE, probability = 20},
            {itemId = Materials.LARGE_BRILLIANT_SHARD, probability = 5}
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
            {itemId = Materials.STRANGE_DUST, probability = 80},
            {itemId = Materials.LESSER_MAGIC_ESSENCE, probability = 20}
        }
    elseif itemLevel <= 20 then
        return {
            {itemId = Materials.STRANGE_DUST, probability = 75},
            {itemId = Materials.GREATER_MAGIC_ESSENCE, probability = 20},
            {itemId = Materials.SMALL_GLIMMERING_SHARD, probability = 5}
        }
    elseif itemLevel <= 25 then
        return {
            {itemId = Materials.STRANGE_DUST, probability = 75},
            {itemId = Materials.LESSER_ASTRAL_ESSENCE, probability = 15},
            {itemId = Materials.SMALL_GLIMMERING_SHARD, probability = 10}
        }
    elseif itemLevel <= 30 then
        return {
            {itemId = Materials.SOUL_DUST, probability = 75},
            {itemId = Materials.GREATER_ASTRAL_ESSENCE, probability = 20},
            {itemId = Materials.LARGE_GLIMMERING_SHARD, probability = 5}
        }
    elseif itemLevel <= 35 then
        return {
            {itemId = Materials.SOUL_DUST, probability = 75},
            {itemId = Materials.LESSER_MYSTIC_ESSENCE, probability = 20},
            {itemId = Materials.SMALL_GLOWING_SHARD, probability = 5}
        }
    elseif itemLevel <= 40 then
        return {
            {itemId = Materials.VISION_DUST, probability = 75},
            {itemId = Materials.GREATER_MYSTIC_ESSENCE, probability = 20},
            {itemId = Materials.LARGE_GLOWING_SHARD, probability = 5}
        }
    elseif itemLevel <= 45 then
        return {
            {itemId = Materials.VISION_DUST, probability = 75},
            {itemId = Materials.LESSER_NETHER_ESSENCE, probability = 20},
            {itemId = Materials.SMALL_RADIANT_SHARD, probability = 5}
        }
    elseif itemLevel <= 50 then
        return {
            {itemId = Materials.DREAM_DUST, probability = 75},
            {itemId = Materials.GREATER_NETHER_ESSENCE, probability = 20},
            {itemId = Materials.LARGE_RADIANT_SHARD, probability = 5}
        }
    elseif itemLevel <= 55 then
        return {
            {itemId = Materials.DREAM_DUST, probability = 75},
            {itemId = Materials.LESSER_ETERNAL_ESSENCE, probability = 20},
            {itemId = Materials.SMALL_BRILLIANT_SHARD, probability = 5}
        }
    elseif itemLevel <= 60 then
        return {
            {itemId = Materials.ILLUSION_DUST, probability = 75},
            {itemId = Materials.GREATER_ETERNAL_ESSENCE, probability = 20},
            {itemId = Materials.LARGE_BRILLIANT_SHARD, probability = 5}
        }
    elseif itemLevel <= 65 then
        return {
            {itemId = Materials.ILLUSION_DUST, probability = 75},
            {itemId = Materials.GREATER_ETERNAL_ESSENCE, probability = 20},
            {itemId = Materials.LARGE_BRILLIANT_SHARD, probability = 5}
        }
    else
        return nil
    end
end
