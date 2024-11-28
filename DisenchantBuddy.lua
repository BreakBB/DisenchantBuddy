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

    local itemsLoaded = 0
    local totalItems = #disenchantResults
    local lines = {}

    for i = 1, totalItems do
        ---@type DisenchantResult
        local result = disenchantResults[i]
        local item = Item:CreateFromItemID(result.itemId)
        item:ContinueOnItemLoad(function()
            local materialName = item:GetItemName()
            local materialTexture = item:GetItemIcon()
            local hex = item:GetItemQualityColor().hex

            lines[i] = "  |T" .. materialTexture .. ":0|t " .. hex .. materialName .. "|r (" .. result.probability .. "%)"

            itemsLoaded = itemsLoaded + 1
            if itemsLoaded == totalItems then
                tooltip:AddLine("Disenchant results:")
                for j = 1, totalItems do
                    local line = lines[j]
                    tooltip:AddLine(line)
                end
                tooltip:Show()
            end
        end)
    end

    return true
end

---@param tooltip GameTooltip
function DisenchantBuddy.OnTooltipSetItem(tooltip)
    local _, link = tooltip:GetItem()

    if (not link) then
        return
    end

    -- crafted wands can not be disenchanted
    local itemId = tonumber(string.match(link, "item:(%d+)"))
    if itemId == 11287 or itemId == 11288 or itemId == 11289 or itemId == 11290 then
        -- TODO: Show that these can not be disenchanted
        return
    end

    local tooltipAdded = AddDisenchantInfo(tooltip, link)

    if tooltipAdded then
        tooltip:Show()
    end
end

GameTooltip:HookScript("OnTooltipSetItem", DisenchantBuddy.OnTooltipSetItem)
