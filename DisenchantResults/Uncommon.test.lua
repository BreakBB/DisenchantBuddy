describe("GetUncommonDisenchantResults", function()

    ---@type Materials
    local Materials
    local GetUncommonDisenchantResults

    before_each(function()
        -- We use `loadfile` over `require` to be able to hand in our own environment
        ---@type DisenchantBuddy
        local DisenchantBuddy = {}
        loadfile("Materials.lua")("DisenchantBuddy", DisenchantBuddy)
        Materials = DisenchantBuddy.Materials
        loadfile("DisenchantResults/Uncommon.lua")("DisenchantBuddy", DisenchantBuddy)
        GetUncommonDisenchantResults = DisenchantBuddy.GetUncommonDisenchantResults
    end)

    it("should return nil for unhandled item level", function()
        local results = GetUncommonDisenchantResults(66)

        assert.is_nil(results)
    end)

    it("should return correct results for level 5 items", function()
        local results = GetUncommonDisenchantResults(5)

        assert.are_same({Materials.STRANGE_DUST, Materials.LESSER_MAGIC_ESSENCE}, results)
    end)

    it("should return correct results for level 15 items", function()
        local results = GetUncommonDisenchantResults(15)

        assert.are_same({Materials.STRANGE_DUST, Materials.LESSER_MAGIC_ESSENCE}, results)
    end)

    it("should return correct results for level 16 items", function()
        local results = GetUncommonDisenchantResults(16)

        assert.are_same({Materials.STRANGE_DUST, Materials.GREATER_MAGIC_ESSENCE}, results)
    end)

    it("should return correct results for level 20 items", function()
        local results = GetUncommonDisenchantResults(20)

        assert.are_same({Materials.STRANGE_DUST, Materials.GREATER_MAGIC_ESSENCE}, results)
    end)

    it("should return correct results for level 21 items", function()
        local results = GetUncommonDisenchantResults(21)

        assert.are_same({Materials.STRANGE_DUST, Materials.LESSER_ASTRAL_ESSENCE, Materials.SMALL_GLIMMERING_SHARD}, results)
    end)

    it("should return correct results for level 25 items", function()
        local results = GetUncommonDisenchantResults(25)

        assert.are_same({Materials.STRANGE_DUST, Materials.LESSER_ASTRAL_ESSENCE, Materials.SMALL_GLIMMERING_SHARD}, results)
    end)

    it("should return correct results for level 26 items", function()
        local results = GetUncommonDisenchantResults(26)

        assert.are_same({Materials.SOUL_DUST, Materials.GREATER_ASTRAL_ESSENCE, Materials.LARGE_GLIMMERING_SHARD}, results)
    end)

    it("should return correct results for level 30 items", function()
        local results = GetUncommonDisenchantResults(30)

        assert.are_same({Materials.SOUL_DUST, Materials.GREATER_ASTRAL_ESSENCE, Materials.LARGE_GLIMMERING_SHARD}, results)
    end)

    it("should return correct results for level 31 items", function()
        local results = GetUncommonDisenchantResults(31)

        assert.are_same({Materials.SOUL_DUST, Materials.LESSER_MYSTIC_ESSENCE, Materials.SMALL_GLOWING_SHARD}, results)
    end)

    it("should return correct results for level 35 items", function()
        local results = GetUncommonDisenchantResults(35)

        assert.are_same({Materials.SOUL_DUST, Materials.LESSER_MYSTIC_ESSENCE, Materials.SMALL_GLOWING_SHARD}, results)
    end)

    it("should return correct results for level 36 items", function()
        local results = GetUncommonDisenchantResults(36)

        assert.are_same({Materials.VISION_DUST, Materials.GREATER_MYSTIC_ESSENCE, Materials.LARGE_GLOWING_SHARD}, results)
    end)

    it("should return correct results for level 40 items", function()
        local results = GetUncommonDisenchantResults(40)

        assert.are_same({Materials.VISION_DUST, Materials.GREATER_MYSTIC_ESSENCE, Materials.LARGE_GLOWING_SHARD}, results)
    end)

    it("should return correct results for level 41 items", function()
        local results = GetUncommonDisenchantResults(41)

        assert.are_same({Materials.VISION_DUST, Materials.LESSER_NETHER_ESSENCE, Materials.SMALL_RADIANT_SHARD}, results)
    end)

    it("should return correct results for level 45 items", function()
        local results = GetUncommonDisenchantResults(45)

        assert.are_same({Materials.VISION_DUST, Materials.LESSER_NETHER_ESSENCE, Materials.SMALL_RADIANT_SHARD}, results)
    end)

    it("should return correct results for level 46 items", function()
        local results = GetUncommonDisenchantResults(46)

        assert.are_same({Materials.DREAM_DUST, Materials.GREATER_NETHER_ESSENCE, Materials.LARGE_RADIANT_SHARD}, results)
    end)

    it("should return correct results for level 50 items", function()
        local results = GetUncommonDisenchantResults(50)

        assert.are_same({Materials.DREAM_DUST, Materials.GREATER_NETHER_ESSENCE, Materials.LARGE_RADIANT_SHARD}, results)
    end)

    it("should return correct results for level 51 items", function()
        local results = GetUncommonDisenchantResults(51)

        assert.are_same({Materials.DREAM_DUST, Materials.LESSER_ETERNAL_ESSENCE, Materials.SMALL_BRILLIANT_SHARD}, results)
    end)

    it("should return correct results for level 55 items", function()
        local results = GetUncommonDisenchantResults(55)

        assert.are_same({Materials.DREAM_DUST, Materials.LESSER_ETERNAL_ESSENCE, Materials.SMALL_BRILLIANT_SHARD}, results)
    end)

    it("should return correct results for level 56 items", function()
        local results = GetUncommonDisenchantResults(56)

        assert.are_same({Materials.ILLUSION_DUST, Materials.GREATER_ETERNAL_ESSENCE, Materials.LARGE_BRILLIANT_SHARD}, results)
    end)

    it("should return correct results for level 60 items", function()
        local results = GetUncommonDisenchantResults(60)

        assert.are_same({Materials.ILLUSION_DUST, Materials.GREATER_ETERNAL_ESSENCE, Materials.LARGE_BRILLIANT_SHARD}, results)
    end)

    it("should return correct results for level 61 items", function()
        local results = GetUncommonDisenchantResults(61)

        assert.are_same({Materials.ILLUSION_DUST, Materials.GREATER_ETERNAL_ESSENCE, Materials.LARGE_BRILLIANT_SHARD}, results)
    end)

    it("should return correct results for level 65 items", function()
        local results = GetUncommonDisenchantResults(65)

        assert.are_same({Materials.ILLUSION_DUST, Materials.GREATER_ETERNAL_ESSENCE, Materials.LARGE_BRILLIANT_SHARD}, results)
    end)
end)