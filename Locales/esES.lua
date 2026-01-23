---@class DisenchantBuddy
local DisenchantBuddy = select(2, ...)

if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then
    return
end

DisenchantBuddy.L = {
    ["Disenchant results:"] = "Resultados de desencantar:",
    ["Disenchanted from:"] = "Desencantado de:",
}
