local Tile = require('src.map.tiles.Tile');
local Constants = require('src.constants.Constants');

local TILE_TYPES = Constants.TILE_TYPES;
local PASSABLE = false;
local SPRITE = '#';

local Wall = {};

function Wall.new(x, y)
    return Tile.new(x, y, TILE_TYPES.WALL, PASSABLE, SPRITE):addInstance('Wall');
end

return Wall;
