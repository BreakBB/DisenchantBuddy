describe("GetMaterialsForUncommonItem", function()

    ---@type Materials
    local Materials
    local GetMaterialsForUncommonItem

    before_each(function()
        -- We use `loadfile` over `require` to be able to hand in our own environment
        ---@type DisenchantBuddy
        local DisenchantBuddy = {}
        loadfile("Materials.lua")("DisenchantBuddy", DisenchantBuddy)
        Materials = DisenchantBuddy.Materials
        loadfile("DisenchantResults/Uncommon.lua")("DisenchantBuddy", DisenchantBuddy)
        GetMaterialsForUncommonItem = DisenchantBuddy.GetMaterialsForUncommonItem
    end)

    it("should return nil for unhandled item level", function()
        local results = GetMaterialsForUncommonItem(66)

        assert.is_nil(results)
    end)

    it("should return correct results for level 5 items", function()
        local results = GetMaterialsForUncommonItem(5)

        assert.are_same({
            {itemId = Materials.STRANGE_DUST, probability = 80},
            {itemId = Materials.LESSER_MAGIC_ESSENCE, probability = 20},
        }, results)
    end)

    it("should return correct results for level 15 items", function()
        local results = GetMaterialsForUncommonItem(15)

        assert.are_same({
            {itemId = Materials.STRANGE_DUST, probability = 80},
            {itemId = Materials.LESSER_MAGIC_ESSENCE, probability = 20},
        }, results)
    end)

    it("should return correct results for level 16 items", function()
        local results = GetMaterialsForUncommonItem(16)

        assert.are_same({
            {itemId = Materials.STRANGE_DUST, probability = 75},
            {itemId = Materials.GREATER_MAGIC_ESSENCE, probability = 20},
            {itemId = Materials.SMALL_GLIMMERING_SHARD, probability = 5},
        }, results)
    end)

    it("should return correct results for level 20 items", function()
        local results = GetMaterialsForUncommonItem(20)

        assert.are_same({
            {itemId = Materials.STRANGE_DUST, probability = 75},
            {itemId = Materials.GREATER_MAGIC_ESSENCE, probability = 20},
            {itemId = Materials.SMALL_GLIMMERING_SHARD, probability = 5},
        }, results)
    end)

    it("should return correct results for level 21 items", function()
        local results = GetMaterialsForUncommonItem(21)

        assert.are_same({
            {itemId = Materials.STRANGE_DUST, probability = 75},
            {itemId = Materials.LESSER_ASTRAL_ESSENCE, probability = 15},
            {itemId = Materials.SMALL_GLIMMERING_SHARD, probability = 10},
        }, results)
    end)

    it("should return correct results for level 25 items", function()
        local results = GetMaterialsForUncommonItem(25)

        assert.are_same({
            {itemId = Materials.STRANGE_DUST, probability = 75},
            {itemId = Materials.LESSER_ASTRAL_ESSENCE, probability = 15},
            {itemId = Materials.SMALL_GLIMMERING_SHARD, probability = 10},
        }, results)
    end)

    it("should return correct results for level 26 items", function()
        local results = GetMaterialsForUncommonItem(26)

        assert.are_same({
            {itemId = Materials.SOUL_DUST, probability = 75},
            {itemId = Materials.GREATER_ASTRAL_ESSENCE, probability = 20},
            {itemId = Materials.LARGE_GLIMMERING_SHARD, probability = 5},
        }, results)
    end)

    it("should return correct results for level 30 items", function()
        local results = GetMaterialsForUncommonItem(30)

        assert.are_same({
            {itemId = Materials.SOUL_DUST, probability = 75},
            {itemId = Materials.GREATER_ASTRAL_ESSENCE, probability = 20},
            {itemId = Materials.LARGE_GLIMMERING_SHARD, probability = 5},
        }, results)
    end)

    it("should return correct results for level 31 items", function()
        local results = GetMaterialsForUncommonItem(31)

        assert.are_same({
            {itemId = Materials.SOUL_DUST, probability = 75},
            {itemId = Materials.LESSER_MYSTIC_ESSENCE, probability = 20},
            {itemId = Materials.SMALL_GLOWING_SHARD, probability = 5},
        }, results)
    end)

    it("should return correct results for level 35 items", function()
        local results = GetMaterialsForUncommonItem(35)

        assert.are_same({
            {itemId = Materials.SOUL_DUST, probability = 75},
            {itemId = Materials.LESSER_MYSTIC_ESSENCE, probability = 20},
            {itemId = Materials.SMALL_GLOWING_SHARD, probability = 5},
        }, results)
    end)

    it("should return correct results for level 36 items", function()
        local results = GetMaterialsForUncommonItem(36)

        assert.are_same({
            {itemId = Materials.VISION_DUST, probability = 75},
            {itemId = Materials.GREATER_MYSTIC_ESSENCE, probability = 20},
            {itemId = Materials.LARGE_GLOWING_SHARD, probability = 5},
        }, results)
    end)

    it("should return correct results for level 40 items", function()
        local results = GetMaterialsForUncommonItem(40)

        assert.are_same({
            {itemId = Materials.VISION_DUST, probability = 75},
            {itemId = Materials.GREATER_MYSTIC_ESSENCE, probability = 20},
            {itemId = Materials.LARGE_GLOWING_SHARD, probability = 5},
        }, results)
    end)

    it("should return correct results for level 41 items", function()
        local results = GetMaterialsForUncommonItem(41)

        assert.are_same({
            {itemId = Materials.VISION_DUST, probability = 75},
            {itemId = Materials.LESSER_NETHER_ESSENCE, probability = 20},
            {itemId = Materials.SMALL_RADIANT_SHARD, probability = 5},
        }, results)
    end)

    it("should return correct results for level 45 items", function()
        local results = GetMaterialsForUncommonItem(45)

        assert.are_same({
            {itemId = Materials.VISION_DUST, probability = 75},
            {itemId = Materials.LESSER_NETHER_ESSENCE, probability = 20},
            {itemId = Materials.SMALL_RADIANT_SHARD, probability = 5},
        }, results)
    end)

    it("should return correct results for level 46 items", function()
        local results = GetMaterialsForUncommonItem(46)

        assert.are_same({
            {itemId = Materials.DREAM_DUST, probability = 75},
            {itemId = Materials.GREATER_NETHER_ESSENCE, probability = 20},
            {itemId = Materials.LARGE_RADIANT_SHARD, probability = 5},
        }, results)
    end)

    it("should return correct results for level 50 items", function()
        local results = GetMaterialsForUncommonItem(50)

        assert.are_same({
            {itemId = Materials.DREAM_DUST, probability = 75},
            {itemId = Materials.GREATER_NETHER_ESSENCE, probability = 20},
            {itemId = Materials.LARGE_RADIANT_SHARD, probability = 5},
        }, results)
    end)

    it("should return correct results for level 51 items", function()
        local results = GetMaterialsForUncommonItem(51)

        assert.are_same({
            {itemId = Materials.DREAM_DUST, probability = 75},
            {itemId = Materials.LESSER_ETERNAL_ESSENCE, probability = 20},
            {itemId = Materials.SMALL_BRILLIANT_SHARD, probability = 5},
        }, results)
    end)

    it("should return correct results for level 55 items", function()
        local results = GetMaterialsForUncommonItem(55)

        assert.are_same({
            {itemId = Materials.DREAM_DUST, probability = 75},
            {itemId = Materials.LESSER_ETERNAL_ESSENCE, probability = 20},
            {itemId = Materials.SMALL_BRILLIANT_SHARD, probability = 5},
        }, results)
    end)

    it("should return correct results for level 56 items", function()
        local results = GetMaterialsForUncommonItem(56)

        assert.are_same({
            {itemId = Materials.ILLUSION_DUST, probability = 75},
            {itemId = Materials.GREATER_ETERNAL_ESSENCE, probability = 20},
            {itemId = Materials.LARGE_BRILLIANT_SHARD, probability = 5},
        }, results)
    end)

    it("should return correct results for level 60 items", function()
        local results = GetMaterialsForUncommonItem(60)

        assert.are_same({
            {itemId = Materials.ILLUSION_DUST, probability = 75},
            {itemId = Materials.GREATER_ETERNAL_ESSENCE, probability = 20},
            {itemId = Materials.LARGE_BRILLIANT_SHARD, probability = 5},
        }, results)
    end)

    it("should return correct results for level 61 items", function()
        local results = GetMaterialsForUncommonItem(61)

        assert.are_same({
            {itemId = Materials.ILLUSION_DUST, probability = 75},
            {itemId = Materials.GREATER_ETERNAL_ESSENCE, probability = 20},
            {itemId = Materials.LARGE_BRILLIANT_SHARD, probability = 5},
        }, results)
    end)

    it("should return correct results for level 65 items", function()
        local results = GetMaterialsForUncommonItem(65)

        assert.are_same({
            {itemId = Materials.ILLUSION_DUST, probability = 75},
            {itemId = Materials.GREATER_ETERNAL_ESSENCE, probability = 20},
            {itemId = Materials.LARGE_BRILLIANT_SHARD, probability = 5},
        }, results)
    end)
end)