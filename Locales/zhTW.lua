---@class DisenchantBuddy
local DisenchantBuddy = select(2, ...)

if GetLocale() ~= "zhTW" then
    return
end

DisenchantBuddy.L = {
    ["Disenchant results:"] = "分解結果：",
    ["Disenchanted from:"] = "分解自：",
    ["Modifier"] = "修改鍵",
    ["Only show disenchant info while this key is held down."] = "僅在按住此鍵時顯示分解資訊。",
    ["Settings are not available on this client."] = "此客戶端不支援設定。",
}
