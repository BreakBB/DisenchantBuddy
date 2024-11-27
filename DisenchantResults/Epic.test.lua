describe("GetEpicDisenchantResults", function()

    ---@type Materials
    local Materials
    local GetEpicDisenchantResults

    before_each(function()
        -- We use `loadfile` over `require` to be able to hand in our own environment
        ---@type DisenchantBuddy
        local DisenchantBuddy = {}
        loadfile("Materials.lua")("DisenchantBuddy", DisenchantBuddy)
        Materials = DisenchantBuddy.Materials
        loadfile("DisenchantResults/Epic.lua")("DisenchantBuddy", DisenchantBuddy)
        GetEpicDisenchantResults = DisenchantBuddy.GetEpicDisenchantResults
    end)

    it("should return nil for unhandled item level", function()
        local results = GetEpicDisenchantResults(66)

        assert.is_nil(results)
    end)

    it("should correct results level 5 items", function()
        local results = GetEpicDisenchantResults(5)

        assert.are_same({Materials.SMALL_RADIANT_SHARD}, results)
    end)

    it("should correct results level 15 items", function()
        local results = GetEpicDisenchantResults(15)

        assert.are_same({Materials.SMALL_RADIANT_SHARD}, results)
    end)

    it("should correct results level 16 items", function()
        local results = GetEpicDisenchantResults(16)

        assert.are_same({Materials.SMALL_RADIANT_SHARD}, results)
    end)

    it("should correct results level 20 items", function()
        local results = GetEpicDisenchantResults(20)

        assert.are_same({Materials.SMALL_RADIANT_SHARD}, results)
    end)

    it("should correct results level 21 items", function()
        local results = GetEpicDisenchantResults(21)

        assert.are_same({Materials.SMALL_RADIANT_SHARD}, results)
    end)

    it("should correct results level 25 items", function()
        local results = GetEpicDisenchantResults(25)

        assert.are_same({Materials.SMALL_RADIANT_SHARD}, results)
    end)

    it("should correct results level 26 items", function()
        local results = GetEpicDisenchantResults(26)

        assert.are_same({Materials.SMALL_RADIANT_SHARD}, results)
    end)

    it("should correct results level 30 items", function()
        local results = GetEpicDisenchantResults(30)

        assert.are_same({Materials.SMALL_RADIANT_SHARD}, results)
    end)

    it("should correct results level 31 items", function()
        local results = GetEpicDisenchantResults(31)

        assert.are_same({Materials.SMALL_RADIANT_SHARD}, results)
    end)

    it("should correct results level 35 items", function()
        local results = GetEpicDisenchantResults(35)

        assert.are_same({Materials.SMALL_RADIANT_SHARD}, results)
    end)

    it("should correct results level 36 items", function()
        local results = GetEpicDisenchantResults(36)

        assert.are_same({Materials.SMALL_RADIANT_SHARD}, results)
    end)

    it("should correct results level 40 items", function()
        local results = GetEpicDisenchantResults(40)

        assert.are_same({Materials.SMALL_RADIANT_SHARD}, results)
    end)

    it("should correct results level 41 items", function()
        local results = GetEpicDisenchantResults(41)

        assert.are_same({Materials.SMALL_RADIANT_SHARD}, results)
    end)

    it("should correct results level 45 items", function()
        local results = GetEpicDisenchantResults(45)

        assert.are_same({Materials.SMALL_RADIANT_SHARD}, results)
    end)

    it("should correct results level 46 items", function()
        local results = GetEpicDisenchantResults(46)

        assert.are_same({Materials.LARGE_RADIANT_SHARD}, results)
    end)

    it("should correct results level 50 items", function()
        local results = GetEpicDisenchantResults(50)

        assert.are_same({Materials.LARGE_RADIANT_SHARD}, results)
    end)

    it("should correct results level 51 items", function()
        local results = GetEpicDisenchantResults(51)

        assert.are_same({Materials.SMALL_BRILLIANT_SHARD}, results)
    end)

    it("should correct results level 55 items", function()
        local results = GetEpicDisenchantResults(55)

        assert.are_same({Materials.SMALL_BRILLIANT_SHARD}, results)
    end)

    it("should correct results level 56 items", function()
        local results = GetEpicDisenchantResults(56)

        assert.are_same({Materials.NEXUS_CRYSTAL}, results)
    end)

    it("should correct results level 60 items", function()
        local results = GetEpicDisenchantResults(60)

        assert.are_same({Materials.NEXUS_CRYSTAL}, results)
    end)

    it("should correct results level 61 items", function()
        local results = GetEpicDisenchantResults(61)

        assert.are_same({Materials.NEXUS_CRYSTAL}, results)
    end)

    it("should correct results level 65 items", function()
        local results = GetEpicDisenchantResults(65)

        assert.are_same({Materials.NEXUS_CRYSTAL}, results)
    end)
end)