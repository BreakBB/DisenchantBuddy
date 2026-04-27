---@class DisenchantBuddy
local DisenchantBuddy = select(2, ...)

if GetLocale() ~= "ptBR" then
    return
end

DisenchantBuddy.L = {
    ["Disenchant results:"] = "Resultados de desencantar:",
    ["Disenchanted from:"] = "Desencantado de:",
    ["Modifier is now: %s"] = "Modificador agora: %s",
    ["Syntax:"] = "Sintaxe:",
}
