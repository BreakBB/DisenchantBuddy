describe("AuctionatorShoppingList", function()
    ---@type DisenchantBuddy
    local DisenchantBuddy
    ---@type Materials
    local Materials

    before_each(function()
        _G.DisenchantBuddy_Profile = {}
        _G.print = spy.new(function() end)
        _G.C_Item = {
            GetItemClassInfo = function(classId)
                return ({[2] = "Weapon", [4] = "Armor"})[classId]
            end,
            GetItemInfo = function(itemId)
                return "Item " .. itemId
            end,
        }
        _G.Auctionator = {
            API = {
                v1 = {
                    ConvertToSearchString = spy.new(function(_, term)
                        return table.concat({term.searchString, term.categoryKey, term.minItemLevel, term.maxItemLevel, term.quality}, ";")
                    end),
                    CreateShoppingList = spy.new(function() end),
                },
            },
        }

        DisenchantBuddy = {
            IsClassic = true, IsSoD = false, IsTBC = false, IsWotLK = false, IsCata = false, IsMoP = false,
            L = {
                ["Created Auctionator shopping list: %s"] = "Created: %s",
                ["No item sources left after excluding low-chance results."] = "Nothing left",
            },
        }
        loadfile("Materials.lua")("DisenchantBuddy", DisenchantBuddy)
        Materials = DisenchantBuddy.Materials
        loadfile("DisenchantResults/Uncommon.lua")("DisenchantBuddy", DisenchantBuddy)
        loadfile("DisenchantResults/Rare.lua")("DisenchantBuddy", DisenchantBuddy)
        loadfile("DisenchantResults/Epic.lua")("DisenchantBuddy", DisenchantBuddy)
        loadfile("MaterialSources.lua")("DisenchantBuddy", DisenchantBuddy)
        loadfile("MaterialsOverview.lua")("DisenchantBuddy", DisenchantBuddy)
        loadfile("AuctionatorShoppingList.lua")("DisenchantBuddy", DisenchantBuddy)
    end)

    describe("IsAuctionatorAvailable", function()
        it("should return true when the Auctionator shopping list API exists", function()
            assert.is_true(DisenchantBuddy.IsAuctionatorAvailable())
        end)

        it("should return false when Auctionator is not loaded", function()
            _G.Auctionator = nil

            assert.is_false(DisenchantBuddy.IsAuctionatorAvailable())
        end)
    end)

    describe("GetShoppingListSearchTerms", function()
        it("should create one search term per source with category, item level and quality", function()
            local terms = DisenchantBuddy.GetShoppingListSearchTerms(Materials.STRANGE_DUST, false)

            assert.are_same({
                {searchString = "", categoryKey = "Armor", minItemLevel = 1, maxItemLevel = 25, quality = 2},
                {searchString = "", categoryKey = "Weapon", minItemLevel = 1, maxItemLevel = 25, quality = 2},
            }, terms)
        end)

        it("should use no category for rare and epic sources", function()
            local terms = DisenchantBuddy.GetShoppingListSearchTerms(Materials.SMALL_GLIMMERING_SHARD, false)

            assert.are_same({searchString = "", categoryKey = "", minItemLevel = 1, maxItemLevel = 25, quality = 3}, terms[#terms])
        end)

        it("should skip low chance sources when they are excluded", function()
            local terms = DisenchantBuddy.GetShoppingListSearchTerms(Materials.SMALL_GLIMMERING_SHARD, true)

            assert.are_same({
                {searchString = "", categoryKey = "Armor", minItemLevel = 21, maxItemLevel = 25, quality = 2},
                {searchString = "", categoryKey = "Weapon", minItemLevel = 21, maxItemLevel = 25, quality = 2},
                {searchString = "", categoryKey = "", minItemLevel = 1, maxItemLevel = 25, quality = 3},
            }, terms)
        end)
    end)

    describe("CreateShoppingList", function()
        it("should create a shopping list named after the material", function()
            DisenchantBuddy.CreateShoppingList(Materials.STRANGE_DUST)

            assert.spy(_G.Auctionator.API.v1.CreateShoppingList).was.called_with("DisenchantBuddy", "DE: Item " .. Materials.STRANGE_DUST, {
                ";Armor;1;25;2",
                ";Weapon;1;25;2",
            })
            assert.spy(_G.print).was.called_with("Created: DE: Item " .. Materials.STRANGE_DUST)
        end)

        it("should respect the low chance setting", function()
            DisenchantBuddy.SetLowChanceExcluded(true)

            DisenchantBuddy.CreateShoppingList(Materials.SMALL_GLIMMERING_SHARD)

            assert.spy(_G.Auctionator.API.v1.CreateShoppingList).was.called_with("DisenchantBuddy", "DE: Item " .. Materials.SMALL_GLIMMERING_SHARD, {
                ";Armor;21;25;2",
                ";Weapon;21;25;2",
                ";;1;25;3",
            })
        end)

        it("should not create a list when only low chance sources exist and they are excluded", function()
            DisenchantBuddy.SetLowChanceExcluded(true)
            DisenchantBuddy.GetMaterialSources = function()
                return {{quality = "rare", minItemLevel = 1, maxItemLevel = 10, minChance = 1, maxChance = 1, isLowChance = true}}
            end

            DisenchantBuddy.CreateShoppingList(Materials.NEXUS_CRYSTAL)

            assert.spy(_G.Auctionator.API.v1.CreateShoppingList).was_not.called()
            assert.spy(_G.print).was.called_with("Nothing left")
        end)
    end)
end)
