---@class DisenchantBuddy
local _, DisenchantBuddy = ...

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
        disenchantResults = DisenchantBuddy.GetMaterialsForUncommonItem(itemLevel)
    elseif quality == Enum.ItemQuality.Rare then
        disenchantResults = DisenchantBuddy.GetMaterialsForRareItem(itemLevel)
    elseif quality == Enum.ItemQuality.Epic then
        disenchantResults = DisenchantBuddy.GetMaterialsForEpicItem(itemLevel)
    end

    if (not disenchantResults) then
        -- No disenchant results for this item, e.g. itemLevel too high
        return false
    end

    tooltip:AddLine("Disenchant results:")
    for i = 1, #disenchantResults do
        ---@type DisenchantResult
        local result = disenchantResults[i]
        local materialName, _, materialQuality, _, _, _, _, _, _, materialTexture = GetItemInfo(result.itemId)

        local _, _, _, hex = GetItemQualityColor(materialQuality)

        tooltip:AddLine("  |T" .. materialTexture .. ":0|t " .. "|c" .. hex .. materialName .. "|r (" .. result.probability .. "%)")
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
