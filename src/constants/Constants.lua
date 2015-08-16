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
    ITEM_STACK = 'itemstack',
}

local ACTOR_STATS = {
    [ACTOR_TYPES.PLAYER]  = { maxhealth = 20, ar = 10, dr = 10, speed = 8 },
    [ACTOR_TYPES.CAT]     = { maxhealth = 6,  ar =  5, dr =  2, speed = 6 },
    [ACTOR_TYPES.TURTLE]  = { maxhealth = 12, ar =  6, dr =  8, speed = 1 },
    [ACTOR_TYPES.TROLL]   = { maxhealth = 34, ar = 12, dr = 14, speed = 2 },
    [ACTOR_TYPES.GOBLIN]  = { maxhealth = 18, ar = 10, dr = 11, speed = 4 },
    [ACTOR_TYPES.VAMPIRE] = { maxhealth = 22, ar = 14, dr =  9, speed = 8 },
}

local TILE_SPRITES = {
    -- Map Tiles
    [TILE_TYPES.WALL]       = '#',
    [TILE_TYPES.FLOOR]      = '.',
    [TILE_TYPES.DOOROPEN]   = 'O',
    [TILE_TYPES.DOORCLOSED] = '/',
    [TILE_TYPES.ITEM_STACK] = '!',

    -- Actor Tiles
    [ACTOR_TYPES.PLAYER]  = '@',
    [ACTOR_TYPES.CAT]     = 'c',
    [ACTOR_TYPES.TURTLE]  = 't',
    [ACTOR_TYPES.TROLL]   = 'T',
    [ACTOR_TYPES.GOBLIN]  = 'G',
    [ACTOR_TYPES.VAMPIRE] = 'V'
}

local COLORS = {
    INVISIBLE = {   0,   0,   0,   0 },
    WHITE     = { 255, 255, 255, 255 },
    DARK_GREY = {  50,  50,  50, 255 },
    RED       = { 255,   0,   0, 255 },
    GREEN     = {   0, 255,   0, 255 },
    PURPLE    = { 148,   0, 211, 255 },
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
    COLORS       = COLORS,
    ENERGY_THRESHOLD = ENERGY_THRESHOLD,
};
