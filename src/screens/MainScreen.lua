local Screen = require('lib.screenmanager.Screen');
local Map = require('src.map.Map');
local Player = require('src.entities.Player');

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

    function self:keypressed(key)
        if key == 'up' then
            player:move('n');
        elseif key == 'down' then
            player:move('s');
        end
        if key == 'left' then
            player:move('w');
        elseif key == 'right' then
            player:move('e');
        end
    end

    return self;
end

return MainScreen;
