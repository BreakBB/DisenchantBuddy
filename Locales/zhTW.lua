---@class DisenchantBuddy
local DisenchantBuddy = select(2, ...)

if GetLocale() ~= "zhTW" then
    return
end

DisenchantBuddy.L = {
    ["Disenchant results:"] = "分解結果：",
}
