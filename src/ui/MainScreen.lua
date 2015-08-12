local Screen = require('lib.screenmanager.Screen');
local Constants = require('src.constants.Constants');
local Game = require('src.Game');

-- ------------------------------------------------
-- Constants
-- ------------------------------------------------

local TILE_SIZE  = Constants.TILE_SIZE;
local TILE_TYPES = Constants.TILE_TYPES;
local TILE_SPRITES = Constants.TILE_SPRITES;
local COLORS = Constants.COLORS;
local FACTIONS = Constants.FACTIONS;
local DIRECTION = Constants.DIRECTION;

-- ------------------------------------------------
-- Module
-- ------------------------------------------------

local MainScreen = {};

-- ------------------------------------------------
-- Constructor
-- ------------------------------------------------

function MainScreen.new()
    local self = Screen.new();

    local game;

    local map;
    local actors;
    local turns;

    local blockingFunction;

    local target;

    -- ------------------------------------------------
    -- Local Functions
    -- ------------------------------------------------

    ---
    -- Draws a sprite at the given position.
    --
    local function drawTile(sprite, x, y, color)
        love.graphics.setColor(color);
        love.graphics.print(sprite, x * TILE_SIZE, y * TILE_SIZE);
        love.graphics.setColor(255, 255, 255, 255);
    end

    ---
    -- Returns the color with which the tile will be drawn.
    -- Visible tiles will be drawn in a bright white, whereas tiles which are
    -- hidden from the player will be dimmed by using a dark grey. If a tile-
    -- hasn't been explored yet it will be hidden completely.
    --
    local function selectTileColor(tile)
        -- Hide unexplored tiles.
        if not tile:isExplored() then
            return COLORS.INVISIBLE;
        end

        -- Dim tiles hidden from the player.
        if not tile:isVisible() then
            return COLORS.DARK_GREY;
        end

        -- Occupied tiles will be invisible.
        if tile:isOccupied() then
            return COLORS.INVISIBLE;
        end

        return COLORS.WHITE;
    end

    local function selectActorColor(actor)
        if actor:attributes():getFaction() == FACTIONS.ALLIED then
            return COLORS.GREEN;
        end
        return COLORS.RED;
    end

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
    -- Returns a sprite based on the tile type.
    --
    local function selectTileSprite(tile)
        local type = tile:getType();
        if type == TILE_TYPES.DOOR then
            if tile:isPassable() then
                return TILE_SPRITES[TILE_TYPES.DOOROPEN];
            else
                return TILE_SPRITES[TILE_TYPES.DOORCLOSED];
            end
        end
        return TILE_SPRITES[type];
    end

    ---
    -- Draws all tiles of the map.
    --
    local function drawMap(map)
        local tiles = map:getTiles();
        for x = 1, #tiles do
            for y = 1, #tiles[x] do
                local tile = tiles[x][y];
                drawTile(selectTileSprite(tile), x, y, selectTileColor(tile));
            end
        end
    end

    local function drawActors(actors)
        for i = 1, #actors do
            local actor = actors[i];
            local tile = actor:getTile();

            if tile:isVisible() then
                drawTile(selectTileSprite(actor), tile:getX(), tile:getY(), selectActorColor(actor));
            end

            -- TODO remove
            love.graphics.print(selectTileSprite(actor), 10, 400 + i * 20)
            love.graphics.print(actor:health():getHealth(), 30, 400 + i * 20)
            love.graphics.rectangle('fill', 50, 400 + i * 20, actors[i]:energy():getEnergy() * 15, 15);
        end
    end

    local function drawHighlight(player)
        if not target then return end

        local tile = player:getTile():getNeighbours()[target];
        love.graphics.setColor(0, 0, 255);
        love.graphics.rectangle('line', tile:getX() * TILE_SIZE, tile:getY() * TILE_SIZE, TILE_SIZE, TILE_SIZE);
        love.graphics.setColor(255, 255, 255);
    end

    -- ------------------------------------------------
    -- Public Functions
    -- ------------------------------------------------

    function self:init()
        game = Game.new();
        game:init();
    end

    function self:draw()
        drawMap(map);
        drawActors(actors);
        drawHighlight(game:getPlayer());

        love.graphics.print(string.format('%.5d', turns), love.graphics.getWidth() - 45, love.graphics.getHeight() - 20);
    end

    function self:update(dt)
        game:update(dt);

        map = game:getMap();
        actors = game:getActors();
        turns = game:getTurns();
    end

    function self:keypressed(key)
        if blockingFunction then
            blockingFunction(key);
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
    end

    return self;
end

return MainScreen;
