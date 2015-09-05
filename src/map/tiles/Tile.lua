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
    local inventory = {};
    local dirty = false;
    local id;

    function self:addItem(item)
        inventory[#inventory + 1] = item;
    end

    function self:removeActor()
        content.actor = nil;
    end

    function self:removeItem(index)
        inventory[index] = nil;
    end

    function self:setActor(nactor)
        content.actor = nactor;
    end

    function self:setDirty(ndirty)
        dirty = ndirty;
    end

    function self:setExplored(nexplored)
        explored = nexplored;
    end

    function self:setId(nid)
        id = nid;
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

    function self:setType(ntype)
        type = ntype;
    end

    function self:setVisible(nvisible)
        visible = nvisible;
    end

    function self:getActor()
        return content.actor;
    end

    function self:isDirty()
        return dirty;
    end

    function self:getId()
        return id;
    end

    function self:getItems()
        return inventory;
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

    function self:hasItems()
        return #inventory > 0;
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
