local Constants = require('src.Constants');

-- ------------------------------------------------
-- Constants
-- ------------------------------------------------

local TILE_SIZE = Constants.TILE_SIZE;
local ENERGY_THRESHOLD = Constants.ENERGY_THRESHOLD;

-- ------------------------------------------------
-- Module
-- ------------------------------------------------

local Entity = {};

---
-- @param tile - The tile the entity is located on.
-- @param ed - The amount of energy this entity gets per turn.
--
function Entity.new(tile, sprite, color, ed)
    local self = {};

    local action;
    local energyDelta = ed;
    local energy = energyDelta;

    function self:update(dt)
        return;
    end

    function self:draw()
        love.graphics.setColor(color);
        love.graphics.print(sprite, tile:getX() * TILE_SIZE, tile:getY() * TILE_SIZE);
        love.graphics.setColor(255, 255, 255);
    end

    function self:grantEnergy()
        energy = energy + energyDelta;
    end

    function self:drainEnergy()
        energy = energy - ENERGY_THRESHOLD;
    end

    function self:clearAction()
        action = nil;
    end

    function self:canPerform()
        return energy >= ENERGY_THRESHOLD;
    end

    function self:setAction(naction)
        if naction then
            action = naction;
            action:bind(self);
            return;
        end
    end

    function self:setTile(ntile)
        tile = ntile;
    end

    function self:getAction()
        return action;
    end

    function self:getSprite()
        return sprite;
    end

    function self:getTile()
        return tile;
    end

    function self:getEnergy()
        return energy;
    end

    function self:hasAction()
        return action ~= nil;
    end

    return self;
end

return Entity;
