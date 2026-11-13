---@class DisenchantBuddy
local DisenchantBuddy = select(2, ...)

if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then
    return
end

DisenchantBuddy.L = {
    ["Disenchant results:"] = "Resultados de desencantar:",
    ["Disenchanted from:"] = "Desencantado de:",
    ["Modifier"] = "Modificador",
    ["Only show disenchant info while this key is held down."] = "Mostrar la información de desencantamiento solo mientras se mantiene pulsada esta tecla.",
    ["Materials"] = "Materiales",
    ["Dusts"] = "Polvos",
    ["Essences"] = "Esencias",
    ["Shards"] = "Fragmentos",
    ["Crystals"] = "Cristales",
    ["Item Level"] = "Nivel de objeto",
    ["Exclude low-chance results"] = "Excluir resultados de baja probabilidad",
}
