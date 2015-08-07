local TILE_SIZE  = 16;

local DIRECTION = {
    NORTH = 'n',
    SOUTH = 's',
    EAST  = 'e',
    WEST  = 'w',
};

-- The factions to which the actors can belong. The factions are created from
-- the player's POV so allied means all actors which are friendly to the player.
local FACTIONS = {
    ALLIED = 'allied',
    ENEMY  = 'enemy',
}

local ACTOR_TYPES = {
    PLAYER  = 'player',
    CAT     = 'cat',
    TURTLE  = 'turtle',
    TROLL   = 'troll',
    GOBLIN  = 'goblin',
    VAMPIRE = 'vampire',
}

local TILE_TYPES = {
    WALL = 'wall',
    FLOOR = 'floor',
    DOOR = 'door',
    DOOROPEN = 'dooropen',
    DOORCLOSED = 'doorclosed',
}

local ACTOR_STATS = {
    [ACTOR_TYPES.PLAYER]  = { speed = 8 },
    [ACTOR_TYPES.CAT]     = { speed = 6 },
    [ACTOR_TYPES.TURTLE]  = { speed = 1 },
    [ACTOR_TYPES.TROLL]   = { speed = 2 },
    [ACTOR_TYPES.GOBLIN]  = { speed = 4 },
    [ACTOR_TYPES.VAMPIRE] = { speed = 8 },
}

local TILE_SPRITES = {
    -- Map Tiles
    [TILE_TYPES.WALL]       = '#',
    [TILE_TYPES.FLOOR]      = '.',
    [TILE_TYPES.DOOROPEN]   = 'O',
    [TILE_TYPES.DOORCLOSED] = '/',

    -- Actor Tiles
    [ACTOR_TYPES.PLAYER]  = '@',
    [ACTOR_TYPES.CAT]     = 'c',
    [ACTOR_TYPES.TURTLE]  = 't',
    [ACTOR_TYPES.TROLL]   = 'T',
    [ACTOR_TYPES.GOBLIN]  = 'G',
    [ACTOR_TYPES.VAMPIRE] = 'V'
}

-- The default amount of energy an actor has to spend to perform its task.
local ENERGY_THRESHOLD = 8;

-- Make the constants available as a module.
return {
    TILE_SIZE    = TILE_SIZE,
    DIRECTION    = DIRECTION,
    FACTIONS     = FACTIONS,
    ACTOR_TYPES  = ACTOR_TYPES,
    TILE_TYPES   = TILE_TYPES,
    ACTOR_STATS  = ACTOR_STATS,
    TILE_SPRITES = TILE_SPRITES,
    ENERGY_THRESHOLD = ENERGY_THRESHOLD,
};
