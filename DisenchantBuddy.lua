---@class DisenchantBuddy
local _, DisenchantBuddy = ...

local L = DisenchantBuddy.L
local GetTooltipLineData = DisenchantBuddy.GetTooltipLineData

local GetItemInfo = C_Item.GetItemInfo or GetItemInfo

---@param quality number
---@param classId number
---@param itemLevel number
---@return DisenchantResult|nil
local function GetDisenchantResults(quality, classId, itemLevel)
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
local function AddDisenchantInfo(tooltip, itemLink)
    local _, _, quality, itemLevel, _, _, _, _, _, _, _, classId = GetItemInfo(itemLink)

    if quality == Enum.ItemQuality.Poor or
        quality == Enum.ItemQuality.Standard or
        quality == Enum.ItemQuality.Legendary or
        (classId ~= Enum.ItemClass.Armor and classId ~= Enum.ItemClass.Weapon) then
        return
    end

    local disenchantResults = GetDisenchantResults(quality, classId, itemLevel)
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

local notDisenchantableItems = {
    [11287] = true, -- Lesser Magic Wand
    [11288] = true, -- Greater Magic Wand
    [11289] = true, -- Lesser Mystic Wand
    [11290] = true, -- Greater Mystic Wand
}

---@param tooltip GameTooltip
function DisenchantBuddy.OnTooltipSetItem(tooltip)
    local _, link = tooltip:GetItem()

    if (not link) or tooltip:IsForbidden() then
        return
    end

    -- crafted wands Cannot be disenchanted
    local itemId = tonumber(string.match(link, "item:(%d+)"))
    if notDisenchantableItems[itemId] then
        tooltip:AddLine(ITEM_DISENCHANT_NOT_DISENCHANTABLE)
        tooltip:Show()
        return
    end

    AddDisenchantInfo(tooltip, link)
end

---@param isLogin boolean
---@param isReload boolean
function DisenchantBuddy.OnPlayerEnteringWorld(_, _, isLogin, isReload)
    if isLogin then
        -- Trigger caching of all materials, so they are available when hovering over items
        for _, itemId in pairs(DisenchantBuddy.Materials) do
            GetItemInfo(itemId)
        end
    end

    if isLogin or isReload then
        GameTooltip:HookScript("OnTooltipSetItem", DisenchantBuddy.OnTooltipSetItem)    -- hovering over an item
        ItemRefTooltip:HookScript("OnTooltipSetItem", DisenchantBuddy.OnTooltipSetItem) -- clicking an item link
    end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", DisenchantBuddy.OnPlayerEnteringWorld)
