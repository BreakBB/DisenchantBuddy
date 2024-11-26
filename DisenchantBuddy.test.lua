describe("DisenchantBuddy", function()

    local DisenchantBuddy

    before_each(function()
        _G.GameTooltip = {
            HookScript = spy.new(),
        }
        DisenchantBuddy = require("DisenchantBuddy")
    end)

    it("should hook GameTooltip with OnTooltipSetItem", function()
        assert.spy(_G.GameTooltip.HookScript).was_called_with(_G.GameTooltip, "OnTooltipSetItem", DisenchantBuddy.OnTooltipSetItem)
    end)

    describe("OnTooltipSetItem", function()
        it("should show tooltip", function()
            local tooltip = {
                GetItem = spy.new(function() return "Cookie's Tenderizer", "|cff1eff00|Hitem:5197:0:0:0:0:0:0:0:0:0:0|h[Cookie's Tenderizer]|h|r" end),
                Show = spy.new()
            }

            DisenchantBuddy.OnTooltipSetItem(tooltip)

            assert.spy(tooltip.GetItem).was_called()
            assert.spy(tooltip.Show).was_called()
        end)
    end)
end)
