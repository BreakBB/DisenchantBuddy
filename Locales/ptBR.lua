---@class DisenchantBuddy
local DisenchantBuddy = select(2, ...)

if GetLocale() ~= "ptBR" then
    return
end

DisenchantBuddy.L = {
    ["Disenchant results:"] = "Resultados de desencantar:",
    ["Disenchanted from:"] = "Desencantado de:",
    ["Modifier"] = "Modificador",
    ["Only show disenchant info while this key is held down."] = "Mostrar informações de desencantamento somente enquanto esta tecla estiver pressionada.",
    ["Materials"] = "Materiais",
    ["Dusts"] = "Pós",
    ["Essences"] = "Essências",
    ["Shards"] = "Fragmentos",
    ["Crystals"] = "Cristais",
    ["Item Level"] = "Nível do item",
    ["Exclude low-chance results"] = "Excluir resultados de baixa chance",
    ["Shopping list"] = "Lista de compras",
    ["Create an Auctionator shopping list for all items that disenchant into this material."] = "Criar uma lista de compras do Auctionator com todos os itens que se desencantam neste material.",
    ["Created Auctionator shopping list: %s"] = "Lista de compras do Auctionator criada: %s",
    ["No item sources left after excluding low-chance results."] = "Nenhum item restante após excluir resultados de baixa chance.",
    ["Show prices per material"] = "Mostrar preços por material",
    ["Show the Auctionator price of each material in the tooltip."] = "Mostra o preço do Auctionator de cada material na dica.",
    ["Show average price"] = "Mostrar preço médio",
    ["Show the average disenchant value based on Auctionator prices in the tooltip."] = "Mostra o valor médio de desencantamento com base nos preços do Auctionator na dica.",
}
