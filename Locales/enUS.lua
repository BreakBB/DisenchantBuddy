---@class DisenchantBuddy
local DisenchantBuddy = select(2, ...)

if GetLocale() ~= "enUS" then
    return
end

DisenchantBuddy.L = {
    ["Disenchant results:"] = "Disenchant results:",
    ["Disenchanted from:"] = "Disenchanted from:",
    ["Modifier"] = "Modifier",
    ["Only show disenchant info while this key is held down."] = "Only show disenchant info while this key is held down.",
    ["Materials"] = "Materials",
    ["Dusts"] = "Dusts",
    ["Essences"] = "Essences",
    ["Shards"] = "Shards",
    ["Crystals"] = "Crystals",
    ["Item Level"] = "Item Level",
    ["Exclude low-chance results"] = "Exclude low-chance results",
}
