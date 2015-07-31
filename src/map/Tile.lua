local Constants = require('src.Constants');

-- ------------------------------------------------
-- Constants
-- ------------------------------------------------

local TILE_SIZE = Constants.TILE_SIZE;
local DIRECTION = Constants.DIRECTION;

local TILES = {
    floor = { passable = true,  sprite = '.' },
    wall  = { passable = false, sprite = '#' },
    door  = { passable = false, sprite = '/' },
}

local COLORS = {
    visible = { 255, 255, 255 },
    notvisible = { 50, 50, 50 },
};

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
    local visible = false;
    local explored = false;

    function self:draw()
        if not explored then
            return;
        elseif not visible then
            love.graphics.setColor(50, 50, 50, 255);
            love.graphics.print(sprite, x * TILE_SIZE, y * TILE_SIZE);
            love.graphics.setColor(255, 255, 255, 255);
        elseif not self:isOccupied() then
            love.graphics.print(sprite, x * TILE_SIZE, y * TILE_SIZE);
        end
    end

    function self:update(dt)
    end

    function self:removeActor()
        content.actor = nil;
    end

    function self:setActor(nactor)
        content.actor = nactor;
    end

    function self:setExplored(nexplored)
        explored = nexplored;
    end

    function self:setNeighbours(n, s, e, w)
        neighbours[DIRECTION.NORTH] = n;
        neighbours[DIRECTION.SOUTH] = s;
        neighbours[DIRECTION.EAST]  = e;
        neighbours[DIRECTION.WEST]  = w;
    end

    function self:setPassable(np)
        passable = np;
    end

    function self:setSprite(nsprite)
        sprite = nsprite;
    end

    function self:setVisible(nvisible)
        visible = nvisible;
    end

    function self:getActor()
        return content.actor;
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
        return content.actor ~= nil;
    end

    function self:isPassable()
        return passable;
    end

    function self:isVisible()
        return visible;
    end

    return self;
end

return Tile;
