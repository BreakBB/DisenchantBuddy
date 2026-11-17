---@class DisenchantBuddy
local DisenchantBuddy = select(2, ...)

local GetItemInfo = C_Item.GetItemInfo or GetItemInfo

DisenchantBuddy.API = {
    v1 = {},
}
_G.DisenchantBuddy = DisenchantBuddy

---Returns the disenchant results of an item.
---@param callerName string The name of the addon calling this function
---@param item string|number An item link or item ID
---@return DisenchantResult[]|nil
function DisenchantBuddy.API.v1.GetDisenchantResults(callerName, item)
    if type(callerName) ~= "string" or callerName == "" then
        return nil
    end
    if type(item) ~= "string" and type(item) ~= "number" then
        return nil
    end

    local itemId = type(item) == "number" and item or tonumber(string.match(item, "item:(%d+)"))
    if itemId and DisenchantBuddy.NotDisenchantableItems and DisenchantBuddy.NotDisenchantableItems[itemId] then
        return nil
    end

    local _, _, quality, itemLevel, _, _, _, _, _, _, _, classId = GetItemInfo(item)
    if (not quality) or (classId ~= Enum.ItemClass.Armor and classId ~= Enum.ItemClass.Weapon) then
        return nil
    end

    return DisenchantBuddy.GetDisenchantResults(quality, classId, itemLevel)
end
