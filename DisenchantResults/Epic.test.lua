describe("GetMaterialsForEpicItem", function()

    ---@type Materials
    local Materials
    local GetMaterialsForEpicItem

    before_each(function()
        -- We use `loadfile` over `require` to be able to hand in our own environment
        ---@type DisenchantBuddy
        local DisenchantBuddy = {}
        loadfile("Materials.lua")("DisenchantBuddy", DisenchantBuddy)
        Materials = DisenchantBuddy.Materials
        loadfile("DisenchantResults/Epic.lua")("DisenchantBuddy", DisenchantBuddy)
        GetMaterialsForEpicItem = DisenchantBuddy.GetMaterialsForEpicItem
    end)

    it("should return nil for unhandled item level", function()
        local results = GetMaterialsForEpicItem(66)

        assert.is_nil(results)
    end)

    it("should return correct results for level 5 items", function()
        local results = GetMaterialsForEpicItem(5)

        assert.are_same({Materials.SMALL_RADIANT_SHARD}, results)
    end)

    it("should return correct results for level 15 items", function()
        local results = GetMaterialsForEpicItem(15)

        assert.are_same({Materials.SMALL_RADIANT_SHARD}, results)
    end)

    it("should return correct results for level 16 items", function()
        local results = GetMaterialsForEpicItem(16)

        assert.are_same({Materials.SMALL_RADIANT_SHARD}, results)
    end)

    it("should return correct results for level 20 items", function()
        local results = GetMaterialsForEpicItem(20)

        assert.are_same({Materials.SMALL_RADIANT_SHARD}, results)
    end)

    it("should return correct results for level 21 items", function()
        local results = GetMaterialsForEpicItem(21)

        assert.are_same({Materials.SMALL_RADIANT_SHARD}, results)
    end)

    it("should return correct results for level 25 items", function()
        local results = GetMaterialsForEpicItem(25)

        assert.are_same({Materials.SMALL_RADIANT_SHARD}, results)
    end)

    it("should return correct results for level 26 items", function()
        local results = GetMaterialsForEpicItem(26)

        assert.are_same({Materials.SMALL_RADIANT_SHARD}, results)
    end)

    it("should return correct results for level 30 items", function()
        local results = GetMaterialsForEpicItem(30)

        assert.are_same({Materials.SMALL_RADIANT_SHARD}, results)
    end)

    it("should return correct results for level 31 items", function()
        local results = GetMaterialsForEpicItem(31)

        assert.are_same({Materials.SMALL_RADIANT_SHARD}, results)
    end)

    it("should return correct results for level 35 items", function()
        local results = GetMaterialsForEpicItem(35)

        assert.are_same({Materials.SMALL_RADIANT_SHARD}, results)
    end)

    it("should return correct results for level 36 items", function()
        local results = GetMaterialsForEpicItem(36)

        assert.are_same({Materials.SMALL_RADIANT_SHARD}, results)
    end)

    it("should return correct results for level 40 items", function()
        local results = GetMaterialsForEpicItem(40)

        assert.are_same({Materials.SMALL_RADIANT_SHARD}, results)
    end)

    it("should return correct results for level 41 items", function()
        local results = GetMaterialsForEpicItem(41)

        assert.are_same({Materials.SMALL_RADIANT_SHARD}, results)
    end)

    it("should return correct results for level 45 items", function()
        local results = GetMaterialsForEpicItem(45)

        assert.are_same({Materials.SMALL_RADIANT_SHARD}, results)
    end)

    it("should return correct results for level 46 items", function()
        local results = GetMaterialsForEpicItem(46)

        assert.are_same({Materials.LARGE_RADIANT_SHARD}, results)
    end)

    it("should return correct results for level 50 items", function()
        local results = GetMaterialsForEpicItem(50)

        assert.are_same({Materials.LARGE_RADIANT_SHARD}, results)
    end)

    it("should return correct results for level 51 items", function()
        local results = GetMaterialsForEpicItem(51)

        assert.are_same({Materials.SMALL_BRILLIANT_SHARD}, results)
    end)

    it("should return correct results for level 55 items", function()
        local results = GetMaterialsForEpicItem(55)

        assert.are_same({Materials.SMALL_BRILLIANT_SHARD}, results)
    end)

    it("should return correct results for level 56 items", function()
        local results = GetMaterialsForEpicItem(56)

        assert.are_same({Materials.NEXUS_CRYSTAL}, results)
    end)

    it("should return correct results for level 60 items", function()
        local results = GetMaterialsForEpicItem(60)

        assert.are_same({Materials.NEXUS_CRYSTAL}, results)
    end)

    it("should return correct results for level 61 items", function()
        local results = GetMaterialsForEpicItem(61)

        assert.are_same({Materials.NEXUS_CRYSTAL}, results)
    end)

    it("should return correct results for level 65 items", function()
        local results = GetMaterialsForEpicItem(65)

        assert.are_same({Materials.NEXUS_CRYSTAL}, results)
    end)
end)