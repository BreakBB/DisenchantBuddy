---@meta

---@alias ItemId number

---@class DisenchantResult
---@field itemId ItemId
---@field probability number @Probability of getting this item (0-100)
---@field minQuantity number @Minimum quantity of this item obtained
---@field maxQuantity number @Maximum quantity of this item obtained

---@class MaterialSource
---@field quality "uncommon"|"rare"|"epic"
---@field itemClass "armor"|"weapon"|nil @Only set for uncommon items
---@field minItemLevel number
---@field maxItemLevel number
---@field minChance number @Lowest probability within the item level range (0-100)
---@field maxChance number @Highest probability within the item level range (0-100)
---@field isLowChance boolean @Whether the chance is below the low chance threshold

---@param callerId string
---@param itemID ItemId
---@return number @The price of the item in copper
function Auctionator.API.v1.GetAuctionPriceByItemID(callerId, itemID) end

---@param callerId string
---@param term table @Auctionator.Search.SearchTerm
---@return string
function Auctionator.API.v1.ConvertToSearchString(callerId, term) end

---@param callerId string
---@param name string
---@param searchStrings string[]
function Auctionator.API.v1.CreateShoppingList(callerId, name, searchStrings) end
