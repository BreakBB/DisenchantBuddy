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
    ["Settings are not available on this client."] = "Los ajustes no están disponibles en este cliente.",
}
