local Screen = require('lib.screenmanager.Screen');
local Constants = require('src.Constants');
local Game = require('src.Game');

-- ------------------------------------------------
-- Constants
-- ------------------------------------------------

local TILE_SIZE  = Constants.TILE_SIZE;
local TILE_TYPES = Constants.TILE_TYPES;
local TILE_SPRITES = Constants.TILE_SPRITES;

local FACTIONS = Constants.FACTIONS;

local COLORS = {
    INVISIBLE = {   0,   0,   0,   0 },
    WHITE     = { 255, 255, 255, 255 },
    DARK_GREY = {  50,  50,  50, 255 },
    RED       = { 255,   0,   0, 255 },
    GREEN     = {   0, 255,   0, 255 },
}

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

    function selectActorColor(actor)
        if actor:getFaction() == FACTIONS.ALLIED then
            return COLORS.GREEN;
        end
        return COLORS.RED;
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
            love.graphics.rectangle('fill', 30, 400 + i * 20, actors[i]:getEnergy() * 15, 15);
            love.graphics.print(selectTileSprite(actor), 10, 400 + i * 20)
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
        drawActors(actors);

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
