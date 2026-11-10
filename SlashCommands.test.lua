_G.SlashCmdList = {}
_G.SLASH_DisenchantBuddy1 = nil
_G.SLASH_DisenchantBuddy2 = nil

describe("SlashCommands", function()
    ---@type DisenchantBuddy
    local DisenchantBuddy

    before_each(function()
        _G.IsShiftKeyDown = spy.new(function() return false end)
        _G.IsAltKeyDown = spy.new(function() return false end)
        _G.IsControlKeyDown = spy.new(function() return false end)
        _G.print = spy.new(function() end)
        _G.DisenchantBuddy_Profile = {}

        DisenchantBuddy = {
            L = {
                ["Settings are not available on this client."] = "Settings are not available",
            }
        }
        loadfile("SlashCommands.lua")("DisenchantBuddy", DisenchantBuddy)
    end)

    it("should register /disenchantbuddy and /debuddy as slash commands", function()
        assert.are_same("/disenchantbuddy", _G.SLASH_DisenchantBuddy1)
        assert.are_same("/debuddy", _G.SLASH_DisenchantBuddy2)
    end)

    describe("ProcessCommand", function()
        it("should open the settings category", function()
            _G.Settings = { OpenToCategory = spy.new(function() end) }
            DisenchantBuddy.SettingsCategoryID = 42

            DisenchantBuddy.ProcessCommand("")

            assert.spy(_G.Settings.OpenToCategory).was.called_with(42)
        end)

        it("should print a message when settings are not available", function()
            DisenchantBuddy.ProcessCommand("")

            assert.spy(_G.print).was.called_with("Settings are not available")
        end)
    end)

    describe("IsModifierDown", function()
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
