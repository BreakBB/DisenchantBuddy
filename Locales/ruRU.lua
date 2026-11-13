---@class DisenchantBuddy
local DisenchantBuddy = select(2, ...)

if GetLocale() ~= "ruRU" then
    return
end

DisenchantBuddy.L = {
    ["Disenchant results:"] = "Результаты распыления:",
    ["Disenchanted from:"] = "Распылено из:",
    ["Modifier"] = "Модификатор",
    ["Only show disenchant info while this key is held down."] = "Показывать информацию о распылении только при зажатой клавише.",
    ["Materials"] = "Материалы",
    ["Dusts"] = "Пыль",
    ["Essences"] = "Сущности",
    ["Shards"] = "Осколки",
    ["Crystals"] = "Кристаллы",
    ["Item Level"] = "Уровень предмета",
    ["Exclude low-chance results"] = "Исключить результаты с низким шансом",
}
