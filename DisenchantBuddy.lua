local DisenchantBuddy = {}

local function AddDisenchantInfo(tooltip, itemLink)
    -- TODO: Add disenchant info to tooltip

    local _, _, quality, itemLevel, _, itemType = GetItemInfo(itemLink)

    if quality == Enum.ItemQuality.Poor then
        return false
    end

    local disenchantResults = {}

    if itemLevel <= 15 then
        table.insert(disenchantResults, "Strange Dust")
        table.insert(disenchantResults, "Lesser Magic Essence")
    end

    tooltip:AddLine("Disenchant results:")
    for _, result in ipairs(disenchantResults) do
        tooltip:AddLine(result, 1, 1, 1) -- White text
    end

    return true
end

function DisenchantBuddy.OnTooltipSetItem(tooltip)
    local _, link = tooltip:GetItem()

    local tooltipAdded = AddDisenchantInfo(tooltip, link)

    if tooltipAdded then
        tooltip:Show()
    end
end

GameTooltip:HookScript("OnTooltipSetItem", DisenchantBuddy.OnTooltipSetItem)

return DisenchantBuddy
