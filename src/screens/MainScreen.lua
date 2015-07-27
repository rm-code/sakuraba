local Screen = require('lib.screenmanager.Screen');
local Game = require('src.Game');

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

    function self:init()
        game = Game.new();
        game:init();
    end

    function self:draw()
        game:draw();
    end

    function self:update(dt)
        game:update(dt);
    end

    function self:keypressed(key)
        game:handleInput(key);
        game:processTurn();
    end

    return self;
end

return MainScreen;
