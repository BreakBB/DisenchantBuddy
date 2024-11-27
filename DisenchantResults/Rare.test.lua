describe("GetRareDisenchantResults", function()

    ---@type Materials
    local Materials
    local GetRareDisenchantResults

    before_each(function()
        -- We use `loadfile` over `require` to be able to hand in our own environment
        ---@type DisenchantBuddy
        local DisenchantBuddy = {}
        loadfile("Materials.lua")("DisenchantBuddy", DisenchantBuddy)
        Materials = DisenchantBuddy.Materials
        loadfile("DisenchantResults/Rare.lua")("DisenchantBuddy", DisenchantBuddy)
        GetRareDisenchantResults = DisenchantBuddy.GetRareDisenchantResults
    end)

    it("should return nil for unhandled item level", function()
        local results = GetRareDisenchantResults(66)

        assert.is_nil(results)
    end)

    it("should correct results level 5 items", function()
        local results = GetRareDisenchantResults(5)

        assert.are_same({Materials.SMALL_GLIMMERING_SHARD}, results)
    end)

    it("should correct results level 15 items", function()
        local results = GetRareDisenchantResults(15)

        assert.are_same({Materials.SMALL_GLIMMERING_SHARD}, results)
    end)

    it("should correct results level 16 items", function()
        local results = GetRareDisenchantResults(16)

        assert.are_same({Materials.SMALL_GLIMMERING_SHARD}, results)
    end)

    it("should correct results level 20 items", function()
        local results = GetRareDisenchantResults(20)

        assert.are_same({Materials.SMALL_GLIMMERING_SHARD}, results)
    end)

    it("should correct results level 21 items", function()
        local results = GetRareDisenchantResults(21)

        assert.are_same({Materials.SMALL_GLIMMERING_SHARD}, results)
    end)

    it("should correct results level 25 items", function()
        local results = GetRareDisenchantResults(25)

        assert.are_same({Materials.SMALL_GLIMMERING_SHARD}, results)
    end)

    it("should correct results level 26 items", function()
        local results = GetRareDisenchantResults(26)

        assert.are_same({Materials.LARGE_GLIMMERING_SHARD}, results)
    end)

    it("should correct results level 30 items", function()
        local results = GetRareDisenchantResults(30)

        assert.are_same({Materials.LARGE_GLIMMERING_SHARD}, results)
    end)

    it("should correct results level 31 items", function()
        local results = GetRareDisenchantResults(31)

        assert.are_same({Materials.SMALL_GLOWING_SHARD}, results)
    end)

    it("should correct results level 35 items", function()
        local results = GetRareDisenchantResults(35)

        assert.are_same({Materials.SMALL_GLOWING_SHARD}, results)
    end)

    it("should correct results level 36 items", function()
        local results = GetRareDisenchantResults(36)

        assert.are_same({Materials.LARGE_GLOWING_SHARD}, results)
    end)

    it("should correct results level 40 items", function()
        local results = GetRareDisenchantResults(40)

        assert.are_same({Materials.LARGE_GLOWING_SHARD}, results)
    end)

    it("should correct results level 41 items", function()
        local results = GetRareDisenchantResults(41)

        assert.are_same({Materials.SMALL_RADIANT_SHARD}, results)
    end)

    it("should correct results level 45 items", function()
        local results = GetRareDisenchantResults(45)

        assert.are_same({Materials.SMALL_RADIANT_SHARD}, results)
    end)

    it("should correct results level 46 items", function()
        local results = GetRareDisenchantResults(46)

        assert.are_same({Materials.LARGE_RADIANT_SHARD}, results)
    end)

    it("should correct results level 50 items", function()
        local results = GetRareDisenchantResults(50)

        assert.are_same({Materials.LARGE_RADIANT_SHARD}, results)
    end)

    it("should correct results level 51 items", function()
        local results = GetRareDisenchantResults(51)

        assert.are_same({Materials.SMALL_BRILLIANT_SHARD}, results)
    end)

    it("should correct results level 55 items", function()
        local results = GetRareDisenchantResults(55)

        assert.are_same({Materials.SMALL_BRILLIANT_SHARD}, results)
    end)

    it("should correct results level 56 items", function()
        local results = GetRareDisenchantResults(56)

        assert.are_same({Materials.LARGE_BRILLIANT_SHARD, Materials.NEXUS_CRYSTAL}, results)
    end)

    it("should correct results level 60 items", function()
        local results = GetRareDisenchantResults(60)

        assert.are_same({Materials.LARGE_BRILLIANT_SHARD, Materials.NEXUS_CRYSTAL}, results)
    end)

    it("should correct results level 61 items", function()
        local results = GetRareDisenchantResults(61)

        assert.are_same({Materials.LARGE_BRILLIANT_SHARD, Materials.NEXUS_CRYSTAL}, results)
    end)

    it("should correct results level 65 items", function()
        local results = GetRareDisenchantResults(65)

        assert.are_same({Materials.LARGE_BRILLIANT_SHARD, Materials.NEXUS_CRYSTAL}, results)
    end)
end)