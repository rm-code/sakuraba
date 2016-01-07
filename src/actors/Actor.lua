local Object = require('src.Object');
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
    local self = Object.new():addInstance( 'Actor' );

    -- Register the actor on the tile it spawns.
    tile:setActor(self);

    local components = {};

    function self:addComponent( id, component )
        assert( not components[id], string.format( 'Component "%s" already exists!', id ));
        components[id] = component;
    end

    -- TODO rewrite:
    self:addComponent('energy', Energy.new(ACTOR_STATS[type].speed));
    self:addComponent('body', Body.new(ACTOR_STATS[type].bodyParts, ACTOR_STATS[type].maxhealth));
    self:addComponent('attributes', Attributes.new(faction, ACTOR_STATS[type].stats, ACTOR_STATS[type].skills));
    self:addComponent('action', Action.new(self));
    self:addComponent('inventory', Inventory.new(ACTOR_STATS[type].inventory));
    --/

    function self:processTurn()
        return;
    end

    function self:getComponent( component )
        return components[component];
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

    function self:hasComponent( component )
        return components[component] ~= nil;
    end

    return self;
end

return Actor;
