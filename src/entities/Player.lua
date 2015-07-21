local Constants = require('src.Constants');

-- ------------------------------------------------
-- Constants
-- ------------------------------------------------

local TILE_SIZE = Constants.TILE_SIZE;

-- ------------------------------------------------
-- Module
-- ------------------------------------------------

local Player = {};

function Player.new(x, y)
    local self = {};

    function self:draw()
        love.graphics.setColor(0, 255, 0);
        love.graphics.rectangle('fill', x * TILE_SIZE, y * TILE_SIZE, TILE_SIZE, TILE_SIZE);
        love.graphics.setColor(255, 255, 255);
    end

    return self;
end

return Player;
