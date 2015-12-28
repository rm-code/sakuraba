local Constants = require('src.constants.Constants');
local Actor = require('src.actors.Actor');
local Weapon = require('src.items.Weapon');
local Armor = require('src.items.Armor');

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

    return self;
end

return Player;
