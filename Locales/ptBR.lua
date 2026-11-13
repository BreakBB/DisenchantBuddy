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
}
