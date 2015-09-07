local Walk = require('src.actors.actions.Walk');
local Constants = require('src.constants.Constants');
local Actor = require('src.actors.Actor');
local Weapon = require('src.items.Weapon');
local Armor = require('src.items.Armor');

-- ------------------------------------------------
-- Constants
-- ------------------------------------------------

local TILE_SIZE = Constants.TILE_SIZE;
local DIRECTION = Constants.DIRECTION;
local FACTIONS  = Constants.FACTIONS;

-- ------------------------------------------------
-- Module
-- ------------------------------------------------

local Enemy = {};

function Enemy.new(type, tile)
    local self = Actor.new(type, tile, FACTIONS.ENEMY);

    local armor = Armor.new('cap');
    self:inventory():add(armor);
    self:inventory():equip(armor);

    local armor = Armor.new('gloves');
    self:inventory():add(armor);
    self:inventory():equip(armor);

    local armor = Armor.new('pullover');
    self:inventory():add(armor);
    self:inventory():equip(armor);

    local armor = Armor.new('jeans');
    self:inventory():add(armor);
    self:inventory():equip(armor);

    local armor = Armor.new('boots');
    self:inventory():add(armor);
    self:inventory():equip(armor);

    local direction;

    function self:processTurn()
        if direction then
            self:action():setAction(Walk.new(self:getTile():getNeighbours()[direction]));
        end
    end

    function self:setMovementTarget(nx, ny)
        local ox, oy = self:getTile():getPosition();

        -- TODO replace with proper pathfinding
        if oy < ny then
            direction = DIRECTION.SOUTH;
        elseif oy > ny then
            direction = DIRECTION.NORTH;
        end
        if ox < nx then
            direction = DIRECTION.EAST;
        elseif ox > nx then
            direction = DIRECTION.WEST;
        end
    end

    return self;
end

return Enemy;
