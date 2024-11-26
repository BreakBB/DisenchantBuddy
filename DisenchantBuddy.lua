local DisenchantBuddy = {}

local function AddDisenchantInfo(tooltip, itemLink)
    -- TODO: Add disenchant info to tooltip
end

function DisenchantBuddy.OnTooltipSetItem(tooltip)
    local _, link = tooltip:GetItem()

    AddDisenchantInfo(tooltip, link)

    tooltip:Show()
end

GameTooltip:HookScript("OnTooltipSetItem", DisenchantBuddy.OnTooltipSetItem)

return DisenchantBuddy
