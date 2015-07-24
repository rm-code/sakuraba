local Screen = require('lib.screenmanager.Screen');
local Map = require('src.map.Map');
local Player = require('src.entities.Player');
local WalkAction = require('src.entities.actions.WalkAction');

-- ------------------------------------------------
-- Module
-- ------------------------------------------------

local MainScreen = {};

-- ------------------------------------------------
-- Constructor
-- ------------------------------------------------

function MainScreen.new()
    local self = Screen.new();

    local map = Map.new();
    map:init();
    local player = Player.new(map:getTileAt(2, 2));

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
            player:setAction(WalkAction.new('n'));
        elseif key == 'down' then
            player:setAction(WalkAction.new('s'));
        end
        if key == 'left' then
            player:setAction(WalkAction.new('w'));
        elseif key == 'right' then
            player:setAction(WalkAction.new('e'));
        end
    end

    return self;
end

return MainScreen;
