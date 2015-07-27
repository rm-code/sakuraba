local Constants = require('src.Constants');

-- ------------------------------------------------
-- Constants
-- ------------------------------------------------

local TILE_SIZE = Constants.TILE_SIZE;
local DIRECTION = Constants.DIRECTION;

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
    local content = {};

    function self:draw()
        love.graphics.print(sprite, x * TILE_SIZE, y * TILE_SIZE);
    end

    function self:update(dt)
    end

    function self:removeEntity()
        content.entity = nil;
    end

    function self:setEntity(nentity)
        content.entity = nentity;
    end

    function self:setNeighbours(n, s, e, w)
        neighbours[DIRECTION.NORTH] = n;
        neighbours[DIRECTION.SOUTH] = s;
        neighbours[DIRECTION.EAST]  = e;
        neighbours[DIRECTION.WEST]  = w;
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

    function self:isOccupied()
        return content.entity ~= nil;
    end

    function self:isPassable()
        return passable;
    end

    return self;
end

return Tile;
