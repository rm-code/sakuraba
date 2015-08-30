local Constants = require('src.constants.Constants');
local Floor = require('src.map.tiles.Floor');
local Wall  = require('src.map.tiles.Wall');
local Door  = require('src.map.tiles.Door');
local Partition = require('src.map.Partition');

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
    local partitions;
    local rooms;

    -- ------------------------------------------------
    -- Private Functions
    -- ------------------------------------------------

    ---
    -- Updates the tile at the specified position.
    -- @param x
    -- @param y
    -- @param type
    -- @param passable
    local function updateTile(x, y, type, passable)
        local tile = tiles[x][y];
        tile:setType('floor');
        tile:setPassable(true);
    end

    ---
    -- Fills the map grid with actual tiles.
    --
    local function createTiles()
        local tiles = {};

        -- Create tiles.
        for x = 1, GRID_W do
            tiles[x] = {};
            for y = 1, GRID_H do
                tiles[x][y] = Wall.new(x, y);
            end
        end

        return tiles;
    end

    ---
    -- Gives each tile a reference to its neighbours.
    -- @param tiles - The 2d array holding our map.
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

    ---
    -- Splits the map into a BSP tree. The partitions are stored into an array
    -- so they can be easily traversed later on.
    --
    -- @param tiles - The 2d array holding our map.
    --
    local function generateMapPartitions(tiles)
        local partitions = { Partition.new(self, 1, 1, GRID_W, GRID_H) };

        for _ = 1, 6 do
            for i = 1, #partitions do
                local partition = partitions[i];
                -- Only split if the partition doesn't have children yet.
                if not partition:getChildOne() and not partition:getChildTwo() then
                    local one, two = partition:split();
                    partitions[#partitions + 1] = one;
                    partitions[#partitions + 1] = two;
                end
            end
        end

        return partitions;
    end

    ---
    -- Spawns rooms in the partitions of the BSP tree and adds them to an array.
    -- @param partitions - The partitions of our BSP tree.
    --
    local function generateRooms(partitions)
        -- Recursively spawn rooms in their partitions.
        partitions[1]:spawnRooms();

        -- Iterate over all partitions and save the created rooms as an array.
        local rooms = {};
        for i = 1, #partitions do
            local room = partitions[i]:getRoom();
            -- Check if this partition has a room.
            if room then
                rooms[#rooms + 1] = room;
            end
        end
        print('Created ' .. #rooms .. ' rooms');
        return rooms;
    end

    ---
    -- Connect all rooms of our map by spawning corridors. Each room will have
    -- at least one corridor pointing to it. Corridors go from the center of one
    -- room to the center of the second room.
    -- @param rooms - The rooms in our map.
    --
    local function generateCorridors(rooms)
        for i = 1, #rooms do
            local oroom = rooms[i]; -- origin
            local troom;            -- target

            -- Pick a random target room and make sure it isn't the same as the
            -- original room from which we start the corridor.
            repeat
                troom = rooms[love.math.random(1, #rooms)];
            until oroom ~= troom

            -- Corridors will connect the centers of each room.
            local cxo, cyo = oroom:getCenter();
            local cxt, cyt = troom:getCenter();

            -- Get the distance between the centers of both rooms.
            local dx = cxo - cxt;
            local dy = cyo - cyt;

            -- Draw corridor in horitzontal direction.
            if dx < 0 then
                for x = 0, math.abs(dx) do
                    updateTile(cxo + x, cyo, 'floor', true);
                end
            elseif dx > 0 then
                for x = 0, -dx, -1 do
                    updateTile(cxo + x, cyo, 'floor', true);
                end
            end

            -- Draw corridor in vertical direction.
            if dy < 0 then
                for y = 0, math.abs(dy) do
                    updateTile(cxt, cyo + y, 'floor', true);
                end
            elseif dy > 0 then
                for y = 0, -dy, -1 do
                    updateTile(cxt, cyo + y, 'floor', true);
                end
            end
        end
    end

    ---
    -- Saves the whole map to 'map.txt'.
    -- TODO remove
    local function saveMapToFile(tiles)
        love.filesystem.remove('map.txt');
        local file = love.filesystem.newFile('map.txt', 'a');
        for x = 1, #tiles do
            for y = 1, #tiles[x] do
                if tiles[x][y]:getType() == 'floor' then
                    file:write('.');
                elseif tiles[x][y]:getType() == 'wall' then
                    file:write('#');
                end
            end
            file:write('\n');
        end
        file:close();
    end

    -- ------------------------------------------------
    -- Public Functions
    -- ------------------------------------------------

    function self:init()
        tiles = createTiles();
        tiles = addNeighbours(tiles);
        partitions = generateMapPartitions(tiles);
        rooms = generateRooms(partitions);
        generateCorridors(rooms);

        -- TODO remove
        saveMapToFile(tiles);
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

    function self:getRandomRoom()
        return rooms[love.math.random(1, #rooms)];
    end

    return self;
end

return Map;
