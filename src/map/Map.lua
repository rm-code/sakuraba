local Constants = require('src.Constants');
local Tile = require('src.map.Tile');

-- ------------------------------------------------
-- Module
-- ------------------------------------------------

local Map = {};

-- ------------------------------------------------
-- Constants
-- ------------------------------------------------

local MAP_WIDTH  = Constants.MAP_WIDTH;
local MAP_HEIGHT = Constants.MAP_HEIGHT;

-- ------------------------------------------------
-- Constructor
-- ------------------------------------------------

function Map.new()
    local self = {};

    local tiles = {};
    for x = 1, MAP_WIDTH do
        tiles[x] = {};
        for y = 1, MAP_HEIGHT do
            tiles[x][y] = Tile.new(x, y);
        end
    end

    function self:update(dt)
    end

    function self:draw()
        for x = 1, MAP_WIDTH do
            for y = 1, MAP_HEIGHT do
                tiles[x][y]:draw();
            end
        end
    end

    return self;
end

return Map;
