---@class DisenchantBuddy
local DisenchantBuddy = select(2, ...)

local L = DisenchantBuddy.L

SLASH_DisenchantBuddy1 = "/disenchantbuddy"
SLASH_DisenchantBuddy2 = "/debuddy"

function DisenchantBuddy.ProcessCommand()
    if (not DisenchantBuddy.SettingsCategoryID) then
        print(L["Settings are not available on this client."])
        return
    end
    Settings.OpenToCategory(DisenchantBuddy.SettingsCategoryID)
end

SlashCmdList["DisenchantBuddy"] = DisenchantBuddy.ProcessCommand
