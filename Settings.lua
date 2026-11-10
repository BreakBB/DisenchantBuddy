---@class DisenchantBuddy
local DisenchantBuddy = select(2, ...)

local L = DisenchantBuddy.L

local function GetModifier()
    return DisenchantBuddy_Profile and DisenchantBuddy_Profile.Modifier or "OFF"
end

---@param value string
local function SetModifier(value)
    DisenchantBuddy_Profile = DisenchantBuddy_Profile or {}
    DisenchantBuddy_Profile.Modifier = value
end

local function GetModifierOptions()
    local container = Settings.CreateControlTextContainer()
    container:Add("OFF", OFF)
    container:Add("SHIFT", SHIFT_KEY_TEXT)
    container:Add("ALT", ALT_KEY_TEXT)
    container:Add("CONTROL", CTRL_KEY_TEXT)
    return container:GetData()
end

function DisenchantBuddy.RegisterSettings()
    if (not (Settings and Settings.RegisterAddOnCategory)) then
        return
    end

    local category = Settings.RegisterVerticalLayoutCategory("Disenchant Buddy")
    local setting = Settings.RegisterProxySetting(category, "DISENCHANTBUDDY_MODIFIER", Settings.VarType.String, L["Modifier"], "OFF", GetModifier, SetModifier)
    Settings.CreateDropdown(category, setting, GetModifierOptions, L["Only show disenchant info while this key is held down."])
    Settings.RegisterAddOnCategory(category)

    DisenchantBuddy.SettingsCategoryID = category:GetID()
end

DisenchantBuddy.RegisterSettings()
