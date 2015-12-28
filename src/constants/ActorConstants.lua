local ACTOR_TYPES = {
    PLAYER  = 'player',
    CAT     = 'cat',
    DOG     = 'dog'
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
        },
        bodyParts = {
            'head',
            'hands',
            'torso',
            'legs',
            'feet'
        },
        defaultItems = {
            weapon = 'fist',
        }
    },
    [ACTOR_TYPES.CAT] = {
        maxhealth = 6,
        speed = 6,
        stats = {
            strength = 2,
            dexterity = 8,
            endurance = 5
        },
        skills = {
            melee  = 60,
            ranged =  0,
        },
        bodyParts = {
            'head',
            'paws',
            'torso',
            'legs',
            'tail'
        },
        defaultItems = {
            weapon = 'claw',
        }
    },
    [ACTOR_TYPES.DOG] = {
        maxhealth = 10,
        speed = 6,
        stats = {
            strength = 3,
            dexterity = 8,
            endurance = 5
        },
        skills = {
            melee  = 70,
            ranged =  0,
        },
        bodyParts = {
            'head',
            'paws',
            'torso',
            'legs',
            'tail'
        },
        defaultItems = {
            weapon = 'claw',
        }
    }
};

return {
    ACTOR_TYPES   = ACTOR_TYPES,
    ACTOR_STATS   = ACTOR_STATS,
}
