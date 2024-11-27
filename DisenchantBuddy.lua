---@class DisenchantBuddy
local _, DisenchantBuddy = ...

local Materials = DisenchantBuddy.Materials

---@param itemLevel number
---@return table<string>|nil Disenchant results
local function GetUncommonDisenchantResults(itemLevel)
    if itemLevel <= 15 then
        return {Materials.STRANGE_DUST, Materials.LESSER_MAGIC_ESSENCE}
    elseif itemLevel <= 20 then
        return {Materials.STRANGE_DUST, Materials.GREATER_MAGIC_ESSENCE}
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

---@param itemLevel number
---@return table<string>|nil Disenchant results
local function GetRareDisenchantResults(itemLevel)
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

---@param itemLevel number
---@return table<string>|nil Disenchant results
local function GetEpicDisenchantResults(itemLevel)
    if itemLevel <= 45 then
        return {Materials.SMALL_RADIANT_SHARD}
    elseif itemLevel <= 50 then
        return {Materials.LARGE_RADIANT_SHARD}
    elseif itemLevel <= 55 then
        return {Materials.SMALL_BRILLIANT_SHARD}
    elseif itemLevel <= 65 then
        return {Materials.NEXUS_CRYSTAL}
    else
        return nil
    end
end

---@param tooltip GameTooltip
---@param itemLink string
---@return boolean True if tooltip was added, false otherwise
local function AddDisenchantInfo(tooltip, itemLink)
    local _, _, quality, itemLevel, _, _, _, _, _, _, _, classId = GetItemInfo(itemLink)

    if quality == Enum.ItemQuality.Poor or
            quality == Enum.ItemQuality.Standard or
            quality == Enum.ItemQuality.Legendary or
            (classId ~= Enum.ItemClass.Armor and classId ~= Enum.ItemClass.Weapon) then
        return false
    end

    local disenchantResults
    if quality == Enum.ItemQuality.Good then
        disenchantResults = GetUncommonDisenchantResults(itemLevel)
    elseif quality == Enum.ItemQuality.Rare then
        disenchantResults = GetRareDisenchantResults(itemLevel)
    elseif quality == Enum.ItemQuality.Epic then
        disenchantResults = GetEpicDisenchantResults(itemLevel)
    end

    if (not disenchantResults) then
        -- No disenchant results for this item, e.g. itemLevel too high
        return false
    end

    tooltip:AddLine("Disenchant results:")
    for _, result in ipairs(disenchantResults) do
        local name = GetItemInfo(result)
        tooltip:AddLine(name, 1, 1, 1) -- White text
    end

    return true
end

---@param tooltip GameTooltip
function DisenchantBuddy.OnTooltipSetItem(tooltip)
    local _, link = tooltip:GetItem()

    local tooltipAdded = AddDisenchantInfo(tooltip, link)

    if tooltipAdded then
        tooltip:Show()
    end
end

GameTooltip:HookScript("OnTooltipSetItem", DisenchantBuddy.OnTooltipSetItem)

return DisenchantBuddy
