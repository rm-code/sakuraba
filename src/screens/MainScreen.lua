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
    local actors;

    local currentActor = 1;

    function self:init()
        map = Map.new();
        map:init();

        player = Player.new(map:getTileAt(2, 2));

        actors = {};
        actors[#actors + 1] = player;
    end

    function self:draw()
        map:draw();
        for i = 1, #actors do
            actors[i]:draw();
        end
    end

    function self:update(dt)
        while true do
            local action = actors[currentActor]:getAction();
            if action then
                action:perform();
                currentActor = currentActor == #actors and 1 or currentActor + 1;
            else
                break;
            end
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
