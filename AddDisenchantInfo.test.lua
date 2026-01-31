dofile(".types/wow-api/library/Data/Enum.lua")

local Colors = {
    STANDARD = "|cffffffff",
    GOOD = "|cff1eff00",
    RARE = "|cff0070dd",
    EPIC = "|cffa335ee",
}

_G.HIGHLIGHT_FONT_COLOR_CODE = Colors.STANDARD

_G.GetItemQualityColor = function(quality)
    if quality == Enum.ItemQuality.Standard then
        return nil, nil, nil, Colors.STANDARD
    elseif quality == Enum.ItemQuality.Good then
        return nil, nil, nil, Colors.GOOD
    elseif quality == Enum.ItemQuality.Rare then
        return nil, nil, nil, Colors.RARE
    elseif quality == Enum.ItemQuality.Epic then
        return nil, nil, nil, Colors.EPIC
    end
end

local match = require("luassert.match")
local _ = match._ -- any match
_.name = "any"
_.arguments = {n = 0}

local GOLD_COIN_ICON = "|TInterface\\MoneyFrame\\UI-GoldIcon:12:12:2:0|t"
local SILVER_COIN_ICON = "|TInterface\\MoneyFrame\\UI-SilverIcon:12:12:2:0|t"
local COPPER_COIN_ICON = "|TInterface\\MoneyFrame\\UI-CopperIcon:12:12:2:0|t"

local _GetItemInfoForMaterials

