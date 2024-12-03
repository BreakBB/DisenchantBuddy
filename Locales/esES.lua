---@type DisenchantBuddy
local _, DisenchantBuddy = ...

if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then
    return
end

DisenchantBuddy.L = {
    ["Disenchant results:"] = "Resultados de desencantar:",
}