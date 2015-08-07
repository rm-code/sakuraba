local Screen = require('lib.screenmanager.Screen');
local Constants = require('src.Constants');
local Game = require('src.Game');

-- ------------------------------------------------
-- Constants
-- ------------------------------------------------

local TILE_SIZE  = Constants.TILE_SIZE;
local TILE_TYPES = Constants.TILE_TYPES;

local COLORS = {
    INVISIBLE = { 0, 0, 0, 0 },
    WHITE = { 255, 255 , 255, 255 },
    DARK_GREY = { 50, 50, 50, 255 },
}

local SPRITES = {
    floor = '.',
    wall = '#',
    doorclosed = '/',
    dooropen = 'O',
};

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

    -- ------------------------------------------------
    -- Local Functions
    -- ------------------------------------------------

    ---
    -- Draws a sprite at the given position.
    --
    local function drawTile(sprite, x, y)
        love.graphics.print(sprite, x * TILE_SIZE, y * TILE_SIZE);
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

    ---
    -- Returns a sprite based on the tile type.
    --
    local function selectTileSprite(tile)
        local type = tile:getType();
        if type == TILE_TYPES.DOOR then
            if tile:isPassable() then
                return SPRITES['dooropen'];
            else
                return SPRITES['doorclosed'];
            end
        end
        return SPRITES[type];
    end

    ---
    -- Draws all tiles of the map.
    --
    local function drawMap(map)
        local tiles = map:getTiles();
        for x = 1, #tiles do
            for y = 1, #tiles[x] do
                local tile = tiles[x][y];
                love.graphics.setColor(selectTileColor(tile));
                drawTile(selectTileSprite(tile), x, y);
                love.graphics.setColor(255, 255, 255, 255);
            end
        end
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

        for i = 1, #actors do
            actors[i]:draw();
            -- TODO remove
            love.graphics.rectangle('fill', 30, 400 + i * 20, actors[i]:getEnergy() * 15, 15);
            love.graphics.print(actors[i]:getSprite(), 10, 400 + i * 20)
        end

        love.graphics.print(string.format('%.5d', turns), love.graphics.getWidth() - 45, love.graphics.getHeight() - 20);
    end

    function self:update(dt)
        game:update(dt);

        map = game:getMap();
        actors = game:getActors();
        turns = game:getTurns();
    end

    function self:keypressed(key)
        game:handleInput(key);
        game:processTurn();
    end

    return self;
end

return MainScreen;
