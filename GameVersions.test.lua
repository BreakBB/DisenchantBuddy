describe("GameVersions", function()
    ---@type DisenchantBuddy
    local DisenchantBuddy

    before_each(function()
        _G.WOW_PROJECT_CLASSIC = 2
        _G.WOW_PROJECT_MAINLINE = 1
        _G.WOW_PROJECT_BURNING_CRUSADE_CLASSIC = 5
        _G.WOW_PROJECT_WRATH_CLASSIC = 11
        _G.WOW_PROJECT_CATACLYSM_CLASSIC = 14
        _G.WOW_PROJECT_MISTS_CLASSIC = 19
        _G.C_Seasons = {
            HasActiveSeason = function() return false end,
            GetActiveSeason = function() return nil end,
        }
        _G.Enum = {SeasonID = {SeasonOfDiscovery = 1}}

        DisenchantBuddy = {}
    end)

    local function load(wowProjectId, tocVersion)
        _G.WOW_PROJECT_ID = wowProjectId
        _G.GetBuildInfo = function()
            return "1.0.0", "00000", "Jan 1 2020", tocVersion
        end
        loadfile("GameVersions.lua")("DisenchantBuddy", DisenchantBuddy)
    end

    it("should set IsForever when reporting mainline with a low TOC version", function()
        load(_G.WOW_PROJECT_MAINLINE, 16001)

        assert.is_true(DisenchantBuddy.IsForever)
        assert.is_false(DisenchantBuddy.IsClassic)
    end)

    it("should not set IsForever when reporting mainline with a real retail TOC version", function()
        load(_G.WOW_PROJECT_MAINLINE, 120005)

        assert.is_false(DisenchantBuddy.IsForever)
    end)

    it("should set IsForever from the build version alone, regardless of project id", function()
        load(nil, 16001)

        assert.is_true(DisenchantBuddy.IsForever)
    end)

    it("should not set IsForever just below the reserved range (mainline)", function()
        load(_G.WOW_PROJECT_MAINLINE, 15999)

        assert.is_false(DisenchantBuddy.IsForever)
    end)

    it("should not set IsForever just above the reserved range (mainline)", function()
        load(_G.WOW_PROJECT_MAINLINE, 20000)

        assert.is_false(DisenchantBuddy.IsForever)
    end)

    it("should not set IsForever for Classic Era", function()
        load(_G.WOW_PROJECT_CLASSIC, 11509)

        assert.is_false(DisenchantBuddy.IsForever)
        assert.is_true(DisenchantBuddy.IsClassic)
    end)

    it("should not set IsForever for TBC Classic", function()
        load(_G.WOW_PROJECT_BURNING_CRUSADE_CLASSIC, 20506)

        assert.is_false(DisenchantBuddy.IsForever)
    end)
end)
