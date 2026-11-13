---@class DisenchantBuddy
local DisenchantBuddy = select(2, ...)

local L = DisenchantBuddy.L
local Colors = {
    STANDARD = "|cffffffff",
    GOOD = "|cff1eff00",
    RARE = "|cff0070dd",
    EPIC = "|cffa335ee",
}

---@class ItemLevelRange
---@field minItemLevel number
---@field maxItemLevel number

---Merges the sources of a material into one item level range per quality
---@param sources MaterialSource[]
---@return {uncommon: ItemLevelRange?, rare: ItemLevelRange?, epic: ItemLevelRange?}
local function mergeRangesByQuality(sources)
    local ranges = {}
    for _, source in ipairs(sources) do
        local range = ranges[source.quality]
        if (not range) then
            ranges[source.quality] = {minItemLevel = source.minItemLevel, maxItemLevel = source.maxItemLevel}
        else
            range.minItemLevel = math.min(range.minItemLevel, source.minItemLevel)
            range.maxItemLevel = math.max(range.maxItemLevel, source.maxItemLevel)
        end
    end
    return ranges
end

---Adds the item level ranges to an enchanting material's tooltip
---@param tooltip GameTooltip
---@param itemId number
function DisenchantBuddy.AddMaterialInfo(tooltip, itemId)
    local sources = DisenchantBuddy.GetMaterialSources(itemId)
    if (not sources) then
        return
    end

    tooltip:AddLine(L["Disenchanted from:"])
    local ranges = mergeRangesByQuality(sources)
    local uncommon = ranges.uncommon
    if (uncommon) then
        tooltip:AddDoubleLine(Colors.GOOD .. "  Item Level|r",
            uncommon.minItemLevel .. "-" .. uncommon.maxItemLevel)
    end
    local rare = ranges.rare
    if (rare) then
        tooltip:AddDoubleLine(Colors.RARE .. "  Item Level|r",
            rare.minItemLevel .. "-" .. rare.maxItemLevel)
    end
    local epic = ranges.epic
    if (epic) then
        tooltip:AddDoubleLine(Colors.EPIC .. "  Item Level|r",
            epic.minItemLevel .. "-" .. epic.maxItemLevel)
    end
    tooltip:Show()
end
