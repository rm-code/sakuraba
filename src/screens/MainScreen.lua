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
    local player = Player.new(2, 2);

    function self:draw()
        map:draw();
        player:draw();
    end

    return self;
end

return MainScreen;
