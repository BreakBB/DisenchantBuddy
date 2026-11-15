---@class DisenchantBuddy
local DisenchantBuddy = select(2, ...)

if GetLocale() ~= "deDE" then
    return
end

DisenchantBuddy.L = {
    ["Disenchant results:"] = "Entzauberungsergebnisse:",
    ["Disenchanted from:"] = "Entzaubert von:",
    ["Modifier"] = "Modifikatortaste",
    ["Only show disenchant info while this key is held down."] = "Disenchant-Infos nur anzeigen, solange diese Taste gedrückt wird.",
    ["Materials"] = "Materialien",
    ["Dusts"] = "Staub",
    ["Essences"] = "Essenzen",
    ["Shards"] = "Splitter",
    ["Crystals"] = "Kristalle",
    ["Item Level"] = "Gegenstandsstufe",
    ["Exclude low-chance results"] = "Ergebnisse mit geringer Chance ausschließen",
    ["Shopping list"] = "Einkaufsliste",
    ["Create an Auctionator shopping list for all items that disenchant into this material."] = "Eine Auctionator-Einkaufsliste mit allen Gegenständen erstellen, die zu diesem Material entzaubert werden.",
    ["Created Auctionator shopping list: %s"] = "Auctionator-Einkaufsliste erstellt: %s",
    ["No item sources left after excluding low-chance results."] = "Nach dem Ausschließen von Ergebnissen mit geringer Chance bleiben keine Gegenstände übrig.",
    ["Show prices per material"] = "Preise pro Material anzeigen",
    ["Show the Auctionator price of each material in the tooltip."] = "Zeigt den Auctionator-Preis jedes Materials im Tooltip an.",
    ["Show average price"] = "Durchschnittspreis anzeigen",
    ["Show the average disenchant value based on Auctionator prices in the tooltip."] = "Zeigt den durchschnittlichen Entzauberungswert basierend auf Auctionator-Preisen im Tooltip an.",
}
