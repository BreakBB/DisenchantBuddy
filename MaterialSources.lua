---@class DisenchantBuddy
local DisenchantBuddy = select(2, ...)

local LOW_CHANCE_THRESHOLD = 10

---Builds the sources of each enchanting material by probing the disenchant result functions across all
---item levels. Consecutive item levels are merged into one source as long as the material keeps dropping
---and stays on the same side of the low chance threshold. Iteration stops once all probe functions return nil.
---@return table<ItemId, MaterialSource[]>
local function buildMaterialSources()
    local sources = {}
    local probes = {
        {fn = DisenchantBuddy.GetMaterialsForUncommonArmor, quality = "uncommon", itemClass = "armor"},
        {fn = DisenchantBuddy.GetMaterialsForUncommonWeapons, quality = "uncommon", itemClass = "weapon"},
        {fn = DisenchantBuddy.GetMaterialsForRareItem, quality = "rare"},
        {fn = DisenchantBuddy.GetMaterialsForEpicItem, quality = "epic"},
    }
    -- The source of each probe and material which was extended at the previous item level
    local openSources = {}
    for i = 1, #probes do
        openSources[i] = {}
    end

    for itemLevel = 1, math.huge do
        local anyResult = false
        for i, probe in ipairs(probes) do
            local results = probe.fn(itemLevel)
            local nextOpenSources = {}
            if results then
                anyResult = true
                local chances = {}
                local itemIds = {}
                for _, result in ipairs(results) do
                    local id = result.itemId
                    if id then
                        if (not chances[id]) then
                            table.insert(itemIds, id)
                        end
                        chances[id] = (chances[id] or 0) + result.probability
                    end
                end
                for _, id in ipairs(itemIds) do
                    local chance = chances[id]
                    local isLowChance = chance < LOW_CHANCE_THRESHOLD
                    local source = openSources[i][id]
                    if source and source.isLowChance == isLowChance then
                        source.maxItemLevel = itemLevel
                        source.minChance = math.min(source.minChance, chance)
                        source.maxChance = math.max(source.maxChance, chance)
                    else
                        source = {
                            quality = probe.quality,
                            itemClass = probe.itemClass,
                            minItemLevel = itemLevel,
                            maxItemLevel = itemLevel,
                            minChance = chance,
                            maxChance = chance,
                            isLowChance = isLowChance,
                        }
                        sources[id] = sources[id] or {}
                        table.insert(sources[id], source)
                    end
                    nextOpenSources[id] = source
                end
            end
            openSources[i] = nextOpenSources
        end
        if (not anyResult) then
            break
        end
    end

    local probeOrder = {}
    for i, probe in ipairs(probes) do
        probeOrder[probe.quality .. (probe.itemClass or "")] = i
    end
    for _, materialSources in pairs(sources) do
        table.sort(materialSources, function(a, b)
            local orderA = probeOrder[a.quality .. (a.itemClass or "")]
            local orderB = probeOrder[b.quality .. (b.itemClass or "")]
            if orderA ~= orderB then
                return orderA < orderB
            end
            return a.minItemLevel < b.minItemLevel
        end)
    end
    return sources
end

---@type table<ItemId, MaterialSource[]>
local materialSources = buildMaterialSources()

---@param itemId ItemId
---@return MaterialSource[]|nil
function DisenchantBuddy.GetMaterialSources(itemId)
    return materialSources[itemId]
end
