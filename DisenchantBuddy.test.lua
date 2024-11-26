dofile(".types/wow-api/library/Data/Enum.lua")

describe("DisenchantBuddy", function()

    local DisenchantBuddy
    local gameTooltipMock

    before_each(function()
        _G.GameTooltip = {
            HookScript = spy.new(),
            GetItem = spy.new(function()
                return "itemName", "itemLink"
            end),
            Show = spy.new(),
            AddLine = spy.new(),
        }
        gameTooltipMock = _G.GameTooltip

        DisenchantBuddy = {}
        -- We use `loadfile` over `require` to be able to hand in our own environment
        loadfile("DisenchantBuddy.lua")("DisenchantBuddy", DisenchantBuddy)
    end)

    it("should hook GameTooltip with OnTooltipSetItem", function()
        assert.spy(_G.GameTooltip.HookScript).was.called_with(_G.GameTooltip, "OnTooltipSetItem", DisenchantBuddy.OnTooltipSetItem)
    end)

    describe("OnTooltipSetItem", function()
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
                return nil, nil, Enum.ItemQuality.Good, 5, nil, Enum.ItemClass.Container
            end)

            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(gameTooltipMock.GetItem).was.called()
            assert.spy(gameTooltipMock.Show).was_not.called()
            assert.spy(gameTooltipMock.AddLine).was_not.called()
        end)

        describe("Uncommon armor", function()
            it("should not show tooltip for unhandled item level", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Good, 66, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was_not.called()
                assert.spy(gameTooltipMock.AddLine).was_not.called()
            end)

            it("should show tooltip for level 5 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Good, 5, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Strange Dust", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Lesser Magic Essence", 1, 1, 1)
            end)

            it("should show tooltip for level 15 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Good, 15, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Strange Dust", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Lesser Magic Essence", 1, 1, 1)
            end)

            it("should show tooltip for level 16 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Good, 16, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Strange Dust", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Greater Magic Essence", 1, 1, 1)
            end)

            it("should show tooltip for level 20 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Good, 20, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Strange Dust", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Greater Magic Essence", 1, 1, 1)
            end)

            it("should show tooltip for level 21 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Good, 21, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Strange Dust", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Lesser Astral Essence", 1, 1, 1)
            end)

            it("should show tooltip for level 25 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Good, 25, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Strange Dust", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Lesser Astral Essence", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Small Glimmering Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 26 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Good, 26, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Soul Dust", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Greater Astral Essence", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Large Glimmering Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 30 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Good, 30, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Soul Dust", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Greater Astral Essence", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Large Glimmering Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 31 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Good, 31, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Soul Dust", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Lesser Mystic Essence", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Small Glowing Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 35 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Good, 35, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Soul Dust", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Lesser Mystic Essence", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Small Glowing Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 36 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Good, 36, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Vision Dust", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Greater Mystic Essence", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Large Glowing Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 40 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Good, 40, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Vision Dust", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Greater Mystic Essence", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Large Glowing Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 41 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Good, 41, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Vision Dust", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Lesser Nether Essence", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Small Radiant Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 45 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Good, 45, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Vision Dust", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Lesser Nether Essence", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Small Radiant Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 46 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Good, 46, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Dream Dust", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Greater Nether Essence", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Large Radiant Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 50 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Good, 50, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Dream Dust", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Greater Nether Essence", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Large Radiant Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 51 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Good, 51, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Dream Dust", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Lesser Eternal Essence", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Small Brilliant Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 55 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Good, 55, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Dream Dust", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Lesser Eternal Essence", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Small Brilliant Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 56 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Good, 56, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Illusion Dust", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Greater Eternal Essence", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Large Brilliant Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 60 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Good, 60, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Illusion Dust", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Greater Eternal Essence", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Large Brilliant Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 61 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Good, 61, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Illusion Dust", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Greater Eternal Essence", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Large Brilliant Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 65 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Good, 65, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Illusion Dust", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Greater Eternal Essence", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Large Brilliant Shard", 1, 1, 1)
            end)
        end)

        describe("Rare items", function()
            it("should not show tooltip for unhandled item level", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Rare, 66, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was_not.called()
                assert.spy(gameTooltipMock.AddLine).was_not.called()
            end)

            it("should show tooltip for level 5 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Rare, 5, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Small Glimmering Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 15 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Rare, 15, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Small Glimmering Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 16 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Rare, 16, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Small Glimmering Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 20 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Rare, 20, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Small Glimmering Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 21 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Rare, 21, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Small Glimmering Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 25 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Rare, 25, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Small Glimmering Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 26 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Rare, 26, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Large Glimmering Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 30 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Rare, 30, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Large Glimmering Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 31 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Rare, 31, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Small Glowing Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 35 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Rare, 35, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Small Glowing Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 36 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Rare, 36, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Large Glowing Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 40 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Rare, 40, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Large Glowing Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 41 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Rare, 41, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Small Radiant Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 45 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Rare, 45, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Small Radiant Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 46 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Rare, 46, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Large Radiant Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 50 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Rare, 50, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Large Radiant Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 51 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Rare, 51, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Small Brilliant Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 55 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Rare, 55, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Small Brilliant Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 56 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Rare, 56, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Large Brilliant Shard", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Nexus Crystal", 1, 1, 1)
            end)

            it("should show tooltip for level 60 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Rare, 60, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Large Brilliant Shard", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Nexus Crystal", 1, 1, 1)
            end)

            it("should show tooltip for level 61 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Rare, 61, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Large Brilliant Shard", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Nexus Crystal", 1, 1, 1)
            end)

            it("should show tooltip for level 65 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Rare, 65, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Large Brilliant Shard", 1, 1, 1)
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Nexus Crystal", 1, 1, 1)
            end)
        end)

        describe("Epic items", function()
            it("should not show tooltip for unhandled item level", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Epic, 66, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was_not.called()
                assert.spy(gameTooltipMock.AddLine).was_not.called()
            end)

            it("should show tooltip for level 40 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Epic, 40, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Small Radiant Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 45 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Epic, 45, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Small Radiant Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 46 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Epic, 46, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Large Radiant Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 50 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Epic, 50, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Large Radiant Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 51 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Epic, 51, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Small Brilliant Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 55 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Epic, 55, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Small Brilliant Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 56 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Epic, 56, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Nexus Crystal", 1, 1, 1)
            end)

            it("should show tooltip for level 60 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Epic, 60, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Nexus Crystal", 1, 1, 1)
            end)

            it("should show tooltip for level 61 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Epic, 61, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Nexus Crystal", 1, 1, 1)
            end)

            it("should show tooltip for level 65 items", function()
                _G.GetItemInfo = spy.new(function()
                    return nil, nil, Enum.ItemQuality.Epic, 65, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Nexus Crystal", 1, 1, 1)
            end)
        end)
    end)
end)
