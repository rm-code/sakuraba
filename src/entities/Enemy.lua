local WalkAction = require('src.entities.actions.WalkAction');
local Constants = require('src.Constants');
local Entity = require('src.entities.Entity');

-- ------------------------------------------------
-- Constants
-- ------------------------------------------------

local TILE_SIZE = Constants.TILE_SIZE;
local DIRECTION = Constants.DIRECTION;
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
    local self = Entity.new(tile, TYPES[type].sprite, COLOR, TYPES[type].speed);

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
        self:setAction(WalkAction.new(prevDirection));
    end

    return self;
end

return Enemy;
