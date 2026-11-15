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

---@param category table
---@param variable string
---@param key string
---@param name string
---@param tooltip string
local function CreateAuctionatorCheckbox(category, variable, key, name, tooltip)
    local function GetValue()
        return (not DisenchantBuddy_Profile) or DisenchantBuddy_Profile[key] ~= false
    end

    local function SetValue(value)
        DisenchantBuddy_Profile = DisenchantBuddy_Profile or {}
        DisenchantBuddy_Profile[key] = value
    end

    local setting = Settings.RegisterProxySetting(category, variable, Settings.VarType.Boolean, name, true, GetValue, SetValue)
    local initializer = Settings.CreateCheckbox(category, setting, tooltip)
    initializer:AddModifyPredicate(function()
        return Auctionator ~= nil
    end)
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

function DisenchantBuddy.RegisterSettings()
    local category = Settings.RegisterVerticalLayoutCategory("Disenchant Buddy")
    local setting = Settings.RegisterProxySetting(category, "DISENCHANTBUDDY_MODIFIER", Settings.VarType.String, L["Modifier"], "OFF", GetModifier, SetModifier)
    Settings.CreateDropdown(category, setting, GetModifierOptions, L["Only show disenchant info while this key is held down."])
    CreateAuctionatorCheckbox(category, "DISENCHANTBUDDY_SHOW_MATERIAL_PRICES", "ShowMaterialPrices", L["Show prices per material"],
        L["Show the Auctionator price of each material in the tooltip."])
    CreateAuctionatorCheckbox(category, "DISENCHANTBUDDY_SHOW_AVERAGE_PRICE", "ShowAveragePrice", L["Show average price"],
        L["Show the average disenchant value based on Auctionator prices in the tooltip."])
    local materialsCategory = Settings.RegisterCanvasLayoutSubcategory(category, DisenchantBuddy.CreateMaterialsOverviewFrame(), L["Materials"])
    Settings.RegisterAddOnCategory(category)

    DisenchantBuddy.SettingsCategoryID = category:GetID()
    DisenchantBuddy.MaterialsCategoryID = materialsCategory:GetID()
end

DisenchantBuddy.RegisterSettings()
