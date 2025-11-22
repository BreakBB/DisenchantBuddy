---@type DisenchantBuddy
local _, DisenchantBuddy = ...

--- Addon is running on Classic TBC client
DisenchantBuddy.IsTBC = math.floor(select(4, GetBuildInfo()) / 10000) == 2

--- Addon is running on Classic "Vanilla" client: Means Classic Era and its seasons like SoM
---@type boolean
DisenchantBuddy.IsClassic = (not DisenchantBuddy.IsTBC) and WOW_PROJECT_ID == WOW_PROJECT_CLASSIC

--- Addon is running on Classic WotLK client
DisenchantBuddy.IsWotLK = WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC

--- Addon is running on Classic Cata client
DisenchantBuddy.IsCata = WOW_PROJECT_ID == WOW_PROJECT_CATACLYSM_CLASSIC

--- Addon is running on Classic MoP client
---@type boolean
DisenchantBuddy.IsMoP = WOW_PROJECT_ID == WOW_PROJECT_MISTS_CLASSIC

--- Addon is running on Classic "Vanilla" client and on Season of Discovery realm specifically
---@type boolean
DisenchantBuddy.IsSoD = DisenchantBuddy.IsClassic and C_Seasons.HasActiveSeason() and (C_Seasons.GetActiveSeason() == Enum.SeasonID.SeasonOfDiscovery)
