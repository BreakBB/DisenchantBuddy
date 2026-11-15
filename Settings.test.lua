describe("Settings", function()
    ---@type DisenchantBuddy
    local DisenchantBuddy
    local category
    local subcategory
    local overviewFrame = {}
    local getValue
    local setValue
    local options
    local proxySettings
    local checkboxes

    local function load()
        DisenchantBuddy = {
            CreateMaterialsOverviewFrame = function() return overviewFrame end,
            L = {
                ["Modifier"] = "Modifier",
                ["Materials"] = "Materials",
                ["Only show disenchant info while this key is held down."] = "Tooltip",
                ["Show prices per material"] = "Show prices per material",
                ["Show the Auctionator price of each material in the tooltip."] = "Material price tooltip",
                ["Show average price"] = "Show average price",
                ["Show the average disenchant value based on Auctionator prices in the tooltip."] = "Average price tooltip",
            }
        }
        loadfile("Settings.lua")("DisenchantBuddy", DisenchantBuddy)
    end

    before_each(function()
        category = { GetID = function() return 42 end }
        subcategory = { GetID = function() return 43 end }
        options = {}
        proxySettings = {}
        checkboxes = {}
        _G.Auctionator = nil
        _G.OFF = "Off"
        _G.SHIFT_KEY_TEXT = "Shift"
        _G.ALT_KEY_TEXT = "Alt"
        _G.CTRL_KEY_TEXT = "Ctrl"
        _G.DisenchantBuddy_Profile = {}
        _G.IsShiftKeyDown = spy.new(function() return false end)
        _G.IsAltKeyDown = spy.new(function() return false end)
        _G.IsControlKeyDown = spy.new(function() return false end)
        _G.Settings = {
            VarType = { String = "string", Boolean = "boolean" },
            RegisterVerticalLayoutCategory = spy.new(function() return category end),
            RegisterProxySetting = spy.new(function(_, variable, _, _, default, getter, setter)
                proxySettings[variable] = { default = default, getValue = getter, setValue = setter }
                if variable == "DISENCHANTBUDDY_MODIFIER" then
                    getValue = getter
                    setValue = setter
                end
                return variable
            end),
            CreateCheckbox = spy.new(function(_, setting)
                local initializer = {
                    AddModifyPredicate = function(self, predicate) self.predicate = predicate end,
                }
                checkboxes[setting] = initializer
                return initializer
            end),
            CreateControlTextContainer = function()
                return {
                    Add = function(_, value, label) table.insert(options, { value = value, label = label }) end,
                    GetData = function() return options end,
                }
            end,
            CreateDropdown = spy.new(function(_, _, getOptions) getOptions() end),
            RegisterAddOnCategory = spy.new(function() end),
            RegisterCanvasLayoutSubcategory = spy.new(function() return subcategory end),
        }
    end)

    it("should register the category and store its id", function()
        load()

        assert.spy(_G.Settings.RegisterAddOnCategory).was.called_with(category)
        assert.are_same(42, DisenchantBuddy.SettingsCategoryID)
    end)

    it("should register the materials overview as subcategory", function()
        load()

        assert.spy(_G.Settings.RegisterCanvasLayoutSubcategory).was.called_with(category, overviewFrame, "Materials")
        assert.are_same(43, DisenchantBuddy.MaterialsCategoryID)
    end)

    it("should offer all modifier options", function()
        load()

        assert.are_same({
            { value = "OFF", label = "Off" },
            { value = "SHIFT", label = "Shift" },
            { value = "ALT", label = "Alt" },
            { value = "CONTROL", label = "Ctrl" },
        }, options)
    end)

    it("should default the modifier to OFF", function()
        load()

        assert.are_same("OFF", getValue())
    end)

    it("should read and write the modifier in the profile", function()
        load()

        setValue("ALT")

        assert.are_same("ALT", _G.DisenchantBuddy_Profile.Modifier)
        assert.are_same("ALT", getValue())
    end)

    for _, case in ipairs({
        { variable = "DISENCHANTBUDDY_SHOW_MATERIAL_PRICES", key = "ShowMaterialPrices" },
        { variable = "DISENCHANTBUDDY_SHOW_AVERAGE_PRICE", key = "ShowAveragePrice" },
    }) do
        describe(case.variable, function()
            it("should default to enabled", function()
                load()

                assert.is_true(proxySettings[case.variable].default)
                assert.is_true(proxySettings[case.variable].getValue())
            end)

            it("should read and write the value in the profile", function()
                load()

                proxySettings[case.variable].setValue(false)

                assert.is_false(_G.DisenchantBuddy_Profile[case.key])
                assert.is_false(proxySettings[case.variable].getValue())
            end)

            it("should be disabled when Auctionator is not installed", function()
                load()

                assert.is_false(checkboxes[case.variable].predicate())
            end)

            it("should be enabled when Auctionator is installed", function()
                load()
                _G.Auctionator = {}

                assert.is_true(checkboxes[case.variable].predicate())
            end)
        end)
    end

    describe("IsModifierDown", function()
        before_each(load)

        it("should return true when no modifier is set", function()
            assert.is_true(DisenchantBuddy.IsModifierDown("INVALID"))
        end)

        it("should check shift key when modifier is SHIFT", function()
            _G.IsShiftKeyDown = spy.new(function() return true end)

            local result = DisenchantBuddy.IsModifierDown("SHIFT")

            assert.is_true(result)
        end)

        it("should check alt key when modifier is ALT", function()
            _G.IsAltKeyDown = spy.new(function() return true end)

            local result = DisenchantBuddy.IsModifierDown("ALT")

            assert.is_true(result)
        end)

        it("should check control key when modifier is CONTROL", function()
            _G.IsControlKeyDown = spy.new(function() return true end)

            local result = DisenchantBuddy.IsModifierDown("CONTROL")

            assert.is_true(result)
        end)
    end)
end)
