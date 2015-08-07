local Constants = require('src.Constants');
local Actor = require('src.actors.Actor');

-- ------------------------------------------------
-- Constants
-- ------------------------------------------------

local TILE_SIZE = Constants.TILE_SIZE;
local ENERGY_THRESHOLD = Constants.ENERGY_THRESHOLD;
local FACTIONS = Constants.FACTIONS;
local ACTOR_STATS = Constants.ACTOR_STATS;
local TILE_SPRITES = Constants.TILE_SPRITES;
local COLOR = { 0, 255, 0 };

-- ------------------------------------------------
-- Module
-- ------------------------------------------------

local Player = {};

function Player.new(type, tile)
    local self = Actor.new(tile, FACTIONS.ALLIED, TILE_SPRITES[type], COLOR, ACTOR_STATS[type].speed);

    function self:setDead(ndead)
        return;
    end

    return self;
end

return Player;
