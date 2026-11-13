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
    ["Materials"] = "材料",
    ["Dusts"] = "塵",
    ["Essences"] = "精華",
    ["Shards"] = "碎片",
    ["Crystals"] = "水晶",
    ["Item Level"] = "物品等級",
    ["Exclude low-chance results"] = "排除低機率結果",
}
