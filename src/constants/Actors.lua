local ACTOR_TYPES = {
    PLAYER  = 'player',
    CAT     = 'cat',
    TURTLE  = 'turtle',
    TROLL   = 'troll',
    GOBLIN  = 'goblin',
    VAMPIRE = 'vampire'
};

local ACTOR_STATS = {
    [ACTOR_TYPES.PLAYER]  = { maxhealth = 20, ar = 10, dr = 10, speed = 8 },
    [ACTOR_TYPES.CAT]     = { maxhealth = 6,  ar =  5, dr =  2, speed = 6 },
    [ACTOR_TYPES.TURTLE]  = { maxhealth = 12, ar =  6, dr =  8, speed = 1 },
    [ACTOR_TYPES.TROLL]   = { maxhealth = 34, ar = 12, dr = 14, speed = 2 },
    [ACTOR_TYPES.GOBLIN]  = { maxhealth = 18, ar = 10, dr = 11, speed = 4 },
    [ACTOR_TYPES.VAMPIRE] = { maxhealth = 22, ar = 14, dr =  9, speed = 8 }
};

local ACTOR_SPRITES = {
    [ACTOR_TYPES.PLAYER]  = '@',
    [ACTOR_TYPES.CAT]     = 'c',
    [ACTOR_TYPES.TURTLE]  = 't',
    [ACTOR_TYPES.TROLL]   = 'T',
    [ACTOR_TYPES.GOBLIN]  = 'G',
    [ACTOR_TYPES.VAMPIRE] = 'V'
};

return {
    ACTOR_TYPES   = ACTOR_TYPES,
    ACTOR_STATS   = ACTOR_STATS,
    ACTOR_SPRITES = ACTOR_SPRITES
}
