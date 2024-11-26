dofile(".types/wow-api/library/Data/Enum.lua")

describe("DisenchantBuddy", function()

    local DisenchantBuddy
    local gameTooltipMock

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
        DisenchantBuddy = require("DisenchantBuddy")
    end)

    it("should hook GameTooltip with OnTooltipSetItem", function()
        assert.spy(_G.GameTooltip.HookScript).was.called_with(_G.GameTooltip, "OnTooltipSetItem", DisenchantBuddy.OnTooltipSetItem)
    end)

    describe("OnTooltipSetItem", function()
        it("should not show tooltip for poor quality items", function()
            _G.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Poor, 0, nil, Enum.ItemClass.Armor
            end)

            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(gameTooltipMock.GetItem).was.called()
            assert.spy(gameTooltipMock.Show).was_not.called()
            assert.spy(gameTooltipMock.AddLine).was_not.called()
        end)

        it("should not show tooltip for common quality items", function()
            _G.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Common, 0, nil, Enum.ItemClass.Armor
            end)

            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(gameTooltipMock.GetItem).was.called()
            assert.spy(gameTooltipMock.Show).was_not.called()
            assert.spy(gameTooltipMock.AddLine).was_not.called()
        end)

        it("should not show tooltip for item types other than armor and weapon", function()
            _G.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Uncommon, 0, nil, Enum.ItemClass.Container
            end)

            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(gameTooltipMock.GetItem).was.called()
            assert.spy(gameTooltipMock.Show).was_not.called()
            assert.spy(gameTooltipMock.AddLine).was_not.called()
        end)

        it("should show tooltip for level 5 items", function()
            _G.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Uncommon, 5, nil, Enum.ItemClass.Armor
            end)

            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(gameTooltipMock.GetItem).was.called()
            assert.spy(gameTooltipMock.Show).was.called()
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Strange Dust", 1, 1, 1)
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Lesser Magic Essence", 1, 1, 1)
        end)

        it("should show tooltip for level 15 items", function()
            _G.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Uncommon, 15, nil, Enum.ItemClass.Armor
            end)

            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(gameTooltipMock.GetItem).was.called()
            assert.spy(gameTooltipMock.Show).was.called()
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Strange Dust", 1, 1, 1)
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Lesser Magic Essence", 1, 1, 1)
        end)

        it("should show tooltip for level 16 items", function()
            _G.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Uncommon, 16, nil, Enum.ItemClass.Armor
            end)

            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(gameTooltipMock.GetItem).was.called()
            assert.spy(gameTooltipMock.Show).was.called()
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Strange Dust", 1, 1, 1)
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Greater Magic Essence", 1, 1, 1)
        end)

        it("should show tooltip for level 20 items", function()
            _G.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Uncommon, 20, nil, Enum.ItemClass.Armor
            end)

            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(gameTooltipMock.GetItem).was.called()
            assert.spy(gameTooltipMock.Show).was.called()
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Strange Dust", 1, 1, 1)
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Greater Magic Essence", 1, 1, 1)
        end)

        it("should show tooltip for level 21 items", function()
            _G.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Uncommon, 21, nil, Enum.ItemClass.Armor
            end)

            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(gameTooltipMock.GetItem).was.called()
            assert.spy(gameTooltipMock.Show).was.called()
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Strange Dust", 1, 1, 1)
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Lesser Astral Essence", 1, 1, 1)
        end)

        it("should show tooltip for level 25 items", function()
            _G.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Uncommon, 25, nil, Enum.ItemClass.Armor
            end)

            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(gameTooltipMock.GetItem).was.called()
            assert.spy(gameTooltipMock.Show).was.called()
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Strange Dust", 1, 1, 1)
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Lesser Astral Essence", 1, 1, 1)
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Small Glimmering Shard", 1, 1, 1)
        end)

        it("should show tooltip for level 26 items", function()
            _G.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Uncommon, 26, nil, Enum.ItemClass.Armor
            end)

            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(gameTooltipMock.GetItem).was.called()
            assert.spy(gameTooltipMock.Show).was.called()
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Soul Dust", 1, 1, 1)
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Greater Astral Essence", 1, 1, 1)
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Large Glimmering Shard", 1, 1, 1)
        end)

        it("should show tooltip for level 30 items", function()
            _G.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Uncommon, 30, nil, Enum.ItemClass.Armor
            end)

            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(gameTooltipMock.GetItem).was.called()
            assert.spy(gameTooltipMock.Show).was.called()
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Soul Dust", 1, 1, 1)
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Greater Astral Essence", 1, 1, 1)
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Large Glimmering Shard", 1, 1, 1)
        end)
    end)
end)
