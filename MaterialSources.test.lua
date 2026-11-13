describe("MaterialSources", function()
    ---@type DisenchantBuddy
    local DisenchantBuddy
    ---@type Materials
    local Materials

    local function load(flags)
        DisenchantBuddy = flags
        loadfile("Materials.lua")("DisenchantBuddy", DisenchantBuddy)
        Materials = DisenchantBuddy.Materials
        loadfile("DisenchantResults/Uncommon.lua")("DisenchantBuddy", DisenchantBuddy)
        loadfile("DisenchantResults/Rare.lua")("DisenchantBuddy", DisenchantBuddy)
        loadfile("DisenchantResults/Epic.lua")("DisenchantBuddy", DisenchantBuddy)
        loadfile("MaterialSources.lua")("DisenchantBuddy", DisenchantBuddy)
    end

    before_each(function()
        load({IsClassic = true, IsSoD = false, IsTBC = false, IsWotLK = false, IsCata = false, IsMoP = false})
    end)

    it("should return nil for items that are not enchanting materials", function()
        assert.is_nil(DisenchantBuddy.GetMaterialSources(123))
    end)

    it("should split uncommon sources into armor and weapons", function()
        local sources = DisenchantBuddy.GetMaterialSources(Materials.STRANGE_DUST)

        assert.are_same({
            {quality = "uncommon", itemClass = "armor", minItemLevel = 1, maxItemLevel = 25, minChance = 75, maxChance = 80, isLowChance = false},
            {quality = "uncommon", itemClass = "weapon", minItemLevel = 1, maxItemLevel = 25, minChance = 15, maxChance = 20, isLowChance = false},
        }, sources)
    end)

    it("should split brackets at the low chance threshold", function()
        local sources = DisenchantBuddy.GetMaterialSources(Materials.SMALL_GLIMMERING_SHARD)

        assert.are_same({
            {quality = "uncommon", itemClass = "armor", minItemLevel = 16, maxItemLevel = 20, minChance = 5, maxChance = 5, isLowChance = true},
            {quality = "uncommon", itemClass = "armor", minItemLevel = 21, maxItemLevel = 25, minChance = 10, maxChance = 10, isLowChance = false},
            {quality = "uncommon", itemClass = "weapon", minItemLevel = 16, maxItemLevel = 20, minChance = 5, maxChance = 5, isLowChance = true},
            {quality = "uncommon", itemClass = "weapon", minItemLevel = 21, maxItemLevel = 25, minChance = 10, maxChance = 10, isLowChance = false},
            {quality = "rare", minItemLevel = 1, maxItemLevel = 25, minChance = 100, maxChance = 100, isLowChance = false},
        }, sources)
    end)

    it("should mark rare sources below the threshold as low chance", function()
        local sources = DisenchantBuddy.GetMaterialSources(Materials.NEXUS_CRYSTAL)
        local rare = sources[1]

        assert.are_same("rare", rare.quality)
        assert.is_true(rare.isLowChance)
    end)

    it("should sum the chances of a material listed multiple times for the same item level", function()
        local sources = DisenchantBuddy.GetMaterialSources(Materials.NEXUS_CRYSTAL)
        local epicSources = {}
        for _, source in ipairs(sources) do
            if source.quality == "epic" then
                table.insert(epicSources, source)
            end
        end

        assert.are_same(1, #epicSources)
        assert.are_same(100, epicSources[1].minChance)
        assert.are_same(100, epicSources[1].maxChance)
    end)

    it("should not include materials of later expansions", function()
        assert.is_nil(Materials.ARCANE_DUST)
        assert.is_nil(DisenchantBuddy.GetMaterialSources(22445))
    end)
end)
