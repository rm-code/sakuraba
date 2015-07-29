local Tile = require('src.map.Tile');
local Door = require('src.map.Door');

-- ------------------------------------------------
-- Module
-- ------------------------------------------------

local Map = {};

-- ------------------------------------------------
-- Constants
-- ------------------------------------------------

local TEST_MAP = {
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 1, 1, 1, 2, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
};

-- ------------------------------------------------
-- Constructor
-- ------------------------------------------------

function Map.new()
    local self = {};

    local tiles;

    local function createTiles()
        local tiles = {};

        -- Create tiles.
        for x = 1, #TEST_MAP do
            tiles[x] = {};
            for y = 1, #TEST_MAP[x] do
                if TEST_MAP[x][y] == 1 then
                    tiles[x][y] = Tile.new(x, y, 'wall');
                elseif TEST_MAP[x][y] == 0 then
                    tiles[x][y] = Tile.new(x, y, 'floor');
                elseif TEST_MAP[x][y] == 2 then
                    tiles[x][y] = Door.new(x, y);
                end
            end
        end

        -- Give each tile a reference to its neighbours.
        for x = 1, #tiles do
            for y = 1, #tiles[x] do
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
        for x = 1, #tiles do
            for y = 1, #tiles[x] do
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
