local Constants = require('src.constants.Constants');
local Actor = require('src.actors.Actor');
local Walk = require('src.actors.actions.Walk');
local Weapon = require('src.items.Weapon');
local Armor = require('src.items.Armor');

-- ------------------------------------------------
-- Constants
-- ------------------------------------------------

local TILE_SIZE = Constants.TILE_SIZE;
local ENERGY_THRESHOLD = Constants.ENERGY_THRESHOLD;
local DIRECTION = Constants.DIRECTION;
local FACTIONS = Constants.FACTIONS;

-- ------------------------------------------------
-- Module
-- ------------------------------------------------

local Ally = {};

function Ally.new(type, tile)
    local self = Actor.new(type, tile, FACTIONS.ALLIED);

    local weapon = Weapon.new('claw');
    self:inventory():add(weapon);
    self:inventory():equip(weapon);

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

    local direction = DIRECTION.NORTH;

    function self:update(dt)
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

        self:action():setAction(Walk.new(self:getTile():getNeighbours()[direction]));
    end

    return self;
end

return Ally;
