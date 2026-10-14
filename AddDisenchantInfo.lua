---@class DisenchantBuddy
local DisenchantBuddy = select(2, ...)

local GetItemInfo = C_Item.GetItemInfo or GetItemInfo

local L = DisenchantBuddy.L
local GetTooltipLineData = DisenchantBuddy.GetTooltipLineData

-- "Standard"/"Good" are Classic-only aliases for quality 1/2; clients that identify as
-- WOW_PROJECT_MAINLINE only define the retail names "Common"/"Uncommon" for the same values.
local QUALITY_STANDARD = Enum.ItemQuality.Standard or Enum.ItemQuality.Common
local QUALITY_GOOD = Enum.ItemQuality.Good or Enum.ItemQuality.Uncommon

---@param quality number
---@param classId number
---@param itemLevel number
---@return DisenchantResult|nil
function DisenchantBuddy.GetDisenchantResults(quality, classId, itemLevel)
    if quality == QUALITY_GOOD then
        if classId == Enum.ItemClass.Weapon then
            return DisenchantBuddy.GetMaterialsForUncommonWeapons(itemLevel)
        else
            return DisenchantBuddy.GetMaterialsForUncommonArmor(itemLevel)
        end
    elseif quality == Enum.ItemQuality.Rare then
        return DisenchantBuddy.GetMaterialsForRareItem(itemLevel)
    elseif quality == Enum.ItemQuality.Epic then
        return DisenchantBuddy.GetMaterialsForEpicItem(itemLevel)
    end
    return nil
end

---@param tooltip GameTooltip
---@param itemLink string
function DisenchantBuddy.AddDisenchantInfo(tooltip, itemLink)
    local _, _, quality, itemLevel, _, _, _, _, _, _, _, classId = GetItemInfo(itemLink)

    if quality == Enum.ItemQuality.Poor or
        quality == QUALITY_STANDARD or
        quality == Enum.ItemQuality.Legendary or
        (classId ~= Enum.ItemClass.Armor and classId ~= Enum.ItemClass.Weapon) then
        return
    end

    local disenchantResults = DisenchantBuddy.GetDisenchantResults(quality, classId, itemLevel)

    if (not disenchantResults) then
        -- No disenchant results for this item, e.g. itemLevel too high
        return
    end

    local itemsLoaded = 0
    local totalItems = #disenchantResults
    ---@type TooltipLineData[]
    local lines = {}

    local averageValue = 0
    for i = 1, totalItems do
        ---@type DisenchantResult
        local result = disenchantResults[i]
        local item = Item:CreateFromItemID(result.itemId)
        item:ContinueOnItemLoad(function()
            lines[i] = GetTooltipLineData(item, result)
            if lines[i].auctionValue then
                averageValue = averageValue + (lines[i].auctionValue * result.probability / 100 * ((result.minQuantity + result.maxQuantity) / 2))
            end

            itemsLoaded = itemsLoaded + 1
            if itemsLoaded == totalItems then
                tooltip:AddLine(L["Disenchant results:"])
                for j = 1, totalItems do
                    local line = lines[j]
                    tooltip:AddDoubleLine(line.left, line.right)
                end

                if averageValue > 0 then
                    averageValue = math.floor(averageValue + 0.5) -- Round to nearest copper, because GetCoinTextureString does not handle fractions
                    tooltip:AddDoubleLine(" ", "Ø " .. HIGHLIGHT_FONT_COLOR_CODE .. DisenchantBuddy.FormatCoin(averageValue, 12) .. "|r")
                end
                tooltip:Show()
            end
        end)
    end
end
