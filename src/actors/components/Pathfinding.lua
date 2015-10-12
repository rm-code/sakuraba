local Pathfinding = {};

function Pathfinding.new(actor)
    local self = {};

    local path;

    ---
    -- Searches for a value in a table and returns its index.
    -- @param table - The table to search in.
    -- @param val - The value to find in the table.
    --
    local function findIndex(table, val)
        for i = 1, #table do
            if table[i] == val then
                return i;
            end
        end
    end

    ---
    -- Calculates the manhattan distance between target a and b.
    -- @param a - The target (needs getX and getY methods).
    -- @param b - The target (needs getX and getY methods).
    --
    local function calculateHeuristic(a, b)
        return math.abs(a:getX() - b:getX()) + math.abs(a:getY() - b:getY());
    end

    ---
    -- Gets the next tile with the lowest cost from a list.
    -- Returns the node and the index.
    -- @param list - The list to search through.
    --
    local function getNextTile(list)
        local index, cost;
        for i = 1, #list do
            if not cost or cost > list[i].f then
                cost = list[i].f;
                index = i;
            end
        end
        return list[index], index;
    end

    ---
    -- Checks if a tile is in a list and returns the A* node containing the tile.
    -- @param list - The list to search in.
    -- @param tile - The tile to find in the list.
    --
    local function isInList(list, tile)
        for _, node in ipairs(list) do
            if node.tile == tile then
                return node;
            end
        end
        return false;
    end

    ---
    -- Calculate the A* path from the start to the target.
    --
    function self:calculatePath(target)
        local closedList = {};
        local openList = {
            { tile = actor:getTile(), cameFrom = nil, g = 0, f = 0 } -- Starting point.
        };

        path = nil; -- Remove old path.

        local counter = 0; -- Keeps track of the amount of steps A* has taken.

        while #openList > 0 do
            local current, index = getNextTile(openList);

            -- Saveguard in case the path is too long.
            counter = counter + 1;
            if counter > 100 then return end

            -- Add to closed and remove from open list.
            closedList[#closedList + 1] = current;
            table.remove(openList, index);

            if current.tile == target then
                -- Trace the closed list from the target to the starting point
                -- by going to the parents of each tile in the node.
                local result, parent = { current.tile }, current.cameFrom;
                while parent do
                    result[#result + 1] = parent.tile;
                    parent = parent.cameFrom;
                end
                table.remove(result); -- Remove the last entry since it is the starting tile.
                path = result;
            end

            for i, tile in pairs(current.tile:getNeighbours()) do
                local g = current.g + 1;
                local f = g + calculateHeuristic(tile, target);

                -- Check if the tile is passable and not in the closed list.
                if tile:isPassable() and not isInList(closedList, tile) then
                    -- Check if the tile is the target tile (because the target tile will always
                    -- be occupied by the player). If not, make sure it is not occupied and add
                    -- it to the open list.
                    if tile == target or not tile:isOccupied() then
                        -- Check if the tile is in the open list. If it is not, then
                        -- add it to the open list and proceed. If it already is in
                        -- the open list update its cost and parent values.
                        local visitedNode = isInList(openList, tile);
                        if not visitedNode then
                            openList[#openList + 1] = { tile = tile, cameFrom = current, g = g, f = f };
                        elseif g < visitedNode.g then
                            visitedNode.cameFrom = current;
                            visitedNode.g = g;
                            visitedNode.f = f;
                        end
                    end
                end
            end
        end
    end

    function self:getPath()
        return path;
    end

    return self;
end

return Pathfinding;
