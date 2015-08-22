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

local TILE_TYPES = {
    WALL = 'wall',
    FLOOR = 'floor',
    DOOR = 'door',
    DOOROPEN = 'dooropen',
    DOORCLOSED = 'doorclosed',
    ITEM_STACK = 'itemstack',
}

local ITEM_TYPES = {
    WEAPON = 'weapon',
}

local TILE_SPRITES = {
    -- Map Tiles
    [TILE_TYPES.WALL]       = '#',
    [TILE_TYPES.FLOOR]      = '.',
    [TILE_TYPES.DOOROPEN]   = 'O',
    [TILE_TYPES.DOORCLOSED] = '/',
    [TILE_TYPES.ITEM_STACK] = '!',
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
    TILE_TYPES   = TILE_TYPES,
    ITEM_TYPES   = ITEM_TYPES,
    TILE_SPRITES = TILE_SPRITES,
    COLORS       = COLORS,
    ENERGY_THRESHOLD = ENERGY_THRESHOLD,
};
