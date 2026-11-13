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

        DisenchantBuddy = {
            IsClassic = true,
            IsSoD = false,
            IsTBC = true,
            IsWotLK = true,
            IsCata = true,
            IsMoP = true,
        }

        -- We use `loadfile` over `require` to be able to hand in our own environment
        loadfile("Materials.lua")("DisenchantBuddy", DisenchantBuddy)
        Materials = DisenchantBuddy.Materials
        loadfile("Locales/enUS.lua")("DisenchantBuddy", DisenchantBuddy)
        loadfile("DisenchantResults/Uncommon.lua")("DisenchantBuddy", DisenchantBuddy)
        loadfile("DisenchantResults/Rare.lua")("DisenchantBuddy", DisenchantBuddy)
        loadfile("DisenchantResults/Epic.lua")("DisenchantBuddy", DisenchantBuddy)
        loadfile("MaterialSources.lua")("DisenchantBuddy", DisenchantBuddy)
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
        loadfile("MaterialSources.lua")("DisenchantBuddy", DisenchantBuddy)
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

    it("should not include MoP materials on a Classic client", function()
        local classicDisenchantBuddy = {
            IsClassic = true,
            IsSoD = false,
            IsTBC = false,
            IsWotLK = false,
            IsCata = false,
            IsMoP = false,
        }
        loadfile("Materials.lua")("DisenchantBuddy", classicDisenchantBuddy)
        loadfile("Locales/enUS.lua")("DisenchantBuddy", classicDisenchantBuddy)
        loadfile("DisenchantResults/Uncommon.lua")("DisenchantBuddy", classicDisenchantBuddy)
        loadfile("DisenchantResults/Rare.lua")("DisenchantBuddy", classicDisenchantBuddy)
        loadfile("DisenchantResults/Epic.lua")("DisenchantBuddy", classicDisenchantBuddy)
        loadfile("MaterialSources.lua")("DisenchantBuddy", classicDisenchantBuddy)
        loadfile("AddMaterialInfo.lua")("DisenchantBuddy", classicDisenchantBuddy)

        -- SPIRIT_DUST is not defined for Classic, so its item ID is nil → not in the range map
        assert.is_nil(classicDisenchantBuddy.Materials.SPIRIT_DUST)
        classicDisenchantBuddy.AddMaterialInfo(gameTooltipMock, classicDisenchantBuddy.Materials.SPIRIT_DUST)

        assert.spy(gameTooltipMock.Show).was.not_called()
        assert.spy(gameTooltipMock.AddLine).was.not_called()
        assert.spy(gameTooltipMock.AddDoubleLine).was.not_called()
    end)

    it("should not include Cata materials on a TBC client", function()
        local tbcDisenchantBuddy = {
            IsClassic = false,
            IsSoD = false,
            IsTBC = true,
            IsWotLK = false,
            IsCata = false,
            IsMoP = false,
        }
        loadfile("Materials.lua")("DisenchantBuddy", tbcDisenchantBuddy)
        loadfile("Locales/enUS.lua")("DisenchantBuddy", tbcDisenchantBuddy)
        loadfile("DisenchantResults/Uncommon.lua")("DisenchantBuddy", tbcDisenchantBuddy)
        loadfile("DisenchantResults/Rare.lua")("DisenchantBuddy", tbcDisenchantBuddy)
        loadfile("DisenchantResults/Epic.lua")("DisenchantBuddy", tbcDisenchantBuddy)
        loadfile("MaterialSources.lua")("DisenchantBuddy", tbcDisenchantBuddy)
        loadfile("AddMaterialInfo.lua")("DisenchantBuddy", tbcDisenchantBuddy)

        -- HYPNOTIC_DUST is not defined for TBC, so its item ID is nil → not in the range map
        assert.is_nil(tbcDisenchantBuddy.Materials.HYPNOTIC_DUST)
        tbcDisenchantBuddy.AddMaterialInfo(gameTooltipMock, tbcDisenchantBuddy.Materials.HYPNOTIC_DUST)

        assert.spy(gameTooltipMock.Show).was.not_called()
        assert.spy(gameTooltipMock.AddLine).was.not_called()
        assert.spy(gameTooltipMock.AddDoubleLine).was.not_called()
    end)
end)
