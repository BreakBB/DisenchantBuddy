---@diagnostic disable: lowercase-global
std = "lua51"
max_line_length = 140
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
    "GameTooltip",
    "assert.spy",
    "describe",
    "before_each",
    "it",
    "spy",
}
