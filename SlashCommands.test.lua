_G.SlashCmdList = {}
_G.SLASH_DisenchantBuddy1 = nil
_G.SLASH_DisenchantBuddy2 = nil

describe("SlashCommands", function()
    ---@type DisenchantBuddy
    local DisenchantBuddy

    before_each(function()
        DisenchantBuddy = {}
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

        it("should open the materials overview", function()
            _G.Settings = { OpenToCategory = spy.new(function() end) }
            DisenchantBuddy.SettingsCategoryID = 42
            DisenchantBuddy.MaterialsCategoryID = 43

            DisenchantBuddy.ProcessCommand("materials")

            assert.spy(_G.Settings.OpenToCategory).was.called_with(43)
        end)
    end)
end)
