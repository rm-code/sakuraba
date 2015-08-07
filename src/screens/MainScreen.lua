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

    local map;
    local actors;
    local turns;

    function self:init()
        game = Game.new();
        game:init();
    end

    function self:draw()
        map:draw();
        for i = 1, #actors do
            actors[i]:draw();
            -- TODO remove
            love.graphics.rectangle('fill', 30, 400 + i * 20, actors[i]:getEnergy() * 15, 15);
            love.graphics.print(actors[i]:getSprite(), 10, 400 + i * 20)
        end

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
