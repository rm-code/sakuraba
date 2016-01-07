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
        inventory = {
            weapons = {
                { id =  'hands', weapon = 'fist' },
            },
            armor = {
                { id =  'head', armor = 'skin' },
                { id = 'hands', armor = 'skin' },
                { id = 'torso', armor = 'skin' },
                { id =  'legs', armor = 'skin' },
                { id =  'feet', armor = 'skin' }
            }
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
        inventory = {
            weapons = {
                { id =  'paws', weapon = 'claw' },
                { id =  'head', weapon = 'bite' },
            },
            armor = {
                { id =  'head', armor = 'fur' },
                { id =  'paws', armor = 'fur' },
                { id = 'torso', armor = 'fur' },
                { id =  'legs', armor = 'fur' },
                { id =  'tail', armor = 'fur' }
            }
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
        inventory = {
            weapons = {
                { id =  'paws', weapon = 'claw' },
                { id =  'head', weapon = 'bite' },
            },
            armor = {
                { id =  'head', armor = 'fur' },
                { id =  'paws', armor = 'fur' },
                { id = 'torso', armor = 'fur' },
                { id =  'legs', armor = 'fur' },
                { id =  'tail', armor = 'fur' }
            }
        }
    }
};

return {
    ACTOR_TYPES   = ACTOR_TYPES,
    ACTOR_STATS   = ACTOR_STATS,
}
