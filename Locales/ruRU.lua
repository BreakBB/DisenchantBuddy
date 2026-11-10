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
    ["Settings are not available on this client."] = "Настройки недоступны на этом клиенте.",
}
