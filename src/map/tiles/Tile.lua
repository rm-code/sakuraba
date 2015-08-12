local Constants = require('src.constants.Constants');

-- ------------------------------------------------
-- Constants
-- ------------------------------------------------

local DIRECTION = Constants.DIRECTION;

-- ------------------------------------------------
-- Module
-- ------------------------------------------------

local Tile = {};

-- ------------------------------------------------
-- Constructor
-- ------------------------------------------------

function Tile.new(x, y, type, passable)
    local self = {};

    local neighbours = {};
    local content = {};
    local visible = false;
    local explored = false;

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

    function self:setVisible(nvisible)
        visible = nvisible;
    end

    function self:getActor()
        return content.actor;
    end

    function self:getType()
        return type;
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

    function self:isExplored()
        return explored;
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
