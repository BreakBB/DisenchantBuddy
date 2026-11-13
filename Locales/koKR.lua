---@class DisenchantBuddy
local DisenchantBuddy = select(2, ...)

if GetLocale() ~= "koKR" then
    return
end

DisenchantBuddy.L = {
    ["Disenchant results:"] = "마력 추출 결과:",
    ["Disenchanted from:"] = "다음에서 마력 추출:",
    ["Modifier"] = "수정 키",
    ["Only show disenchant info while this key is held down."] = "이 키를 누르고 있는 동안에만 마력 추출 정보를 표시합니다.",
    ["Settings are not available on this client."] = "이 클라이언트에서는 설정을 사용할 수 없습니다.",
}
