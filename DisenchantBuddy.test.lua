dofile(".types/wow-api/library/Data/Enum.lua")

describe("DisenchantBuddy", function()

    local DisenchantBuddy

    before_each(function()
        _G.GameTooltip = {
            HookScript = spy.new(),
        }
        DisenchantBuddy = require("DisenchantBuddy")
    end)

    it("should hook GameTooltip with OnTooltipSetItem", function()
        assert.spy(_G.GameTooltip.HookScript).was.called_with(_G.GameTooltip, "OnTooltipSetItem", DisenchantBuddy.OnTooltipSetItem)
    end)

    describe("OnTooltipSetItem", function()
        it("should not show tooltip for poor quality items", function()
            ---@type GameTooltip
            local tooltip = {
                GetItem = spy.new(function()
                    return "Ruined Pelt", "|c9d9d9d|Hitem:2934:0:0:0:0:0:0:0:0:0:0|h[Ruined Pelt]|h|r"
                end),
                Show = spy.new(),
                AddLine = spy.new(),
            }
            _G.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Poor, 0, nil, Enum.ItemClass.Armor
            end)

            DisenchantBuddy.OnTooltipSetItem(tooltip)

            assert.spy(tooltip.GetItem).was.called()
            assert.spy(tooltip.Show).was_not.called()
            assert.spy(tooltip.AddLine).was_not.called()
        end)

        it("should show tooltip for level 15 items", function()
            ---@type GameTooltip
            local tooltip = {
                GetItem = spy.new(function()
                    return "Red Linen Robe", "|cff1eff00|Hitem:2572:0:0:0:0:0:0:0:0:0:0|h[Red Linen Robe]|h|r"
                end),
                Show = spy.new(),
                AddLine = spy.new(),
            }
            _G.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Uncommon, 15, nil, Enum.ItemClass.Armor
            end)

            DisenchantBuddy.OnTooltipSetItem(tooltip)

            assert.spy(tooltip.GetItem).was.called()
            assert.spy(tooltip.Show).was.called()
            assert.spy(tooltip.AddLine).was.called_with(tooltip, "Disenchant results:")
            assert.spy(tooltip.AddLine).was.called_with(tooltip, "Strange Dust", 1, 1, 1)
            assert.spy(tooltip.AddLine).was.called_with(tooltip, "Lesser Magic Essence", 1, 1, 1)
        end)
    end)
end)
