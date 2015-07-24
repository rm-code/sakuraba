local Constants = {};

Constants.TILE_SIZE  = 16;
Constants.MAP_WIDTH  = 17;
Constants.MAP_HEIGHT = 17;

Constants.DIRECTION = {
    NORTH = 'n',
    SOUTH = 's',
    EAST  = 'e',
    WEST  = 'w',
};

-- The default amount of energy an actor has to spend to perform its task.
Constants.ENERGY_THRESHOLD = 8;

return Constants;
