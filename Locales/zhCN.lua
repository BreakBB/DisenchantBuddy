---@class DisenchantBuddy
local DisenchantBuddy = select(2, ...)

if GetLocale() ~= "zhCN" then
    return
end

DisenchantBuddy.L = {
    ["Disenchant results:"] = "分解结果：",
    ["Disenchanted from:"] = "分解自：",
    ["Modifier is now: %s"] = "修改键现在为：%s",
    ["Syntax:"] = "用法：",
}
