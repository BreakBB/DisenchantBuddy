---@class DisenchantBuddy
local DisenchantBuddy = select(2, ...)

if GetLocale() ~= "zhCN" then
    return
end

DisenchantBuddy.L = {
    ["Disenchant results:"] = "分解结果：",
    ["Disenchanted from:"] = "分解自：",
    ["Modifier"] = "修改键",
    ["Only show disenchant info while this key is held down."] = "仅在按住此键时显示分解信息。",
    ["Settings are not available on this client."] = "此客户端不支持设置。",
}
