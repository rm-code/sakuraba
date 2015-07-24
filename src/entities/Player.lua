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

    function self:draw()
        love.graphics.setColor(0, 255, 0);
        love.graphics.print('@', tile:getX() * TILE_SIZE, tile:getY() * TILE_SIZE);
        love.graphics.setColor(255, 255, 255);
    end

    function self:move(direction)
        local neighbours = tile:getNeighbours();
        if neighbours[direction] and neighbours[direction]:isPassable() then
            tile = neighbours[direction];
        end
    end

    function self:setTile(ntile)
        tile = ntile;
    end

    function self:getTile()
        return tile;
    end

    return self;
end

return Player;
