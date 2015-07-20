local Screen = require('lib.screenmanager.Screen');
local Map = require('src.map.Map');

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

    function self:draw()
        map:draw();
    end

    return self;
end

return MainScreen;
