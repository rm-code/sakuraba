local Constants = require('src.constants.Constants');
local Bresenham = require('lib.Bresenham');

-- ------------------------------------------------
-- Constants
-- ------------------------------------------------

local DIRECTION = Constants.DIRECTION;
local COLORS = Constants.COLORS;
local TILE_SIZE  = Constants.TILE_SIZE;

local RANGE_ADJACENT = 1;
local RANGE_COMBAT   = 8; -- TODO base this on player stats

-- ------------------------------------------------
-- Module
-- ------------------------------------------------

local InputHandler = {};

function InputHandler.new(game, inventory)
    local self = {};

    -- ------------------------------------------------
    -- Private Variables
    -- ------------------------------------------------

    local blockingFunction;
    local highlights;

    -- ------------------------------------------------
    -- Private Functions
    -- ------------------------------------------------

    local function modifyInventory(game)
        local player = game:getPlayer();
        local items = player:inventory():getItems();
        local index = 1;

        inventory:setInventorySelection(index);

        return function(key)
            if key == 'up' then
                index = index - 1;
            elseif key == 'down' then
                index = index + 1;
            end

            if index < 1 then
                index = #items;
            elseif index > #items then
                index = 1;
            end

            inventory:setInventorySelection(index);

            if key == 'e' then
                -- Only send the command to the game object if a valid selection was performed.
                if items[index] then
                    game:control('equip', items[index]);
                end

                blockingFunction = nil;
                inventory:setInventorySelection(0);
                return;
            elseif key == 'u' then
                -- Only send the command to the game object if a valid selection was performed.
                if items[index] then
                    game:control('unequip', items[index]);
                end

                blockingFunction = nil;
                inventory:setInventorySelection(0);
                return;
            elseif key == 'escape' then
                blockingFunction = nil;
                inventory:setInventorySelection(0);
                return;
            end
        end
    end

    ---
    -- Returns an anonymous function which blocks the key input until the player
    -- has selected a target tile.
    -- @param game - A reference to the game object.
    -- @param range - The range in which to select the target.
    -- @param msg - The message to send to the game's control function.
    -- @param confirmationKey - The key to confirm the selection.
    --
    local function selectTarget(game, range, msg, confirmationKey)
        local map = game:getMap();
        local player = game:getPlayer();
        local actors = game:getActors();
        local origin = player:getTile();
        local target = origin;
        local direction;

        local actorIndex = 1;

        return function(key)
            if key == 'up' then
                direction = DIRECTION.NORTH;
            elseif key == 'down' then
                direction = DIRECTION.SOUTH;
            elseif key == 'right' then
                direction = DIRECTION.EAST;
            elseif key == 'left' then
                direction = DIRECTION.WEST;
            elseif key == 'tab' then
                -- Cycle through all actors and select them as targets automatially.
                local tmp = actorIndex;
                while true do
                    actorIndex = actorIndex == #actors and 1 or actorIndex + 1;

                    -- Use the actor as a target if it isn't the same as the player,
                    -- is visible and belongs to a hostile faction.
                    local actor = actors[actorIndex];
                    if actor ~= player and
                        actor:getTile():isVisible() and
                        actor:attributes():getFaction() ~= player:attributes():getFaction() then
                            target = actor:getTile();
                            break;
                    end

                    -- Stop the loop when we have iterated over all actors once.
                    if tmp == actorIndex then
                        break;
                    end
                end
            end

            if target:getNeighbours()[direction] then
                target = target:getNeighbours()[direction];
                direction = nil; -- Reset direction for next turn.
            end

            local highlights = {}; -- Reset the previous tile highlights.

            -- Map the line from the origin to the target tile and see if it can
            -- reach it. The line stops if the maximumg range is surpassed, or if
            -- the target lies outside of the grid.
            Bresenham.calculateLine(origin:getX(), origin:getY(),
                    target:getX(), target:getY(),
                    -- Callback for each tile the line visits.
                    function (nx, ny, counter)
                        -- Stop the algorithm if the maximum range is reached.
                        if counter > range then
                            return false;
                        end

                        -- Stop the algorithm if the target tile is not passable.
                        if not map:getTileAt(nx, ny):isPassable() then
                            highlights[#highlights + 1] = { x = nx , y = ny, col = COLORS.RED };
                            return false;
                        end

                        highlights[#highlights + 1] = { x = nx , y = ny, col = COLORS.GREEN };

                        return true;
                    end);

            -- This line makes sure that the target never lies outside of the range specified
            -- for Bresenham's algorithm by (re)setting the target tile to the last valid tile
            -- specified by the line algorithm.
            target = map:getTileAt(highlights[#highlights].x, highlights[#highlights].y);

            if key == confirmationKey then
                -- Only send the command to the game object if a valid selection was performed.
                if target then
                    game:control(msg, target);
                end
                blockingFunction = nil;
                return;
            elseif key == 'escape' then
                blockingFunction = nil;
                return;
            end

            return highlights;
        end
    end

    -- ------------------------------------------------
    -- Public Functions
    -- ------------------------------------------------

    function self:draw()
        if highlights then
            for i = 1, #highlights do
                love.graphics.setColor(highlights[i].col[1], highlights[i].col[2], highlights[i].col[3], 200);
                love.graphics.rectangle('line', highlights[i].x * TILE_SIZE, highlights[i].y * TILE_SIZE, TILE_SIZE, TILE_SIZE);
                love.graphics.setColor(255, 255, 255);
            end
        end
    end

    function self:keypressed(key)
        if blockingFunction then
            highlights = blockingFunction(key);
            return;
        end

        if key == 'up' then
            game:control('walk', DIRECTION.NORTH);
        elseif key == 'down' then
            game:control('walk', DIRECTION.SOUTH);
        elseif key == 'right' then
            game:control('walk', DIRECTION.EAST);
        elseif key == 'left' then
            game:control('walk', DIRECTION.WEST);
        end

        if key == 'return' then
            game:control('wait');
        end

        if key == 'e' then
            blockingFunction = selectTarget(game, 1, 'interact', 'e');
            blockingFunction();
        end

        if key == 'a' then
            blockingFunction = selectTarget(game, 1, 'attack', 'a');
            blockingFunction();
        end

        if key == 'f' then
            blockingFunction = selectTarget(game, 8, 'rangedattack', 'f');
            blockingFunction();
        end

        if key == 'i' then
            blockingFunction = modifyInventory(game);
        end

        if key == 'g' then
            game:control('grab');
        end
    end

    return self;
end

return InputHandler;
