local Constants = require('src.Constants');
local Actor = require('src.actors.Actor');

-- ------------------------------------------------
-- Constants
-- ------------------------------------------------

local TILE_SIZE = Constants.TILE_SIZE;
local ENERGY_THRESHOLD = Constants.ENERGY_THRESHOLD;
local COLOR = { 0, 255, 0 };
local SPRITE = '@';

-- ------------------------------------------------
-- Module
-- ------------------------------------------------

local Player = {};

function Player.new(tile)
    local self = Actor.new(tile, SPRITE, COLOR, ENERGY_THRESHOLD);

    return self;
end

return Player;
