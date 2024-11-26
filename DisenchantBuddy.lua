local DisenchantBuddy = {}

---@param tooltip GameTooltip
---@param itemLink string
---@return boolean True if tooltip was added, false otherwise
local function AddDisenchantInfo(tooltip, itemLink)
    -- TODO: Add disenchant info to tooltip

    local _, _, quality, itemLevel, _, itemType = GetItemInfo(itemLink)

    if quality == Enum.ItemQuality.Poor or
            quality == Enum.ItemQuality.Common or
            (itemType ~= Enum.ItemClass.Armor and itemType ~= Enum.ItemClass.Weapon) then
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
