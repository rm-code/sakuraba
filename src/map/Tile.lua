local Constants = require('src.Constants');

-- ------------------------------------------------
-- Constants
-- ------------------------------------------------

local TILE_SIZE = Constants.TILE_SIZE;

local TILES = {
    floor = { passable = true,  sprite = '.' },
    wall  = { passable = false, sprite = '#' },
}

-- ------------------------------------------------
-- Module
-- ------------------------------------------------

local Tile = {};

-- ------------------------------------------------
-- Constructor
-- ------------------------------------------------

function Tile.new(x, y, id)
    local self = {};

    local sprite = TILES[id].sprite;
    local passable = TILES[id].passable;
    local neighbours = {};

    function self:draw()
        love.graphics.print(sprite, x * TILE_SIZE, y * TILE_SIZE);
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

    function self:getX()
        return x;
    end

    function self:getY()
        return y;
    end

    function self:isPassable()
        return passable;
    end

    return self;
end

return Tile;
