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
    local passable = id == 'floor' and true or false;
    local neighbours = {};

    function self:draw()
        love.graphics.rectangle(drawMode, x * TILE_SIZE, y * TILE_SIZE, TILE_SIZE, TILE_SIZE);
    end

    function self:update(dt)
    end

    function self:setNeighbours(n, s, e, w)
        neighbours.n = n;
        neighbours.s = s;
        neighbours.e = e;
        neighbours.w = w;
    end

    function self:getId()
        return id;
    end

    function self:getNeighbours()
        return neighbours;
    end

    function self:getPosition()
        return x, y;
    end

    function self:isPassable()
        return passable;
    end

    return self;
end

return Tile;
