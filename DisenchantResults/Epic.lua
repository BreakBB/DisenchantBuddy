---@type DisenchantBuddy
local _, DisenchantBuddy = ...

local Materials = DisenchantBuddy.Materials

---@param itemLevel number
---@return table<DisenchantResult>|nil Disenchant results
function DisenchantBuddy.GetMaterialsForEpicItem(itemLevel)
    if itemLevel <= 45 then
        return {Materials.SMALL_RADIANT_SHARD}
    elseif itemLevel <= 50 then
        return {Materials.LARGE_RADIANT_SHARD}
    elseif itemLevel <= 55 then
        return {Materials.SMALL_BRILLIANT_SHARD}
    elseif itemLevel <= 65 then
        return {{itemId = Materials.NEXUS_CRYSTAL, probability = 100}}
    else
        return nil
    end
end
