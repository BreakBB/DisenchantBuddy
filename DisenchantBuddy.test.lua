dofile(".types/wow-api/library/Data/Enum.lua")

local Colors = {
    STANDARD = "|cffffffff",
    GOOD = "|cff1eff00",
    RARE = "|cff0070dd",
    EPIC = "|cffa335ee",
}

_G.GetItemQualityColor = function(quality)
    if quality == Enum.ItemQuality.Standard then
        return nil, nil, nil, Colors.STANDARD
    elseif quality == Enum.ItemQuality.Good then
        return nil, nil, nil, Colors.GOOD
    elseif quality == Enum.ItemQuality.Rare then
        return nil, nil, nil, Colors.RARE
    elseif quality == Enum.ItemQuality.Epic then
        return nil, nil, nil, Colors.EPIC
    end
end

local match = require("luassert.match")
local _ = match._ -- any match
_.name = "any"
_.arguments = {n = 0}

describe("DisenchantBuddy", function()

    local DisenchantBuddy
    local gameTooltipMock
    local frameMock

    local _GetItemInfoForMaterials

    before_each(function()
        frameMock = {
            RegisterEvent = spy.new(),
            SetScript = spy.new(),
        }
        _G.CreateFrame = function()
            return frameMock
        end
        _G.GameTooltip = {
            HookScript = spy.new(),
            IsForbidden = function()
                return false
            end,
            GetItem = spy.new(function()
                return "itemName", "itemLink"
            end),
            Show = spy.new(),
            AddLine = spy.new(),
        }
        _G.ItemRefTooltip = {
            HookScript = spy.new(),
        }
        gameTooltipMock = _G.GameTooltip
        _G.Item = {
            CreateFromItemID = function(_, itemId)
                return {
                    ContinueOnItemLoad = function(_, callback)
                        callback()
                    end,
                    GetItemName = function()
                        return select(1, _GetItemInfoForMaterials(itemId))
                    end,
                    GetItemIcon = function()
                        return select(10, _GetItemInfoForMaterials(itemId))
                    end,
                    GetItemQualityColor = function()
                        return {
                            hex = select(4, GetItemQualityColor(select(3, _GetItemInfoForMaterials(itemId))))
                        }
                    end
                }
            end,
        }

        DisenchantBuddy = {}
        -- We use `loadfile` over `require` to be able to hand in our own environment
        loadfile("Materials.lua")("DisenchantBuddy", DisenchantBuddy)
        loadfile("DisenchantResults/Uncommon.lua")("DisenchantBuddy", DisenchantBuddy)
        loadfile("DisenchantResults/Rare.lua")("DisenchantBuddy", DisenchantBuddy)
        loadfile("DisenchantResults/Epic.lua")("DisenchantBuddy", DisenchantBuddy)
        loadfile("DisenchantBuddy.lua")("DisenchantBuddy", DisenchantBuddy)
    end)

    it("should hook PLAYER_ENTERING_WORLD event", function()
        assert.spy(frameMock.RegisterEvent).was.called_with(_, "PLAYER_ENTERING_WORLD")
        assert.spy(frameMock.SetScript).was.called_with(_, "OnEvent", DisenchantBuddy.OnPlayerEnteringWorld)
    end)

    describe("OnPlayerEnteringWorld", function()
        it("should hook OnTooltipSetItem", function()
            DisenchantBuddy.OnPlayerEnteringWorld()
            assert.spy(_G.GameTooltip.HookScript).was.called_with(_G.GameTooltip, "OnTooltipSetItem", DisenchantBuddy.OnTooltipSetItem)
            assert.spy(_G.ItemRefTooltip.HookScript).was.called_with(_G.ItemRefTooltip, "OnTooltipSetItem", DisenchantBuddy.OnTooltipSetItem)
        end)
    end)

    describe("OnTooltipSetItem", function()
        it("should not show when itemLink is nil", function()
            gameTooltipMock.GetItem = spy.new(function()
                return nil, nil
            end)

            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(gameTooltipMock.GetItem).was.called()
            assert.spy(gameTooltipMock.Show).was_not.called()
            assert.spy(gameTooltipMock.AddLine).was_not.called()
        end)

        it("should not show when IsForbidden is true", function()
            gameTooltipMock.IsForbidden = function()
                return true
            end

            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(gameTooltipMock.GetItem).was.called()
            assert.spy(gameTooltipMock.Show).was_not.called()
            assert.spy(gameTooltipMock.AddLine).was_not.called()
        end)

        it("should not show tooltip for poor quality items", function()
            _G.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Poor, 5, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
            end)

            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(gameTooltipMock.GetItem).was.called()
            assert.spy(gameTooltipMock.Show).was_not.called()
            assert.spy(gameTooltipMock.AddLine).was_not.called()
        end)

        it("should not show tooltip for common quality items", function()
            _G.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Standard, 5, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
            end)

            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(gameTooltipMock.GetItem).was.called()
            assert.spy(gameTooltipMock.Show).was_not.called()
            assert.spy(gameTooltipMock.AddLine).was_not.called()
        end)

        it("should not show tooltip for legendary quality items", function()
            _G.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Legendary, 5, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
            end)

            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(gameTooltipMock.GetItem).was.called()
            assert.spy(gameTooltipMock.Show).was_not.called()
            assert.spy(gameTooltipMock.AddLine).was_not.called()
        end)

        it("should not show tooltip for item types other than armor and weapon", function()
            _G.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Good, 5, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Container
            end)

            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(gameTooltipMock.GetItem).was.called()
            assert.spy(gameTooltipMock.Show).was_not.called()
            assert.spy(gameTooltipMock.AddLine).was_not.called()
        end)

        it("should not show tooltip for unhandled uncommon item level", function()
            _G.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Standard, 66, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
            end)

            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(gameTooltipMock.GetItem).was.called()
            assert.spy(gameTooltipMock.Show).was_not.called()
            assert.spy(gameTooltipMock.AddLine).was_not.called()
        end)

        it("should not show tooltip for unhandled rare item level", function()
            _G.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Rare, 66, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
            end)

            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(gameTooltipMock.GetItem).was.called()
            assert.spy(gameTooltipMock.Show).was_not.called()
            assert.spy(gameTooltipMock.AddLine).was_not.called()
        end)

        it("should not show tooltip for Lesser Magic Wand", function()
            gameTooltipMock.GetItem = spy.new(function()
                return nil, "|cff1eff00|Hitem:11287::::::::21::::::::|h[Lesser Magic Wand]|h|r"
            end)
            _G.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Good, 5, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
            end)

            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(gameTooltipMock.GetItem).was.called()
            assert.spy(gameTooltipMock.Show).was_not.called()
            assert.spy(gameTooltipMock.AddLine).was_not.called()
        end)

        it("should not show tooltip for Greater Magic Wand", function()
            gameTooltipMock.GetItem = spy.new(function()
                return nil, "|cff1eff00|Hitem:11288::::::::21::::::::|h[Greater Magic Wand]|h|r"
            end)
            _G.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Good, 5, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
            end)

            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(gameTooltipMock.GetItem).was.called()
            assert.spy(gameTooltipMock.Show).was_not.called()
            assert.spy(gameTooltipMock.AddLine).was_not.called()
        end)

        it("should not show tooltip for Lesser Mystic Wand", function()
            gameTooltipMock.GetItem = spy.new(function()
                return nil, "|cff1eff00|Hitem:11289::::::::21::::::::|h[Lesser Mystic Wand]|h|r"
            end)
            _G.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Good, 5, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
            end)

            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(gameTooltipMock.GetItem).was.called()
            assert.spy(gameTooltipMock.Show).was_not.called()
            assert.spy(gameTooltipMock.AddLine).was_not.called()
        end)

        it("should not show tooltip for Greater Mystic Wand", function()
            gameTooltipMock.GetItem = spy.new(function()
                return nil, "|cff1eff00|Hitem:11290::::::::21::::::::|h[Greater Mystic Wand]|h|r"
            end)
            _G.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Good, 5, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
            end)

            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(gameTooltipMock.GetItem).was.called()
            assert.spy(gameTooltipMock.Show).was_not.called()
            assert.spy(gameTooltipMock.AddLine).was_not.called()
        end)

        it("should show tooltip for uncommon level 5 items", function()
            _G.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Good, 5, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
            end)

            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(gameTooltipMock.GetItem).was.called()
            assert.spy(gameTooltipMock.Show).was.called()
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
            assert.spy(gameTooltipMock.AddLine).was.called_with(_, "  |T132858:0|t " .. Colors.STANDARD .. "Strange Dust" .. "|r (80%)")
            assert.spy(gameTooltipMock.AddLine).was.called_with(_, "  |T132867:0|t " .. Colors.GOOD .. "Lesser Magic Essence" .. "|r (20%)")
        end)

        it("should show tooltip for rare level 5 items", function()
            _G.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Rare, 5, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
            end)

            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(gameTooltipMock.GetItem).was.called()
            assert.spy(gameTooltipMock.Show).was.called()
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
            assert.spy(gameTooltipMock.AddLine).was.called_with(_, "  |T132877:0|t " .. Colors.RARE .. "Small Glimmering Shard" .. "|r (100%)")
        end)

        it("should show tooltip for epic level 60 items", function()
            _G.GetItemInfo = spy.new(function()
                return nil, nil, Enum.ItemQuality.Epic, 60, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
            end)

            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(gameTooltipMock.GetItem).was.called()
            assert.spy(gameTooltipMock.Show).was.called()
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
            assert.spy(gameTooltipMock.AddLine).was.called_with(_, "  |T132880:0|t " .. Colors.EPIC .. "Nexus Crystal" .. "|r (100%)")
        end)
    end)

    _GetItemInfoForMaterials = function(itemId)
        if itemId == 10940 then
            return "Strange Dust", nil, Enum.ItemQuality.Standard, nil, nil, nil, nil, nil, nil, 132858
        elseif itemId == 11083 then
            return "Soul Dust", nil, Enum.ItemQuality.Standard, nil, nil, nil, nil, nil, nil, 132857
        elseif itemId == 11137 then
            return "Vision Dust", nil, Enum.ItemQuality.Standard, nil, nil, nil, nil, nil, nil, 132859
        elseif itemId == 11176 then
            return "Dream Dust", nil, Enum.ItemQuality.Standard, nil, nil, nil, nil, nil, nil, 132855
        elseif itemId == 16204 then
            return "Illusion Dust", nil, Enum.ItemQuality.Standard, nil, nil, nil, nil, nil, nil, 132856
        elseif itemId == 10938 then
            return "Lesser Magic Essence", nil, Enum.ItemQuality.Good, nil, nil, nil, nil, nil, nil, 132867
        elseif itemId == 10939 then
            return "Greater Magic Essence", nil, Enum.ItemQuality.Good, nil, nil, nil, nil, nil, nil, 132866
        elseif itemId == 10998 then
            return "Lesser Astral Essence", nil, Enum.ItemQuality.Good, nil, nil, nil, nil, nil, nil, 132863
        elseif itemId == 11082 then
            return "Greater Astral Essence", nil, Enum.ItemQuality.Good, nil, nil, nil, nil, nil, nil, 132862
        elseif itemId == 11134 then
            return "Lesser Mystic Essence", nil, Enum.ItemQuality.Good, nil, nil, nil, nil, nil, nil, 132869
        elseif itemId == 11135 then
            return "Greater Mystic Essence", nil, Enum.ItemQuality.Good, nil, nil, nil, nil, nil, nil, 132868
        elseif itemId == 11174 then
            return "Lesser Nether Essence", nil, Enum.ItemQuality.Good, nil, nil, nil, nil, nil, nil, 132871
        elseif itemId == 11175 then
            return "Greater Nether Essence", nil, Enum.ItemQuality.Good, nil, nil, nil, nil, nil, nil, 132870
        elseif itemId == 16202 then
            return "Lesser Eternal Essence", nil, Enum.ItemQuality.Good, nil, nil, nil, nil, nil, nil, 132865
        elseif itemId == 16203 then
            return "Greater Eternal Essence", nil, Enum.ItemQuality.Good, nil, nil, nil, nil, nil, nil, 132864
        elseif itemId == 10978 then
            return "Small Glimmering Shard", nil, Enum.ItemQuality.Rare, nil, nil, nil, nil, nil, nil, 132877
        elseif itemId == 11084 then
            return "Large Glimmering Shard", nil, Enum.ItemQuality.Rare, nil, nil, nil, nil, nil, nil, 132876
        elseif itemId == 11138 then
            return "Small Glowing Shard", nil, Enum.ItemQuality.Rare, nil, nil, nil, nil, nil, nil, 132879
        elseif itemId == 11139 then
            return "Large Glowing Shard", nil, Enum.ItemQuality.Rare, nil, nil, nil, nil, nil, nil, 132878
        elseif itemId == 11177 then
            return "Small Radiant Shard", nil, Enum.ItemQuality.Rare, nil, nil, nil, nil, nil, nil, 132884
        elseif itemId == 11178 then
            return "Large Radiant Shard", nil, Enum.ItemQuality.Rare, nil, nil, nil, nil, nil, nil, 132883
        elseif itemId == 14343 then
            return "Small Brilliant Shard", nil, Enum.ItemQuality.Rare, nil, nil, nil, nil, nil, nil, 132874
        elseif itemId == 14344 then
            return "Large Brilliant Shard", nil, Enum.ItemQuality.Rare, nil, nil, nil, nil, nil, nil, 132873
        elseif itemId == 20725 then
            return "Nexus Crystal", nil, Enum.ItemQuality.Epic, nil, nil, nil, nil, nil, nil, 132880
        else
            return nil
        end
    end
end)
