---@type DisenchantBuddy
local _, DisenchantBuddy = ...

local Materials = DisenchantBuddy.Materials

---@param itemLevel number
---@return table<DisenchantResult>|nil Disenchant results
function DisenchantBuddy.GetMaterialsForEpicItem(itemLevel)
    if itemLevel <= 45 then
        return {{itemId = Materials.SMALL_RADIANT_SHARD, probability = 100}}
    elseif itemLevel <= 50 then
        return {{itemId = Materials.LARGE_RADIANT_SHARD, probability = 100}}
    elseif itemLevel <= 55 then
        return {{itemId = Materials.SMALL_BRILLIANT_SHARD, probability = 100}}
    elseif itemLevel <= 65 then
        return {{itemId = Materials.NEXUS_CRYSTAL, probability = 100, minQuantity = 1, maxQuantity = 1}}
    else
        return nil
    end
end
