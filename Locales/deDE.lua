---@class DisenchantBuddy
local DisenchantBuddy = select(2, ...)

if GetLocale() ~= "deDE" then
    return
end

DisenchantBuddy.L = {
    ["Disenchant results:"] = "Entzauberungsergebnisse:",
}
