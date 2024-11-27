dofile(".types/wow-api/library/Data/Enum.lua")

describe("DisenchantBuddy", function()

    local DisenchantBuddy
    local gameTooltipMock

    local _GetItemInfoForMaterials

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
        loadfile("Materials.lua")("DisenchantBuddy", DisenchantBuddy)
        loadfile("DisenchantResults/Uncommon.lua")("DisenchantBuddy", DisenchantBuddy)
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

        it("should show tooltip for level 5 items", function()
            _G.GetItemInfo = spy.new(function(itemId)
                local materialName = _GetItemInfoForMaterials(itemId)
                if materialName then
                    return materialName
                end
                return nil, nil, Enum.ItemQuality.Good, 5, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
            end)

            DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

            assert.spy(gameTooltipMock.GetItem).was.called()
            assert.spy(gameTooltipMock.Show).was.called()
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Strange Dust", 1, 1, 1)
            assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Lesser Magic Essence", 1, 1, 1)
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
                _G.GetItemInfo = spy.new(function(itemId)
                    local materialName = _GetItemInfoForMaterials(itemId)
                    if materialName then
                        return materialName
                    end
                    return nil, nil, Enum.ItemQuality.Rare, 5, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Small Glimmering Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 15 items", function()
                _G.GetItemInfo = spy.new(function(itemId)
                    local materialName = _GetItemInfoForMaterials(itemId)
                    if materialName then
                        return materialName
                    end
                    return nil, nil, Enum.ItemQuality.Rare, 15, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Small Glimmering Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 16 items", function()
                _G.GetItemInfo = spy.new(function(itemId)
                    local materialName = _GetItemInfoForMaterials(itemId)
                    if materialName then
                        return materialName
                    end
                    return nil, nil, Enum.ItemQuality.Rare, 16, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Small Glimmering Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 20 items", function()
                _G.GetItemInfo = spy.new(function(itemId)
                    local materialName = _GetItemInfoForMaterials(itemId)
                    if materialName then
                        return materialName
                    end
                    return nil, nil, Enum.ItemQuality.Rare, 20, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Small Glimmering Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 21 items", function()
                _G.GetItemInfo = spy.new(function(itemId)
                    local materialName = _GetItemInfoForMaterials(itemId)
                    if materialName then
                        return materialName
                    end
                    return nil, nil, Enum.ItemQuality.Rare, 21, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Small Glimmering Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 25 items", function()
                _G.GetItemInfo = spy.new(function(itemId)
                    local materialName = _GetItemInfoForMaterials(itemId)
                    if materialName then
                        return materialName
                    end
                    return nil, nil, Enum.ItemQuality.Rare, 25, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Small Glimmering Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 26 items", function()
                _G.GetItemInfo = spy.new(function(itemId)
                    local materialName = _GetItemInfoForMaterials(itemId)
                    if materialName then
                        return materialName
                    end
                    return nil, nil, Enum.ItemQuality.Rare, 26, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Large Glimmering Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 30 items", function()
                _G.GetItemInfo = spy.new(function(itemId)
                    local materialName = _GetItemInfoForMaterials(itemId)
                    if materialName then
                        return materialName
                    end
                    return nil, nil, Enum.ItemQuality.Rare, 30, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Large Glimmering Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 31 items", function()
                _G.GetItemInfo = spy.new(function(itemId)
                    local materialName = _GetItemInfoForMaterials(itemId)
                    if materialName then
                        return materialName
                    end
                    return nil, nil, Enum.ItemQuality.Rare, 31, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Small Glowing Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 35 items", function()
                _G.GetItemInfo = spy.new(function(itemId)
                    local materialName = _GetItemInfoForMaterials(itemId)
                    if materialName then
                        return materialName
                    end
                    return nil, nil, Enum.ItemQuality.Rare, 35, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Small Glowing Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 36 items", function()
                _G.GetItemInfo = spy.new(function(itemId)
                    local materialName = _GetItemInfoForMaterials(itemId)
                    if materialName then
                        return materialName
                    end
                    return nil, nil, Enum.ItemQuality.Rare, 36, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Large Glowing Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 40 items", function()
                _G.GetItemInfo = spy.new(function(itemId)
                    local materialName = _GetItemInfoForMaterials(itemId)
                    if materialName then
                        return materialName
                    end
                    return nil, nil, Enum.ItemQuality.Rare, 40, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Large Glowing Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 41 items", function()
                _G.GetItemInfo = spy.new(function(itemId)
                    local materialName = _GetItemInfoForMaterials(itemId)
                    if materialName then
                        return materialName
                    end
                    return nil, nil, Enum.ItemQuality.Rare, 41, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Small Radiant Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 45 items", function()
                _G.GetItemInfo = spy.new(function(itemId)
                    local materialName = _GetItemInfoForMaterials(itemId)
                    if materialName then
                        return materialName
                    end
                    return nil, nil, Enum.ItemQuality.Rare, 45, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Small Radiant Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 46 items", function()
                _G.GetItemInfo = spy.new(function(itemId)
                    local materialName = _GetItemInfoForMaterials(itemId)
                    if materialName then
                        return materialName
                    end
                    return nil, nil, Enum.ItemQuality.Rare, 46, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Large Radiant Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 50 items", function()
                _G.GetItemInfo = spy.new(function(itemId)
                    local materialName = _GetItemInfoForMaterials(itemId)
                    if materialName then
                        return materialName
                    end
                    return nil, nil, Enum.ItemQuality.Rare, 50, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Large Radiant Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 51 items", function()
                _G.GetItemInfo = spy.new(function(itemId)
                    local materialName = _GetItemInfoForMaterials(itemId)
                    if materialName then
                        return materialName
                    end
                    return nil, nil, Enum.ItemQuality.Rare, 51, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Small Brilliant Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 55 items", function()
                _G.GetItemInfo = spy.new(function(itemId)
                    local materialName = _GetItemInfoForMaterials(itemId)
                    if materialName then
                        return materialName
                    end
                    return nil, nil, Enum.ItemQuality.Rare, 55, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Small Brilliant Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 56 items", function()
                _G.GetItemInfo = spy.new(function(itemId)
                    local materialName = _GetItemInfoForMaterials(itemId)
                    if materialName then
                        return materialName
                    end
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
                _G.GetItemInfo = spy.new(function(itemId)
                    local materialName = _GetItemInfoForMaterials(itemId)
                    if materialName then
                        return materialName
                    end
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
                _G.GetItemInfo = spy.new(function(itemId)
                    local materialName = _GetItemInfoForMaterials(itemId)
                    if materialName then
                        return materialName
                    end
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
                _G.GetItemInfo = spy.new(function(itemId)
                    local materialName = _GetItemInfoForMaterials(itemId)
                    if materialName then
                        return materialName
                    end
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
                _G.GetItemInfo = spy.new(function(itemId)
                    local materialName = _GetItemInfoForMaterials(itemId)
                    if materialName then
                        return materialName
                    end
                    return nil, nil, Enum.ItemQuality.Epic, 40, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Small Radiant Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 45 items", function()
                _G.GetItemInfo = spy.new(function(itemId)
                    local materialName = _GetItemInfoForMaterials(itemId)
                    if materialName then
                        return materialName
                    end
                    return nil, nil, Enum.ItemQuality.Epic, 45, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Small Radiant Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 46 items", function()
                _G.GetItemInfo = spy.new(function(itemId)
                    local materialName = _GetItemInfoForMaterials(itemId)
                    if materialName then
                        return materialName
                    end
                    return nil, nil, Enum.ItemQuality.Epic, 46, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Large Radiant Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 50 items", function()
                _G.GetItemInfo = spy.new(function(itemId)
                    local materialName = _GetItemInfoForMaterials(itemId)
                    if materialName then
                        return materialName
                    end
                    return nil, nil, Enum.ItemQuality.Epic, 50, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Large Radiant Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 51 items", function()
                _G.GetItemInfo = spy.new(function(itemId)
                    local materialName = _GetItemInfoForMaterials(itemId)
                    if materialName then
                        return materialName
                    end
                    return nil, nil, Enum.ItemQuality.Epic, 51, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Small Brilliant Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 55 items", function()
                _G.GetItemInfo = spy.new(function(itemId)
                    local materialName = _GetItemInfoForMaterials(itemId)
                    if materialName then
                        return materialName
                    end
                    return nil, nil, Enum.ItemQuality.Epic, 55, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Small Brilliant Shard", 1, 1, 1)
            end)

            it("should show tooltip for level 56 items", function()
                _G.GetItemInfo = spy.new(function(itemId)
                    local materialName = _GetItemInfoForMaterials(itemId)
                    if materialName then
                        return materialName
                    end
                    return nil, nil, Enum.ItemQuality.Epic, 56, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Nexus Crystal", 1, 1, 1)
            end)

            it("should show tooltip for level 60 items", function()
                _G.GetItemInfo = spy.new(function(itemId)
                    local materialName = _GetItemInfoForMaterials(itemId)
                    if materialName then
                        return materialName
                    end
                    return nil, nil, Enum.ItemQuality.Epic, 60, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Nexus Crystal", 1, 1, 1)
            end)

            it("should show tooltip for level 61 items", function()
                _G.GetItemInfo = spy.new(function(itemId)
                    local materialName = _GetItemInfoForMaterials(itemId)
                    if materialName then
                        return materialName
                    end
                    return nil, nil, Enum.ItemQuality.Epic, 61, nil, nil, nil, nil, nil, nil, nil, Enum.ItemClass.Armor
                end)

                DisenchantBuddy.OnTooltipSetItem(gameTooltipMock)

                assert.spy(gameTooltipMock.GetItem).was.called()
                assert.spy(gameTooltipMock.Show).was.called()
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Disenchant results:")
                assert.spy(gameTooltipMock.AddLine).was.called_with(gameTooltipMock, "Nexus Crystal", 1, 1, 1)
            end)

            it("should show tooltip for level 65 items", function()
                _G.GetItemInfo = spy.new(function(itemId)
                    local materialName = _GetItemInfoForMaterials(itemId)
                    if materialName then
                        return materialName
                    end
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

    _GetItemInfoForMaterials = function(itemId)
        if itemId == 10940 then
            return "Strange Dust"
        elseif itemId == 11083 then
            return "Soul Dust"
        elseif itemId == 11137 then
            return "Vision Dust"
        elseif itemId == 11176 then
            return "Dream Dust"
        elseif itemId == 16204 then
            return "Illusion Dust"
        elseif itemId == 10938 then
            return "Lesser Magic Essence"
        elseif itemId == 10939 then
            return "Greater Magic Essence"
        elseif itemId == 10998 then
            return "Lesser Astral Essence"
        elseif itemId == 11082 then
            return "Greater Astral Essence"
        elseif itemId == 11134 then
            return "Lesser Mystic Essence"
        elseif itemId == 11135 then
            return "Greater Mystic Essence"
        elseif itemId == 11174 then
            return "Lesser Nether Essence"
        elseif itemId == 11175 then
            return "Greater Nether Essence"
        elseif itemId == 16202 then
            return "Lesser Eternal Essence"
        elseif itemId == 16203 then
            return "Greater Eternal Essence"
        elseif itemId == 10978 then
            return "Small Glimmering Shard"
        elseif itemId == 11084 then
            return "Large Glimmering Shard"
        elseif itemId == 11138 then
            return "Small Glowing Shard"
        elseif itemId == 11139 then
            return "Large Glowing Shard"
        elseif itemId == 11177 then
            return "Small Radiant Shard"
        elseif itemId == 11178 then
            return "Large Radiant Shard"
        elseif itemId == 14343 then
            return "Small Brilliant Shard"
        elseif itemId == 14344 then
            return "Large Brilliant Shard"
        elseif itemId == 20725 then
            return "Nexus Crystal"
        else
            return nil
        end
    end
end)
