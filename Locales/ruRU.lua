---@class DisenchantBuddy
local DisenchantBuddy = select(2, ...)

if GetLocale() ~= "ruRU" then
    return
end

DisenchantBuddy.L = {
    ["Disenchant results:"] = "Результаты распыления:",
    ["Disenchanted from:"] = "Распылено из:",
}
