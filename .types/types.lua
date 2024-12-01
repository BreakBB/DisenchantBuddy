---@meta

---@alias ItemId number

---@class DisenchantResult
---@field itemId ItemId
---@field probability number @Probability of getting this item (0-100)

---@param callerId string
---@param itemID ItemId
---@return number @The price of the item in copper
function Auctionator.API.v1.GetAuctionPriceByItemID(callerId, itemID) end