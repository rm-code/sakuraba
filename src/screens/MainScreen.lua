local Screen = require('lib.screenmanager.Screen');
local Constants = require('src.Constants');
local Map = require('src.map.Map');
local Player = require('src.entities.Player');
local WalkAction = require('src.entities.actions.WalkAction');

-- ------------------------------------------------
-- Constants
-- ------------------------------------------------

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

    local map;
    local player;

    function self:init()
        map = Map.new();
        map:init();

        player = Player.new(map:getTileAt(2, 2));
    end

    function self:draw()
        map:draw();
        player:draw();
    end

    function self:update(dt)
        if player:getAction() then
            player:getAction():perform();
        end
    end

    function self:keypressed(key)
        if key == 'up' then
            player:setAction(WalkAction.new(DIRECTION.NORTH));
        elseif key == 'down' then
            player:setAction(WalkAction.new(DIRECTION.SOUTH));
        end
        if key == 'left' then
            player:setAction(WalkAction.new(DIRECTION.WEST));
        elseif key == 'right' then
            player:setAction(WalkAction.new(DIRECTION.EAST));
        end
    end

    return self;
end

return MainScreen;
