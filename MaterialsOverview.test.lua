describe("MaterialsOverview", function()
    ---@type DisenchantBuddy
    local DisenchantBuddy
    ---@type Materials
    local Materials

    before_each(function()
        _G.DisenchantBuddy_Profile = {}
        DisenchantBuddy = {IsClassic = true, IsSoD = false, IsTBC = false, IsWotLK = false, IsCata = false, IsMoP = false}
        loadfile("Materials.lua")("DisenchantBuddy", DisenchantBuddy)
        Materials = DisenchantBuddy.Materials
        loadfile("DisenchantResults/Uncommon.lua")("DisenchantBuddy", DisenchantBuddy)
        loadfile("DisenchantResults/Rare.lua")("DisenchantBuddy", DisenchantBuddy)
        loadfile("DisenchantResults/Epic.lua")("DisenchantBuddy", DisenchantBuddy)
        loadfile("MaterialSources.lua")("DisenchantBuddy", DisenchantBuddy)
        loadfile("MaterialsOverview.lua")("DisenchantBuddy", DisenchantBuddy)
    end)

    describe("GetMaterialGroups", function()
        it("should group materials by type in a fixed order", function()
            local groups = DisenchantBuddy.GetMaterialGroups()

            local keys = {}
            for _, group in ipairs(groups) do
                table.insert(keys, group.key)
            end
            assert.are_same({"DUST", "ESSENCE", "SHARD", "CRYSTAL"}, keys)
        end)

        it("should sort materials by their lowest item level", function()
            local dusts = DisenchantBuddy.GetMaterialGroups()[1]

            assert.are_same({
                Materials.STRANGE_DUST,
                Materials.SOUL_DUST,
                Materials.VISION_DUST,
                Materials.DREAM_DUST,
                Materials.ILLUSION_DUST,
            }, dusts.itemIds)
        end)

        it("should include every material with sources on MoP", function()
            local mopDisenchantBuddy = {IsClassic = false, IsSoD = false, IsTBC = false, IsWotLK = false, IsCata = false, IsMoP = true}
            loadfile("Materials.lua")("DisenchantBuddy", mopDisenchantBuddy)
            loadfile("DisenchantResults/Uncommon.lua")("DisenchantBuddy", mopDisenchantBuddy)
            loadfile("DisenchantResults/Rare.lua")("DisenchantBuddy", mopDisenchantBuddy)
            loadfile("DisenchantResults/Epic.lua")("DisenchantBuddy", mopDisenchantBuddy)
            loadfile("MaterialSources.lua")("DisenchantBuddy", mopDisenchantBuddy)
            loadfile("MaterialsOverview.lua")("DisenchantBuddy", mopDisenchantBuddy)

            local grouped = {}
            for _, group in ipairs(mopDisenchantBuddy.GetMaterialGroups()) do
                for _, itemId in ipairs(group.itemIds) do
                    grouped[itemId] = true
                end
            end
            for _, itemId in pairs(mopDisenchantBuddy.Materials) do
                assert.are_same(mopDisenchantBuddy.GetMaterialSources(itemId) ~= nil, grouped[itemId] == true)
            end
        end)
    end)

    describe("IsLowChanceExcluded", function()
        it("should exclude low chance results by default", function()
            assert.is_true(DisenchantBuddy.IsLowChanceExcluded())
        end)

        it("should read and write the setting in the profile", function()
            DisenchantBuddy.SetLowChanceExcluded(false)

            assert.is_false(_G.DisenchantBuddy_Profile.ExcludeLowChance)
            assert.is_false(DisenchantBuddy.IsLowChanceExcluded())
        end)
    end)
end)
