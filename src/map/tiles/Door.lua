local Tile = require('src.map.tiles.Tile');
local Constants = require('src.Constants');

local TILE_TYPES = Constants.TILE_TYPES;
local PASSABLE = false;
local SPRITE = '/';

local Door = {};

function Door.new(x, y)
    local self = Tile.new(x, y, TILE_TYPES.DOOR, PASSABLE, SPRITE);

    function self:open()
        self:setPassable(true);
        self:setSprite('O');
    end

    function self:close()
        self:setPassable(false);
        self:setSprite('/');
    end

    return self;
end

return Door;
