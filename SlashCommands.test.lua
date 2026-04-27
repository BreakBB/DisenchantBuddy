_G.SlashCmdList = {}
_G.SLASH_DisenchantBuddy1 = nil

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
                ["Modifier is now: %s"] = "Modifier is now: %s",
                ["Syntax:"] = "Syntax:",
            }
        }
        loadfile("SlashCommands.lua")("DisenchantBuddy", DisenchantBuddy)
    end)

    describe("ProcessCommand", function()
        it("should set modifier to SHIFT", function()
            DisenchantBuddy.ProcessCommand("modifier shift")

            assert.are.equal("SHIFT", _G.DisenchantBuddy_Profile.Modifier)
        end)

        it("should set modifier to ALT", function()
            DisenchantBuddy.ProcessCommand("modifier alt")

            assert.are.equal("ALT", _G.DisenchantBuddy_Profile.Modifier)
        end)

        it("should set modifier to CONTROL", function()
            DisenchantBuddy.ProcessCommand("modifier control")

            assert.are.equal("CONTROL", _G.DisenchantBuddy_Profile.Modifier)
        end)

        it("should set modifier to OFF when off is passed", function()
            DisenchantBuddy.ProcessCommand("modifier off")

            assert.are.equal("OFF", _G.DisenchantBuddy_Profile.Modifier)
        end)

        it("should set modifier to OFF for unknown value", function()
            DisenchantBuddy.ProcessCommand("modifier banana")

            assert.are.equal("OFF", _G.DisenchantBuddy_Profile.Modifier)
        end)

        it("should print translated modifier confirmation", function()
            DisenchantBuddy.L["Modifier is now: %s"] = "Modifier ist jetzt: %s"
            loadfile("SlashCommands.lua")("DisenchantBuddy", DisenchantBuddy)

            DisenchantBuddy.ProcessCommand("modifier shift")

            assert.spy(_G.print).was.called_with("Modifier ist jetzt: SHIFT")
        end)

        it("should print translated syntax help for unknown command", function()
            DisenchantBuddy.L["Syntax:"] = "Syntaxe:"
            loadfile("SlashCommands.lua")("DisenchantBuddy", DisenchantBuddy)

            DisenchantBuddy.ProcessCommand("test")

            assert.spy(_G.print).was.called_with("Syntaxe: /disenchantbuddy modifier ( shift | alt | control | off )")
        end)

        it("should print syntax help for unknown command", function()
            DisenchantBuddy.ProcessCommand("test")

            assert.spy(_G.print).was.called()
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
