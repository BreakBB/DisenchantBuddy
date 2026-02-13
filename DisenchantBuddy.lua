---@class DisenchantBuddy
local DisenchantBuddy = select(2, ...)

local GetItemInfo = C_Item.GetItemInfo or GetItemInfo
local AddDisenchantInfo = DisenchantBuddy.AddDisenchantInfo
local AddMaterialInfo = DisenchantBuddy.AddMaterialInfo

local notDisenchantableItems = {
    [11287] = true, -- Lesser Magic Wand
    [11288] = true, -- Greater Magic Wand
    [11289] = true, -- Lesser Mystic Wand
    [11290] = true, -- Greater Mystic Wand
    [20406] = true, -- Twilight Cultist Mantle
    [20407] = true, -- Twilight Cultist Robe
    [20408] = true, -- Twilight Cultist Cowl
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

    AddMaterialInfo(tooltip, itemId)
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
        GameTooltip:HookScript("OnTooltipSetItem", DisenchantBuddy.OnTooltipSetItem) -- hovering over an item
        ItemRefTooltip:HookScript("OnTooltipSetItem", DisenchantBuddy.OnTooltipSetItem) -- clicking an item link
    end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", DisenchantBuddy.OnPlayerEnteringWorld)
