describe("GetMaterialsForRareItem", function()

    ---@type Materials
    local Materials
    local GetMaterialsForRareItem

    before_each(function()
        -- We use `loadfile` over `require` to be able to hand in our own environment
        ---@type DisenchantBuddy
        local DisenchantBuddy = {}
        loadfile("Materials.lua")("DisenchantBuddy", DisenchantBuddy)
        Materials = DisenchantBuddy.Materials
        loadfile("DisenchantResults/Rare.lua")("DisenchantBuddy", DisenchantBuddy)
        GetMaterialsForRareItem = DisenchantBuddy.GetMaterialsForRareItem
    end)

    it("should return nil for unhandled item level", function()
        local results = GetMaterialsForRareItem(66)

        assert.is_nil(results)
    end)

    it("should return correct results for level 5 items", function()
        local results = GetMaterialsForRareItem(5)

        assert.are_same({{itemId = Materials.SMALL_GLIMMERING_SHARD, probability = 100}}, results)
    end)

    it("should return correct results for level 15 items", function()
        local results = GetMaterialsForRareItem(15)

        assert.are_same({{itemId = Materials.SMALL_GLIMMERING_SHARD, probability = 100}}, results)
    end)

    it("should return correct results for level 16 items", function()
        local results = GetMaterialsForRareItem(16)

        assert.are_same({{itemId = Materials.SMALL_GLIMMERING_SHARD, probability = 100}}, results)
    end)

    it("should return correct results for level 20 items", function()
        local results = GetMaterialsForRareItem(20)

        assert.are_same({{itemId = Materials.SMALL_GLIMMERING_SHARD, probability = 100}}, results)
    end)

    it("should return correct results for level 21 items", function()
        local results = GetMaterialsForRareItem(21)

        assert.are_same({{itemId = Materials.SMALL_GLIMMERING_SHARD, probability = 100}}, results)
    end)

    it("should return correct results for level 25 items", function()
        local results = GetMaterialsForRareItem(25)

        assert.are_same({{itemId = Materials.SMALL_GLIMMERING_SHARD, probability = 100}}, results)
    end)

    it("should return correct results for level 26 items", function()
        local results = GetMaterialsForRareItem(26)

        assert.are_same({Materials.LARGE_GLIMMERING_SHARD}, results)
    end)

    it("should return correct results for level 30 items", function()
        local results = GetMaterialsForRareItem(30)

        assert.are_same({Materials.LARGE_GLIMMERING_SHARD}, results)
    end)

    it("should return correct results for level 31 items", function()
        local results = GetMaterialsForRareItem(31)

        assert.are_same({Materials.SMALL_GLOWING_SHARD}, results)
    end)

    it("should return correct results for level 35 items", function()
        local results = GetMaterialsForRareItem(35)

        assert.are_same({Materials.SMALL_GLOWING_SHARD}, results)
    end)

    it("should return correct results for level 36 items", function()
        local results = GetMaterialsForRareItem(36)

        assert.are_same({Materials.LARGE_GLOWING_SHARD}, results)
    end)

    it("should return correct results for level 40 items", function()
        local results = GetMaterialsForRareItem(40)

        assert.are_same({Materials.LARGE_GLOWING_SHARD}, results)
    end)

    it("should return correct results for level 41 items", function()
        local results = GetMaterialsForRareItem(41)

        assert.are_same({Materials.SMALL_RADIANT_SHARD}, results)
    end)

    it("should return correct results for level 45 items", function()
        local results = GetMaterialsForRareItem(45)

        assert.are_same({Materials.SMALL_RADIANT_SHARD}, results)
    end)

    it("should return correct results for level 46 items", function()
        local results = GetMaterialsForRareItem(46)

        assert.are_same({Materials.LARGE_RADIANT_SHARD}, results)
    end)

    it("should return correct results for level 50 items", function()
        local results = GetMaterialsForRareItem(50)

        assert.are_same({Materials.LARGE_RADIANT_SHARD}, results)
    end)

    it("should return correct results for level 51 items", function()
        local results = GetMaterialsForRareItem(51)

        assert.are_same({Materials.SMALL_BRILLIANT_SHARD}, results)
    end)

    it("should return correct results for level 55 items", function()
        local results = GetMaterialsForRareItem(55)

        assert.are_same({Materials.SMALL_BRILLIANT_SHARD}, results)
    end)

    it("should return correct results for level 56 items", function()
        local results = GetMaterialsForRareItem(56)

        assert.are_same({Materials.LARGE_BRILLIANT_SHARD, Materials.NEXUS_CRYSTAL}, results)
    end)

    it("should return correct results for level 60 items", function()
        local results = GetMaterialsForRareItem(60)

        assert.are_same({Materials.LARGE_BRILLIANT_SHARD, Materials.NEXUS_CRYSTAL}, results)
    end)

    it("should return correct results for level 61 items", function()
        local results = GetMaterialsForRareItem(61)

        assert.are_same({Materials.LARGE_BRILLIANT_SHARD, Materials.NEXUS_CRYSTAL}, results)
    end)

    it("should return correct results for level 65 items", function()
        local results = GetMaterialsForRareItem(65)

        assert.are_same({Materials.LARGE_BRILLIANT_SHARD, Materials.NEXUS_CRYSTAL}, results)
    end)
end)