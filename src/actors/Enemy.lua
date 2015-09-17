local Walk = require('src.actors.actions.Walk');
local Constants = require('src.constants.Constants');
local Actor = require('src.actors.Actor');
local Weapon = require('src.items.Weapon');
local Armor = require('src.items.Armor');

-- ------------------------------------------------
-- Constants
-- ------------------------------------------------

local TILE_SIZE = Constants.TILE_SIZE;
local DIRECTION = Constants.DIRECTION;
local FACTIONS  = Constants.FACTIONS;

-- ------------------------------------------------
-- Module
-- ------------------------------------------------

local Enemy = {};

function Enemy.new(type, tile)
    local self = Actor.new(type, tile, FACTIONS.ENEMY);

    local armor = Armor.new('cap');
    self:inventory():add(armor);
    self:inventory():equip(armor);

    local armor = Armor.new('gloves');
    self:inventory():add(armor);
    self:inventory():equip(armor);

    local armor = Armor.new('pullover');
    self:inventory():add(armor);
    self:inventory():equip(armor);

    local armor = Armor.new('jeans');
    self:inventory():add(armor);
    self:inventory():equip(armor);

    local armor = Armor.new('boots');
    self:inventory():add(armor);
    self:inventory():equip(armor);

    local path;

    function self:processTurn()
        if path then
            local target = table.remove(path);
            if target then -- TODO fix properly (see https://github.com/rm-code/sakuraba/issues/8)
                self:action():setAction(Walk.new(target));
            end
        end
    end

    local function findIndex(table, val)
        for i = 1, #table do
            if table[i] == val then
                return i;
            end
        end
    end

    local function calculateHeuristic(a, b)
        return math.abs(a:getX() - b:getX()) + math.abs(a:getY() - b:getY());
    end

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

    local function isInList(list, tile)
        for _, node in ipairs(list) do
            if node.tile == tile then
                return node;
            end
        end
        return false;
    end

    function self:getMovementTarget(target)
        local closedList = {};
        local openList = {
            { tile = self:getTile(), cameFrom = nil, g = 0, f = 0 } -- Starting point.
        };

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
                return result;
            end

            for i, tile in pairs(current.tile:getNeighbours()) do
                local g = current.g + 1;
                local f = g + calculateHeuristic(tile, target);

                -- Check if the tile is passable and not in the closed list.
                if tile:isPassable() and not isInList(closedList, tile) then
                    -- Check if the tile is in the open list. If it is not, then
                    -- add it to the open list and proceed. If it already is in
                    -- the open list replace its cost and parent variables.
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

    function self:setPath(npath)
        path = npath;
    end

    return self;
end

return Enemy;
