dofile(".types/wow-api/library/Data/Enum.lua")

describe("API", function()
    ---@type DisenchantBuddy
    local DisenchantBuddy

    local function loadApi(itemInfo)
        _G.C_Item = {
            GetItemInfo = spy.new(function()
                return unpack(itemInfo or {})
            end)
        }
        DisenchantBuddy = {}
        loadfile("Materials.lua")("DisenchantBuddy", DisenchantBuddy)
        loadfile("AddDisenchantInfo.lua")("DisenchantBuddy", DisenchantBuddy)
        loadfile("DisenchantResults/Epic.lua")("DisenchantBuddy", DisenchantBuddy)
        loadfile("API.lua")("DisenchantBuddy", DisenchantBuddy)
    end

    local epicArmor = {nil, nil, Enum.ItemQuality.Epic, 60, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor}

    before_each(function()
        _G.GetLocale = function()
            return "enUS"
        end
        _G.Item = {}
        _G.DisenchantBuddy = nil
    end)

    it("should expose the API on the DisenchantBuddy global", function()
        loadApi(epicArmor)

        assert.is_true(DisenchantBuddy == _G.DisenchantBuddy)
        assert.is_true(type(_G.DisenchantBuddy.API.v1.GetDisenchantResults) == "function")
    end)

    it("should return disenchant results for an item link", function()
        loadApi(epicArmor)

        local results = DisenchantBuddy.API.v1.GetDisenchantResults("MyAddon", "item:12345")

        assert.are_same(DisenchantBuddy.GetMaterialsForEpicItem(60), results)
        assert.spy(_G.C_Item.GetItemInfo).was.called_with("item:12345")
    end)

    it("should return nil when the caller name is missing", function()
        loadApi(epicArmor)

        assert.is_nil(DisenchantBuddy.API.v1.GetDisenchantResults(nil, "item:12345"))
        assert.is_nil(DisenchantBuddy.API.v1.GetDisenchantResults("", "item:12345"))
        assert.is_nil(DisenchantBuddy.API.v1.GetDisenchantResults(123, "item:12345"))
    end)

    it("should return nil when the item is invalid", function()
        loadApi(epicArmor)

        assert.is_nil(DisenchantBuddy.API.v1.GetDisenchantResults("MyAddon", nil))
        assert.is_nil(DisenchantBuddy.API.v1.GetDisenchantResults("MyAddon", {}))
        assert.spy(_G.C_Item.GetItemInfo).was_not.called()
    end)

    it("should return nil for items that are not armor or weapons", function()
        loadApi({nil, nil, Enum.ItemQuality.Epic, 60, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Consumable})

        assert.is_nil(DisenchantBuddy.API.v1.GetDisenchantResults("MyAddon", 12345))
    end)

    it("should return nil for items that cannot be disenchanted", function()
        loadApi(epicArmor)
        DisenchantBuddy.NotDisenchantableItems = {[11287] = true}

        assert.is_nil(DisenchantBuddy.API.v1.GetDisenchantResults("MyAddon", "item:11287::::"))
        assert.is_nil(DisenchantBuddy.API.v1.GetDisenchantResults("MyAddon", 11287))
        assert.spy(_G.C_Item.GetItemInfo).was_not.called()
    end)

    it("should return nil when the item is unknown", function()
        loadApi()

        assert.is_nil(DisenchantBuddy.API.v1.GetDisenchantResults("MyAddon", 12345))
    end)
end)
