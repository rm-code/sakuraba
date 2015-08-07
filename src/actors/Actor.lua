local Constants = require('src.Constants');

-- ------------------------------------------------
-- Constants
-- ------------------------------------------------

local TILE_SIZE = Constants.TILE_SIZE;
local ENERGY_THRESHOLD = Constants.ENERGY_THRESHOLD;
local ACTOR_STATS = Constants.ACTOR_STATS;

-- ------------------------------------------------
-- Module
-- ------------------------------------------------

local Actor = {};

---
-- @param tile - The tile the actor is located on.
-- @param ed - The amount of energy this actor gets per turn.
--
function Actor.new(type, tile, faction)
    local self = {};

    -- Register the actor on the tile it spawns.
    tile:setActor(self);

    local action;
    local energyDelta = ACTOR_STATS[type].speed;
    local energy = energyDelta;
    local dead = false;

    function self:update(dt)
        return;
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

    function self:setDead(ndead)
        dead = ndead;
    end

    function self:setTile(ntile)
        tile = ntile;
    end

    function self:getAction()
        return action;
    end

    function self:getFaction()
        return faction;
    end

    function self:getType()
        return type;
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

    function self:isDead()
        return dead;
    end

    return self;
end

return Actor;
