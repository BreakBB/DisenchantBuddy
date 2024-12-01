---@type DisenchantBuddy
local _, DisenchantBuddy = ...

local Materials = DisenchantBuddy.Materials

---@param itemLevel number
---@return table<DisenchantResult>|nil Disenchant results
function DisenchantBuddy.GetMaterialsForRareItem(itemLevel)
    if itemLevel <= 25 then
        return {{itemId = Materials.SMALL_GLIMMERING_SHARD, probability = 100}}
    elseif itemLevel <= 30 then
        return {{itemId = Materials.LARGE_GLIMMERING_SHARD, probability = 100}}
    elseif itemLevel <= 35 then
        return {{itemId = Materials.SMALL_GLOWING_SHARD, probability = 100}}
    elseif itemLevel <= 40 then
        return {{itemId = Materials.LARGE_GLOWING_SHARD, probability = 100}}
    elseif itemLevel <= 45 then
        return {{itemId = Materials.SMALL_RADIANT_SHARD, probability = 100}}
    elseif itemLevel <= 50 then
        return {{itemId = Materials.LARGE_RADIANT_SHARD, probability = 100}}
    elseif itemLevel <= 55 then
        return {{itemId = Materials.SMALL_BRILLIANT_SHARD, probability = 100}}
    elseif itemLevel <= 65 then
        return {
            {itemId = Materials.LARGE_BRILLIANT_SHARD, probability = 99.5},
            {itemId = Materials.NEXUS_CRYSTAL, probability = 0.5},
        }
    else
        return nil
    end
end
