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

function Tile.new(x, y, id)
    local self = {};

    -- Decide the draw mode based on the tile's id. This can later be changed
    -- to a more elaborate function to choose a sprite.
    local drawMode = id == 'floor' and 'line' or 'fill';

    function self:draw()
        love.graphics.rectangle(drawMode, x * TILE_SIZE, y * TILE_SIZE, TILE_SIZE, TILE_SIZE);
    end

    function self:update(dt)
    end

    function self:getId()
        return id;
    end

    return self;
end

return Tile;
