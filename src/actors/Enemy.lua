local Walk = require('src.actors.actions.Walk');
local Constants = require('src.Constants');
local Actor = require('src.actors.Actor');

-- ------------------------------------------------
-- Constants
-- ------------------------------------------------

local TILE_SIZE = Constants.TILE_SIZE;
local DIRECTION = Constants.DIRECTION;
local FACTIONS  = Constants.FACTIONS;
local TYPES = {
    turtle =  { sprite = 'O', speed = 1 };
    troll  =  { sprite = 'T', speed = 2 };
    goblin =  { sprite = 'G', speed = 4 };
    vampire = { sprite = 'V', speed = 8 };
}
local COLOR = { 255, 0, 0 };

-- ------------------------------------------------
-- Module
-- ------------------------------------------------

local Enemy = {};

function Enemy.new(type, tile)
    local self = Actor.new(tile, FACTIONS.ENEMY, TYPES[type].sprite, COLOR, TYPES[type].speed);

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
