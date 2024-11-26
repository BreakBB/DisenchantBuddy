local DisenchantBuddy = {}

local function AddDisenchantInfo(tooltip, itemLink)
    -- TODO: Add disenchant info to tooltip

    local _, _, quality, itemLevel, _, itemType = GetItemInfo(itemLink)

    local disenchantResults = {}

    if itemLevel <= 15 then
        table.insert(disenchantResults, "Strange Dust")
        table.insert(disenchantResults, "Lesser Magic Essence")
    end

    tooltip:AddLine("Disenchant results:")
    for _, result in ipairs(disenchantResults) do
        tooltip:AddLine(result, 1, 1, 1) -- White text
    end
end

function DisenchantBuddy.OnTooltipSetItem(tooltip)
    local _, link = tooltip:GetItem()

    AddDisenchantInfo(tooltip, link)

    tooltip:Show()
end

GameTooltip:HookScript("OnTooltipSetItem", DisenchantBuddy.OnTooltipSetItem)

return DisenchantBuddy
