local Constants = require('src.constants.Constants');
local Actor = require('src.actors.Actor');

-- ------------------------------------------------
-- Constants
-- ------------------------------------------------

local TILE_SIZE = Constants.TILE_SIZE;
local ENERGY_THRESHOLD = Constants.ENERGY_THRESHOLD;
local FACTIONS = Constants.FACTIONS;

-- ------------------------------------------------
-- Module
-- ------------------------------------------------

local Player = {};

function Player.new(type, tile)
    local self = Actor.new(type, tile, FACTIONS.ALLIED);

    return self;
end

return Player;
