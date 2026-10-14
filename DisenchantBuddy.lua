---@class DisenchantBuddy
local DisenchantBuddy = select(2, ...)

DisenchantBuddy_Profile = DisenchantBuddy_Profile or {}

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
    if (not tooltip.GetItem) then
        -- TooltipDataProcessor fires for every item tooltip, including comparison
        -- tooltips that don't implement the legacy GameTooltip mixin.
        return
    end

    local _, link = tooltip:GetItem()
	local modifier = DisenchantBuddy_Profile and DisenchantBuddy_Profile.Modifier

    if (not link) or tooltip:IsForbidden() or not DisenchantBuddy.IsModifierDown(modifier) then
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
        -- HasScript is the reliable way to detect the old OnTooltipSetItem hook; TooltipDataProcessor is the newer callback-based replacement.
        if GameTooltip.HasScript and GameTooltip:HasScript("OnTooltipSetItem") then
            GameTooltip:HookScript("OnTooltipSetItem", DisenchantBuddy.OnTooltipSetItem) -- hovering over an item
            ItemRefTooltip:HookScript("OnTooltipSetItem", DisenchantBuddy.OnTooltipSetItem) -- clicking an item link
        elseif TooltipDataProcessor and TooltipDataProcessor.AddTooltipPostCall then
            TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, DisenchantBuddy.OnTooltipSetItem)
        end
		DisenchantBuddy_Profile = DisenchantBuddy_Profile or {}
    end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", DisenchantBuddy.OnPlayerEnteringWorld)
