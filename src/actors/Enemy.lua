local Walk = require('src.actors.actions.Walk');
local Constants = require('src.constants.Constants');
local Actor = require('src.actors.Actor');
local Weapon = require('src.items.Weapon');
local Armor = require('src.items.Armor');
local Pathfinding = require('src.actors.components.Pathfinding');

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

    local pathfinding = Pathfinding.new(self);

    function self:pathfinding()
        return pathfinding;
    end

    function self:processTurn()
        local path = self:pathfinding():getPath();
        if path then
            local target = table.remove(path); -- Get next tile from the A* path.
            if target then -- TODO fix properly (see https://github.com/rm-code/sakuraba/issues/8)
                self:action():setAction(Walk.new(target));
            end
        end
    end

    return self;
end

return Enemy;
