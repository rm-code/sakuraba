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

Constants.TILE_TYPES = {
    WALL = 'wall',
    FLOOR = 'floor',
    DOOR = 'door',
}

-- The default amount of energy an actor has to spend to perform its task.
Constants.ENERGY_THRESHOLD = 8;

return Constants;
