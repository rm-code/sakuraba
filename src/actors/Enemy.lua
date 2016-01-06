local Constants = require('src.constants.Constants');
local Actor = require('src.actors.Actor');
local Walk = require('src.actors.actions.Walk');
local Pathfinding = require('src.actors.components.Pathfinding');
local ItemFactory = require('src.items.ItemFactory');

-- ------------------------------------------------
-- Constants
-- ------------------------------------------------

local DIRECTION = Constants.DIRECTION;
local FACTIONS  = Constants.FACTIONS;

-- ------------------------------------------------
-- Module
-- ------------------------------------------------

local Enemy = {};

function Enemy.new(type, tile)
    local self = Actor.new(type, tile, FACTIONS.ENEMY);

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

    self:addComponent( 'pathfinding', Pathfinding.new(self) );

    function self:processTurn()
        local path = self:getComponent( 'pathfinding' ):getPath();
        if path then
            local target = table.remove(path); -- Get next tile from the A* path.
            if target then -- TODO fix properly (see https://github.com/rm-code/sakuraba/issues/8)
                self:getComponent( 'action' ):setAction(Walk.new(target));
            end
        end
    end

    return self;
end

return Enemy;
