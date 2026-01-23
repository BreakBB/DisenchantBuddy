---@class DisenchantBuddy
local DisenchantBuddy = select(2, ...)

if GetLocale() ~= "koKR" then
    return
end

DisenchantBuddy.L = {
    ["Disenchant results:"] = "마력 추출 결과:",
}
