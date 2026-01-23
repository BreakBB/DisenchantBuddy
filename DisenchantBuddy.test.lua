dofile(".types/wow-api/library/Data/Enum.lua")

_G.ITEM_DISENCHANT_NOT_DISENCHANTABLE = "Cannot be disenchanted"

local match = require("luassert.match")
local _ = match._ -- any match
_.name = "any"
_.arguments = { n = 0 }

describe("DisenchantBuddy", function()
    ---@type DisenchantBuddy
    local DisenchantBuddy
    local gameTooltipMock
    local frameMock

    before_each(function()
        frameMock = {
            RegisterEvent = spy.new(function() end),
            SetScript = spy.new(function() end),
        }
        _G.C_Item = {
            GetItemInfo = spy.new(function() end)
        }
        _G.CreateFrame = function()
            return frameMock
        end
        _G.GameTooltip = {
            HookScript = spy.new(function() end),
            IsForbidden = function()
                return false
            end,
            GetItem = spy.new(function()
                return "itemName", "itemLink"
            end),
            Show = spy.new(function() end),
            AddLine = spy.new(function() end),
        }
        _G.ItemRefTooltip = {
            HookScript = spy.new(function() end),
        }
        gameTooltipMock = _G.GameTooltip

        DisenchantBuddy = {}
        -- We use `loadfile` over `require` to be able to hand in our own environment
        loadfile("Materials.lua")("DisenchantBuddy", DisenchantBuddy)
        DisenchantBuddy.AddDisenchantInfo = spy.new(function(tooltip, itemLink) end)
        loadfile("DisenchantBuddy.lua")("DisenchantBuddy", DisenchantBuddy)

        DisenchantBuddy.IsTBC = false
        DisenchantBuddy.IsWotLK = false
        DisenchantBuddy.IsCata = false
        DisenchantBuddy.IsMoP = false
    end)

    it("should hook PLAYER_ENTERING_WORLD event", function()
        assert.spy(frameMock.RegisterEvent).was.called_with(_, "PLAYER_ENTERING_WORLD")
        assert.spy(frameMock.SetScript).was.called_with(_, "OnEvent", DisenchantBuddy.OnPlayerEnteringWorld)
    end)

    describe("OnPlayerEnteringWorld", function()
        it("should hook OnTooltipSetItem when isLogin is true", function()
            DisenchantBuddy.OnPlayerEnteringWorld(_, _, true, false)

            assert.spy(_G.GameTooltip.HookScript)
                .was.called_with(_G.GameTooltip, "OnTooltipSetItem", DisenchantBuddy.OnTooltipSetItem)
            assert.spy(_G.ItemRefTooltip.HookScript)
                .was.called_with(_G.ItemRefTooltip, "OnTooltipSetItem", DisenchantBuddy.OnTooltipSetItem)
        end)

        it("should hook OnTooltipSetItem when isReload is true", function()
            DisenchantBuddy.OnPlayerEnteringWorld(_, _, false, true)

            assert.spy(_G.GameTooltip.HookScript)
                .was.called_with(_G.GameTooltip, "OnTooltipSetItem", DisenchantBuddy.OnTooltipSetItem)
            assert.spy(_G.ItemRefTooltip.HookScript)
                .was.called_with(_G.ItemRefTooltip, "OnTooltipSetItem", DisenchantBuddy.OnTooltipSetItem)
        end)

        it("should hook OnTooltipSetItem when isLogin and isReload are false", function()
            DisenchantBuddy.OnPlayerEnteringWorld(_, _, false, false)

            assert.spy(_G.GameTooltip.HookScript).was_not.called()
            assert.spy(_G.ItemRefTooltip.HookScript).was_not.called()
        end)

        it("should trigger Classic material caching on login", function()
            DisenchantBuddy.OnPlayerEnteringWorld(_, _, true, false)

            assert.spy(_G.C_Item.GetItemInfo).was.called(24)
        end)

        it("should trigger TBC material caching on login", function()
            DisenchantBuddy.IsTBC = true
            loadfile("Materials.lua")("DisenchantBuddy", DisenchantBuddy)

            DisenchantBuddy.OnPlayerEnteringWorld(_, _, true, false)

            assert.spy(_G.C_Item.GetItemInfo).was.called(30)
        end)

        it("should trigger WotLK material caching on login", function()
            DisenchantBuddy.IsWotLK = true
            loadfile("Materials.lua")("DisenchantBuddy", DisenchantBuddy)

            DisenchantBuddy.OnPlayerEnteringWorld(_, _, true, false)

            assert.spy(_G.C_Item.GetItemInfo).was.called(36)
        end)

        it("should trigger Cata material caching on login", function()
            DisenchantBuddy.IsCata = true
            loadfile("Materials.lua")("DisenchantBuddy", DisenchantBuddy)

            DisenchantBuddy.OnPlayerEnteringWorld(_, _, true, false)

            assert.spy(_G.C_Item.GetItemInfo).was.called(42)
        end)

        it("should trigger MoP material caching on login", function()
            DisenchantBuddy.IsMoP = true
            loadfile("Materials.lua")("DisenchantBuddy", DisenchantBuddy)

            DisenchantBuddy.OnPlayerEnteringWorld(_, _, true, false)

            assert.spy(_G.C_Item.GetItemInfo).was.called(50)
        end)
    end)

    describe("OnTooltipSetItem", function()
        it("should not show when itemLink is nil", function()
            gameTooltipMock.GetItem = spy.new(function()
                return nil, nil
            end)

            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(DisenchantBuddy.AddDisenchantInfo).was.not_called()
            assert.spy(gameTooltipMock.Show).was_not.called()
            assert.spy(gameTooltipMock.AddLine).was_not.called()
        end)

        it("should not show when IsForbidden is true", function()
            gameTooltipMock.IsForbidden = function()
                return true
            end

            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(DisenchantBuddy.AddDisenchantInfo).was.not_called()
            assert.spy(gameTooltipMock.Show).was_not.called()
            assert.spy(gameTooltipMock.AddLine).was_not.called()
        end)

        it("should not show tooltip for Lesser Magic Wand", function()
            gameTooltipMock.GetItem = spy.new(function()
                return nil, "|cff1eff00|Hitem:11287::::::::21::::::::|h[Lesser Magic Wand]|h|r"
            end)
            _G.C_Item.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Good, 5, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
            end)

            loadfile("DisenchantBuddy.lua")("DisenchantBuddy", DisenchantBuddy)
            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(DisenchantBuddy.AddDisenchantInfo).was.not_called()
            assert.spy(gameTooltipMock.Show).was.called()
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Cannot be disenchanted")
        end)

        it("should not show tooltip for Greater Magic Wand", function()
            gameTooltipMock.GetItem = spy.new(function()
                return nil, "|cff1eff00|Hitem:11288::::::::21::::::::|h[Greater Magic Wand]|h|r"
            end)
            _G.C_Item.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Good, 5, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
            end)

            loadfile("DisenchantBuddy.lua")("DisenchantBuddy", DisenchantBuddy)
            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(DisenchantBuddy.AddDisenchantInfo).was.not_called()
            assert.spy(gameTooltipMock.Show).was.called()
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Cannot be disenchanted")
        end)

        it("should not show tooltip for Lesser Mystic Wand", function()
            gameTooltipMock.GetItem = spy.new(function()
                return nil, "|cff1eff00|Hitem:11289::::::::21::::::::|h[Lesser Mystic Wand]|h|r"
            end)
            _G.C_Item.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Good, 5, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
            end)

            loadfile("DisenchantBuddy.lua")("DisenchantBuddy", DisenchantBuddy)
            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(DisenchantBuddy.AddDisenchantInfo).was.not_called()
            assert.spy(gameTooltipMock.Show).was.called()
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Cannot be disenchanted")
        end)

        it("should not show tooltip for Greater Mystic Wand", function()
            gameTooltipMock.GetItem = spy.new(function()
                return nil, "|cff1eff00|Hitem:11290::::::::21::::::::|h[Greater Mystic Wand]|h|r"
            end)
            _G.C_Item.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Good, 5, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
            end)

            loadfile("DisenchantBuddy.lua")("DisenchantBuddy", DisenchantBuddy)
            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(DisenchantBuddy.AddDisenchantInfo).was.not_called()
            assert.spy(gameTooltipMock.Show).was.called()
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Cannot be disenchanted")
        end)
    end)
end)
