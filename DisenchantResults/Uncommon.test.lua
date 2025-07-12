describe("GetMaterialsForUncommonItem", function()

    ---@type Materials
    local Materials
    local GetMaterialsForUncommonArmor
    local GetMaterialsForUncommonWeapons

    before_each(function()
        -- We use `loadfile` over `require` to be able to hand in our own environment
        ---@type DisenchantBuddy
        local DisenchantBuddy = {}
        DisenchantBuddy.IsTBC = true
        DisenchantBuddy.IsWotLK = true
        DisenchantBuddy.IsCata = true
        loadfile("Materials.lua")("DisenchantBuddy", DisenchantBuddy)
        Materials = DisenchantBuddy.Materials
        loadfile("DisenchantResults/Uncommon.lua")("DisenchantBuddy", DisenchantBuddy)
        GetMaterialsForUncommonArmor = DisenchantBuddy.GetMaterialsForUncommonArmor
        GetMaterialsForUncommonWeapons = DisenchantBuddy.GetMaterialsForUncommonWeapons
    end)

    describe("GetMaterialsForUncommonArmor", function()
        it("should return nil for unhandled item level", function()
            local results = GetMaterialsForUncommonArmor(484)

            assert.is_nil(results)
        end)

        it("should return correct results for level 5 items", function()
            local results = GetMaterialsForUncommonArmor(5)

            assert.are_same({
                {itemId = Materials.STRANGE_DUST, probability = 80, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.LESSER_MAGIC_ESSENCE, probability = 20, minQuantity = 1, maxQuantity = 2},
            }, results)
        end)

        it("should return correct results for level 15 items", function()
            local results = GetMaterialsForUncommonArmor(15)

            assert.are_same({
                {itemId = Materials.STRANGE_DUST, probability = 80, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.LESSER_MAGIC_ESSENCE, probability = 20, minQuantity = 1, maxQuantity = 2},
            }, results)
        end)

        it("should return correct results for level 16 items", function()
            local results = GetMaterialsForUncommonArmor(16)

            assert.are_same({
                {itemId = Materials.STRANGE_DUST, probability = 75, minQuantity = 2, maxQuantity = 3},
                {itemId = Materials.GREATER_MAGIC_ESSENCE, probability = 20, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.SMALL_GLIMMERING_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 20 items", function()
            local results = GetMaterialsForUncommonArmor(20)

            assert.are_same({
                {itemId = Materials.STRANGE_DUST, probability = 75, minQuantity = 2, maxQuantity = 3},
                {itemId = Materials.GREATER_MAGIC_ESSENCE, probability = 20, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.SMALL_GLIMMERING_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 21 items", function()
            local results = GetMaterialsForUncommonArmor(21)

            assert.are_same({
                {itemId = Materials.STRANGE_DUST, probability = 75, minQuantity = 4, maxQuantity = 6},
                {itemId = Materials.LESSER_ASTRAL_ESSENCE, probability = 15, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.SMALL_GLIMMERING_SHARD, probability = 10, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 25 items", function()
            local results = GetMaterialsForUncommonArmor(25)

            assert.are_same({
                {itemId = Materials.STRANGE_DUST, probability = 75, minQuantity = 4, maxQuantity = 6},
                {itemId = Materials.LESSER_ASTRAL_ESSENCE, probability = 15, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.SMALL_GLIMMERING_SHARD, probability = 10, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 26 items", function()
            local results = GetMaterialsForUncommonArmor(26)

            assert.are_same({
                {itemId = Materials.SOUL_DUST, probability = 75, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.GREATER_ASTRAL_ESSENCE, probability = 20, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.LARGE_GLIMMERING_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 30 items", function()
            local results = GetMaterialsForUncommonArmor(30)

            assert.are_same({
                {itemId = Materials.SOUL_DUST, probability = 75, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.GREATER_ASTRAL_ESSENCE, probability = 20, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.LARGE_GLIMMERING_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 31 items", function()
            local results = GetMaterialsForUncommonArmor(31)

            assert.are_same({
                {itemId = Materials.SOUL_DUST, probability = 75, minQuantity = 2, maxQuantity = 5},
                {itemId = Materials.LESSER_MYSTIC_ESSENCE, probability = 20, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.SMALL_GLOWING_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 35 items", function()
            local results = GetMaterialsForUncommonArmor(35)

            assert.are_same({
                {itemId = Materials.SOUL_DUST, probability = 75, minQuantity = 2, maxQuantity = 5},
                {itemId = Materials.LESSER_MYSTIC_ESSENCE, probability = 20, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.SMALL_GLOWING_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 36 items", function()
            local results = GetMaterialsForUncommonArmor(36)

            assert.are_same({
                {itemId = Materials.VISION_DUST, probability = 75, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.GREATER_MYSTIC_ESSENCE, probability = 20, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.LARGE_GLOWING_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 40 items", function()
            local results = GetMaterialsForUncommonArmor(40)

            assert.are_same({
                {itemId = Materials.VISION_DUST, probability = 75, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.GREATER_MYSTIC_ESSENCE, probability = 20, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.LARGE_GLOWING_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 41 items", function()
            local results = GetMaterialsForUncommonArmor(41)

            assert.are_same({
                {itemId = Materials.VISION_DUST, probability = 75, minQuantity = 2, maxQuantity = 5},
                {itemId = Materials.LESSER_NETHER_ESSENCE, probability = 20, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.SMALL_RADIANT_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 45 items", function()
            local results = GetMaterialsForUncommonArmor(45)

            assert.are_same({
                {itemId = Materials.VISION_DUST, probability = 75, minQuantity = 2, maxQuantity = 5},
                {itemId = Materials.LESSER_NETHER_ESSENCE, probability = 20, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.SMALL_RADIANT_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 46 items", function()
            local results = GetMaterialsForUncommonArmor(46)

            assert.are_same({
                {itemId = Materials.DREAM_DUST, probability = 75, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.GREATER_NETHER_ESSENCE, probability = 20, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.LARGE_RADIANT_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 50 items", function()
            local results = GetMaterialsForUncommonArmor(50)

            assert.are_same({
                {itemId = Materials.DREAM_DUST, probability = 75, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.GREATER_NETHER_ESSENCE, probability = 20, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.LARGE_RADIANT_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 51 items", function()
            local results = GetMaterialsForUncommonArmor(51)

            assert.are_same({
                {itemId = Materials.DREAM_DUST, probability = 75, minQuantity = 2, maxQuantity = 5},
                {itemId = Materials.LESSER_ETERNAL_ESSENCE, probability = 20, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.SMALL_BRILLIANT_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 55 items", function()
            local results = GetMaterialsForUncommonArmor(55)

            assert.are_same({
                {itemId = Materials.DREAM_DUST, probability = 75, minQuantity = 2, maxQuantity = 5},
                {itemId = Materials.LESSER_ETERNAL_ESSENCE, probability = 20, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.SMALL_BRILLIANT_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 56 items", function()
            local results = GetMaterialsForUncommonArmor(56)

            assert.are_same({
                {itemId = Materials.ILLUSION_DUST, probability = 75, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.GREATER_ETERNAL_ESSENCE, probability = 20, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.LARGE_BRILLIANT_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 60 items", function()
            local results = GetMaterialsForUncommonArmor(60)

            assert.are_same({
                {itemId = Materials.ILLUSION_DUST, probability = 75, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.GREATER_ETERNAL_ESSENCE, probability = 20, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.LARGE_BRILLIANT_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 61 items", function()
            local results = GetMaterialsForUncommonArmor(61)

            assert.are_same({
                {itemId = Materials.ILLUSION_DUST, probability = 75, minQuantity = 2, maxQuantity = 5},
                {itemId = Materials.GREATER_ETERNAL_ESSENCE, probability = 20, minQuantity = 2, maxQuantity = 3},
                {itemId = Materials.LARGE_BRILLIANT_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 65 items", function()
            local results = GetMaterialsForUncommonArmor(65)

            assert.are_same({
                {itemId = Materials.ILLUSION_DUST, probability = 75, minQuantity = 2, maxQuantity = 5},
                {itemId = Materials.GREATER_ETERNAL_ESSENCE, probability = 20, minQuantity = 2, maxQuantity = 3},
                {itemId = Materials.LARGE_BRILLIANT_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 79 items", function()
            local results = GetMaterialsForUncommonArmor(79)

            assert.are_same({
                {itemId = Materials.ARCANE_DUST, probability = 75, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.LESSER_PLANAR_ESSENCE, probability = 22, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.SMALL_PRISMATIC_SHARD, probability = 3, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 80 items", function()
            local results = GetMaterialsForUncommonArmor(80)

            assert.are_same({
                {itemId = Materials.ARCANE_DUST, probability = 75, minQuantity = 2, maxQuantity = 3},
                {itemId = Materials.LESSER_PLANAR_ESSENCE, probability = 22, minQuantity = 2, maxQuantity = 3},
                {itemId = Materials.SMALL_PRISMATIC_SHARD, probability = 3, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 99 items", function()
            local results = GetMaterialsForUncommonArmor(99)

            assert.are_same({
                {itemId = Materials.ARCANE_DUST, probability = 75, minQuantity = 2, maxQuantity = 3},
                {itemId = Materials.LESSER_PLANAR_ESSENCE, probability = 22, minQuantity = 2, maxQuantity = 3},
                {itemId = Materials.SMALL_PRISMATIC_SHARD, probability = 3, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 100 items", function()
            local results = GetMaterialsForUncommonArmor(100)

            assert.are_same({
                {itemId = Materials.ARCANE_DUST, probability = 75, minQuantity = 2, maxQuantity = 5},
                {itemId = Materials.GREATER_PLANAR_ESSENCE, probability = 22, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.LARGE_PRISMATIC_SHARD, probability = 3, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 120 items", function()
            local results = GetMaterialsForUncommonArmor(120)

            assert.are_same({
                {itemId = Materials.ARCANE_DUST, probability = 75, minQuantity = 2, maxQuantity = 5},
                {itemId = Materials.GREATER_PLANAR_ESSENCE, probability = 22, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.LARGE_PRISMATIC_SHARD, probability = 3, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 130 items", function()
            local results = GetMaterialsForUncommonArmor(130)

            assert.are_same({
                {itemId = Materials.INFINITE_DUST, probability = 75, minQuantity = 2, maxQuantity = 3},
                {itemId = Materials.LESSER_COSMIC_ESSENCE, probability = 22, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.SMALL_DREAM_SHARD, probability = 3, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 151 items", function()
            local results = GetMaterialsForUncommonArmor(151)

            assert.are_same({
                {itemId = Materials.INFINITE_DUST, probability = 75, minQuantity = 2, maxQuantity = 3},
                {itemId = Materials.LESSER_COSMIC_ESSENCE, probability = 22, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.SMALL_DREAM_SHARD, probability = 3, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 152 items", function()
            local results = GetMaterialsForUncommonArmor(152)

            assert.are_same({
                {itemId = Materials.INFINITE_DUST, probability = 75, minQuantity = 4, maxQuantity = 7},
                {itemId = Materials.GREATER_COSMIC_ESSENCE, probability = 22, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.DREAM_SHARD, probability = 3, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 200 items", function()
            local results = GetMaterialsForUncommonArmor(200)

            assert.are_same({
                {itemId = Materials.INFINITE_DUST, probability = 75, minQuantity = 4, maxQuantity = 7},
                {itemId = Materials.GREATER_COSMIC_ESSENCE, probability = 22, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.DREAM_SHARD, probability = 3, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 272 items", function()
            local results = GetMaterialsForUncommonArmor(272)

            assert.are_same({
                {itemId = Materials.HYPNOTIC_DUST, probability = 75, minQuantity = 1, maxQuantity = 5},
                {itemId = Materials.LESSER_CELESTIAL_ESSENCE, probability = 25, minQuantity = 1, maxQuantity = 3},
            }, results)
        end)

        it("should return correct results for level 333 items", function()
            local results = GetMaterialsForUncommonArmor(333)

            assert.are_same({
                {itemId = Materials.HYPNOTIC_DUST, probability = 75, minQuantity = 1, maxQuantity = 5},
                {itemId = Materials.LESSER_CELESTIAL_ESSENCE, probability = 25, minQuantity = 1, maxQuantity = 3},
            }, results)
        end)

        it("should return correct results for level 364 items", function()
            local results = GetMaterialsForUncommonArmor(364)

            assert.are_same({
                {itemId = Materials.SPIRIT_DUST, probability = 85, minQuantity = 1, maxQuantity = 3},
                {itemId = Materials.MYSTERIOUS_ESSENCE, probability = 15, minQuantity = 1, maxQuantity = 1},
            }, results)
        end)

        it("should return correct results for level 413 items", function()
            local results = GetMaterialsForUncommonArmor(413)

            assert.are_same({
                {itemId = Materials.SPIRIT_DUST, probability = 85, minQuantity = 1, maxQuantity = 3},
                {itemId = Materials.MYSTERIOUS_ESSENCE, probability = 15, minQuantity = 1, maxQuantity = 1},
            }, results)
        end)

        it("should return correct results for level 414 items", function()
            local results = GetMaterialsForUncommonArmor(414)

            assert.are_same({
                {itemId = Materials.SPIRIT_DUST, probability = 85, minQuantity = 1, maxQuantity = 5},
                {itemId = Materials.MYSTERIOUS_ESSENCE, probability = 15, minQuantity = 1, maxQuantity = 2},
            }, results)
        end)

        it("should return correct results for level 437 items", function()
            local results = GetMaterialsForUncommonArmor(437)

            assert.are_same({
                {itemId = Materials.SPIRIT_DUST, probability = 85, minQuantity = 1, maxQuantity = 5},
                {itemId = Materials.MYSTERIOUS_ESSENCE, probability = 15, minQuantity = 1, maxQuantity = 2},
            }, results)
        end)
    end)

    describe("GetMaterialsForUncommonWeapons", function()
        it("should return nil for unhandled item level", function()
            local results = GetMaterialsForUncommonWeapons(484)

            assert.is_nil(results)
        end)

        it("should return correct results for level 5 items", function()
            local results = GetMaterialsForUncommonWeapons(5)

            assert.are_same({
                {itemId = Materials.LESSER_MAGIC_ESSENCE, probability = 80, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.STRANGE_DUST, probability = 20, minQuantity = 1, maxQuantity = 2},
            }, results)
        end)

        it("should return correct results for level 15 items", function()
            local results = GetMaterialsForUncommonWeapons(15)

            assert.are_same({
                {itemId = Materials.LESSER_MAGIC_ESSENCE, probability = 80, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.STRANGE_DUST, probability = 20, minQuantity = 1, maxQuantity = 2},
            }, results)
        end)

        it("should return correct results for level 16 items", function()
            local results = GetMaterialsForUncommonWeapons(16)

            assert.are_same({
                {itemId = Materials.GREATER_MAGIC_ESSENCE, probability = 75, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.STRANGE_DUST, probability = 20, minQuantity = 2, maxQuantity = 3},
                {itemId = Materials.SMALL_GLIMMERING_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 20 items", function()
            local results = GetMaterialsForUncommonWeapons(20)

            assert.are_same({
                {itemId = Materials.GREATER_MAGIC_ESSENCE, probability = 75, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.STRANGE_DUST, probability = 20, minQuantity = 2, maxQuantity = 3},
                {itemId = Materials.SMALL_GLIMMERING_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 21 items", function()
            local results = GetMaterialsForUncommonWeapons(21)

            assert.are_same({
                {itemId = Materials.GREATER_MAGIC_ESSENCE, probability = 75, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.STRANGE_DUST, probability = 15, minQuantity = 4, maxQuantity = 6},
                {itemId = Materials.SMALL_GLIMMERING_SHARD, probability = 10, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 25 items", function()
            local results = GetMaterialsForUncommonWeapons(25)

            assert.are_same({
                {itemId = Materials.GREATER_MAGIC_ESSENCE, probability = 75, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.STRANGE_DUST, probability = 15, minQuantity = 4, maxQuantity = 6},
                {itemId = Materials.SMALL_GLIMMERING_SHARD, probability = 10, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 26 items", function()
            local results = GetMaterialsForUncommonWeapons(26)

            assert.are_same({
                {itemId = Materials.GREATER_MAGIC_ESSENCE, probability = 75, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.SOUL_DUST, probability = 20, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.LARGE_GLIMMERING_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 30 items", function()
            local results = GetMaterialsForUncommonWeapons(30)

            assert.are_same({
                {itemId = Materials.GREATER_MAGIC_ESSENCE, probability = 75, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.SOUL_DUST, probability = 20, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.LARGE_GLIMMERING_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 31 items", function()
            local results = GetMaterialsForUncommonWeapons(31)

            assert.are_same({
                {itemId = Materials.LESSER_MYSTIC_ESSENCE, probability = 75, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.SOUL_DUST, probability = 20, minQuantity = 2, maxQuantity = 5},
                {itemId = Materials.SMALL_GLOWING_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 35 items", function()
            local results = GetMaterialsForUncommonWeapons(35)

            assert.are_same({
                {itemId = Materials.LESSER_MYSTIC_ESSENCE, probability = 75, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.SOUL_DUST, probability = 20, minQuantity = 2, maxQuantity = 5},
                {itemId = Materials.SMALL_GLOWING_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 36 items", function()
            local results = GetMaterialsForUncommonWeapons(36)

            assert.are_same({
                {itemId = Materials.GREATER_MYSTIC_ESSENCE, probability = 75, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.VISION_DUST, probability = 20, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.LARGE_GLOWING_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 40 items", function()
            local results = GetMaterialsForUncommonWeapons(40)

            assert.are_same({
                {itemId = Materials.GREATER_MYSTIC_ESSENCE, probability = 75, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.VISION_DUST, probability = 20, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.LARGE_GLOWING_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 41 items", function()
            local results = GetMaterialsForUncommonWeapons(41)

            assert.are_same({
                {itemId = Materials.LESSER_NETHER_ESSENCE, probability = 75, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.VISION_DUST, probability = 20, minQuantity = 2, maxQuantity = 5},
                {itemId = Materials.SMALL_RADIANT_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 45 items", function()
            local results = GetMaterialsForUncommonWeapons(45)

            assert.are_same({
                {itemId = Materials.LESSER_NETHER_ESSENCE, probability = 75, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.VISION_DUST, probability = 20, minQuantity = 2, maxQuantity = 5},
                {itemId = Materials.SMALL_RADIANT_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 46 items", function()
            local results = GetMaterialsForUncommonWeapons(46)

            assert.are_same({
                {itemId = Materials.GREATER_NETHER_ESSENCE, probability = 75, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.DREAM_DUST, probability = 20, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.LARGE_RADIANT_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 50 items", function()
            local results = GetMaterialsForUncommonWeapons(50)

            assert.are_same({
                {itemId = Materials.GREATER_NETHER_ESSENCE, probability = 75, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.DREAM_DUST, probability = 20, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.LARGE_RADIANT_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 51 items", function()
            local results = GetMaterialsForUncommonWeapons(51)

            assert.are_same({
                {itemId = Materials.LESSER_ETERNAL_ESSENCE, probability = 75, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.DREAM_DUST, probability = 20, minQuantity = 2, maxQuantity = 5},
                {itemId = Materials.SMALL_BRILLIANT_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 55 items", function()
            local results = GetMaterialsForUncommonWeapons(55)

            assert.are_same({
                {itemId = Materials.LESSER_ETERNAL_ESSENCE, probability = 75, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.DREAM_DUST, probability = 20, minQuantity = 2, maxQuantity = 5},
                {itemId = Materials.SMALL_BRILLIANT_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 56 items", function()
            local results = GetMaterialsForUncommonWeapons(56)

            assert.are_same({
                {itemId = Materials.GREATER_ETERNAL_ESSENCE, probability = 75, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.ILLUSION_DUST, probability = 20, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.LARGE_BRILLIANT_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 60 items", function()
            local results = GetMaterialsForUncommonWeapons(60)

            assert.are_same({
                {itemId = Materials.GREATER_ETERNAL_ESSENCE, probability = 75, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.ILLUSION_DUST, probability = 20, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.LARGE_BRILLIANT_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 61 items", function()
            local results = GetMaterialsForUncommonWeapons(61)

            assert.are_same({
                {itemId = Materials.GREATER_ETERNAL_ESSENCE, probability = 75, minQuantity = 2, maxQuantity = 3},
                {itemId = Materials.ILLUSION_DUST, probability = 20, minQuantity = 2, maxQuantity = 5},
                {itemId = Materials.LARGE_BRILLIANT_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 65 items", function()
            local results = GetMaterialsForUncommonWeapons(65)

            assert.are_same({
                {itemId = Materials.GREATER_ETERNAL_ESSENCE, probability = 75, minQuantity = 2, maxQuantity = 3},
                {itemId = Materials.ILLUSION_DUST, probability = 20, minQuantity = 2, maxQuantity = 5},
                {itemId = Materials.LARGE_BRILLIANT_SHARD, probability = 5, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 80 items", function()
            local results = GetMaterialsForUncommonWeapons(80)

            assert.are_same({
                {itemId = Materials.LESSER_PLANAR_ESSENCE, probability = 75, minQuantity = 2, maxQuantity = 3},
                {itemId = Materials.ARCANE_DUST, probability = 22, minQuantity = 2, maxQuantity = 3},
                {itemId = Materials.SMALL_PRISMATIC_SHARD, probability = 3, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 99 items", function()
            local results = GetMaterialsForUncommonWeapons(99)

            assert.are_same({
                {itemId = Materials.LESSER_PLANAR_ESSENCE, probability = 75, minQuantity = 2, maxQuantity = 3},
                {itemId = Materials.ARCANE_DUST, probability = 22, minQuantity = 2, maxQuantity = 3},
                {itemId = Materials.SMALL_PRISMATIC_SHARD, probability = 3, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 100 items", function()
            local results = GetMaterialsForUncommonWeapons(100)

            assert.are_same({
                {itemId = Materials.GREATER_PLANAR_ESSENCE, probability = 75, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.ARCANE_DUST, probability = 22, minQuantity = 2, maxQuantity = 5},
                {itemId = Materials.LARGE_PRISMATIC_SHARD, probability = 3, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 120 items", function()
            local results = GetMaterialsForUncommonWeapons(120)

            assert.are_same({
                {itemId = Materials.GREATER_PLANAR_ESSENCE, probability = 75, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.ARCANE_DUST, probability = 22, minQuantity = 2, maxQuantity = 5},
                {itemId = Materials.LARGE_PRISMATIC_SHARD, probability = 3, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 130 items", function()
            local results = GetMaterialsForUncommonWeapons(130)

            assert.are_same({
                {itemId = Materials.LESSER_COSMIC_ESSENCE, probability = 75, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.INFINITE_DUST, probability = 22, minQuantity = 2, maxQuantity = 3},
                {itemId = Materials.SMALL_DREAM_SHARD, probability = 3, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 151 items", function()
            local results = GetMaterialsForUncommonWeapons(151)

            assert.are_same({
                {itemId = Materials.LESSER_COSMIC_ESSENCE, probability = 75, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.INFINITE_DUST, probability = 22, minQuantity = 2, maxQuantity = 3},
                {itemId = Materials.SMALL_DREAM_SHARD, probability = 3, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 152 items", function()
            local results = GetMaterialsForUncommonWeapons(152)

            assert.are_same({
                {itemId = Materials.GREATER_COSMIC_ESSENCE, probability = 75, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.INFINITE_DUST, probability = 22, minQuantity = 4, maxQuantity = 7},
                {itemId = Materials.DREAM_SHARD, probability = 3, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 200 items", function()
            local results = GetMaterialsForUncommonWeapons(200)

            assert.are_same({
                {itemId = Materials.GREATER_COSMIC_ESSENCE, probability = 75, minQuantity = 1, maxQuantity = 2},
                {itemId = Materials.INFINITE_DUST, probability = 22, minQuantity = 4, maxQuantity = 7},
                {itemId = Materials.DREAM_SHARD, probability = 3, minQuantity = 1, maxQuantity = 1}
            }, results)
        end)

        it("should return correct results for level 272 items", function()
            local results = GetMaterialsForUncommonWeapons(272)

            assert.are_same({
                {itemId = Materials.LESSER_CELESTIAL_ESSENCE, probability = 80, minQuantity = 1, maxQuantity = 5},
                {itemId = Materials.HYPNOTIC_DUST, probability = 20, minQuantity = 1, maxQuantity = 5},
            }, results)
        end)

        it("should return correct results for level 289 items", function()
            local results = GetMaterialsForUncommonWeapons(289)

            assert.are_same({
                {itemId = Materials.LESSER_CELESTIAL_ESSENCE, probability = 80, minQuantity = 1, maxQuantity = 5},
                {itemId = Materials.HYPNOTIC_DUST, probability = 20, minQuantity = 1, maxQuantity = 5},
            }, results)
        end)

        it("should return correct results for level 295 items", function()
            local results = GetMaterialsForUncommonWeapons(295)

            assert.are_same({
                {itemId = Materials.LESSER_CELESTIAL_ESSENCE, probability = 80, minQuantity = 2, maxQuantity = 7},
                {itemId = Materials.HYPNOTIC_DUST, probability = 20, minQuantity = 1, maxQuantity = 6},
            }, results)
        end)

        it("should return correct results for level 305 items", function()
            local results = GetMaterialsForUncommonWeapons(305)

            assert.are_same({
                {itemId = Materials.LESSER_CELESTIAL_ESSENCE, probability = 80, minQuantity = 2, maxQuantity = 7},
                {itemId = Materials.HYPNOTIC_DUST, probability = 20, minQuantity = 1, maxQuantity = 6},
            }, results)
        end)

        it("should return correct results for level 306 items", function()
            local results = GetMaterialsForUncommonWeapons(306)

            assert.are_same({
                {itemId = Materials.GREATER_CELESTIAL_ESSENCE, probability = 80, minQuantity = 1, maxQuantity = 6},
                {itemId = Materials.HYPNOTIC_DUST, probability = 20, minQuantity = 2, maxQuantity = 8},
            }, results)
        end)

        it("should return correct results for level 317 items", function()
            local results = GetMaterialsForUncommonWeapons(317)

            assert.are_same({
                {itemId = Materials.GREATER_CELESTIAL_ESSENCE, probability = 80, minQuantity = 1, maxQuantity = 6},
                {itemId = Materials.HYPNOTIC_DUST, probability = 20, minQuantity = 2, maxQuantity = 8},
            }, results)
        end)

        it("should return correct results for level 318 items", function()
            local results = GetMaterialsForUncommonWeapons(318)

            assert.are_same({
                {itemId = Materials.GREATER_CELESTIAL_ESSENCE, probability = 80, minQuantity = 2, maxQuantity = 6},
                {itemId = Materials.HYPNOTIC_DUST, probability = 20, minQuantity = 2, maxQuantity = 8},
            }, results)
        end)

        it("should return correct results for level 364 items", function()
            local results = GetMaterialsForUncommonWeapons(364)

            assert.are_same({
                {itemId = Materials.SPIRIT_DUST, probability = 85, minQuantity = 1, maxQuantity = 3},
                {itemId = Materials.MYSTERIOUS_ESSENCE, probability = 15, minQuantity = 1, maxQuantity = 1},
            }, results)
        end)

        it("should return correct results for level 398 items", function()
            local results = GetMaterialsForUncommonWeapons(398)

            assert.are_same({
                {itemId = Materials.SPIRIT_DUST, probability = 85, minQuantity = 1, maxQuantity = 3},
                {itemId = Materials.MYSTERIOUS_ESSENCE, probability = 15, minQuantity = 1, maxQuantity = 1},
            }, results)
        end)

        it("should return correct results for level 399 items", function()
            local results = GetMaterialsForUncommonWeapons(399)

            assert.are_same({
                {itemId = Materials.SPIRIT_DUST, probability = 85, minQuantity = 1, maxQuantity = 4},
                {itemId = Materials.MYSTERIOUS_ESSENCE, probability = 15, minQuantity = 1, maxQuantity = 2},
            }, results)
        end)

        it("should return correct results for level 428 items", function()
            local results = GetMaterialsForUncommonWeapons(428)

            assert.are_same({
                {itemId = Materials.SPIRIT_DUST, probability = 85, minQuantity = 1, maxQuantity = 4},
                {itemId = Materials.MYSTERIOUS_ESSENCE, probability = 15, minQuantity = 1, maxQuantity = 2},
            }, results)
        end)

        it("should return correct results for level 429 items", function()
            local results = GetMaterialsForUncommonWeapons(429)

            assert.are_same({
                {itemId = Materials.SPIRIT_DUST, probability = 85, minQuantity = 1, maxQuantity = 6},
                {itemId = Materials.MYSTERIOUS_ESSENCE, probability = 15, minQuantity = 1, maxQuantity = 3},
            }, results)
        end)

        it("should return correct results for level 437 items", function()
            local results = GetMaterialsForUncommonWeapons(437)

            assert.are_same({
                {itemId = Materials.SPIRIT_DUST, probability = 85, minQuantity = 1, maxQuantity = 6},
                {itemId = Materials.MYSTERIOUS_ESSENCE, probability = 15, minQuantity = 1, maxQuantity = 3},
            }, results)
        end)
    end)
end)