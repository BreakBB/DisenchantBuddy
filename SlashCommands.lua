---@class DisenchantBuddy
local DisenchantBuddy = select(2, ...)

SLASH_DisenchantBuddy1 = "/disenchantbuddy"
SLASH_DisenchantBuddy2 = "/debuddy"

function DisenchantBuddy.ProcessCommand()
    Settings.OpenToCategory(DisenchantBuddy.SettingsCategoryID)
end

SlashCmdList["DisenchantBuddy"] = DisenchantBuddy.ProcessCommand
