---@class DisenchantBuddy
local DisenchantBuddy = select(2, ...)

if GetLocale() ~= "deDE" then
    return
end

DisenchantBuddy.L = {
    ["Disenchant results:"] = "Entzauberungsergebnisse:",
    ["Disenchanted from:"] = "Entzaubert von:",
    ["Modifier"] = "Modifikatortaste",
    ["Only show disenchant info while this key is held down."] = "Disenchant-Infos nur anzeigen, solange diese Taste gedrückt wird.",
    ["Settings are not available on this client."] = "Einstellungen sind auf diesem Client nicht verfügbar.",
}
