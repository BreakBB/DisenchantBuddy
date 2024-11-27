---@type DisenchantBuddy
local _, DisenchantBuddy = ...

local Materials = DisenchantBuddy.Materials

---@param itemLevel number
---@return table<ItemId>|nil Disenchant results
function DisenchantBuddy.GetMaterialsForRareItem(itemLevel)
    if itemLevel <= 25 then
        return {Materials.SMALL_GLIMMERING_SHARD}
    elseif itemLevel <= 30 then
        return {Materials.LARGE_GLIMMERING_SHARD}
    elseif itemLevel <= 35 then
        return {Materials.SMALL_GLOWING_SHARD}
    elseif itemLevel <= 40 then
        return {Materials.LARGE_GLOWING_SHARD}
    elseif itemLevel <= 45 then
        return {Materials.SMALL_RADIANT_SHARD}
    elseif itemLevel <= 50 then
        return {Materials.LARGE_RADIANT_SHARD}
    elseif itemLevel <= 55 then
        return {Materials.SMALL_BRILLIANT_SHARD}
    elseif itemLevel <= 65 then
        return {Materials.LARGE_BRILLIANT_SHARD, Materials.NEXUS_CRYSTAL}
    else
        return nil
    end
end
