local WalkAction = require('src.entities.actions.WalkAction');
local Constants = require('src.Constants');

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

-- ------------------------------------------------
-- Module
-- ------------------------------------------------

local Enemy = {};

function Enemy.new(type, tile)
    local self = {};

    local action;
    local energyDelta = TYPES[type].speed;
    local energy = energyDelta;
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

    function self:draw()
        love.graphics.setColor(255, 0, 0);
        love.graphics.print(TYPES[type].sprite, tile:getX() * TILE_SIZE, tile:getY() * TILE_SIZE);
        love.graphics.setColor(255, 255, 255);
    end

    function self:clearAction()
        action = nil;
    end

    function self:grantEnergy()
        energy = energy + energyDelta;
    end

    function self:setAction(naction)
        if naction then
            action = naction;
            action:bind(self);
            return;
        end
    end

    function self:setEnergy(nenergy)
        energy = nenergy;
    end

    function self:setTile(ntile)
        tile = ntile;
    end

    function self:getAction()
        return action;
    end

    function self:getTile()
        return tile;
    end

    function self:getEnergy()
        return energy;
    end

    return self;
end

return Enemy;
