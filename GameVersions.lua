---@type DisenchantBuddy
local _, DisenchantBuddy = ...

--- Addon is running on Classic TBC client
DisenchantBuddy.IsTBC = WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC

--- Addon is running on Classic WotLK client
DisenchantBuddy.IsWotLK = WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC

--- Addon is running on Classic Cata client
DisenchantBuddy.IsCata = WOW_PROJECT_ID == WOW_PROJECT_CATACLYSM_CLASSIC