---@diagnostic disable: lowercase-global
std = "lua51"
max_line_length = 180
exclude_files = {
    ".github/",
    ".history/",
    ".idea/",
    ".types/",
    ".vscode/",
    "releases/",
    ".luacheckrc",
    "**/.luarocks/**/", -- Created by the GitHub Action
    "**/.install/**/",  -- Created by the GitHub Action
}
ignore = {
    "631", -- Line is too long.
}
globals = {
    "Auctionator",
    "CreateFrame",
    "Enum",
    "GameTooltip",
    "GetCoinTextureString",
    "GetItemInfo",
    "GetItemQualityColor",
    "GetLocale",
    "HIGHLIGHT_FONT_COLOR_CODE",
    "Item",
    "ItemRefTooltip",
    "ITEM_DISENCHANT_NOT_DISENCHANTABLE",
    "WOW_PROJECT_ID",
    "WOW_PROJECT_BURNING_CRUSADE_CLASSIC",
    "WOW_PROJECT_WRATH_CLASSIC",
    "WOW_PROJECT_CATACLYSM_CLASSIC",
    "assert.spy",
    "assert.are_same",
    "assert.is_nil",
    "describe",
    "before_each",
    "it",
    "spy",
}
