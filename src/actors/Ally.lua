local Constants = require('src.constants.Constants');
local Actor = require('src.actors.Actor');
local Walk = require('src.actors.actions.Walk');
local ItemFactory = require('src.items.ItemFactory');

-- ------------------------------------------------
-- Constants
-- ------------------------------------------------

local ENERGY_THRESHOLD = Constants.ENERGY_THRESHOLD;
local DIRECTION = Constants.DIRECTION;
local FACTIONS = Constants.FACTIONS;

-- ------------------------------------------------
-- Module
-- ------------------------------------------------

local Ally = {};

function Ally.new(type, tile)
    local self = Actor.new(type, tile, FACTIONS.ALLIED);

    -- TODO Find a better way to create and assign default items.
    local armor = ItemFactory.createItem( 'cap' );
    self:getComponent( 'inventory' ):add(armor);
    self:getComponent( 'inventory' ):equip(armor);

    local armor = ItemFactory.createItem( 'gloves' );
    self:getComponent( 'inventory' ):add(armor);
    self:getComponent( 'inventory' ):equip(armor);

    local armor = ItemFactory.createItem( 'pullover' );
    self:getComponent( 'inventory' ):add(armor);
    self:getComponent( 'inventory' ):equip(armor);

    local armor = ItemFactory.createItem( 'jeans' );
    self:getComponent( 'inventory' ):add(armor);
    self:getComponent( 'inventory' ):equip(armor);

    local armor = ItemFactory.createItem( 'boots' );
    self:getComponent( 'inventory' ):add(armor);
    self:getComponent( 'inventory' ):equip(armor);

    local direction = DIRECTION.NORTH;

    function self:processTurn()
        local rnd = love.math.random(4);
        if rnd == 1 then
            direction = DIRECTION.NORTH;
        elseif rnd == 2 then
            direction = DIRECTION.SOUTH;
        elseif rnd == 3 then
            direction = DIRECTION.EAST;
        elseif rnd == 4 then
            direction = DIRECTION.WEST;
        end

        self:getComponent( 'action' ):setAction(Walk.new(self:getTile():getNeighbours()[direction]));
    end

    return self;
end

return Ally;
