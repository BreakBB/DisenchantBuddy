---@class DisenchantBuddy
local DisenchantBuddy = select(2, ...)

local L = DisenchantBuddy.L

local CALLER_ID = "DisenchantBuddy"
local QUALITIES = {uncommon = 2, rare = 3, epic = 4}
local ITEM_CLASS_IDS = {armor = 4, weapon = 2}

---@return boolean
function DisenchantBuddy.IsAuctionatorAvailable()
    return Auctionator ~= nil and Auctionator.API ~= nil and Auctionator.API.v1 ~= nil
        and Auctionator.API.v1.CreateShoppingList ~= nil
end

---@param itemId ItemId
---@param excludeLowChance boolean
---@return table[] Auctionator search terms
function DisenchantBuddy.GetShoppingListSearchTerms(itemId, excludeLowChance)
    local GetItemClassInfo = C_Item.GetItemClassInfo or GetItemClassInfo
    local terms = {}
    for _, source in ipairs(DisenchantBuddy.GetMaterialSources(itemId) or {}) do
        if (not (excludeLowChance and source.isLowChance)) then
            table.insert(terms, {
                searchString = "",
                -- Auctionator resolves item class names via its legacy category lookup, which is localized on every client
                categoryKey = source.itemClass and GetItemClassInfo(ITEM_CLASS_IDS[source.itemClass]) or "",
                minItemLevel = source.minItemLevel,
                maxItemLevel = source.maxItemLevel,
                quality = QUALITIES[source.quality],
            })
        end
    end
    return terms
end

---Creates an Auctionator shopping list with all items which can be disenchanted into the given material
---@param itemId ItemId
function DisenchantBuddy.CreateShoppingList(itemId)
    local terms = DisenchantBuddy.GetShoppingListSearchTerms(itemId, DisenchantBuddy.IsLowChanceExcluded())
    if #terms == 0 then
        print(L["No item sources left after excluding low-chance results."])
        return
    end

    local searchStrings = {}
    for _, term in ipairs(terms) do
        table.insert(searchStrings, Auctionator.API.v1.ConvertToSearchString(CALLER_ID, term))
    end

    local itemName = (C_Item.GetItemInfo or GetItemInfo)(itemId) or tostring(itemId)
    local listName = "DE: " .. itemName
    Auctionator.API.v1.CreateShoppingList(CALLER_ID, listName, searchStrings)
    print(string.format(L["Created Auctionator shopping list: %s"], listName))
end
