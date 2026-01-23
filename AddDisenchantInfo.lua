---@class DisenchantBuddy
local _, DisenchantBuddy = ...

local GetItemInfo = C_Item.GetItemInfo or GetItemInfo

local L = DisenchantBuddy.L
local GetTooltipLineData = DisenchantBuddy.GetTooltipLineData

---@param quality number
---@param classId number
---@param itemLevel number
---@return DisenchantResult|nil
function DisenchantBuddy.GetDisenchantResults(quality, classId, itemLevel)
    if quality == Enum.ItemQuality.Good then
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
        quality == Enum.ItemQuality.Standard or
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

    for i = 1, totalItems do
        ---@type DisenchantResult
        local result = disenchantResults[i]
        local item = Item:CreateFromItemID(result.itemId)
        item:ContinueOnItemLoad(function()
            lines[i] = GetTooltipLineData(item, result)

            itemsLoaded = itemsLoaded + 1
            if itemsLoaded == totalItems then
                tooltip:AddLine(L["Disenchant results:"])
                for j = 1, totalItems do
                    local line = lines[j]
                    tooltip:AddDoubleLine(line.left, line.right)
                end
                tooltip:Show()
            end
        end)
    end
end
