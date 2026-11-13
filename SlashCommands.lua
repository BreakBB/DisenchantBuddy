---@class DisenchantBuddy
local DisenchantBuddy = select(2, ...)

SLASH_DisenchantBuddy1 = "/disenchantbuddy"
SLASH_DisenchantBuddy2 = "/debuddy"

---@param msg string?
function DisenchantBuddy.ProcessCommand(msg)
    if (msg or ""):lower():match("^%s*materials%s*$") then
        Settings.OpenToCategory(DisenchantBuddy.MaterialsCategoryID)
        return
    end
    Settings.OpenToCategory(DisenchantBuddy.SettingsCategoryID)
end

SlashCmdList["DisenchantBuddy"] = DisenchantBuddy.ProcessCommand
