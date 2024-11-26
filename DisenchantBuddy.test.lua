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

        it("should not show tooltip for common quality items", function()
            ---@type GameTooltip
            local tooltip = {
                GetItem = spy.new(function()
                    return "Hillman's Cloak", "|c9d9d9d|Hitem:3719:0:0:0:0:0:0:0:0:0:0|h[Hillman's Cloak]|h|r"
                end),
                Show = spy.new(),
                AddLine = spy.new(),
            }
            _G.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Common, 0, nil, Enum.ItemClass.Armor
            end)

            DisenchantBuddy.OnTooltipSetItem(tooltip)

            assert.spy(tooltip.GetItem).was.called()
            assert.spy(tooltip.Show).was_not.called()
            assert.spy(tooltip.AddLine).was_not.called()
        end)

        it("should not show tooltip for item types other than armor and weapon", function()
            ---@type GameTooltip
            local tooltip = {
                GetItem = spy.new(function()
                    return "Small Blue Pouch", "|cff1eff00|Hitem:4496:0:0:0:0:0:0:0:0:0:0|h[Small Blue Pouch]|h|r"
                end),
                Show = spy.new(),
                AddLine = spy.new(),
            }
            _G.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Uncommon, 0, nil, Enum.ItemClass.Container
            end)

            DisenchantBuddy.OnTooltipSetItem(tooltip)

            assert.spy(tooltip.GetItem).was.called()
            assert.spy(tooltip.Show).was_not.called()
            assert.spy(tooltip.AddLine).was_not.called()
        end)

        it("should show tooltip for level 5 items", function()
            ---@type GameTooltip
            local tooltip = {
                GetItem = spy.new(function()
                    return "Red Linen Robe", "|cff1eff00|Hitem:2572:0:0:0:0:0:0:0:0:0:0|h[Red Linen Robe]|h|r"
                end),
                Show = spy.new(),
                AddLine = spy.new(),
            }
            _G.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Uncommon, 5, nil, Enum.ItemClass.Armor
            end)

            DisenchantBuddy.OnTooltipSetItem(tooltip)

            assert.spy(tooltip.GetItem).was.called()
            assert.spy(tooltip.Show).was.called()
            assert.spy(tooltip.AddLine).was.called_with(tooltip, "Disenchant results:")
            assert.spy(tooltip.AddLine).was.called_with(tooltip, "Strange Dust", 1, 1, 1)
            assert.spy(tooltip.AddLine).was.called_with(tooltip, "Lesser Magic Essence", 1, 1, 1)
        end)

        it("should show tooltip for level 15 items", function()
            ---@type GameTooltip
            local tooltip = {
                GetItem = spy.new(function()
                    return "Shadow Goggles", "|cff1eff00|Hitem:4373:0:0:0:0:0:0:0:0:0:0|h[Shadow Goggles]|h|r"
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

        it("should show tooltip for level 16 items", function()
            ---@type GameTooltip
            local tooltip = {
                GetItem = spy.new(function()
                    return "Soft-soled Linen Boots", "|cff1eff00|Hitem:4312:0:0:0:0:0:0:0:0:0:0|h[Soft-soled Linen Boots]|h|r"
                end),
                Show = spy.new(),
                AddLine = spy.new(),
            }
            _G.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Uncommon, 16, nil, Enum.ItemClass.Armor
            end)

            DisenchantBuddy.OnTooltipSetItem(tooltip)

            assert.spy(tooltip.GetItem).was.called()
            assert.spy(tooltip.Show).was.called()
            assert.spy(tooltip.AddLine).was.called_with(tooltip, "Disenchant results:")
            assert.spy(tooltip.AddLine).was.called_with(tooltip, "Strange Dust", 1, 1, 1)
            assert.spy(tooltip.AddLine).was.called_with(tooltip, "Greater Magic Essence", 1, 1, 1)
        end)

        it("should show tooltip for level 20 items", function()
            ---@type GameTooltip
            local tooltip = {
                GetItem = spy.new(function()
                    return "War Paint Shield", "|cff1eff00|Hitem:14729:0:0:0:0:0:0:0:0:0:0|h[War Paint Shield]|h|r"
                end),
                Show = spy.new(),
                AddLine = spy.new(),
            }
            _G.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Uncommon, 20, nil, Enum.ItemClass.Armor
            end)

            DisenchantBuddy.OnTooltipSetItem(tooltip)

            assert.spy(tooltip.GetItem).was.called()
            assert.spy(tooltip.Show).was.called()
            assert.spy(tooltip.AddLine).was.called_with(tooltip, "Disenchant results:")
            assert.spy(tooltip.AddLine).was.called_with(tooltip, "Strange Dust", 1, 1, 1)
            assert.spy(tooltip.AddLine).was.called_with(tooltip, "Greater Magic Essence", 1, 1, 1)
        end)

        it("should show tooltip for level 21 items", function()
            ---@type GameTooltip
            local tooltip = {
                GetItem = spy.new(function()
                    return "Gray Woolen Robe", "|cff1eff00|Hitem:2585:0:0:0:0:0:0:0:0:0:0|h[Gray Woolen Robe]|h|r"
                end),
                Show = spy.new(),
                AddLine = spy.new(),
            }
            _G.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Uncommon, 21, nil, Enum.ItemClass.Armor
            end)

            DisenchantBuddy.OnTooltipSetItem(tooltip)

            assert.spy(tooltip.GetItem).was.called()
            assert.spy(tooltip.Show).was.called()
            assert.spy(tooltip.AddLine).was.called_with(tooltip, "Disenchant results:")
            assert.spy(tooltip.AddLine).was.called_with(tooltip, "Strange Dust", 1, 1, 1)
            assert.spy(tooltip.AddLine).was.called_with(tooltip, "Lesser Astral Essence", 1, 1, 1)
        end)

        it("should show tooltip for level 25 items", function()
            ---@type GameTooltip
            local tooltip = {
                GetItem = spy.new(function()
                    return "Fletcher's Gloves", "|cff1eff00|Hitem:7348:0:0:0:0:0:0:0:0:0:0|h[Fletcher's Gloves]|h|r"
                end),
                Show = spy.new(),
                AddLine = spy.new(),
            }
            _G.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Uncommon, 25, nil, Enum.ItemClass.Armor
            end)

            DisenchantBuddy.OnTooltipSetItem(tooltip)

            assert.spy(tooltip.GetItem).was.called()
            assert.spy(tooltip.Show).was.called()
            assert.spy(tooltip.AddLine).was.called_with(tooltip, "Disenchant results:")
            assert.spy(tooltip.AddLine).was.called_with(tooltip, "Strange Dust", 1, 1, 1)
            assert.spy(tooltip.AddLine).was.called_with(tooltip, "Lesser Astral Essence", 1, 1, 1)
            assert.spy(tooltip.AddLine).was.called_with(tooltip, "Small Glimmering Shard", 1, 1, 1)
        end)
    end)
end)
