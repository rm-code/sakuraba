local Constants = {};

Constants.TILE_SIZE  = 16;

Constants.DIRECTION = {
    NORTH = 'n',
    SOUTH = 's',
    EAST  = 'e',
    WEST  = 'w',
};

-- The factions to which the actors can belong. The factions are created from
-- the player's POV so allied means all actors which are friendly to the player.
Constants.FACTIONS = {
    ALLIED = 'allied',
    ENEMY  = 'enemy',
}

Constants.ACTOR_TYPES = {
    PLAYER  = 'player',
    CAT     = 'cat',
    TURTLE  = 'turtle',
    TROLL   = 'troll',
    GOBLIN  = 'goblin',
    VAMPIRE = 'vampire',
}

Constants.TILE_TYPES = {
    WALL = 'wall',
    FLOOR = 'floor',
    DOOR = 'door',
    DOOROPEN = 'dooropen',
    DOORCLOSED = 'doorclosed',
}

Constants.ACTOR_STATS = {
    [Constants.ACTOR_TYPES.PLAYER]  = { speed = 8 },
    [Constants.ACTOR_TYPES.CAT]     = { speed = 6 },
    [Constants.ACTOR_TYPES.TURTLE]  = { speed = 1 },
    [Constants.ACTOR_TYPES.TROLL]   = { speed = 2 },
    [Constants.ACTOR_TYPES.GOBLIN]  = { speed = 4 },
    [Constants.ACTOR_TYPES.VAMPIRE] = { speed = 8 },
}

Constants.TILE_SPRITES = {
    -- Map Tiles
    [Constants.TILE_TYPES.WALL]       = '#',
    [Constants.TILE_TYPES.FLOOR]      = '.',
    [Constants.TILE_TYPES.DOOROPEN]   = 'O',
    [Constants.TILE_TYPES.DOORCLOSED] = '/',

    -- Actor Tiles
    [Constants.ACTOR_TYPES.PLAYER]  = '@',
    [Constants.ACTOR_TYPES.CAT]     = 'c',
    [Constants.ACTOR_TYPES.TURTLE]  = 't',
    [Constants.ACTOR_TYPES.TROLL]   = 'T',
    [Constants.ACTOR_TYPES.GOBLIN]  = 'G',
    [Constants.ACTOR_TYPES.VAMPIRE] = 'V'
}

-- The default amount of energy an actor has to spend to perform its task.
Constants.ENERGY_THRESHOLD = 8;

return Constants;
