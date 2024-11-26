local DisenchantBuddy = {}

---@param tooltip GameTooltip
---@param itemLink string
---@return boolean True if tooltip was added, false otherwise
local function AddDisenchantInfo(tooltip, itemLink)
    -- TODO: Add disenchant info to tooltip

    local _, _, quality, itemLevel, _, _, _, _, _, _, _, classId = GetItemInfo(itemLink)

    if quality == Enum.ItemQuality.Poor or
            quality == Enum.ItemQuality.Standard or
            (classId ~= Enum.ItemClass.Armor and classId ~= Enum.ItemClass.Weapon) then
        return false
    end

    local disenchantResults = {}

    if itemLevel <= 15 then
        table.insert(disenchantResults, "Strange Dust")
        table.insert(disenchantResults, "Lesser Magic Essence")
    elseif itemLevel <= 20 then
        table.insert(disenchantResults, "Strange Dust")
        table.insert(disenchantResults, "Greater Magic Essence")
    elseif itemLevel <= 25 then
        table.insert(disenchantResults, "Strange Dust")
        table.insert(disenchantResults, "Lesser Astral Essence")
        table.insert(disenchantResults, "Small Glimmering Shard")
    elseif itemLevel <= 30 then
        table.insert(disenchantResults, "Soul Dust")
        table.insert(disenchantResults, "Greater Astral Essence")
        table.insert(disenchantResults, "Large Glimmering Shard")
    elseif itemLevel <= 35 then
        table.insert(disenchantResults, "Soul Dust")
        table.insert(disenchantResults, "Lesser Mystic Essence")
        table.insert(disenchantResults, "Small Glowing Shard")
    elseif itemLevel <= 40 then
        table.insert(disenchantResults, "Vision Dust")
        table.insert(disenchantResults, "Greater Mystic Essence")
        table.insert(disenchantResults, "Large Glowing Shard")
    elseif itemLevel <= 45 then
        table.insert(disenchantResults, "Vision Dust")
        table.insert(disenchantResults, "Lesser Nether Essence")
        table.insert(disenchantResults, "Small Radiant Shard")
    elseif itemLevel <= 50 then
        table.insert(disenchantResults, "Dream Dust")
        table.insert(disenchantResults, "Greater Nether Essence")
        table.insert(disenchantResults, "Large Radiant Shard")
    elseif itemLevel <= 55 then
        table.insert(disenchantResults, "Dream Dust")
        table.insert(disenchantResults, "Lesser Eternal Essence")
        table.insert(disenchantResults, "Small Brilliant Shard")
    elseif itemLevel <= 60 then
        table.insert(disenchantResults, "Illusion Dust")
        table.insert(disenchantResults, "Greater Eternal Essence")
        table.insert(disenchantResults, "Large Brilliant Shard")
    elseif itemLevel <= 65 then
        table.insert(disenchantResults, "Illusion Dust")
        table.insert(disenchantResults, "Greater Eternal Essence")
        table.insert(disenchantResults, "Large Brilliant Shard")
    end

    tooltip:AddLine("Disenchant results:")
    for _, result in ipairs(disenchantResults) do
        tooltip:AddLine(result, 1, 1, 1) -- White text
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
