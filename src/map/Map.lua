local Constants = require('src.constants.Constants');
local Floor = require('src.map.tiles.Floor');
local Wall  = require('src.map.tiles.Wall');
local Door  = require('src.map.tiles.Door');

-- ------------------------------------------------
-- Module
-- ------------------------------------------------

local Map = {};

-- ------------------------------------------------
-- Constants
-- ------------------------------------------------

local TILE_SIZE = Constants.TILE_SIZE;
local GRID_W = 200;
local GRID_H = 200;

-- ------------------------------------------------
-- Constructor
-- ------------------------------------------------

function Map.new()
    local self = {};

    local tiles;

    -- ------------------------------------------------
    -- Private Functions
    -- ------------------------------------------------

    ---
    -- Fills the map grid with actual tiles.
    --
    local function createTiles()
        local tiles = {};

        -- Create tiles.
        for x = 1, GRID_W do
            tiles[x] = {};
            for y = 1, GRID_H do
                if x == 1 or x == GRID_W or y == 1 or y == GRID_H then
                    tiles[x][y] = Wall.new(x, y);
                else
                    tiles[x][y] = Floor.new(x, y);
                end
            end
        end

        return tiles;
    end

    ---
    -- Gives each tile a reference to its neighbours.
    --
    local function addNeighbours(tiles)
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

    -- ------------------------------------------------
    -- Public Functions
    -- ------------------------------------------------

    function self:init()
        tiles = createTiles();
        tiles = addNeighbours(tiles);
    end

    function self:update(dt)
        return;
    end

    ---
    -- Resets the visibility flags for all visible tiles in the map.
    --
    function self:resetVisibility()
        for x = 1, #tiles do
            for y = 1, #tiles[x] do
                local tile = tiles[x][y];
                if tile:isVisible() then
                    tile:setVisible(false);
                    tile:setDirty(true); -- Mark tile for updating.
                end
            end
        end
    end

    ---
    -- Cast rays in a 360° radius.
    --
    function self:calculateVisibility(tile)
        local tx, ty = tile:getPosition();

        for i = 1, 360 do
            local ox, oy = tx + 0.5, ty + 0.5;
            local rad = math.rad(i);
            local rx, ry = math.cos(rad), math.sin(rad);

            for i = 1, 12 do
                local target = tiles[math.floor(ox)][math.floor(oy)];
                target:setVisible(true);
                target:setExplored(true);
                target:setDirty(true); -- Mark tile for updating.
                if not target:isPassable() then
                    break;
                end
                ox = ox + rx;
                oy = oy + ry;
            end
        end
    end

    -- ------------------------------------------------
    -- Getters
    -- ------------------------------------------------

    function self:getTileAt(x, y)
        return tiles[x][y];
    end

    function self:getTileCount()
        local count = 0;
        for x = 1, #tiles do
            for y = 1, #tiles[x] do
                count = count + 1;
            end
        end
        return count;
    end

    function self:getTiles()
        return tiles;
    end

    return self;
end

return Map;
