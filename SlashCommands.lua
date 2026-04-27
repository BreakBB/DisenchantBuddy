---@class DisenchantBuddy
local DisenchantBuddy = select(2, ...)

SLASH_DisenchantBuddy1 = "/disenchantbuddy"

---@param msg string
function DisenchantBuddy.ProcessCommand(msg)
    local _, _, cmd, args = string.find(msg, "%s?(%w+)%s?(.*)")
    if cmd then
        cmd = cmd:lower()
    end
    if cmd == "modifier" then
        local args_upper = args:upper()
        if (args_upper == "SHIFT" or args_upper == "ALT" or args_upper == "CONTROL") then
            DisenchantBuddy_Profile.Modifier = args_upper
        else
            DisenchantBuddy_Profile.Modifier = "OFF"
        end
        print("Modifier is now: " .. DisenchantBuddy_Profile.Modifier)
    else
        print("Syntax: " .. SLASH_DisenchantBuddy1 .. " modifier ( shift | alt | control | off )")
    end
end

---@param mod string
function DisenchantBuddy.IsModifierDown(mod)
    if mod == "SHIFT" then
        return IsShiftKeyDown()
    elseif mod == "ALT" then
        return IsAltKeyDown()
    elseif mod == "CONTROL" then
        return IsControlKeyDown()
    end
    return true
end

SlashCmdList["DisenchantBuddy"] = DisenchantBuddy.ProcessCommand
