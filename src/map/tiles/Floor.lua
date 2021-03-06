local Tile = require('src.map.tiles.Tile');
local Constants = require('src.constants.Constants');

local TILE_TYPES = Constants.TILE_TYPES;
local PASSABLE = true;
local SPRITE = '.';

local Floor = {};

function Floor.new(x, y)
    return Tile.new(x, y, TILE_TYPES.FLOOR, PASSABLE, SPRITE):addInstance('Floor');
end

return Floor;
