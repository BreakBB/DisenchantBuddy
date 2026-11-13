---@class DisenchantBuddy
local DisenchantBuddy = select(2, ...)

local L = DisenchantBuddy.L

local GROUP_ORDER = {"DUST", "ESSENCE", "SHARD", "CRYSTAL"}
local GROUP_LABELS = {DUST = "Dusts", ESSENCE = "Essences", SHARD = "Shards", CRYSTAL = "Crystals"}
local QUALITY_COLORS = {uncommon = "|cff1eff00", rare = "|cff0070dd", epic = "|cffa335ee"}
local QUALITY_LABEL_GLOBALS = {uncommon = "ITEM_QUALITY2_DESC", rare = "ITEM_QUALITY3_DESC", epic = "ITEM_QUALITY4_DESC"}
local ITEM_CLASS_IDS = {armor = 4, weapon = 2}

local ICON_SIZE = 24
local LINE_HEIGHT = 16
local ROW_SPACING = 8
local SOURCE_COLUMN = 165
local COLUMN_PADDING = 16
local MIN_SHOPPING_LIST_BUTTON_WIDTH = 90
local SHOPPING_LIST_BUTTON_TEXT_PADDING = 24

function DisenchantBuddy.IsLowChanceExcluded()
    return (not DisenchantBuddy_Profile) or DisenchantBuddy_Profile.ExcludeLowChance ~= false
end

---@param value boolean
function DisenchantBuddy.SetLowChanceExcluded(value)
    DisenchantBuddy_Profile = DisenchantBuddy_Profile or {}
    DisenchantBuddy_Profile.ExcludeLowChance = value
end

---@param sources MaterialSource[]
---@return number
local function getLowestItemLevel(sources)
    local lowest = math.huge
    for _, source in ipairs(sources) do
        lowest = math.min(lowest, source.minItemLevel)
    end
    return lowest
end

---Groups all materials with known sources by their type (dust, essence, ...), sorted by their lowest item level
---@return {key: string, itemIds: ItemId[]}[]
function DisenchantBuddy.GetMaterialGroups()
    local itemIdsByGroup = {}
    for name, itemId in pairs(DisenchantBuddy.Materials) do
        local key = name:match("_(%u+)$")
        if DisenchantBuddy.GetMaterialSources(itemId) and GROUP_LABELS[key] then
            itemIdsByGroup[key] = itemIdsByGroup[key] or {}
            table.insert(itemIdsByGroup[key], itemId)
        end
    end

    local groups = {}
    for _, key in ipairs(GROUP_ORDER) do
        local itemIds = itemIdsByGroup[key]
        if itemIds then
            table.sort(itemIds, function(a, b)
                local levelA = getLowestItemLevel(DisenchantBuddy.GetMaterialSources(a))
                local levelB = getLowestItemLevel(DisenchantBuddy.GetMaterialSources(b))
                if levelA ~= levelB then
                    return levelA < levelB
                end
                return a < b
            end)
            table.insert(groups, {key = key, itemIds = itemIds})
        end
    end
    return groups
end

---Calculates the left offset of each column, so that every column starts after the widest text of the previous one
---@param startX number
---@param widths number[] widest text of each column
---@param padding number
---@return number[]
function DisenchantBuddy.GetColumnOffsets(startX, widths, padding)
    local offsets = {}
    local x = startX
    for i, width in ipairs(widths) do
        offsets[i] = x
        x = x + width + padding
    end
    return offsets
end

---@param min number
---@param max number
---@return string
local function formatRange(min, max)
    if min == max then
        return tostring(min)
    end
    return min .. "-" .. max
end

---@param source MaterialSource
---@return string
local function getSourceLabel(source)
    local label = QUALITY_COLORS[source.quality] .. _G[QUALITY_LABEL_GLOBALS[source.quality]] .. "|r"
    if source.itemClass then
        local GetItemClassInfo = C_Item.GetItemClassInfo or GetItemClassInfo
        label = label .. " " .. GetItemClassInfo(ITEM_CLASS_IDS[source.itemClass])
    end
    return label
end

