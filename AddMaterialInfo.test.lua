local Colors = {
    STANDARD = "|cffffffff",
    GOOD = "|cff1eff00",
    RARE = "|cff0070dd",
    EPIC = "|cffa335ee",
}

describe("AddMaterialInfo", function()
    ---@type DisenchantBuddy
    local DisenchantBuddy
    ---@type Materials
    local Materials
    local gameTooltipMock

    before_each(function()
        _G.GameTooltip = {
            Show = spy.new(function() end),
            AddLine = spy.new(function() end),
            AddDoubleLine = spy.new(function() end),
        }
        _G.GetLocale = function()
            return "enUS"
        end
        gameTooltipMock = _G.GameTooltip

        DisenchantBuddy = {}

        DisenchantBuddy.IsSoD = false
        DisenchantBuddy.IsTBC = true
        DisenchantBuddy.IsWotLK = true
        DisenchantBuddy.IsCata = true
        DisenchantBuddy.IsMoP = true

        -- We use `loadfile` over `require` to be able to hand in our own environment
        loadfile("Materials.lua")("DisenchantBuddy", DisenchantBuddy)
        Materials = DisenchantBuddy.Materials
        loadfile("Locales/enUS.lua")("DisenchantBuddy", DisenchantBuddy)
        loadfile("AddMaterialInfo.lua")("DisenchantBuddy", DisenchantBuddy)
    end)

    it("should not add anything to the tooltip when item is not an enchanting material", function()
        DisenchantBuddy.AddMaterialInfo(gameTooltipMock, 123)

        assert.spy(gameTooltipMock.Show).was.not_called()
        assert.spy(gameTooltipMock.AddLine).was.not_called()
        assert.spy(gameTooltipMock.AddDoubleLine).was.not_called()
    end)

    it("should add uncommon item ranges to material tooltip", function()
        DisenchantBuddy.AddMaterialInfo(gameTooltipMock, Materials.STRANGE_DUST)

        assert.spy(gameTooltipMock.Show).was.called()
        assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchanted from:")
        assert.spy(gameTooltipMock.AddDoubleLine)
            .was.called_with(gameTooltipMock, Colors.GOOD .. "  Item Level|r", "1-25")
    end)

    it("should add rare item ranges to material tooltip", function()
        DisenchantBuddy.AddMaterialInfo(gameTooltipMock, Materials.SMALL_HEAVENLY_SHARD)

        assert.spy(gameTooltipMock.Show).was.called()
        assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchanted from:")
        assert.spy(gameTooltipMock.AddDoubleLine)
            .was.called_with(gameTooltipMock, Colors.RARE .. "  Item Level|r", "201-316")
    end)

    it("should add epic item ranges to material tooltip", function()
        DisenchantBuddy.AddMaterialInfo(gameTooltipMock, Materials.VOID_CRYSTAL)

        assert.spy(gameTooltipMock.Show).was.called()
        assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchanted from:")
        assert.spy(gameTooltipMock.AddDoubleLine)
            .was.called_with(gameTooltipMock, Colors.EPIC .. "  Item Level|r", "93-164")
    end)

    it("should add correct Void Crystal epic item ranges for SoD to material tooltip", function()
        DisenchantBuddy.IsSoD = true
        loadfile("AddMaterialInfo.lua")("DisenchantBuddy", DisenchantBuddy)

        DisenchantBuddy.AddMaterialInfo(gameTooltipMock, Materials.VOID_CRYSTAL)

        assert.spy(gameTooltipMock.Show).was.called()
        assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchanted from:")
        assert.spy(gameTooltipMock.AddDoubleLine)
            .was.called_with(gameTooltipMock, Colors.EPIC .. "  Item Level|r", "101-164")
    end)

    it("should add multiple item ranges to material tooltip", function()
        DisenchantBuddy.AddMaterialInfo(gameTooltipMock, Materials.SMALL_GLIMMERING_SHARD)

        assert.spy(gameTooltipMock.Show).was.called()
        assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchanted from:")
        assert.spy(gameTooltipMock.AddDoubleLine)
            .was.called_with(gameTooltipMock, Colors.GOOD .. "  Item Level|r", "16-25")
        assert.spy(gameTooltipMock.AddDoubleLine)
            .was.called_with(gameTooltipMock, Colors.RARE .. "  Item Level|r", "1-25")
    end)
end)
