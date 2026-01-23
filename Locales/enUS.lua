---@class DisenchantBuddy
local DisenchantBuddy = select(2, ...)

if GetLocale() ~= "enUS" then
    return
end

DisenchantBuddy.L = {
    ["Disenchant results:"] = "Disenchant results:",
}