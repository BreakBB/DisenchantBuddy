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
    ["Materials"] = "재료",
    ["Dusts"] = "가루",
    ["Essences"] = "정수",
    ["Shards"] = "조각",
    ["Crystals"] = "수정",
    ["Item Level"] = "아이템 레벨",
    ["Exclude low-chance results"] = "확률이 낮은 결과 제외",
    ["Shopping list"] = "구매 목록",
    ["Create an Auctionator shopping list for all items that disenchant into this material."] = "이 재료로 마력 추출되는 모든 아이템으로 Auctionator 구매 목록을 만듭니다.",
    ["Created Auctionator shopping list: %s"] = "Auctionator 구매 목록 생성됨: %s",
    ["No item sources left after excluding low-chance results."] = "확률이 낮은 결과를 제외하면 남는 아이템이 없습니다.",
}
