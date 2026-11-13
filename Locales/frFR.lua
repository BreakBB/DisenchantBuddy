---@class DisenchantBuddy
local DisenchantBuddy = select(2, ...)

if GetLocale() ~= "frFR" then
    return
end

DisenchantBuddy.L = {
    ["Disenchant results:"] = "Résultats de désenchantement :",
    ["Disenchanted from:"] = "Désenchanté de :",
    ["Modifier"] = "Modificateur",
    ["Only show disenchant info while this key is held down."] = "N'afficher les infos de désenchantement que lorsque cette touche est maintenue enfoncée.",
}
