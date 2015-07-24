local Constants = require('src.Constants');

-- ------------------------------------------------
-- Constants
-- ------------------------------------------------

local TILE_SIZE = Constants.TILE_SIZE;

-- ------------------------------------------------
-- Module
-- ------------------------------------------------

local Player = {};

function Player.new(tile)
    local self = {};

    local action;

    function self:update(dt)
        return;
    end

    function self:draw()
        love.graphics.setColor(0, 255, 0);
        love.graphics.print('@', tile:getX() * TILE_SIZE, tile:getY() * TILE_SIZE);
        love.graphics.setColor(255, 255, 255);
    end

    function self:setAction(naction)
        if naction then
            action = naction;
            action:bind(self);
            return;
        end
        action = nil;
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

    return self;
end

return Player;
