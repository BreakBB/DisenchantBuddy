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
    ["Settings are not available on this client."] = "Les options ne sont pas disponibles sur ce client.",
}
