local Screen = require( 'lib.screenmanager.Screen' );
local Constants = require( 'src.constants.Constants' );
local ActorConstants = require( 'src.constants.ActorConstants' );
local InputHandler = require( 'src.ui.InputHandler' );
local InventoryScreen = require( 'src.ui.InventoryScreen' );
local Game = require( 'src.Game' );
local Camera = require( 'lib.Camera' );

-- ------------------------------------------------
-- Constants
-- ------------------------------------------------

local TILE_SIZE   = Constants.TILE_SIZE;
local TILE_TYPES  = Constants.TILE_TYPES;
local ACTOR_TYPES = ActorConstants.ACTOR_TYPES;
local COLORS      = Constants.COLORS;
local FACTIONS    = Constants.FACTIONS;

local TILESET = love.graphics.newImage( 'res/tiles/tileset_16px.png' );
local TILE_SPRITES = {
    ['empty']               = love.graphics.newQuad( 0 * TILE_SIZE, 0 * TILE_SIZE, TILE_SIZE, TILE_SIZE, TILESET:getDimensions() );
    [TILE_TYPES.FLOOR]      = love.graphics.newQuad( 1 * TILE_SIZE, 0 * TILE_SIZE, TILE_SIZE, TILE_SIZE, TILESET:getDimensions() );
    [TILE_TYPES.WALL]       = love.graphics.newQuad( 2 * TILE_SIZE, 0 * TILE_SIZE, TILE_SIZE, TILE_SIZE, TILESET:getDimensions() );
    [TILE_TYPES.DOORCLOSED] = love.graphics.newQuad( 3 * TILE_SIZE, 0 * TILE_SIZE, TILE_SIZE, TILE_SIZE, TILESET:getDimensions() );
    [TILE_TYPES.DOOROPEN]   = love.graphics.newQuad( 4 * TILE_SIZE, 0 * TILE_SIZE, TILE_SIZE, TILE_SIZE, TILESET:getDimensions() );
    [TILE_TYPES.ITEM_STACK] = love.graphics.newQuad( 5 * TILE_SIZE, 0 * TILE_SIZE, TILE_SIZE, TILE_SIZE, TILESET:getDimensions() );
}

local ACTOR_SPRITES = {
    [ACTOR_TYPES.PLAYER] = love.graphics.newQuad( 0 * TILE_SIZE, 8 * TILE_SIZE, TILE_SIZE, TILE_SIZE, TILESET:getDimensions() );
    [ACTOR_TYPES.DOG]    = love.graphics.newQuad( 1 * TILE_SIZE, 8 * TILE_SIZE, TILE_SIZE, TILE_SIZE, TILESET:getDimensions() );
    [ACTOR_TYPES.CAT]    = love.graphics.newQuad( 2 * TILE_SIZE, 8 * TILE_SIZE, TILE_SIZE, TILE_SIZE, TILESET:getDimensions() );
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
    local player;
    local turns;

    local input;

    local camera;

    local spritebatch;

    -- ------------------------------------------------
    -- Local Functions
    -- ------------------------------------------------

    ---
    -- Returns the color with which the tile will be drawn.
    -- Visible tiles will be drawn in a bright white, whereas tiles which are
    -- hidden from the player will be dimmed by using a dark grey. If a tile-
    -- hasn't been explored yet it will be hidden completely.
    --
    local function selectTileColor( tile )
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
            local actor = tile:getActor();
            if actor:getComponent( 'attributes' ):getFaction() == FACTIONS.ALLIED then
                return COLORS.GREEN;
            end
            return COLORS.RED;
        end

        -- Tiles containing items are purple.
        if tile:hasItems() then
            return COLORS.PURPLE;
        end

        return COLORS.WHITE;
    end

    ---
    -- Returns a sprite based on the tile type.
    --
    local function selectTileSprite( tile )
        local type = tile:getType();
        if tile:isVisible() and tile:isOccupied() then
            return ACTOR_SPRITES[tile:getActor():getType()];
        else
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
    end

    local function updateMap( map )
        local tiles = map:getTiles();
        for x = 1, #tiles do
            for y = 1, #tiles[x] do
                local tile = tiles[x][y];

                -- Only update tiles which are marked dirty for updating.
                if tile:isDirty() then
                    spritebatch:setColor( selectTileColor( tile ) );
                    spritebatch:set( tile:getId(), selectTileSprite( tile ), x * TILE_SIZE, y * TILE_SIZE );
                    tile:setDirty( false );
                end
            end
        end
    end

    local function initialiseSpritebatch( spritebatch, map )
        local tiles = map:getTiles();
        for x = 1, #tiles do
            for y = 1, #tiles[x] do
                local id = spritebatch:add( TILE_SPRITES.empty, x * TILE_SIZE, y * TILE_SIZE );
                tiles[x][y]:setId( id );
            end
        end
        print( string.format('Initialised %d tiles.', spritebatch:getCount()) );
    end

    -- ------------------------------------------------
    -- Public Functions
    -- ------------------------------------------------

    function self:init()
        game = Game.new();
        game:init();

        inventory = InventoryScreen.new( game );

        input = InputHandler.new( game, inventory );

        camera = Camera.new();

        map = game:getMap();
        spritebatch = love.graphics.newSpriteBatch( TILESET, map:getTileCount(), 'dynamic' );
        initialiseSpritebatch( spritebatch, map );
    end

    function self:draw()
        camera:attach();
        love.graphics.draw( spritebatch, 0, 0 );
        input:draw();

        camera:detach();

        inventory:draw();
        love.graphics.print( string.format('%.5d', turns), love.graphics.getWidth() - 45, love.graphics.getHeight() - 20 );
    end

    function self:update( dt )
        map = game:getMap();
        turns = game:getTurns();

        updateMap( map );

        -- Track the player's position.
        local px, py = game:getPlayer():getTile():getPosition();
        camera:lookAt( px * TILE_SIZE, py * TILE_SIZE );
    end

    function self:keypressed( key )
        input:keypressed( key );
    end

    return self;
end

return MainScreen;
