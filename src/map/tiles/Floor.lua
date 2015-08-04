local Tile = require('src.map.tiles.Tile');
local Constants = require('src.Constants');

local TILE_TYPES = Constants.TILE_TYPES;
local PASSABLE = true;
local SPRITE = '.';

local Floor = {};

function Floor.new(x, y)
    return Tile.new(x, y, TILE_TYPES.FLOOR, PASSABLE, SPRITE);
end

return Floor;
