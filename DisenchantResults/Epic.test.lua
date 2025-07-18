describe("GetMaterialsForEpicItem", function()

    ---@type Materials
    local Materials
    local GetMaterialsForEpicItem

    -- We use `loadfile` over `require` to be able to hand in our own environment
    ---@type DisenchantBuddy
    local DisenchantBuddy = {}

    before_each(function()
        DisenchantBuddy.IsTBC = true
        DisenchantBuddy.IsWotLK = true
        DisenchantBuddy.IsSoD = false
        loadfile("Materials.lua")("DisenchantBuddy", DisenchantBuddy)
        Materials = DisenchantBuddy.Materials
        loadfile("DisenchantResults/Epic.lua")("DisenchantBuddy", DisenchantBuddy)
        GetMaterialsForEpicItem = DisenchantBuddy.GetMaterialsForEpicItem
    end)

    it("should return nil for unhandled item level", function()
        local results = GetMaterialsForEpicItem(573)

        assert.is_nil(results)
    end)

    it("should return correct results for level 5 items", function()
        local results = GetMaterialsForEpicItem(5)

        assert.are_same({{itemId = Materials.SMALL_RADIANT_SHARD, probability = 100, minQuantity = 2, maxQuantity = 4}}, results)
    end)

    it("should return correct results for level 15 items", function()
        local results = GetMaterialsForEpicItem(15)

        assert.are_same({{itemId = Materials.SMALL_RADIANT_SHARD, probability = 100, minQuantity = 2, maxQuantity = 4}}, results)
    end)

    it("should return correct results for level 16 items", function()
        local results = GetMaterialsForEpicItem(16)

        assert.are_same({{itemId = Materials.SMALL_RADIANT_SHARD, probability = 100, minQuantity = 2, maxQuantity = 4}}, results)
    end)

    it("should return correct results for level 20 items", function()
        local results = GetMaterialsForEpicItem(20)

        assert.are_same({{itemId = Materials.SMALL_RADIANT_SHARD, probability = 100, minQuantity = 2, maxQuantity = 4}}, results)
    end)

    it("should return correct results for level 21 items", function()
        local results = GetMaterialsForEpicItem(21)

        assert.are_same({{itemId = Materials.SMALL_RADIANT_SHARD, probability = 100, minQuantity = 2, maxQuantity = 4}}, results)
    end)

    it("should return correct results for level 25 items", function()
        local results = GetMaterialsForEpicItem(25)

        assert.are_same({{itemId = Materials.SMALL_RADIANT_SHARD, probability = 100, minQuantity = 2, maxQuantity = 4}}, results)
    end)

    it("should return correct results for level 26 items", function()
        local results = GetMaterialsForEpicItem(26)

        assert.are_same({{itemId = Materials.SMALL_RADIANT_SHARD, probability = 100, minQuantity = 2, maxQuantity = 4}}, results)
    end)

    it("should return correct results for level 30 items", function()
        local results = GetMaterialsForEpicItem(30)

        assert.are_same({{itemId = Materials.SMALL_RADIANT_SHARD, probability = 100, minQuantity = 2, maxQuantity = 4}}, results)
    end)

    it("should return correct results for level 31 items", function()
        local results = GetMaterialsForEpicItem(31)

        assert.are_same({{itemId = Materials.SMALL_RADIANT_SHARD, probability = 100, minQuantity = 2, maxQuantity = 4}}, results)
    end)

    it("should return correct results for level 35 items", function()
        local results = GetMaterialsForEpicItem(35)

        assert.are_same({{itemId = Materials.SMALL_RADIANT_SHARD, probability = 100, minQuantity = 2, maxQuantity = 4}}, results)
    end)

    it("should return correct results for level 36 items", function()
        local results = GetMaterialsForEpicItem(36)

        assert.are_same({{itemId = Materials.SMALL_RADIANT_SHARD, probability = 100, minQuantity = 2, maxQuantity = 4}}, results)
    end)

    it("should return correct results for level 40 items", function()
        local results = GetMaterialsForEpicItem(40)

        assert.are_same({{itemId = Materials.SMALL_RADIANT_SHARD, probability = 100, minQuantity = 2, maxQuantity = 4}}, results)
    end)

    it("should return correct results for level 41 items", function()
        local results = GetMaterialsForEpicItem(41)

        assert.are_same({{itemId = Materials.SMALL_RADIANT_SHARD, probability = 100, minQuantity = 2, maxQuantity = 4}}, results)
    end)

    it("should return correct results for level 45 items", function()
        local results = GetMaterialsForEpicItem(45)

        assert.are_same({{itemId = Materials.SMALL_RADIANT_SHARD, probability = 100, minQuantity = 2, maxQuantity = 4}}, results)
    end)

    it("should return correct results for level 46 items", function()
        local results = GetMaterialsForEpicItem(46)

        assert.are_same({{itemId = Materials.LARGE_RADIANT_SHARD, probability = 100, minQuantity = 2, maxQuantity = 4}}, results)
    end)

    it("should return correct results for level 50 items", function()
        local results = GetMaterialsForEpicItem(50)

        assert.are_same({{itemId = Materials.LARGE_RADIANT_SHARD, probability = 100, minQuantity = 2, maxQuantity = 4}}, results)
    end)

    it("should return correct results for level 51 items", function()
        local results = GetMaterialsForEpicItem(51)

        assert.are_same({{itemId = Materials.SMALL_BRILLIANT_SHARD, probability = 100, minQuantity = 2, maxQuantity = 4}}, results)
    end)

    it("should return correct results for level 55 items", function()
        local results = GetMaterialsForEpicItem(55)

        assert.are_same({{itemId = Materials.SMALL_BRILLIANT_SHARD, probability = 100, minQuantity = 2, maxQuantity = 4}}, results)
    end)

    it("should return correct results for level 56 items", function()
        local results = GetMaterialsForEpicItem(56)

        assert.are_same({{itemId = Materials.NEXUS_CRYSTAL, probability = 100, minQuantity = 1, maxQuantity = 1}}, results)
    end)

    it("should return correct results for level 60 items", function()
        local results = GetMaterialsForEpicItem(60)

        assert.are_same({{itemId = Materials.NEXUS_CRYSTAL, probability = 100, minQuantity = 1, maxQuantity = 1}}, results)
    end)

    it("should return correct results for level 61 items", function()
        local results = GetMaterialsForEpicItem(61)

        assert.are_same({
            {itemId = Materials.NEXUS_CRYSTAL, probability = 33, minQuantity = 1, maxQuantity = 1},
            {itemId = Materials.NEXUS_CRYSTAL, probability = 67, minQuantity = 2, maxQuantity = 2},
        }, results)
    end)

    it("should return correct results for level 65 items", function()
        local results = GetMaterialsForEpicItem(65)

        assert.are_same({
            {itemId = Materials.NEXUS_CRYSTAL, probability = 33, minQuantity = 1, maxQuantity = 1},
            {itemId = Materials.NEXUS_CRYSTAL, probability = 67, minQuantity = 2, maxQuantity = 2},
        }, results)
    end)

    it("should return correct results for level 92 items", function()
        local results = GetMaterialsForEpicItem(92)

        assert.are_same({
            {itemId = Materials.NEXUS_CRYSTAL, probability = 33, minQuantity = 1, maxQuantity = 1},
            {itemId = Materials.NEXUS_CRYSTAL, probability = 67, minQuantity = 2, maxQuantity = 2},
        }, results)
    end)

    it("should return correct results for level 99 items", function()
        local results = GetMaterialsForEpicItem(99)

        assert.are_same({{itemId = Materials.VOID_CRYSTAL, probability = 100, minQuantity = 1, maxQuantity = 2}}, results)
    end)

    it("should return correct results for level 100 SoD items", function()
        DisenchantBuddy.IsSoD = true
        local results = GetMaterialsForEpicItem(100)

        assert.are_same({
            {itemId = Materials.NEXUS_CRYSTAL, probability = 33, minQuantity = 1, maxQuantity = 1},
            {itemId = Materials.NEXUS_CRYSTAL, probability = 67, minQuantity = 2, maxQuantity = 2},
        }, results)
    end)

    it("should return correct results for level 100 items", function()
        local results = GetMaterialsForEpicItem(100)

        assert.are_same({{itemId = Materials.VOID_CRYSTAL, probability = 100, minQuantity = 1, maxQuantity = 2}}, results)
    end)

    it("should return correct results for level 105 items", function()
        local results = GetMaterialsForEpicItem(105)

        assert.are_same({
            {itemId = Materials.VOID_CRYSTAL, probability = 33, minQuantity = 1, maxQuantity = 1},
            {itemId = Materials.VOID_CRYSTAL, probability = 67, minQuantity = 2, maxQuantity = 2},
        }, results)
    end)

    it("should return correct results for level 164 items", function()
        local results = GetMaterialsForEpicItem(164)

        assert.are_same({
            {itemId = Materials.VOID_CRYSTAL, probability = 33, minQuantity = 1, maxQuantity = 1},
            {itemId = Materials.VOID_CRYSTAL, probability = 67, minQuantity = 2, maxQuantity = 2},
        }, results)
    end)

    it("should return correct results for level 185 items", function()
        local results = GetMaterialsForEpicItem(185)

        assert.are_same({
            {itemId = Materials.ABYSS_CRYSTAL, probability = 100, minQuantity = 1, maxQuantity = 2},
        }, results)
    end)

    it("should return correct results for level 199 items", function()
        local results = GetMaterialsForEpicItem(199)

        assert.are_same({
            {itemId = Materials.ABYSS_CRYSTAL, probability = 100, minQuantity = 1, maxQuantity = 2},
        }, results)
    end)

    it("should return correct results for level 200 items", function()
        local results = GetMaterialsForEpicItem(200)

        assert.are_same({
            {itemId = Materials.ABYSS_CRYSTAL, probability = 100, minQuantity = 1, maxQuantity = 1},
        }, results)
    end)

    it("should return correct results for level 284 items", function()
        local results = GetMaterialsForEpicItem(284)

        assert.are_same({
            {itemId = Materials.ABYSS_CRYSTAL, probability = 100, minQuantity = 1, maxQuantity = 1},
        }, results)
    end)

    it("should return correct results for level 353 items", function()
        local results = GetMaterialsForEpicItem(353)

        assert.are_same({
            {itemId = Materials.MAELSTROM_CRYSTAL, probability = 100, minQuantity = 1, maxQuantity = 2},
        }, results)
    end)

    it("should return correct results for level 416 items", function()
        local results = GetMaterialsForEpicItem(416)

        assert.are_same({
            {itemId = Materials.MAELSTROM_CRYSTAL, probability = 100, minQuantity = 1, maxQuantity = 2},
        }, results)
    end)

    it("should return correct results for level 420 items", function()
        local results = GetMaterialsForEpicItem(420)

        assert.are_same({
            {itemId = Materials.SHA_CRYSTAL, probability = 100, minQuantity = 1, maxQuantity = 1},
        }, results)
    end)

    it("should return correct results for level 572 items", function()
        local results = GetMaterialsForEpicItem(572)

        assert.are_same({
            {itemId = Materials.SHA_CRYSTAL, probability = 100, minQuantity = 1, maxQuantity = 1},
        }, results)
    end)
end)