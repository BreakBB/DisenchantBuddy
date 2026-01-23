---@class DisenchantBuddy
local DisenchantBuddy = select(2, ...)

local Materials = DisenchantBuddy.Materials

---@param itemLevel number
---@return table<DisenchantResult>|nil Disenchant results
function DisenchantBuddy.GetMaterialsForRareItem(itemLevel)
    if itemLevel <= 25 then
        return {{itemId = Materials.SMALL_GLIMMERING_SHARD, probability = 100, minQuantity = 1, maxQuantity = 1}}
    elseif itemLevel <= 30 then
        return {{itemId = Materials.LARGE_GLIMMERING_SHARD, probability = 100, minQuantity = 1, maxQuantity = 1}}
    elseif itemLevel <= 35 then
        return {{itemId = Materials.SMALL_GLOWING_SHARD, probability = 100, minQuantity = 1, maxQuantity = 1}}
    elseif itemLevel <= 40 then
        return {{itemId = Materials.LARGE_GLOWING_SHARD, probability = 100, minQuantity = 1, maxQuantity = 1}}
    elseif itemLevel <= 45 then
        return {{itemId = Materials.SMALL_RADIANT_SHARD, probability = 100, minQuantity = 1, maxQuantity = 1}}
    elseif itemLevel <= 50 then
        return {{itemId = Materials.LARGE_RADIANT_SHARD, probability = 100, minQuantity = 1, maxQuantity = 1}}
    elseif itemLevel <= 55 then
        return {{itemId = Materials.SMALL_BRILLIANT_SHARD, probability = 100, minQuantity = 1, maxQuantity = 1}}
    elseif itemLevel <= 86 then
        return {
            {itemId = Materials.LARGE_BRILLIANT_SHARD, probability = 99.5, minQuantity = 1, maxQuantity = 1},
            {itemId = Materials.NEXUS_CRYSTAL, probability = 0.5, minQuantity = 1, maxQuantity = 1},
        }
    elseif itemLevel <= 99 then
        return {
            {itemId = Materials.SMALL_PRISMATIC_SHARD, probability = 99.5, minQuantity = 1, maxQuantity = 1},
            {itemId = Materials.NEXUS_CRYSTAL, probability = 0.5, minQuantity = 1, maxQuantity = 1},
        }
    elseif itemLevel <= 115 then
        return {
            {itemId = Materials.LARGE_PRISMATIC_SHARD, probability = 99.5, minQuantity = 1, maxQuantity = 1},
            {itemId = Materials.VOID_CRYSTAL, probability = 0.5, minQuantity = 1, maxQuantity = 1},
        }
    elseif itemLevel <= 166 then
        return {{itemId = Materials.SMALL_DREAM_SHARD, probability = 100, minQuantity = 1, maxQuantity = 1}}
    elseif itemLevel <= 200 then
        return {{itemId = Materials.DREAM_SHARD, probability = 100, minQuantity = 1, maxQuantity = 1}}
    elseif itemLevel <= 316 then
        return {{itemId = Materials.SMALL_HEAVENLY_SHARD, probability = 100, minQuantity = 1, maxQuantity = 2}}
    elseif itemLevel <= 377 then
        return {{itemId = Materials.HEAVENLY_SHARD, probability = 100, minQuantity = 1, maxQuantity = 2}}
    elseif itemLevel <= 424 then
        return {{itemId = Materials.SMALL_ETHEREAL_SHARD, probability = 100, minQuantity = 1, maxQuantity = 1}}
    elseif itemLevel <= 476 then
        return {{itemId = Materials.ETHEREAL_SHARD, probability = 100, minQuantity = 1, maxQuantity = 2}}
    else
        return nil
    end
end
