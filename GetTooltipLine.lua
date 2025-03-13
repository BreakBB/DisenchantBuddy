---@type DisenchantBuddy
local _, DisenchantBuddy = ...

---@class TooltipLineData
---@field left string
---@field right string
---@field price number

---@param item ItemMixin
---@param result DisenchantResult
---@return TooltipLineData
function DisenchantBuddy.GetTooltipLine(item, result)
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

    return {
        left = leftSide,
        right = rightSide,
    }
end