local Constants = require('src.Constants');

-- ------------------------------------------------
-- Constants
-- ------------------------------------------------

local TILE_SIZE = Constants.TILE_SIZE;
local ENERGY_THRESHOLD = Constants.ENERGY_THRESHOLD;

-- ------------------------------------------------
-- Module
-- ------------------------------------------------

local Player = {};

function Player.new(tile)
    local self = {};

    local action;
    local energyDelta = ENERGY_THRESHOLD;
    local energy = energyDelta;

    function self:update(dt)
        return;
    end

    function self:draw()
        love.graphics.setColor(0, 255, 0);
        love.graphics.print('@', tile:getX() * TILE_SIZE, tile:getY() * TILE_SIZE);
        love.graphics.setColor(255, 255, 255);
    end

    function self:grantEnergy()
        energy = energy + energyDelta;
    end

    function self:clearAction()
        action = nil;
    end

    function self:setAction(naction)
        if naction then
            action = naction;
            action:bind(self);
            return;
        end
    end

    function self:setEnergy(nenergy)
        energy = nenergy;
    end

    function self:setTile(ntile)
        tile = ntile;
    end

    function self:getAction()
        return action;
    end

    function self:getTile()
        return tile;
    end

    function self:getEnergy()
        return energy;
    end

    return self;
end

return Player;
