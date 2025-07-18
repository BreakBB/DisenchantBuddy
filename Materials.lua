---@type DisenchantBuddy
local _, DisenchantBuddy = ...

---@class Materials
DisenchantBuddy.Materials = {
    STRANGE_DUST = 10940,
    SOUL_DUST = 11083,
    VISION_DUST = 11137,
    DREAM_DUST = 11176,
    ILLUSION_DUST = 16204,
    LESSER_MAGIC_ESSENCE = 10938,
    GREATER_MAGIC_ESSENCE = 10939,
    LESSER_ASTRAL_ESSENCE = 10998,
    GREATER_ASTRAL_ESSENCE = 11082,
    LESSER_MYSTIC_ESSENCE = 11134,
    GREATER_MYSTIC_ESSENCE = 11135,
    LESSER_NETHER_ESSENCE = 11174,
    GREATER_NETHER_ESSENCE = 11175,
    LESSER_ETERNAL_ESSENCE = 16202,
    GREATER_ETERNAL_ESSENCE = 16203,
    SMALL_GLIMMERING_SHARD = 10978,
    LARGE_GLIMMERING_SHARD = 11084,
    SMALL_GLOWING_SHARD = 11138,
    LARGE_GLOWING_SHARD = 11139,
    SMALL_RADIANT_SHARD = 11177,
    LARGE_RADIANT_SHARD = 11178,
    SMALL_BRILLIANT_SHARD = 14343,
    LARGE_BRILLIANT_SHARD = 14344,
    NEXUS_CRYSTAL = 20725
}

if DisenchantBuddy.IsTBC or DisenchantBuddy.IsWotLK or DisenchantBuddy.IsCata or DisenchantBuddy.IsMoP then
    DisenchantBuddy.Materials.ARCANE_DUST = 22445
    DisenchantBuddy.Materials.LESSER_PLANAR_ESSENCE = 22447
    DisenchantBuddy.Materials.GREATER_PLANAR_ESSENCE = 22446
    DisenchantBuddy.Materials.SMALL_PRISMATIC_SHARD = 22448
    DisenchantBuddy.Materials.LARGE_PRISMATIC_SHARD = 22449
    DisenchantBuddy.Materials.VOID_CRYSTAL = 22450
end

if DisenchantBuddy.IsWotLK or DisenchantBuddy.IsCata or DisenchantBuddy.IsMoP then
    DisenchantBuddy.Materials.INFINITE_DUST = 34054
    DisenchantBuddy.Materials.LESSER_COSMIC_ESSENCE = 34056
    DisenchantBuddy.Materials.GREATER_COSMIC_ESSENCE = 34055
    DisenchantBuddy.Materials.SMALL_DREAM_SHARD = 34053
    DisenchantBuddy.Materials.DREAM_SHARD = 34052
    DisenchantBuddy.Materials.ABYSS_CRYSTAL = 34057
end

if DisenchantBuddy.IsCata or DisenchantBuddy.IsMoP then
    DisenchantBuddy.Materials.HYPNOTIC_DUST = 52555
    DisenchantBuddy.Materials.LESSER_CELESTIAL_ESSENCE = 52718
    DisenchantBuddy.Materials.GREATER_CELESTIAL_ESSENCE = 52719
    DisenchantBuddy.Materials.SMALL_HEAVENLY_SHARD = 52720
    DisenchantBuddy.Materials.HEAVENLY_SHARD = 52721
    DisenchantBuddy.Materials.MAELSTROM_CRYSTAL = 52722
end

if DisenchantBuddy.IsMoP then
    DisenchantBuddy.Materials.ETHEREAL_SHARD = 74247
    DisenchantBuddy.Materials.SHA_CRYSTAL = 74248
    DisenchantBuddy.Materials.SPIRIT_DUST = 74249
    DisenchantBuddy.Materials.MYSTERIOUS_ESSENCE = 74250
    DisenchantBuddy.Materials.SMALL_ETHEREAL_SHARD = 74252
    DisenchantBuddy.Materials.BLOOD_SPIRIT = 80433
    DisenchantBuddy.Materials.HAUNTING_SPIRIT = 94289
    DisenchantBuddy.Materials.SPIRIT_OF_WAR = 102218
end
