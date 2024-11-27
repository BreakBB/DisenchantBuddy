---@type DisenchantBuddy
local _, DisenchantBuddy = ...

local Materials = DisenchantBuddy.Materials

---@param itemLevel number
---@return table<DisenchantResult>|nil Disenchant results
function DisenchantBuddy.GetMaterialsForUncommonItem(itemLevel)
    if itemLevel <= 15 then
        return {{itemId = Materials.STRANGE_DUST, probability = 80}, {itemId = Materials.LESSER_MAGIC_ESSENCE, probability = 20}}
    elseif itemLevel <= 20 then
        return {Materials.STRANGE_DUST, Materials.GREATER_MAGIC_ESSENCE, Materials.SMALL_GLIMMERING_SHARD}
    elseif itemLevel <= 25 then
        return {Materials.STRANGE_DUST, Materials.LESSER_ASTRAL_ESSENCE, Materials.SMALL_GLIMMERING_SHARD}
    elseif itemLevel <= 30 then
        return {Materials.SOUL_DUST, Materials.GREATER_ASTRAL_ESSENCE, Materials.LARGE_GLIMMERING_SHARD}
    elseif itemLevel <= 35 then
        return {Materials.SOUL_DUST, Materials.LESSER_MYSTIC_ESSENCE, Materials.SMALL_GLOWING_SHARD}
    elseif itemLevel <= 40 then
        return {Materials.VISION_DUST, Materials.GREATER_MYSTIC_ESSENCE, Materials.LARGE_GLOWING_SHARD}
    elseif itemLevel <= 45 then
        return {Materials.VISION_DUST, Materials.LESSER_NETHER_ESSENCE, Materials.SMALL_RADIANT_SHARD}
    elseif itemLevel <= 50 then
        return {Materials.DREAM_DUST, Materials.GREATER_NETHER_ESSENCE, Materials.LARGE_RADIANT_SHARD}
    elseif itemLevel <= 55 then
        return {Materials.DREAM_DUST, Materials.LESSER_ETERNAL_ESSENCE, Materials.SMALL_BRILLIANT_SHARD}
    elseif itemLevel <= 60 then
        return {Materials.ILLUSION_DUST, Materials.GREATER_ETERNAL_ESSENCE, Materials.LARGE_BRILLIANT_SHARD}
    elseif itemLevel <= 65 then
        return {Materials.ILLUSION_DUST, Materials.GREATER_ETERNAL_ESSENCE, Materials.LARGE_BRILLIANT_SHARD}
    else
        return nil
    end
end
