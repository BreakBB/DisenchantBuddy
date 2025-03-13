_G.HIGHLIGHT_FONT_COLOR_CODE = "|cffffffff"

local match = require("luassert.match")
local _ = match._ -- any match

local GOLD_COIN_ICON = "|TInterface\\MoneyFrame\\UI-GoldIcon:12:12:2:0|t"
local SILVER_COIN_ICON = "|TInterface\\MoneyFrame\\UI-SilverIcon:12:12:2:0|t"
local COPPER_COIN_ICON = "|TInterface\\MoneyFrame\\UI-CopperIcon:12:12:2:0|t"

_G.GetCoinTextureString = function(amount)
    return math.floor((amount / 10000)) .. GOLD_COIN_ICON .. " " .. math.floor(((amount % 10000) / 100)) .. SILVER_COIN_ICON .. " " .. math.floor((amount % 100)) .. COPPER_COIN_ICON
end

describe("GetTooltipLineData", function()
    ---@type DisenchantBuddy
    local DisenchantBuddy

    before_each(function()
        DisenchantBuddy = {}
        loadfile("GetTooltipLineData.lua")("DisenchantBuddy", DisenchantBuddy)
    end)

    it("should return line data without Auctionator", function()
        local mockedItem = {
            GetItemName = function()
                return "Strange Dust"
            end,
            GetItemIcon = function()
                return 132858
            end,
            GetItemQualityColor = function()
                return {hex = "|cffffffff"}
            end
        }
        local disenchantResult = {
            probability = 100,
            minQuantity = 1,
            maxQuantity = 2,
            itemId = 10940
        }

        local lineData = DisenchantBuddy.GetTooltipLineData(mockedItem, disenchantResult)

        assert.same({
            left = "  |T132858:0|t |cffffffffStrange Dust|r",
            right = "100% (1-2x)"
        }, lineData)
    end)

    it("should return line data with Auctionator", function()
        _G.Auctionator = {
            API = {
                v1 = {
                    GetAuctionPriceByItemID = function()
                        return 10000
                    end
                }
            }
        }

        local mockedItem = {
            GetItemName = function()
                return "Strange Dust"
            end,
            GetItemIcon = function()
                return 132858
            end,
            GetItemQualityColor = function()
                return {hex = "|cffffffff"}
            end
        }
        local disenchantResult = {
            probability = 100,
            minQuantity = 1,
            maxQuantity = 2,
            itemId = 10940
        }

        local lineData = DisenchantBuddy.GetTooltipLineData(mockedItem, disenchantResult)

        assert.same({
            left = "  |T132858:0|t |cffffffffStrange Dust|r",
            right = '100% (1-2 x |cffffffff1|TInterface\\MoneyFrame\\UI-GoldIcon:12:12:2:0|t 0|TInterface\\MoneyFrame\\UI-SilverIcon:12:12:2:0|t 0|TInterface\\MoneyFrame\\UI-CopperIcon:12:12:2:0|t|r)'
        }, lineData)
    end)
end)