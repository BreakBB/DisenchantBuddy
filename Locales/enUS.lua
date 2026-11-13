---@class DisenchantBuddy
local DisenchantBuddy = select(2, ...)

if GetLocale() ~= "enUS" then
    return
end

DisenchantBuddy.L = {
    ["Disenchant results:"] = "Disenchant results:",
    ["Disenchanted from:"] = "Disenchanted from:",
    ["Modifier"] = "Modifier",
    ["Only show disenchant info while this key is held down."] = "Only show disenchant info while this key is held down.",
    ["Materials"] = "Materials",
    ["Dusts"] = "Dusts",
    ["Essences"] = "Essences",
    ["Shards"] = "Shards",
    ["Crystals"] = "Crystals",
    ["Item Level"] = "Item Level",
    ["Exclude low-chance results"] = "Exclude low-chance results",
    ["Shopping list"] = "Shopping list",
    ["Create an Auctionator shopping list for all items that disenchant into this material."] = "Create an Auctionator shopping list for all items that disenchant into this material.",
    ["Created Auctionator shopping list: %s"] = "Created Auctionator shopping list: %s",
    ["No item sources left after excluding low-chance results."] = "No item sources left after excluding low-chance results.",
}
