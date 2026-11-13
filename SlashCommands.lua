---@class DisenchantBuddy
local DisenchantBuddy = select(2, ...)

local L = DisenchantBuddy.L

SLASH_DisenchantBuddy1 = "/disenchantbuddy"
SLASH_DisenchantBuddy2 = "/debuddy"

local MODIFIERS = { off = "OFF", shift = "SHIFT", alt = "ALT", ctrl = "CONTROL", control = "CONTROL" }

---@param msg string?
function DisenchantBuddy.ProcessCommand(msg)
    if (not DisenchantBuddy.SettingsCategoryID) then
        local arg = (msg or ""):lower():match("^modifier%s+(%a+)$")
        local value = arg and MODIFIERS[arg]
        if value then
            DisenchantBuddy_Profile = DisenchantBuddy_Profile or {}
            DisenchantBuddy_Profile.Modifier = value
            print(L["Modifier"] .. ": " .. value)
        else
            print(L["Settings are not available on this client."])
            print("/debuddy modifier off|shift|alt|ctrl")
        end
        return
    end
    Settings.OpenToCategory(DisenchantBuddy.SettingsCategoryID)
end

SlashCmdList["DisenchantBuddy"] = DisenchantBuddy.ProcessCommand
