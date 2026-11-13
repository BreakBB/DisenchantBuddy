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
    ["Materials"] = "材料",
    ["Dusts"] = "尘",
    ["Essences"] = "精华",
    ["Shards"] = "碎片",
    ["Crystals"] = "水晶",
    ["Item Level"] = "物品等级",
    ["Exclude low-chance results"] = "排除低概率结果",
    ["Shopping list"] = "购物清单",
    ["Create an Auctionator shopping list for all items that disenchant into this material."] = "创建一个Auctionator购物清单，包含所有可分解为此材料的物品。",
    ["Created Auctionator shopping list: %s"] = "已创建Auctionator购物清单：%s",
    ["No item sources left after excluding low-chance results."] = "排除低概率结果后没有剩余物品。",
}
