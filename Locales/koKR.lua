---@class DisenchantBuddy
local DisenchantBuddy = select(2, ...)

if GetLocale() ~= "koKR" then
    return
end

DisenchantBuddy.L = {
    ["Disenchant results:"] = "마력 추출 결과:",
    ["Disenchanted from:"] = "다음에서 마력 추출:",
    ["Modifier is now: %s"] = "수정 키가 다음으로 설정되었습니다: %s",
    ["Syntax:"] = "구문:",
}
