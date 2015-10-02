local TILE_SIZE  = 16;

local DIRECTION = {
    NORTH      =  'n',
    NORTH_EAST = 'ne',
    NORTH_WEST = 'nw',
    SOUTH      =  's',
    SOUTH_EAST = 'se',
    SOUTH_WEST = 'sw',
    EAST       =  'e',
    WEST       =  'w',
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
    ARMOR = 'armor',
}

local BODY_PARTS = {
    HEAD = 'head',
    HANDS = 'hands',
    TORSO = 'torso',
    LEGS = 'legs',
    FEET = 'feet'
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
    BODY_PARTS   = BODY_PARTS,
    COLORS       = COLORS,
    ENERGY_THRESHOLD = ENERGY_THRESHOLD,
};
