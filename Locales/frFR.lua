---@class DisenchantBuddy
local DisenchantBuddy = select(2, ...)

if GetLocale() ~= "frFR" then
    return
end

DisenchantBuddy.L = {
    ["Disenchant results:"] = "Résultats de désenchantement:",
    ["Disenchanted from:"] = "Désenchanté de:",
}
