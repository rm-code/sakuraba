local Constants = require('src.Constants');

-- ------------------------------------------------
-- Constants
-- ------------------------------------------------

local TILE_SIZE = Constants.TILE_SIZE;

-- ------------------------------------------------
-- Module
-- ------------------------------------------------

local Tile = {};

-- ------------------------------------------------
-- Constructor
-- ------------------------------------------------

function Tile.new(x, y)
    local self = {};

    function self:draw()
        love.graphics.rectangle('line', x * TILE_SIZE, y * TILE_SIZE, TILE_SIZE, TILE_SIZE);
    end

    function self:update(dt)
    end

    return self;
end

return Tile;
