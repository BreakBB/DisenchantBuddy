---@class DisenchantBuddy
local DisenchantBuddy = select(2, ...)

if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then
    return
end

DisenchantBuddy.L = {
    ["Disenchant results:"] = "Resultados de desencantar:",
    ["Disenchanted from:"] = "Desencantado de:",
    ["Modifier"] = "Modificador",
    ["Only show disenchant info while this key is held down."] = "Mostrar la información de desencantamiento solo mientras se mantiene pulsada esta tecla.",
    ["Materials"] = "Materiales",
    ["Dusts"] = "Polvos",
    ["Essences"] = "Esencias",
    ["Shards"] = "Fragmentos",
    ["Crystals"] = "Cristales",
    ["Item Level"] = "Nivel de objeto",
    ["Exclude low-chance results"] = "Excluir resultados de baja probabilidad",
    ["Shopping list"] = "Lista de compras",
    ["Create an Auctionator shopping list for all items that disenchant into this material."] = "Crea una lista de compras de Auctionator con todos los objetos que se desencantan en este material.",
    ["Created Auctionator shopping list: %s"] = "Lista de compras de Auctionator creada: %s",
    ["No item sources left after excluding low-chance results."] = "No quedan objetos tras excluir los resultados de baja probabilidad.",
    ["Show prices per material"] = "Mostrar precios por material",
    ["Show the Auctionator price of each material in the tooltip."] = "Muestra el precio de Auctionator de cada material en la descripción emergente.",
    ["Show average price"] = "Mostrar precio medio",
    ["Show the average disenchant value based on Auctionator prices in the tooltip."] = "Muestra el valor medio de desencantamiento según los precios de Auctionator en la descripción emergente.",
}
