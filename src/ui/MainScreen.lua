local Screen = require('lib.screenmanager.Screen');
local Constants = require('src.constants.Constants');
local Actors = require('src.constants.Actors');
local InputHandler = require('src.ui.InputHandler');
local InventoryScreen = require('src.ui.InventoryScreen');
local Game = require('src.Game');
local Camera = require('lib.Camera');

-- ------------------------------------------------
-- Constants
-- ------------------------------------------------

local TILE_SIZE  = Constants.TILE_SIZE;
local TILE_TYPES = Constants.TILE_TYPES;
local TILE_SPRITES = Constants.TILE_SPRITES;
local ACTOR_SPRITES = Actors.ACTOR_SPRITES;
local COLORS = Constants.COLORS;
local FACTIONS = Constants.FACTIONS;

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
    local player;
    local turns;

    local input;

    local camera;

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

        -- Tiles containing items are purple.
        if tile:hasItems() then
            return COLORS.PURPLE;
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
        elseif tile:hasItems() then
            return TILE_SPRITES[TILE_TYPES.ITEM_STACK];
        end
        return TILE_SPRITES[type];
    end

    ---
    -- Returns a sprite for actors based on their type.
    --
    local function selectActorSprite(actor)
        return ACTOR_SPRITES[actor:getType()];
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
                drawTile(selectActorSprite(actor), tile:getX(), tile:getY(), selectActorColor(actor));
            end
        end
    end

    -- ------------------------------------------------
    -- Public Functions
    -- ------------------------------------------------

    function self:init()
        game = Game.new();
        game:init();

        inventory = InventoryScreen.new(game);

        input = InputHandler.new(game, inventory);

        camera = Camera.new();
    end

    function self:draw()
        camera:attach();
        drawMap(map);
        drawActors(actors);
        input:draw();
        camera:detach();

        inventory:draw();
        love.graphics.print(string.format('%.5d', turns), love.graphics.getWidth() - 45, love.graphics.getHeight() - 20);
    end

    function self:update(dt)
        game:update(dt);

        map = game:getMap();
        actors = game:getActors();
        turns = game:getTurns();

        -- Track the player's position.
        local px, py = game:getPlayer():getTile():getPosition();
        camera:lookAt(px * TILE_SIZE, py * TILE_SIZE);
    end

    function self:keypressed(key)
        input:keypressed(key);
    end

    return self;
end

return MainScreen;
