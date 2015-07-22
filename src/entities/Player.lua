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

    local x, y = tile:getPosition();

    function self:draw()
        love.graphics.setColor(0, 255, 0);
        love.graphics.rectangle('fill', x * TILE_SIZE, y * TILE_SIZE, TILE_SIZE, TILE_SIZE);
        love.graphics.setColor(255, 255, 255);
    end

    function self:move(direction)
        local neighbours = tile:getNeighbours();
        if neighbours[direction] and neighbours[direction]:isPassable() then
            tile = neighbours[direction];
            x, y = tile:getPosition();
        end
    end

    return self;
end

return Player;