---@param parent Frame
---@param itemId ItemId
---@param y number
---@param lowChanceLines FontString[]
---@param columns FontString[][] the texts of each column, to be positioned after all rows exist
---@param buttons Button[]
---@return number height of the row
local function createMaterialRow(parent, itemId, y, lowChanceLines, columns, buttons)
    local icon = CreateFrame("Button", nil, parent)
    icon:SetSize(ICON_SIZE, ICON_SIZE)
    icon:SetPoint("TOPLEFT", 0, y)
    icon:SetNormalTexture((C_Item.GetItemIconByID or GetItemIcon)(itemId))
    icon:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetHyperlink("item:" .. itemId)
        GameTooltip:Show()
    end)
    icon:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
    icon:SetScript("OnClick", function()
        local _, link = (C_Item.GetItemInfo or GetItemInfo)(itemId)
        if link then
            HandleModifiedItemClick(link)
        end
    end)

    local name = parent:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    name:SetPoint("LEFT", icon, "RIGHT", 8, 0)
    name:SetWidth(SOURCE_COLUMN - ICON_SIZE - 16)
    name:SetJustifyH("LEFT")
    name:SetText(tostring(itemId))
    local item = Item:CreateFromItemID(itemId)
    item:ContinueOnItemLoad(function()
        name:SetText(item:GetItemName())
        local color = ITEM_QUALITY_COLORS[item:GetItemQuality()]
        if color then
            name:SetTextColor(color.r, color.g, color.b)
        end
    end)

    if DisenchantBuddy.IsAuctionatorAvailable() then
        local shoppingListButton = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
        shoppingListButton:SetHeight(22)
        shoppingListButton:SetPoint("TOPRIGHT", 0, y)
        shoppingListButton:SetText(L["Shopping list"])
        shoppingListButton:SetScript("OnClick", function()
            DisenchantBuddy.CreateShoppingList(itemId)
        end)
        shoppingListButton:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(L["Create an Auctionator shopping list for all items that disenchant into this material."], nil, nil, nil, nil, true)
            GameTooltip:Show()
        end)
        shoppingListButton:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)
        table.insert(buttons, shoppingListButton)
    end

    local sources = DisenchantBuddy.GetMaterialSources(itemId)
    for i, source in ipairs(sources) do
        local lineY = y - (i - 1) * LINE_HEIGHT
        local texts = {
            getSourceLabel(source),
            L["Item Level"] .. " " .. formatRange(source.minItemLevel, source.maxItemLevel),
            formatRange(source.minChance, source.maxChance) .. "%",
        }
        for columnIndex, value in ipairs(texts) do
            local text = parent:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
            text:SetPoint("TOPLEFT", SOURCE_COLUMN, lineY)
            text:SetText(value)
            text.lineY = lineY
            columns[columnIndex] = columns[columnIndex] or {}
            table.insert(columns[columnIndex], text)
            if source.isLowChance then
                table.insert(lowChanceLines, text)
            end
        end
    end

    return math.max(ICON_SIZE, #sources * LINE_HEIGHT) + ROW_SPACING
end

---Positions the columns by the widest text of each column, as translated texts differ a lot in their length
---@param columns FontString[][]
local function positionColumns(columns)
    local widths = {}
    for i, texts in ipairs(columns) do
        widths[i] = 0
        for _, text in ipairs(texts) do
            widths[i] = math.max(widths[i], text:GetStringWidth())
        end
    end
    local offsets = DisenchantBuddy.GetColumnOffsets(SOURCE_COLUMN, widths, COLUMN_PADDING)
    for i, texts in ipairs(columns) do
        for _, text in ipairs(texts) do
            text:ClearAllPoints()
            text:SetPoint("TOPLEFT", offsets[i], text.lineY)
        end
    end
end

---Sizes all buttons to fit the translated text
---@param buttons Button[]
local function sizeButtons(buttons)
    for _, button in ipairs(buttons) do
        button:SetWidth(math.max(MIN_SHOPPING_LIST_BUTTON_WIDTH, button:GetFontString():GetStringWidth() + SHOPPING_LIST_BUTTON_TEXT_PADDING))
    end
end

---@param frame Frame
local function buildOverview(frame)
    local title = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText(L["Materials"])

    local lowChanceLines = {}
    local function refreshLowChanceLines()
        local alpha = DisenchantBuddy.IsLowChanceExcluded() and 0.4 or 1
        for _, line in ipairs(lowChanceLines) do
            line:SetAlpha(alpha)
        end
    end

    local checkboxLabel = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    checkboxLabel:SetPoint("TOPRIGHT", -16, -18)
    checkboxLabel:SetText(L["Exclude low-chance results"])

    local checkbox = CreateFrame("CheckButton", nil, frame, "UICheckButtonTemplate")
    checkbox:SetPoint("RIGHT", checkboxLabel, "LEFT", -4, 0)
    checkbox:SetChecked(DisenchantBuddy.IsLowChanceExcluded())
    checkbox:SetScript("OnClick", function(self)
        DisenchantBuddy.SetLowChanceExcluded(self:GetChecked() and true or false)
        refreshLowChanceLines()
    end)

    local scrollFrame = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 16, -50)
    scrollFrame:SetPoint("BOTTOMRIGHT", -32, 16)
    local content = CreateFrame("Frame", nil, scrollFrame)
    scrollFrame:SetScrollChild(content)

    local columns = {}
    local buttons = {}
    local y = 0
    for _, group in ipairs(DisenchantBuddy.GetMaterialGroups()) do
        local header = content:CreateFontString(nil, "ARTWORK", "GameFontNormal")
        header:SetPoint("TOPLEFT", 0, y)
        header:SetText(L[GROUP_LABELS[group.key]])
        y = y - LINE_HEIGHT - 4
        for _, itemId in ipairs(group.itemIds) do
            y = y - createMaterialRow(content, itemId, y, lowChanceLines, columns, buttons)
        end
        y = y - ROW_SPACING
    end
    content:SetHeight(-y)
    positionColumns(columns)
    sizeButtons(buttons)
    -- Keeps the right aligned shopping list buttons inside the visible area
    scrollFrame:HookScript("OnSizeChanged", function(_, width)
        content:SetWidth(width)
    end)
    content:SetWidth(scrollFrame:GetWidth())

    refreshLowChanceLines()
end

---Creates the canvas frame for the materials overview. Its content is built on first show.
---@return Frame
function DisenchantBuddy.CreateMaterialsOverviewFrame()
    local frame = CreateFrame("Frame")
    frame:Hide()
    local built = false
    frame:SetScript("OnShow", function(self)
        if (not built) then
            built = true
            buildOverview(self)
        end
    end)
    return frame
end
