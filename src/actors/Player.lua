local Constants = require('src.constants.Constants');
local Actor = require('src.actors.Actor');
local ItemFactory = require('src.items.ItemFactory');

-- ------------------------------------------------
-- Constants
-- ------------------------------------------------

local ENERGY_THRESHOLD = Constants.ENERGY_THRESHOLD;
local FACTIONS = Constants.FACTIONS;

-- ------------------------------------------------
-- Module
-- ------------------------------------------------

local Player = {};

function Player.new(type, tile)
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

    return self;
end

return Player;
