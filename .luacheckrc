---@diagnostic disable: lowercase-global
std = "lua51"
max_line_length = 160
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
ignore = {}
globals = {
    "Enum",
    "GameTooltip",
    "GetItemInfo",
    "GetItemQualityColor",
    "assert.spy",
    "assert.are_same",
    "assert.is_nil",
    "describe",
    "before_each",
    "it",
    "spy",
}
