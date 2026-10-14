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
    "C_CurrencyInfo",
    "C_Item",
    "C_Seasons",
    "Enum",
    "GameTooltip",
    "GetBuildInfo",
    "GetCoinTextureString",
    "GetItemInfo",
    "GetItemQualityColor",
    "GetLocale",
    "HIGHLIGHT_FONT_COLOR_CODE",
    "Item",
    "ItemRefTooltip",
    "ITEM_DISENCHANT_NOT_DISENCHANTABLE",
    "TooltipDataProcessor",
    "WOW_PROJECT_ID",
    "WOW_PROJECT_MAINLINE",
    "WOW_PROJECT_CLASSIC",
    "WOW_PROJECT_BURNING_CRUSADE_CLASSIC",
    "WOW_PROJECT_WRATH_CLASSIC",
    "WOW_PROJECT_CATACLYSM_CLASSIC",
    "WOW_PROJECT_MISTS_CLASSIC",
    "assert.spy",
    "assert.are_same",
    "assert.is_nil",
    "assert.is_true",
    "assert.is_false",
    "describe",
    "before_each",
    "it",
    "spy",
    "DisenchantBuddy_Profile",
    "SLASH_DisenchantBuddy1",
    "SLASH_DisenchantBuddy2",
    "IsShiftKeyDown",
    "IsAltKeyDown",
    "IsControlKeyDown",
	"SlashCmdList",
}
