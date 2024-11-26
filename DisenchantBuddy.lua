local DisenchantBuddy = {}

---@param itemLevel number
---@return table<string>|nil Disenchant results
local function GetUncommonDisenchantResults(itemLevel)
    if itemLevel <= 15 then
        return {"Strange Dust","Lesser Magic Essence"}
    elseif itemLevel <= 20 then
        return {"Strange Dust","Greater Magic Essence"}
    elseif itemLevel <= 25 then
        return {"Strange Dust","Lesser Astral Essence","Small Glimmering Shard"}
    elseif itemLevel <= 30 then
        return {"Soul Dust","Greater Astral Essence","Large Glimmering Shard"}
    elseif itemLevel <= 35 then
        return {"Soul Dust","Lesser Mystic Essence","Small Glowing Shard"}
    elseif itemLevel <= 40 then
        return {"Vision Dust","Greater Mystic Essence","Large Glowing Shard"}
    elseif itemLevel <= 45 then
        return {"Vision Dust","Lesser Nether Essence","Small Radiant Shard"}
    elseif itemLevel <= 50 then
        return {"Dream Dust","Greater Nether Essence","Large Radiant Shard"}
    elseif itemLevel <= 55 then
        return {"Dream Dust","Lesser Eternal Essence","Small Brilliant Shard"}
    elseif itemLevel <= 60 then
        return {"Illusion Dust","Greater Eternal Essence","Large Brilliant Shard"}
    elseif itemLevel <= 65 then
        return {"Illusion Dust","Greater Eternal Essence","Large Brilliant Shard"}
    else
        return nil
    end
end

---@param itemLevel number
---@return table<string>|nil Disenchant results
local function GetRareDisenchantResults(itemLevel)
    if itemLevel <= 25 then
        return {"Small Glimmering Shard"}
    elseif itemLevel <= 30 then
        return {"Large Glimmering Shard"}
    elseif itemLevel <= 35 then
        return {"Small Glowing Shard"}
    elseif itemLevel <= 40 then
        return {"Large Glowing Shard"}
    elseif itemLevel <= 45 then
        return {"Small Radiant Shard"}
    elseif itemLevel <= 50 then
        return {"Large Radiant Shard"}
    elseif itemLevel <= 55 then
        return {"Small Brilliant Shard"}
    elseif itemLevel <= 65 then
        return {"Large Brilliant Shard","Nexus Crystal"}
    else
        return nil
    end
end

---@param itemLevel number
---@return table<string>|nil Disenchant results
local function GetEpicDisenchantResults(itemLevel)
    if itemLevel <= 45 then
        return {"Small Radiant Shard"}
    elseif itemLevel <= 50 then
        return {"Large Radiant Shard"}
    elseif itemLevel <= 55 then
        return {"Small Brilliant Shard"}
    elseif itemLevel <= 65 then
        return {"Nexus Crystal"}
    else
        return nil
    end
end

---@param tooltip GameTooltip
---@param itemLink string
---@return boolean True if tooltip was added, false otherwise
local function AddDisenchantInfo(tooltip, itemLink)
    local _, _, quality, itemLevel, _, _, _, _, _, _, _, classId = GetItemInfo(itemLink)

    if quality == Enum.ItemQuality.Poor or
            quality == Enum.ItemQuality.Standard or
            quality == Enum.ItemQuality.Legendary or
            (classId ~= Enum.ItemClass.Armor and classId ~= Enum.ItemClass.Weapon) then
        return false
    end

    local disenchantResults
    if quality == Enum.ItemQuality.Good then
        disenchantResults = GetUncommonDisenchantResults(itemLevel)
    elseif quality == Enum.ItemQuality.Rare then
        disenchantResults = GetRareDisenchantResults(itemLevel)
    elseif quality == Enum.ItemQuality.Epic then
        disenchantResults = GetEpicDisenchantResults(itemLevel)
    end

    if (not disenchantResults) then
        -- No disenchant results for this item, e.g. itemLevel too high
        return false
    end

    tooltip:AddLine("Disenchant results:")
    for _, result in ipairs(disenchantResults) do
        tooltip:AddLine(result, 1, 1, 1) -- White text
    end

    return true
end

---@param tooltip GameTooltip
function DisenchantBuddy.OnTooltipSetItem(tooltip)
    local _, link = tooltip:GetItem()

    local tooltipAdded = AddDisenchantInfo(tooltip, link)

    if tooltipAdded then
        tooltip:Show()
    end
end

GameTooltip:HookScript("OnTooltipSetItem", DisenchantBuddy.OnTooltipSetItem)

return DisenchantBuddy
