describe("Settings", function()
    ---@type DisenchantBuddy
    local DisenchantBuddy
    local category
    local getValue
    local setValue
    local options

    local function load()
        DisenchantBuddy = {
            L = {
                ["Modifier"] = "Modifier",
                ["Only show disenchant info while this key is held down."] = "Tooltip",
            }
        }
        loadfile("Settings.lua")("DisenchantBuddy", DisenchantBuddy)
    end

    before_each(function()
        category = { GetID = function() return 42 end }
        options = {}
        _G.OFF = "Off"
        _G.SHIFT_KEY_TEXT = "Shift"
        _G.ALT_KEY_TEXT = "Alt"
        _G.CTRL_KEY_TEXT = "Ctrl"
        _G.DisenchantBuddy_Profile = {}
        _G.IsShiftKeyDown = spy.new(function() return false end)
        _G.IsAltKeyDown = spy.new(function() return false end)
        _G.IsControlKeyDown = spy.new(function() return false end)
        _G.Settings = {
            VarType = { String = "string" },
            RegisterVerticalLayoutCategory = spy.new(function() return category end),
            RegisterProxySetting = spy.new(function(_, _, _, _, _, getter, setter)
                getValue = getter
                setValue = setter
                return "setting"
            end),
            CreateControlTextContainer = function()
                return {
                    Add = function(_, value, label) table.insert(options, { value = value, label = label }) end,
                    GetData = function() return options end,
                }
            end,
            CreateDropdown = spy.new(function(_, _, getOptions) getOptions() end),
            RegisterAddOnCategory = spy.new(function() end),
        }
    end)

    it("should register the category and store its id", function()
        load()

        assert.spy(_G.Settings.RegisterAddOnCategory).was.called_with(category)
        assert.are_same(42, DisenchantBuddy.SettingsCategoryID)
    end)

    it("should not fail when the settings api is missing", function()
        _G.Settings = nil

        load()

        assert.is_nil(DisenchantBuddy.SettingsCategoryID)
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
