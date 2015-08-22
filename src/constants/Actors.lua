local ACTOR_TYPES = {
    PLAYER  = 'player',
    CAT     = 'cat',
    TURTLE  = 'turtle',
    TROLL   = 'troll',
    GOBLIN  = 'goblin',
    VAMPIRE = 'vampire'
};

local ACTOR_STATS = {
    [ACTOR_TYPES.PLAYER] = {
        maxhealth = 20,
        speed = 8,
        stats = {
            strength = 5,
            dexterity = 6,
            endurance = 5
        },
        skills = {
            melee  = 70,
            ranged = 70,
        }
    },
    [ACTOR_TYPES.CAT]     = {
        maxhealth = 20,
        speed = 8,
        stats = {
            strength = 2,
            dexterity = 8,
            endurance = 5
        },
        skills = {
            melee  = 60,
            ranged =  0,
        }
    },
    [ACTOR_TYPES.TURTLE]  = {
        maxhealth = 20,
        speed = 8,
        stats = {
            strength = 3,
            dexterity = 3,
            endurance = 5
        },
        skills = {
            melee  = 40,
            ranged =  0,
        }
    },
    [ACTOR_TYPES.TROLL]   = {
        maxhealth = 20,
        speed = 8,
        stats = {
            strength = 8,
            dexterity = 4,
            endurance = 5
        },
        skills = {
            melee  = 70,
            ranged = 30,
        }
    },
    [ACTOR_TYPES.GOBLIN]  = {
        maxhealth = 20,
        speed = 8,
        stats = {
            strength = 5,
            dexterity = 5,
            endurance = 5
        },
        skills = {
            melee  = 80,
            ranged = 50,
        }
    },
    [ACTOR_TYPES.VAMPIRE] = {
        maxhealth = 20,
        speed = 8,
        stats = {
            strength = 6,
            dexterity = 8,
            endurance = 5
        },
        skills = {
            melee  = 95,
            ranged = 75,
        }
    }
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