describe("AddDisenchantInfo", function()
    ---@type DisenchantBuddy
    local DisenchantBuddy
    local gameTooltipMock

    before_each(function()
        _G.C_Item = {
            GetItemInfo = spy.new(function() end)
        }
        _G.GetLocale = function()
            return "enUS"
        end
        _G.GameTooltip = {
            Show = spy.new(function() end),
            AddLine = spy.new(function() end),
            AddDoubleLine = spy.new(function() end),
        }
        gameTooltipMock = _G.GameTooltip
        _G.Item = {
            CreateFromItemID = function(_, itemId)
                return {
                    ContinueOnItemLoad = function(_, callback)
                        callback()
                    end,
                    GetItemName = function()
                        return select(1, _GetItemInfoForMaterials(itemId))
                    end,
                    GetItemIcon = function()
                        return select(3, _GetItemInfoForMaterials(itemId))
                    end,
                    GetItemQualityColor = function()
                        return {
                            hex = select(4, GetItemQualityColor(select(2, _GetItemInfoForMaterials(itemId))))
                        }
                    end
                }
            end,
        }
        _G.Auctionator = nil

        DisenchantBuddy = {}
        -- We use `loadfile` over `require` to be able to hand in our own environment
        loadfile("Materials.lua")("DisenchantBuddy", DisenchantBuddy)
        loadfile("GetTooltipLineData.lua")("DisenchantBuddy", DisenchantBuddy)
        loadfile("AddDisenchantInfo.lua")("DisenchantBuddy", DisenchantBuddy)
        loadfile("Locales/enUS.lua")("DisenchantBuddy", DisenchantBuddy)
        loadfile("DisenchantResults/Uncommon.lua")("DisenchantBuddy", DisenchantBuddy)
        loadfile("DisenchantResults/Rare.lua")("DisenchantBuddy", DisenchantBuddy)
        loadfile("DisenchantResults/Epic.lua")("DisenchantBuddy", DisenchantBuddy)

        DisenchantBuddy.IsTBC = false
        DisenchantBuddy.IsWotLK = false
        DisenchantBuddy.IsCata = false
        DisenchantBuddy.IsMoP = false
    end)

    it("should not show tooltip for poor quality items", function()
        _G.GetItemInfo = spy.new(function()
            return nil, nil, Enum.ItemQuality.Poor, 5, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
        end)

        loadfile("AddDisenchantInfo.lua")("DisenchantBuddy", DisenchantBuddy)
        DisenchantBuddy.AddDisenchantInfo(gameTooltipMock, "itemLink")

        assert.spy(gameTooltipMock.Show).was_not.called()
        assert.spy(gameTooltipMock.AddLine).was_not.called()
    end)

    it("should not show tooltip for common quality items", function()
        _G.C_Item.GetItemInfo = spy.new(function()
            return nil, nil, Enum.ItemQuality.Standard, 5, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
        end)

        loadfile("AddDisenchantInfo.lua")("DisenchantBuddy", DisenchantBuddy)
        DisenchantBuddy.AddDisenchantInfo(gameTooltipMock, "itemLink")

        assert.spy(gameTooltipMock.Show).was_not.called()
        assert.spy(gameTooltipMock.AddLine).was_not.called()
    end)

    it("should not show tooltip for legendary quality items", function()
        _G.C_Item.GetItemInfo = spy.new(function()
            return nil, nil, Enum.ItemQuality.Legendary, 5, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
        end)

        loadfile("AddDisenchantInfo.lua")("DisenchantBuddy", DisenchantBuddy)
        DisenchantBuddy.AddDisenchantInfo(gameTooltipMock, "itemLink")

        assert.spy(gameTooltipMock.Show).was_not.called()
        assert.spy(gameTooltipMock.AddLine).was_not.called()
    end)

    it("should not show tooltip for item types other than armor and weapon", function()
        _G.C_Item.GetItemInfo = spy.new(function()
            return nil, nil, Enum.ItemQuality.Good, 5, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Container
        end)

        loadfile("AddDisenchantInfo.lua")("DisenchantBuddy", DisenchantBuddy)
        DisenchantBuddy.AddDisenchantInfo(gameTooltipMock, "itemLink")

        assert.spy(gameTooltipMock.Show).was_not.called()
        assert.spy(gameTooltipMock.AddLine).was_not.called()
    end)

    it("should not show tooltip for unhandled uncommon item level", function()
        _G.C_Item.GetItemInfo = spy.new(function()
            return nil, nil, Enum.ItemQuality.Good, 484, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
        end)

        loadfile("AddDisenchantInfo.lua")("DisenchantBuddy", DisenchantBuddy)
        DisenchantBuddy.AddDisenchantInfo(gameTooltipMock, "itemLink")

        assert.spy(gameTooltipMock.Show).was_not.called()
        assert.spy(gameTooltipMock.AddLine).was_not.called()
    end)

    it("should not show tooltip for unhandled rare item level", function()
        _G.C_Item.GetItemInfo = spy.new(function()
            return nil, nil, Enum.ItemQuality.Rare, 477, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
        end)

        loadfile("AddDisenchantInfo.lua")("DisenchantBuddy", DisenchantBuddy)
        DisenchantBuddy.AddDisenchantInfo(gameTooltipMock, "itemLink")

        assert.spy(gameTooltipMock.Show).was_not.called()
        assert.spy(gameTooltipMock.AddLine).was_not.called()
    end)

    it("should show tooltip for uncommon level 5 armor", function()
        _G.C_Item.GetItemInfo = spy.new(function()
            return nil, nil, Enum.ItemQuality.Good, 5, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
        end)

        loadfile("AddDisenchantInfo.lua")("DisenchantBuddy", DisenchantBuddy)
        DisenchantBuddy.AddDisenchantInfo(gameTooltipMock, "itemLink")

        assert.spy(gameTooltipMock.Show).was.called()
        assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
        assert.spy(gameTooltipMock.AddDoubleLine)
            .was.called_with(_, "  |T132858:0|t " .. Colors.STANDARD .. "Strange Dust" .. "|r", "80% (1-2x)")
        assert.spy(gameTooltipMock.AddDoubleLine)
            .was.called_with(_, "  |T132867:0|t " .. Colors.GOOD .. "Lesser Magic Essence" .. "|r", "20% (1-2x)")
    end)

    it("should show tooltip for uncommon level 5 weapons", function()
        _G.C_Item.GetItemInfo = spy.new(function()
            return nil, nil, Enum.ItemQuality.Good, 5, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Weapon
        end)

        loadfile("AddDisenchantInfo.lua")("DisenchantBuddy", DisenchantBuddy)
        DisenchantBuddy.AddDisenchantInfo(gameTooltipMock, "itemLink")

        assert.spy(gameTooltipMock.Show).was.called()
        assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
        assert.spy(gameTooltipMock.AddDoubleLine)
            .was.called_with(_, "  |T132867:0|t " .. Colors.GOOD .. "Lesser Magic Essence" .. "|r", "80% (1-2x)")
        assert.spy(gameTooltipMock.AddDoubleLine)
            .was.called_with(_, "  |T132858:0|t " .. Colors.STANDARD .. "Strange Dust" .. "|r", "20% (1-2x)")
    end)

    it("should show tooltip for rare level 5 items", function()
        _G.C_Item.GetItemInfo = spy.new(function()
            return nil, nil, Enum.ItemQuality.Rare, 5, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
        end)

        loadfile("AddDisenchantInfo.lua")("DisenchantBuddy", DisenchantBuddy)
        DisenchantBuddy.AddDisenchantInfo(gameTooltipMock, "itemLink")

        assert.spy(gameTooltipMock.Show).was.called()
        assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
        assert.spy(gameTooltipMock.AddDoubleLine)
            .was.called_with(_, "  |T132877:0|t " .. Colors.RARE .. "Small Glimmering Shard" .. "|r", "100% (1x)")
    end)

    it("should show tooltip for epic level 60 items", function()
        _G.C_Item.GetItemInfo = spy.new(function()
            return nil, nil, Enum.ItemQuality.Epic, 60, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
        end)

        loadfile("AddDisenchantInfo.lua")("DisenchantBuddy", DisenchantBuddy)
        DisenchantBuddy.AddDisenchantInfo(gameTooltipMock, "itemLink")

        assert.spy(gameTooltipMock.Show).was.called()
        assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
        assert.spy(gameTooltipMock.AddDoubleLine)
            .was.called_with(_, "  |T132880:0|t " .. Colors.EPIC .. "Nexus Crystal" .. "|r", "100% (1x)")
    end)

    it("should show auction price for materials when Auctionator is active", function()
        _G.Auctionator = {
            API = {
                v1 = {
                    GetAuctionPriceByItemID = spy.new(function()
                        return 12345
                    end)
                }
            }
        }
        _G.C_Item.GetItemInfo = spy.new(function()
            return nil, nil, Enum.ItemQuality.Epic, 60, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
        end)
        _G.GetCoinTextureString = function(amount)
            return math.floor((amount / 10000)) ..
                GOLD_COIN_ICON ..
                " " ..
                math.floor(((amount % 10000) / 100)) ..
                SILVER_COIN_ICON .. " " .. math.floor((amount % 100)) .. COPPER_COIN_ICON
        end

        loadfile("AddDisenchantInfo.lua")("DisenchantBuddy", DisenchantBuddy)
        DisenchantBuddy.AddDisenchantInfo(gameTooltipMock, "itemLink")

        assert.spy(gameTooltipMock.Show).was.called()
        assert.spy(_G.Auctionator.API.v1.GetAuctionPriceByItemID).was.called_with(_, 20725)
        assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
        local leftSide = "  |T132880:0|t " .. Colors.EPIC .. "Nexus Crystal" .. "|r"
        local rightSide = "100% (1 x " ..
            _G.HIGHLIGHT_FONT_COLOR_CODE ..
            "1" .. GOLD_COIN_ICON .. " 23" .. SILVER_COIN_ICON .. " 45" .. COPPER_COIN_ICON .. "|r)"
        assert.spy(gameTooltipMock.AddDoubleLine).was.called_with(_, leftSide, rightSide)
    end)

    it("should show average disenchant value when Auctionator is active", function()
        local Materials = DisenchantBuddy.Materials
        _G.Auctionator = {
            API = {
                v1 = {
                    GetAuctionPriceByItemID = spy.new(function(_, itemId)
                        if itemId == Materials.STRANGE_DUST then
                            return 1000 -- 10 silver
                        elseif itemId == Materials.GREATER_MAGIC_ESSENCE then
                            return 1500 -- 15 silver
                        elseif itemId == Materials.SMALL_GLIMMERING_SHARD then
                            return 2500 -- 25 silver
                        end
                        return 0
                    end)
                }
            }
        }
        _G.C_Item.GetItemInfo = spy.new(function()
            return nil, nil, Enum.ItemQuality.Good, 20, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
        end)
        _G.GetCoinTextureString = function(amount)
            return math.floor((amount / 10000)) ..
                GOLD_COIN_ICON ..
                " " ..
                math.floor(((amount % 10000) / 100)) ..
                SILVER_COIN_ICON .. " " .. math.floor((amount % 100)) .. COPPER_COIN_ICON
        end

        loadfile("AddDisenchantInfo.lua")("DisenchantBuddy", DisenchantBuddy)
        DisenchantBuddy.AddDisenchantInfo(gameTooltipMock, "itemLink")

        assert.spy(gameTooltipMock.Show).was.called()
        assert.spy(_G.Auctionator.API.v1.GetAuctionPriceByItemID).was.called_with(_, Materials.STRANGE_DUST)
        assert.spy(_G.Auctionator.API.v1.GetAuctionPriceByItemID).was.called_with(_, Materials.GREATER_MAGIC_ESSENCE)
        assert.spy(_G.Auctionator.API.v1.GetAuctionPriceByItemID).was.called_with(_, Materials.SMALL_GLIMMERING_SHARD)
        local rightSide = "Ø " ..
            _G.HIGHLIGHT_FONT_COLOR_CODE ..
            "0" .. GOLD_COIN_ICON .. " 24" .. SILVER_COIN_ICON .. " 50" .. COPPER_COIN_ICON .. "|r"
        assert.spy(gameTooltipMock.AddDoubleLine).was.called_with(_, " ", rightSide)
    end)

    it("should not show auction price for materials when Auctionator is active but does not have a price", function()
        _G.Auctionator = {
            API = {
                v1 = {
                    GetAuctionPriceByItemID = spy.new(function()
                        return nil
                    end)
                }
            }
        }
        _G.C_Item.GetItemInfo = spy.new(function()
            return nil, nil, Enum.ItemQuality.Epic, 60, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
        end)

        loadfile("AddDisenchantInfo.lua")("DisenchantBuddy", DisenchantBuddy)
        DisenchantBuddy.AddDisenchantInfo(gameTooltipMock, "itemLink")

        assert.spy(gameTooltipMock.Show).was.called()
        assert.spy(_G.Auctionator.API.v1.GetAuctionPriceByItemID).was.called_with(_, 20725)
        assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
        assert.spy(gameTooltipMock.AddDoubleLine)
            .was.called_with(_, "  |T132880:0|t " .. Colors.EPIC .. "Nexus Crystal" .. "|r", "100% (1x)")
    end)

    it("should translate tooltip header line", function()
        _G.C_Item.GetItemInfo = spy.new(function()
            return nil, nil, Enum.ItemQuality.Good, 5, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
        end)
        _G.GetLocale = function()
            return "deDE"
        end
        loadfile("Locales/deDE.lua")("DisenchantBuddy", DisenchantBuddy)
        loadfile("AddDisenchantInfo.lua")("DisenchantBuddy", DisenchantBuddy)

        DisenchantBuddy.AddDisenchantInfo(gameTooltipMock, "itemLink")

        assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Entzauberungsergebnisse:")
    end)
end)

