---@class DisenchantBuddy
local DisenchantBuddy = select(2, ...)

if GetLocale() ~= "frFR" then
    return
end

DisenchantBuddy.L = {
    ["Disenchant results:"] = "Résultats de désenchantement :",
    ["Disenchanted from:"] = "Désenchanté de :",
    ["Modifier"] = "Modificateur",
    ["Only show disenchant info while this key is held down."] = "N'afficher les infos de désenchantement que lorsque cette touche est maintenue enfoncée.",
    ["Materials"] = "Matériaux",
    ["Dusts"] = "Poussières",
    ["Essences"] = "Essences",
    ["Shards"] = "Éclats",
    ["Crystals"] = "Cristaux",
    ["Item Level"] = "Niveau d'objet",
    ["Exclude low-chance results"] = "Exclure les résultats à faible probabilité",
    ["Shopping list"] = "Liste d'achats",
    ["Create an Auctionator shopping list for all items that disenchant into this material."] = "Créer une liste d'achats Auctionator avec tous les objets qui se désenchantent en ce matériau.",
    ["Created Auctionator shopping list: %s"] = "Liste d'achats Auctionator créée : %s",
    ["No item sources left after excluding low-chance results."] = "Aucun objet restant après l'exclusion des résultats à faible probabilité.",
    ["Show prices per material"] = "Afficher les prix par matériau",
    ["Show the Auctionator price of each material in the tooltip."] = "Affiche le prix Auctionator de chaque matériau dans l'infobulle.",
    ["Show average price"] = "Afficher le prix moyen",
    ["Show the average disenchant value based on Auctionator prices in the tooltip."] = "Affiche la valeur moyenne de désenchantement basée sur les prix Auctionator dans l'infobulle.",
}
