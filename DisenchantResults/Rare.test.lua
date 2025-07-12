describe("GetMaterialsForRareItem", function()

    ---@type Materials
    local Materials
    local GetMaterialsForRareItem

    before_each(function()
        -- We use `loadfile` over `require` to be able to hand in our own environment
        ---@type DisenchantBuddy
        local DisenchantBuddy = {}
        DisenchantBuddy.IsTBC = true
        DisenchantBuddy.IsWotLK = true
        loadfile("Materials.lua")("DisenchantBuddy", DisenchantBuddy)
        Materials = DisenchantBuddy.Materials
        loadfile("DisenchantResults/Rare.lua")("DisenchantBuddy", DisenchantBuddy)
        GetMaterialsForRareItem = DisenchantBuddy.GetMaterialsForRareItem
    end)

    it("should return nil for unhandled item level", function()
        local results = GetMaterialsForRareItem(477)

        assert.is_nil(results)
    end)

    it("should return correct results for level 5 items", function()
        local results = GetMaterialsForRareItem(5)

        assert.are_same({{itemId = Materials.SMALL_GLIMMERING_SHARD, probability = 100, minQuantity = 1, maxQuantity = 1}}, results)
    end)

    it("should return correct results for level 15 items", function()
        local results = GetMaterialsForRareItem(15)

        assert.are_same({{itemId = Materials.SMALL_GLIMMERING_SHARD, probability = 100, minQuantity = 1, maxQuantity = 1}}, results)
    end)

    it("should return correct results for level 16 items", function()
        local results = GetMaterialsForRareItem(16)

        assert.are_same({{itemId = Materials.SMALL_GLIMMERING_SHARD, probability = 100, minQuantity = 1, maxQuantity = 1}}, results)
    end)

    it("should return correct results for level 20 items", function()
        local results = GetMaterialsForRareItem(20)

        assert.are_same({{itemId = Materials.SMALL_GLIMMERING_SHARD, probability = 100, minQuantity = 1, maxQuantity = 1}}, results)
    end)

    it("should return correct results for level 21 items", function()
        local results = GetMaterialsForRareItem(21)

        assert.are_same({{itemId = Materials.SMALL_GLIMMERING_SHARD, probability = 100, minQuantity = 1, maxQuantity = 1}}, results)
    end)

    it("should return correct results for level 25 items", function()
        local results = GetMaterialsForRareItem(25)

        assert.are_same({{itemId = Materials.SMALL_GLIMMERING_SHARD, probability = 100, minQuantity = 1, maxQuantity = 1}}, results)
    end)

    it("should return correct results for level 26 items", function()
        local results = GetMaterialsForRareItem(26)

        assert.are_same({{itemId = Materials.LARGE_GLIMMERING_SHARD, probability = 100, minQuantity = 1, maxQuantity = 1}}, results)
    end)

    it("should return correct results for level 30 items", function()
        local results = GetMaterialsForRareItem(30)

        assert.are_same({{itemId = Materials.LARGE_GLIMMERING_SHARD, probability = 100, minQuantity = 1, maxQuantity = 1}}, results)
    end)

    it("should return correct results for level 31 items", function()
        local results = GetMaterialsForRareItem(31)

        assert.are_same({{itemId = Materials.SMALL_GLOWING_SHARD, probability = 100, minQuantity = 1, maxQuantity = 1}}, results)
    end)

    it("should return correct results for level 35 items", function()
        local results = GetMaterialsForRareItem(35)

        assert.are_same({{itemId = Materials.SMALL_GLOWING_SHARD, probability = 100, minQuantity = 1, maxQuantity = 1}}, results)
    end)

    it("should return correct results for level 36 items", function()
        local results = GetMaterialsForRareItem(36)

        assert.are_same({{itemId = Materials.LARGE_GLOWING_SHARD, probability = 100, minQuantity = 1, maxQuantity = 1}}, results)
    end)

    it("should return correct results for level 40 items", function()
        local results = GetMaterialsForRareItem(40)

        assert.are_same({{itemId = Materials.LARGE_GLOWING_SHARD, probability = 100, minQuantity = 1, maxQuantity = 1}}, results)
    end)

    it("should return correct results for level 41 items", function()
        local results = GetMaterialsForRareItem(41)

        assert.are_same({{itemId = Materials.SMALL_RADIANT_SHARD, probability = 100, minQuantity = 1, maxQuantity = 1}}, results)
    end)

    it("should return correct results for level 45 items", function()
        local results = GetMaterialsForRareItem(45)

        assert.are_same({{itemId = Materials.SMALL_RADIANT_SHARD, probability = 100, minQuantity = 1, maxQuantity = 1}}, results)
    end)

    it("should return correct results for level 46 items", function()
        local results = GetMaterialsForRareItem(46)

        assert.are_same({{itemId = Materials.LARGE_RADIANT_SHARD, probability = 100, minQuantity = 1, maxQuantity = 1}}, results)
    end)

    it("should return correct results for level 50 items", function()
        local results = GetMaterialsForRareItem(50)

        assert.are_same({{itemId = Materials.LARGE_RADIANT_SHARD, probability = 100, minQuantity = 1, maxQuantity = 1}}, results)
    end)

    it("should return correct results for level 51 items", function()
        local results = GetMaterialsForRareItem(51)

        assert.are_same({{itemId = Materials.SMALL_BRILLIANT_SHARD, probability = 100, minQuantity = 1, maxQuantity = 1}}, results)
    end)

    it("should return correct results for level 55 items", function()
        local results = GetMaterialsForRareItem(55)

        assert.are_same({{itemId = Materials.SMALL_BRILLIANT_SHARD, probability = 100, minQuantity = 1, maxQuantity = 1}}, results)
    end)

    it("should return correct results for level 56 items", function()
        local results = GetMaterialsForRareItem(56)

        assert.are_same({
            {itemId = Materials.LARGE_BRILLIANT_SHARD, probability = 99.5, minQuantity = 1, maxQuantity = 1},
            {itemId = Materials.NEXUS_CRYSTAL, probability = 0.5, minQuantity = 1, maxQuantity = 1},
        }, results)
    end)

    it("should return correct results for level 60 items", function()
        local results = GetMaterialsForRareItem(60)

        assert.are_same({
            {itemId = Materials.LARGE_BRILLIANT_SHARD, probability = 99.5, minQuantity = 1, maxQuantity = 1},
            {itemId = Materials.NEXUS_CRYSTAL, probability = 0.5, minQuantity = 1, maxQuantity = 1},
        }, results)
    end)

    it("should return correct results for level 61 items", function()
        local results = GetMaterialsForRareItem(61)

        assert.are_same({
            {itemId = Materials.LARGE_BRILLIANT_SHARD, probability = 99.5, minQuantity = 1, maxQuantity = 1},
            {itemId = Materials.NEXUS_CRYSTAL, probability = 0.5, minQuantity = 1, maxQuantity = 1},
        }, results)
    end)

    it("should return correct results for level 86 items", function()
        local results = GetMaterialsForRareItem(86)

        assert.are_same({
            {itemId = Materials.LARGE_BRILLIANT_SHARD, probability = 99.5, minQuantity = 1, maxQuantity = 1},
            {itemId = Materials.NEXUS_CRYSTAL, probability = 0.5, minQuantity = 1, maxQuantity = 1},
        }, results)
    end)

    it("should return correct results for level 87 items", function()
        local results = GetMaterialsForRareItem(87)

        assert.are_same({
            {itemId = Materials.SMALL_PRISMATIC_SHARD, probability = 99.5, minQuantity = 1, maxQuantity = 1},
            {itemId = Materials.NEXUS_CRYSTAL, probability = 0.5, minQuantity = 1, maxQuantity = 1},
        }, results)
    end)

    it("should return correct results for level 99 items", function()
        local results = GetMaterialsForRareItem(99)

        assert.are_same({
            {itemId = Materials.SMALL_PRISMATIC_SHARD, probability = 99.5, minQuantity = 1, maxQuantity = 1},
            {itemId = Materials.NEXUS_CRYSTAL, probability = 0.5, minQuantity = 1, maxQuantity = 1},
        }, results)
    end)

    it("should return correct results for level 100 items", function()
        local results = GetMaterialsForRareItem(100)

        assert.are_same({
            {itemId = Materials.LARGE_PRISMATIC_SHARD, probability = 99.5, minQuantity = 1, maxQuantity = 1},
            {itemId = Materials.VOID_CRYSTAL, probability = 0.5, minQuantity = 1, maxQuantity = 1},
        }, results)
    end)

    it("should return correct results for level 115 items", function()
        local results = GetMaterialsForRareItem(115)

        assert.are_same({
            {itemId = Materials.LARGE_PRISMATIC_SHARD, probability = 99.5, minQuantity = 1, maxQuantity = 1},
            {itemId = Materials.VOID_CRYSTAL, probability = 0.5, minQuantity = 1, maxQuantity = 1},
        }, results)
    end)

    it("should return correct results for level 130 items", function()
        local results = GetMaterialsForRareItem(130)

        assert.are_same({
            {itemId = Materials.SMALL_DREAM_SHARD, probability = 100, minQuantity = 1, maxQuantity = 1},
        }, results)
    end)

    it("should return correct results for level 166 items", function()
        local results = GetMaterialsForRareItem(166)

        assert.are_same({
            {itemId = Materials.SMALL_DREAM_SHARD, probability = 100, minQuantity = 1, maxQuantity = 1},
        }, results)
    end)

    it("should return correct results for level 167 items", function()
        local results = GetMaterialsForRareItem(167)

        assert.are_same({
            {itemId = Materials.DREAM_SHARD, probability = 100, minQuantity = 1, maxQuantity = 1},
        }, results)
    end)

    it("should return correct results for level 200 items", function()
        local results = GetMaterialsForRareItem(200)

        assert.are_same({
            {itemId = Materials.DREAM_SHARD, probability = 100, minQuantity = 1, maxQuantity = 1},
        }, results)
    end)

    it("should return correct results for level 288 items", function()
        local results = GetMaterialsForRareItem(288)

        assert.are_same({
            {itemId = Materials.SMALL_HEAVENLY_SHARD, probability = 100, minQuantity = 1, maxQuantity = 2},
        }, results)
    end)

    it("should return correct results for level 316 items", function()
        local results = GetMaterialsForRareItem(316)

        assert.are_same({
            {itemId = Materials.SMALL_HEAVENLY_SHARD, probability = 100, minQuantity = 1, maxQuantity = 2},
        }, results)
    end)

    it("should return correct results for level 318 items", function()
        local results = GetMaterialsForRareItem(318)

        assert.are_same({
            {itemId = Materials.HEAVENLY_SHARD, probability = 100, minQuantity = 1, maxQuantity = 2},
        }, results)
    end)

    it("should return correct results for level 377 items", function()
        local results = GetMaterialsForRareItem(377)

        assert.are_same({
            {itemId = Materials.HEAVENLY_SHARD, probability = 100, minQuantity = 1, maxQuantity = 2},
        }, results)
    end)

    it("should return correct results for level 393 items", function()
        local results = GetMaterialsForRareItem(393)

        assert.are_same({
            {itemId = Materials.SMALL_ETHEREAL_SHARD, probability = 100, minQuantity = 1, maxQuantity = 1},
        }, results)
    end)

    it("should return correct results for level 424 items", function()
        local results = GetMaterialsForRareItem(424)

        assert.are_same({
            {itemId = Materials.SMALL_ETHEREAL_SHARD, probability = 100, minQuantity = 1, maxQuantity = 1},
        }, results)
    end)

    it("should return correct results for level 425 items", function()
        local results = GetMaterialsForRareItem(425)

        assert.are_same({
            {itemId = Materials.ETHEREAL_SHARD, probability = 100, minQuantity = 1, maxQuantity = 1},
        }, results)
    end)

    it("should return correct results for level 476 items", function()
        local results = GetMaterialsForRareItem(476)

        assert.are_same({
            {itemId = Materials.ETHEREAL_SHARD, probability = 100, minQuantity = 1, maxQuantity = 1},
        }, results)
    end)
end)