_GetItemInfoForMaterials = function(itemId)
    if itemId == 10940 then
        return "Strange Dust", Enum.ItemQuality.Standard, 132858
    elseif itemId == 11083 then
        return "Soul Dust", Enum.ItemQuality.Standard, 132857
    elseif itemId == 11137 then
        return "Vision Dust", Enum.ItemQuality.Standard, 132859
    elseif itemId == 11176 then
        return "Dream Dust", Enum.ItemQuality.Standard, 132855
    elseif itemId == 16204 then
        return "Illusion Dust", Enum.ItemQuality.Standard, 132856
    elseif itemId == 10938 then
        return "Lesser Magic Essence", Enum.ItemQuality.Good, 132867
    elseif itemId == 10939 then
        return "Greater Magic Essence", Enum.ItemQuality.Good, 132866
    elseif itemId == 10998 then
        return "Lesser Astral Essence", Enum.ItemQuality.Good, 132863
    elseif itemId == 11082 then
        return "Greater Astral Essence", Enum.ItemQuality.Good, 132862
    elseif itemId == 11134 then
        return "Lesser Mystic Essence", Enum.ItemQuality.Good, 132869
    elseif itemId == 11135 then
        return "Greater Mystic Essence", Enum.ItemQuality.Good, 132868
    elseif itemId == 11174 then
        return "Lesser Nether Essence", Enum.ItemQuality.Good, 132871
    elseif itemId == 11175 then
        return "Greater Nether Essence", Enum.ItemQuality.Good, 132870
    elseif itemId == 16202 then
        return "Lesser Eternal Essence", Enum.ItemQuality.Good, 132865
    elseif itemId == 16203 then
        return "Greater Eternal Essence", Enum.ItemQuality.Good, 132864
    elseif itemId == 10978 then
        return "Small Glimmering Shard", Enum.ItemQuality.Rare, 132877
    elseif itemId == 11084 then
        return "Large Glimmering Shard", Enum.ItemQuality.Rare, 132876
    elseif itemId == 11138 then
        return "Small Glowing Shard", Enum.ItemQuality.Rare, 132879
    elseif itemId == 11139 then
        return "Large Glowing Shard", Enum.ItemQuality.Rare, 132878
    elseif itemId == 11177 then
        return "Small Radiant Shard", Enum.ItemQuality.Rare, 132884
    elseif itemId == 11178 then
        return "Large Radiant Shard", Enum.ItemQuality.Rare, 132883
    elseif itemId == 14343 then
        return "Small Brilliant Shard", Enum.ItemQuality.Rare, 132874
    elseif itemId == 14344 then
        return "Large Brilliant Shard", Enum.ItemQuality.Rare, 132873
    elseif itemId == 20725 then
        return "Nexus Crystal", Enum.ItemQuality.Epic, 132880
    else
        return nil
    end
end
