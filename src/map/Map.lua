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

    local tiles;

    local function createTiles()
        local tiles = {};

        -- Create tiles.
        -- TODO use templates
        for x = 1, MAP_WIDTH do
            tiles[x] = {};
            for y = 1, MAP_HEIGHT do
                if x == 1 or x == MAP_WIDTH or y == 1 or y == MAP_HEIGHT then
                    tiles[x][y] = Tile.new(x, y, 'wall');
                else
                    tiles[x][y] = Tile.new(x, y, 'floor');
                end
            end
        end

        -- Give each tile a reference to its neighbours.
        for x = 1, MAP_WIDTH do
            for y = 1, MAP_WIDTH do
                local n, s, e, w;
                if tiles[x][y - 1] then
                    n = tiles[x][y - 1];
                end
                if tiles[x][y + 1] then
                    s = tiles[x][y + 1];
                end
                if tiles[x + 1] and tiles[x + 1][y] then
                    e = tiles[x + 1][y];
                end
                if tiles[x - 1] and tiles[x - 1][y] then
                    w = tiles[x - 1][y];
                end
                tiles[x][y]:setNeighbours(n, s, e, w);
            end
        end

        return tiles;
    end

    function self:init()
        tiles = createTiles();
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

    function self:getTileAt(x, y)
        return tiles[x][y];
    end

    return self;
end

return Map;
