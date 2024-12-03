---@class DisenchantBuddy
local _, DisenchantBuddy = ...

local L = DisenchantBuddy.L

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

    local disenchantResults
    if quality == Enum.ItemQuality.Good then
        if classId == Enum.ItemClass.Weapon then
            disenchantResults = DisenchantBuddy.GetMaterialsForUncommonWeapons(itemLevel)
        else
            disenchantResults = DisenchantBuddy.GetMaterialsForUncommonArmor(itemLevel)
        end
    elseif quality == Enum.ItemQuality.Rare then
        disenchantResults = DisenchantBuddy.GetMaterialsForRareItem(itemLevel)
    elseif quality == Enum.ItemQuality.Epic then
        disenchantResults = DisenchantBuddy.GetMaterialsForEpicItem(itemLevel)
    end

    if (not disenchantResults) then
        -- No disenchant results for this item, e.g. itemLevel too high
        return
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

            local leftSide = "  |T" .. materialTexture .. ":0|t " .. hex .. materialName .. "|r"
            local rightSide = result.probability .. "%"
            if result.minQuantity == result.maxQuantity then
                rightSide = rightSide .. " (" .. result.minQuantity
            else
                rightSide = rightSide .. " (" .. result.minQuantity .. "-" .. result.maxQuantity
            end

            if Auctionator then
                local auctionValue = Auctionator.API.v1.GetAuctionPriceByItemID("DisenchantBuddy", result.itemId)
                if auctionValue then
                    rightSide = rightSide .. " x " .. HIGHLIGHT_FONT_COLOR_CODE .. GetCoinTextureString(auctionValue, 12) .. "|r"
                else
                    rightSide = rightSide .. "x"
                end
            else
                rightSide = rightSide .. "x"
            end
            rightSide = rightSide .. ")"

            lines[i] = {leftSide, rightSide}

            itemsLoaded = itemsLoaded + 1
            if itemsLoaded == totalItems then
                tooltip:AddLine(L["Disenchant results:"]) -- TODO: Localize
                for j = 1, totalItems do
                    local line = lines[j]
                    tooltip:AddDoubleLine(line[1], line[2])
                end
                tooltip:Show()
            end
        end)
    end
end

---@param tooltip GameTooltip
function DisenchantBuddy.OnTooltipSetItem(tooltip)
    local _, link = tooltip:GetItem()

    if (not link) or tooltip:IsForbidden() then
        return
    end

    -- crafted wands Cannot be disenchanted
    local itemId = tonumber(string.match(link, "item:(%d+)"))
    if itemId == 11287 or itemId == 11288 or itemId == 11289 or itemId == 11290 then
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
        GameTooltip:HookScript("OnTooltipSetItem", DisenchantBuddy.OnTooltipSetItem) -- hovering over an item
        ItemRefTooltip:HookScript("OnTooltipSetItem", DisenchantBuddy.OnTooltipSetItem) -- clicking an item link
    end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", DisenchantBuddy.OnPlayerEnteringWorld)
