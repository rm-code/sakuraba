local ActorConstants = require('src.constants.ActorConstants');
local Energy = require('src.actors.components.Energy');
local Attributes = require('src.actors.components.Attributes');
local Body = require('src.actors.components.Body');
local Action = require('src.actors.components.Action');
local Inventory = require('src.actors.components.Inventory');

-- ------------------------------------------------
-- Constants
-- ------------------------------------------------

local ACTOR_STATS = ActorConstants.ACTOR_STATS;

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
    local energy = Energy.new(ACTOR_STATS[type].speed);
    local body = Body.new(ACTOR_STATS[type].bodyParts, ACTOR_STATS[type].maxhealth);
    local attributes = Attributes.new(faction, ACTOR_STATS[type].stats, ACTOR_STATS[type].skills);
    local action = Action.new(self);
    local inventory = Inventory.new(ACTOR_STATS[type].defaultItems);

    function self:processTurn()
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

    function self:body()
        return body;
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
