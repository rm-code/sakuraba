local Constants = require('src.constants.Constants');

-- ------------------------------------------------
-- Constants
-- ------------------------------------------------

local DIRECTION = Constants.DIRECTION;
local COLORS = Constants.COLORS;
local TILE_SIZE  = Constants.TILE_SIZE;

-- ------------------------------------------------
-- Module
-- ------------------------------------------------

local InputHandler = {};

function InputHandler.new(game)
    local self = {};

    -- ------------------------------------------------
    -- Private Variables
    -- ------------------------------------------------

    local blockingFunction;

    local target;
    local points = {};

    -- ------------------------------------------------
    -- Private Functions
    -- ------------------------------------------------

    ---
    -- Returns an anonymous function which blocks the key input until the player
    -- has selected a target tile.
    -- @param game - A reference to the game object.
    -- @param msg - The message to send to the game's control function.
    -- @param confirmationKey - The key to confirm the selection.
    --
    local function selectTarget(game, msg, confirmationKey)
        local player = game:getPlayer();
        local tile = player:getTile();

        return function(key)
            if key == 'up' then
                target = DIRECTION.NORTH;
            elseif key == 'down' then
                target = DIRECTION.SOUTH;
            elseif key == 'right' then
                target = DIRECTION.EAST;
            elseif key == 'left' then
                target = DIRECTION.WEST;
            end

            if key == confirmationKey then
                -- Don't send the command to the game object if no target
                -- selection was performed.
                if target then
                    game:control(msg, target);
                end
                blockingFunction = nil;
                target = nil;
            elseif key == 'escape' then
                blockingFunction = nil;
                target = nil;
            end
        end
    end

    ---
    -- Bresenham!
    --
    local function calcPoints(ox, oy, ex, ey, callback)
        if not callback then return end

        local dx = math.abs(ex - ox);
        local dy = math.abs(ey - oy) * -1;

        local sx = ox < ex and 1 or -1;
        local sy = oy < ey and 1 or -1;
        local err = dx + dy;

        local counter = 0;
        while true do
            counter = counter + 1;
            local continue = callback(ox, oy, counter);

            if not continue then
                return;
            end

            if ox == ex and oy == ey then
                return;
            end

            local tmpErr = 2 * err;
            if tmpErr > dy then
                err = err + dy;
                ox = ox + sx;
            end
            if tmpErr < dx then
                err = err + dx;
                oy = oy + sy;
            end
        end
    end

    ---
    -- Returns an anonymous function which blocks the key input until the player
    -- has selected a target tile.
    -- @param game - A reference to the game object.
    -- @param msg - The message to send to the game's control function.
    -- @param confirmationKey - The key to confirm the selection.
    --
    local function selectRangedTarget(game, msg, confirmationKey)
        local map = game:getMap();
        local player = game:getPlayer();
        local origin = player:getTile();
        local target = origin;

        return function(key)
            if key == 'up' then
                target = target:getNeighbours()[DIRECTION.NORTH] or target;
            elseif key == 'down' then
                target = target:getNeighbours()[DIRECTION.SOUTH] or target;
            elseif key == 'right' then
                target = target:getNeighbours()[DIRECTION.EAST] or target;
            elseif key == 'left' then
                target = target:getNeighbours()[DIRECTION.WEST] or target;
            end

            local line = {};
            calcPoints(origin:getX(), origin:getY(), target:getX(), target:getY(), function (nx, ny, counter)
                    if counter > 8 then
                        return false;
                    end
                    if not map:getTileAt(nx, ny):isPassable() then
                        line[#line + 1] = { x = nx , y = ny, col = COLORS.RED };
                        return false;
                    end

                    line[#line + 1] = { x = nx , y = ny, col = COLORS.GREEN };

                    return true;
                end);

            if key == confirmationKey then
                -- Don't send the command to the game object if no target
                -- selection was performed.
                if target then
                    game:control(msg, target);
                end
                blockingFunction = nil;
                target = nil;
                return;
            elseif key == 'escape' then
                blockingFunction = nil;
                target = nil;
                return;
            end

            return line;
        end
    end

    -- ------------------------------------------------
    -- Public Functions
    -- ------------------------------------------------

    function self:draw()
        if target then
            local tile = game:getPlayer():getTile():getNeighbours()[target];
            love.graphics.setColor(0, 0, 255);
            love.graphics.rectangle('line', tile:getX() * TILE_SIZE, tile:getY() * TILE_SIZE, TILE_SIZE, TILE_SIZE);
            love.graphics.setColor(255, 255, 255);
        end

        -- TODO remove
        if points then
            for i = 1, #points do
                love.graphics.setColor(points[i].col[1], points[i].col[2], points[i].col[3], 200);
                love.graphics.rectangle('line', points[i].x * TILE_SIZE, points[i].y * TILE_SIZE, TILE_SIZE, TILE_SIZE);
                love.graphics.setColor(255, 255, 255);
            end
        end
    end

    function self:keypressed(key)
        if blockingFunction then
            points = blockingFunction(key);
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
            blockingFunction = selectTarget(game, 'interact', 'e');
        end

        if key == 'a' then
            blockingFunction = selectTarget(game, 'attack', 'a');
        end

        if key == 'f' then
            blockingFunction = selectRangedTarget(game, 'rangedattack', 'f');
        end
    end

    return self;
end

return InputHandler;
