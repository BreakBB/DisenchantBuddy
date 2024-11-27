dofile(".types/wow-api/library/Data/Enum.lua")

local Colors = {
    POOR = "ff9d9d9d",
    STANDARD = "ffffffff",
    GOOD = "ff1eff00",
    RARE = "ff0070dd",
    EPIC = "ffa335ee",
}

_G.GetItemQualityColor = function(quality)
    if quality == Enum.ItemQuality.Poor then
        return nil, nil, nil, Colors.POOR
    elseif quality == Enum.ItemQuality.Standard then
        return nil, nil, nil, Colors.STANDARD
    elseif quality == Enum.ItemQuality.Good then
        return nil, nil, nil, Colors.GOOD
    elseif quality == Enum.ItemQuality.Rare then
        return nil, nil, nil, Colors.RARE
    elseif quality == Enum.ItemQuality.Epic then
        return nil, nil, nil, Colors.EPIC
    end
end

describe("DisenchantBuddy", function()

    local DisenchantBuddy
    local gameTooltipMock

    local _GetItemInfoForMaterials

    before_each(function()
        _G.GameTooltip = {
            HookScript = spy.new(),
            GetItem = spy.new(function()
                return "itemName", "itemLink"
            end),
            Show = spy.new(),
            AddLine = spy.new(),
        }
        gameTooltipMock = _G.GameTooltip

        DisenchantBuddy = {}
        -- We use `loadfile` over `require` to be able to hand in our own environment
        loadfile("Materials.lua")("DisenchantBuddy", DisenchantBuddy)
        loadfile("DisenchantResults/Uncommon.lua")("DisenchantBuddy", DisenchantBuddy)
        loadfile("DisenchantResults/Rare.lua")("DisenchantBuddy", DisenchantBuddy)
        loadfile("DisenchantResults/Epic.lua")("DisenchantBuddy", DisenchantBuddy)
        loadfile("DisenchantBuddy.lua")("DisenchantBuddy", DisenchantBuddy)
    end)

    it("should hook GameTooltip with OnTooltipSetItem", function()
        assert.spy(_G.GameTooltip.HookScript).was.called_with(_G.GameTooltip, "OnTooltipSetItem", DisenchantBuddy.OnTooltipSetItem)
    end)

    describe("OnTooltipSetItem", function()
        it("should not show tooltip for poor quality items", function()
            _G.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Poor, 5, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
            end)

            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(gameTooltipMock.GetItem).was.called()
            assert.spy(gameTooltipMock.Show).was_not.called()
            assert.spy(gameTooltipMock.AddLine).was_not.called()
        end)

        it("should not show tooltip for common quality items", function()
            _G.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Standard, 5, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
            end)

            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(gameTooltipMock.GetItem).was.called()
            assert.spy(gameTooltipMock.Show).was_not.called()
            assert.spy(gameTooltipMock.AddLine).was_not.called()
        end)

        it("should not show tooltip for legendary quality items", function()
            _G.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Legendary, 5, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
            end)

            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(gameTooltipMock.GetItem).was.called()
            assert.spy(gameTooltipMock.Show).was_not.called()
            assert.spy(gameTooltipMock.AddLine).was_not.called()
        end)

        it("should not show tooltip for item types other than armor and weapon", function()
            _G.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Good, 5, nil, Enum.ItemClass.Container
            end)

            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(gameTooltipMock.GetItem).was.called()
            assert.spy(gameTooltipMock.Show).was_not.called()
            assert.spy(gameTooltipMock.AddLine).was_not.called()
        end)

        it("should not show tooltip for unhandled uncommon item level", function()
            _G.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Standard, 66, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
            end)

            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(gameTooltipMock.GetItem).was.called()
            assert.spy(gameTooltipMock.Show).was_not.called()
            assert.spy(gameTooltipMock.AddLine).was_not.called()
        end)

        it("should not show tooltip for unhandled rare item level", function()
            _G.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Rare, 66, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
            end)

            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(gameTooltipMock.GetItem).was.called()
            assert.spy(gameTooltipMock.Show).was_not.called()
            assert.spy(gameTooltipMock.AddLine).was_not.called()
        end)

        it("should show tooltip for uncommon level 5 items", function()
            _G.GetItemInfo = spy.new(function(itemId)
                local materialName = _GetItemInfoForMaterials(itemId)
                if materialName then
                    return _GetItemInfoForMaterials(itemId)
                end
                return nil, nil, Enum.ItemQuality.Good, 5, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
            end)

            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(gameTooltipMock.GetItem).was.called()
            assert.spy(gameTooltipMock.Show).was.called()
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "|T132858:0|t" .. " |c" .. Colors.STANDARD .. "Strange Dust")
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "|T132867:0|t" .. " |c" .. Colors.GOOD .. "Lesser Magic Essence")
        end)

        it("should show tooltip for rare level 5 items", function()
            _G.GetItemInfo = spy.new(function(itemId)
                local materialName = _GetItemInfoForMaterials(itemId)
                if materialName then
                    return _GetItemInfoForMaterials(itemId)
                end
                return nil, nil, Enum.ItemQuality.Rare, 5, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
            end)

            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(gameTooltipMock.GetItem).was.called()
            assert.spy(gameTooltipMock.Show).was.called()
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "|T132877:0|t" .. " |c" .. Colors.RARE .. "Small Glimmering Shard")
        end)

        it("should show tooltip for epic level 40 items", function()
            _G.GetItemInfo = spy.new(function(itemId)
                local materialName = _GetItemInfoForMaterials(itemId)
                if materialName then
                    return _GetItemInfoForMaterials(itemId)
                end
                return nil, nil, Enum.ItemQuality.Epic, 40, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
            end)

            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(gameTooltipMock.GetItem).was.called()
            assert.spy(gameTooltipMock.Show).was.called()
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "|T132884:0|t" .. " |c" .. Colors.RARE .. "Small Radiant Shard")
        end)
    end)

    _GetItemInfoForMaterials = function(itemId)
        if itemId == 10940 then
            return "Strange Dust", nil, Enum.ItemQuality.Standard, nil, nil, nil, nil, nil, nil, 132858
        elseif itemId == 11083 then
            return "Soul Dust", nil, Enum.ItemQuality.Standard, nil, nil, nil, nil, nil, nil, 132857
        elseif itemId == 11137 then
            return "Vision Dust", nil, Enum.ItemQuality.Standard, nil, nil, nil, nil, nil, nil, 132859
        elseif itemId == 11176 then
            return "Dream Dust", nil, Enum.ItemQuality.Standard, nil, nil, nil, nil, nil, nil, 132855
        elseif itemId == 16204 then
            return "Illusion Dust", nil, Enum.ItemQuality.Standard, nil, nil, nil, nil, nil, nil, 132856
        elseif itemId == 10938 then
            return "Lesser Magic Essence", nil, Enum.ItemQuality.Good, nil, nil, nil, nil, nil, nil, 132867
        elseif itemId == 10939 then
            return "Greater Magic Essence", nil, Enum.ItemQuality.Good, nil, nil, nil, nil, nil, nil, 132866
        elseif itemId == 10998 then
            return "Lesser Astral Essence", nil, Enum.ItemQuality.Good, nil, nil, nil, nil, nil, nil, 132863
        elseif itemId == 11082 then
            return "Greater Astral Essence", nil, Enum.ItemQuality.Good, nil, nil, nil, nil, nil, nil, 132862
        elseif itemId == 11134 then
            return "Lesser Mystic Essence", nil, Enum.ItemQuality.Good, nil, nil, nil, nil, nil, nil, 132869
        elseif itemId == 11135 then
            return "Greater Mystic Essence", nil, Enum.ItemQuality.Good, nil, nil, nil, nil, nil, nil, 132868
        elseif itemId == 11174 then
            return "Lesser Nether Essence", nil, Enum.ItemQuality.Good, nil, nil, nil, nil, nil, nil, 132871
        elseif itemId == 11175 then
            return "Greater Nether Essence", nil, Enum.ItemQuality.Good, nil, nil, nil, nil, nil, nil, 132870
        elseif itemId == 16202 then
            return "Lesser Eternal Essence", nil, Enum.ItemQuality.Good, nil, nil, nil, nil, nil, nil, 132865
        elseif itemId == 16203 then
            return "Greater Eternal Essence", nil, Enum.ItemQuality.Good, nil, nil, nil, nil, nil, nil, 132864
        elseif itemId == 10978 then
            return "Small Glimmering Shard", nil, Enum.ItemQuality.Rare, nil, nil, nil, nil, nil, nil, 132877
        elseif itemId == 11084 then
            return "Large Glimmering Shard", nil, Enum.ItemQuality.Rare, nil, nil, nil, nil, nil, nil, 132876
        elseif itemId == 11138 then
            return "Small Glowing Shard", nil, Enum.ItemQuality.Rare, nil, nil, nil, nil, nil, nil, 132879
        elseif itemId == 11139 then
            return "Large Glowing Shard", nil, Enum.ItemQuality.Rare, nil, nil, nil, nil, nil, nil, 132878
        elseif itemId == 11177 then
            return "Small Radiant Shard", nil, Enum.ItemQuality.Rare, nil, nil, nil, nil, nil, nil, 132884
        elseif itemId == 11178 then
            return "Large Radiant Shard", nil, Enum.ItemQuality.Rare, nil, nil, nil, nil, nil, nil, 132883
        elseif itemId == 14343 then
            return "Small Brilliant Shard", nil, Enum.ItemQuality.Rare, nil, nil, nil, nil, nil, nil, 132874
        elseif itemId == 14344 then
            return "Large Brilliant Shard", nil, Enum.ItemQuality.Rare, nil, nil, nil, nil, nil, nil, 132873
        elseif itemId == 20725 then
            return "Nexus Crystal", nil, Enum.ItemQuality.Epic, nil, nil, nil, nil, nil, nil, 132880
        else
            return nil
        end
    end
end)
