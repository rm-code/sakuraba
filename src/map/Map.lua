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
    -- Initialise the tile grid and fill it with placeholder chars for walls.
    --
    local function initialiseGrid()
        local tiles = {};

        for x = 1, GRID_W do
            tiles[x] = {};
            for y = 1, GRID_H do
                tiles[x][y] = '#';
            end
        end

        return tiles;
    end

    local function createTiles(tiles)
        for x = 1, #tiles do
            for y = 1, #tiles[x] do
                local tile = tiles[x][y];
                if tile == '#' then
                    tiles[x][y] = Wall.new(x, y);
                elseif tile == '.' then
                    tiles[x][y] = Floor.new(x, y);
                elseif tile == '>' then
                    tiles[x][y] = Floor.new(x, y);
                elseif tile == '/' then
                    tiles[x][y] = Door.new(x, y);
                end
            end
        end
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
    end

    ---
    -- Splits the map into a BSP tree. The partitions are stored into an array
    -- so they can be easily traversed later on.
    --
    -- @param tiles - The 2d array holding our map.
    --
    local function generateMapPartitions(tiles)
        local partitions = { Partition.new(1, 1, GRID_W, GRID_H) };

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
                -- Map the room's blueprint to the tile grid.
                local rx, ry = room:getPosition();
                local rw, rh = room:getDimensions();
                for ix = rx, rx + rw do
                    for iy = ry, ry + rh do
                        tiles[ix][iy] = '.';
                    end
                end
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
                    if tiles[cxo + x][cyo] ~= '.' then
                        tiles[cxo + x][cyo] = '>';
                    end
                end
            elseif dx > 0 then
                for x = 0, -dx, -1 do
                    if tiles[cxo + x][cyo] ~= '.' then
                        tiles[cxo + x][cyo] = '>';
                    end
                end
            end

            -- Draw corridor in vertical direction.
            if dy < 0 then
                for y = 0, math.abs(dy) do
                    if tiles[cxt][cyo + y] ~= '.' then
                        tiles[cxt][cyo + y] = '>';
                    end
                end
            elseif dy > 0 then
                for y = 0, -dy, -1 do
                    if tiles[cxt][cyo + y] ~= '.' then
                        tiles[cxt][cyo + y] = '>';
                    end
                end
            end
        end
    end

    local function cleanUpMap(tiles)
        local counter = 0;
        for x = 1, #tiles do
            for y = 1, #tiles[x] do
                local n, s, e, w = tiles[x][y - 1], tiles[x][y + 1], tiles[x - 1] and tiles[x - 1][y], tiles[x + 1] and tiles[x + 1][y];
                if tiles[x][y] == '#' then
                    if n and s and n == '.' and s == '.' then
                        tiles[x][y] = '.';
                        counter = counter + 1;
                    elseif e and w and e == '.' and w == '.' then
                        tiles[x][y] = '.';
                        counter = counter + 1;
                    elseif n and s and n == '>' and s == '>' then
                        tiles[x][y] = '>';
                        counter = counter + 1;
                    elseif e and w and e == '>' and w == '>' then
                        tiles[x][y] = '>';
                        counter = counter + 1;
                    end
                end
            end
        end
        print('Cleaned up ' .. counter .. ' tiles');
    end

    ---
    -- Spawns doors across the map under the following conditions:
    -- The tile has to be a corridor tile. It has to have two opposing wall
    -- tiles either and an opposing floor and corridor tile.
    --  E.g.:
    --   #>#    ##.
    --   #>#    >>.
    --   ...    ##.
    --
    local function spawnDoors(tiles)
        local count = 0;
        for x = 1, #tiles do
            for y = 1, #tiles[x] do
                local n, s, e, w = tiles[x][y - 1], tiles[x][y + 1], tiles[x - 1] and tiles[x - 1][y], tiles[x + 1] and tiles[x + 1][y];
                if tiles[x][y] == '>' then
                    if (e == '#' and w == '#') and (n == '>' and s == '.')
                        or (e == '#' and w == '#') and (n == '.' and s == '>')
                        or (e == '>' and w == '.') and (n == '#' and s == '#')
                        or (e == '.' and w == '>') and (n == '#' and s == '#') then
                            if love.math.random(1, 100) < 60 then
                                tiles[x][y] = '/';
                                count = count + 1;
                            end
                    end
                end
            end
        end
        print('Created ' .. count .. ' doors');
    end

    ---
    -- Saves the whole map to 'map.txt'.
    -- TODO remove
    local function saveMapToFile(tiles)
        love.filesystem.remove('map.txt');
        local file = love.filesystem.newFile('map.txt', 'a');
        for x = 1, #tiles do
            for y = 1, #tiles[x] do
                file:write(tiles[x][y]);
            end
            file:write('\n');
        end
        file:close();
    end

    -- ------------------------------------------------
    -- Public Functions
    -- ------------------------------------------------

    function self:init()
        tiles = initialiseGrid();
        partitions = generateMapPartitions(tiles);
        rooms = generateRooms(partitions);
        generateCorridors(rooms);
        cleanUpMap(tiles);
        spawnDoors(tiles)

        -- TODO remove
        saveMapToFile(tiles);

        createTiles(tiles);
        addNeighbours(tiles);
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
