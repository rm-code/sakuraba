local Walk = require('src.actors.actions.Walk');
local Constants = require('src.Constants');
local Actor = require('src.actors.Actor');

-- ------------------------------------------------
-- Constants
-- ------------------------------------------------

local TILE_SIZE = Constants.TILE_SIZE;
local DIRECTION = Constants.DIRECTION;
local FACTIONS  = Constants.FACTIONS;
local ACTOR_STATS = Constants.ACTOR_STATS;
local TILE_SPRITES = Constants.TILE_SPRITES;
local COLOR = { 255, 0, 0 };

-- ------------------------------------------------
-- Module
-- ------------------------------------------------

local Enemy = {};

function Enemy.new(type, tile)
    local self = Actor.new(tile, FACTIONS.ENEMY, TILE_SPRITES[type], COLOR, ACTOR_STATS[type].speed);

    local prevDirection = DIRECTION.NORTH;

    function self:update(dt)
        local rnd = love.math.random(4);
        if rnd == 1 then
            prevDirection = DIRECTION.NORTH;
        elseif rnd == 2 then
            prevDirection = DIRECTION.SOUTH;
        elseif rnd == 3 then
            prevDirection = DIRECTION.EAST;
        elseif rnd == 4 then
            prevDirection = DIRECTION.WEST;
        end
        self:setAction(Walk.new(prevDirection));
    end

    return self;
end

return Enemy;
