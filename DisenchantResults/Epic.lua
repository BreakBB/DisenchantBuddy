---@type DisenchantBuddy
local _, DisenchantBuddy = ...

local Materials = DisenchantBuddy.Materials

---@param itemLevel number
---@return table<DisenchantResult>|nil Disenchant results
function DisenchantBuddy.GetMaterialsForEpicItem(itemLevel)
    if itemLevel <= 45 then
        return {{itemId = Materials.SMALL_RADIANT_SHARD, probability = 100, minQuantity = 2, maxQuantity = 4}}
    elseif itemLevel <= 50 then
        return {{itemId = Materials.LARGE_RADIANT_SHARD, probability = 100, minQuantity = 2, maxQuantity = 4}}
    elseif itemLevel <= 55 then
        return {{itemId = Materials.SMALL_BRILLIANT_SHARD, probability = 100, minQuantity = 2, maxQuantity = 4}}
    elseif itemLevel <= 60 then
        return {{itemId = Materials.NEXUS_CRYSTAL, probability = 100, minQuantity = 1, maxQuantity = 1}}
    elseif itemLevel <= 92 then
        return {{itemId = Materials.NEXUS_CRYSTAL, probability = 100, minQuantity = 1, maxQuantity = 2}}
    else
        return nil
    end
end
