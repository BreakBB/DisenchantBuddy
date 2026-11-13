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
    ["Shopping list"] = "購物清單",
    ["Create an Auctionator shopping list for all items that disenchant into this material."] = "建立一個Auctionator購物清單，包含所有可分解為此材料的物品。",
    ["Created Auctionator shopping list: %s"] = "已建立Auctionator購物清單：%s",
    ["No item sources left after excluding low-chance results."] = "排除低機率結果後沒有剩餘物品。",
}
