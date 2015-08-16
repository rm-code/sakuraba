local Constants = require('src.constants.Constants');
local Health = require('src.actors.components.Health');
local Energy = require('src.actors.components.Energy');
local Attributes = require('src.actors.components.Attributes');
local Action = require('src.actors.components.Action');
local Inventory = require('src.actors.components.Inventory');

-- ------------------------------------------------
-- Constants
-- ------------------------------------------------

local TILE_SIZE = Constants.TILE_SIZE;
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

    -- Load components.
    local health = Health.new(ACTOR_STATS[type].maxhealth);
    local energy = Energy.new(ACTOR_STATS[type].speed);
    local attributes = Attributes.new(faction, ACTOR_STATS[type].ar, ACTOR_STATS[type].dr);
    local action = Action.new(self);
    local inventory = Inventory.new(self);

    function self:update(dt)
        return;
    end

    function self:setTile(ntile)
        tile = ntile;
    end

    function self:getTile()
        return tile;
    end

    function self:getType()
        return type;
    end

    function self:health()
        return health;
    end

    function self:energy()
        return energy;
    end

    function self:attributes()
        return attributes;
    end

    function self:action()
        return action;
    end

    function self:inventory()
        return inventory;
    end

    return self;
end

return Actor;
