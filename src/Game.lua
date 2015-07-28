local Constants = require('src.Constants');
local Map = require('src.map.Map');
local Player = require('src.entities.Player');
local Enemy = require('src.entities.Enemy');
local WalkAction = require('src.entities.actions.WalkAction');

-- ------------------------------------------------
-- Constants
-- ------------------------------------------------

local DIRECTION = Constants.DIRECTION;
local ENERGY_THRESHOLD = Constants.ENERGY_THRESHOLD;

-- ------------------------------------------------
-- Module
-- ------------------------------------------------

local Game = {};

-- ------------------------------------------------
-- Constructor
-- ------------------------------------------------

function Game.new()
    local self = {};

    local map;
    local player;
    local actors;
    local turns;

    function self:init()
        map = Map.new();
        map:init();

        player = Player.new(map:getTileAt(2, 2));

        actors = {};
        actors[#actors + 1] = player;
        actors[#actors + 1] = Enemy.new('goblin', map:getTileAt(8, 2));
        actors[#actors + 1] = Enemy.new('troll', map:getTileAt(8, 8));
        actors[#actors + 1] = Enemy.new('turtle', map:getTileAt(10, 10));
        actors[#actors + 1] = Enemy.new('vampire', map:getTileAt(12, 12));

        turns = 0;
    end

    function self:draw()
        map:draw();
        for i = 1, #actors do
            actors[i]:draw();
        end

        love.graphics.print(string.format('%.5d', turns), love.graphics.getWidth() - 45, love.graphics.getHeight() - 20);
    end

    function self:update(dt)
        -- Wait for player input before advancing a turn.
        if not player:hasAction() then
            return
        end

        for i, actor in ipairs(actors) do
            actor:update(dt);

            local action = actor:getAction();
            if actor:getEnergy() >= ENERGY_THRESHOLD then
                local success = action:perform();
                if not success then return end
                actor:setEnergy(actor:getEnergy() - ENERGY_THRESHOLD);
            end
            actor:grantEnergy();
        end

        turns = turns + 1;
    end

    function self:handleInput(command)
        if command == 'up' then
            player:setAction(WalkAction.new(DIRECTION.NORTH));
        elseif command == 'down' then
            player:setAction(WalkAction.new(DIRECTION.SOUTH));
        end
        if command == 'right' then
            player:setAction(WalkAction.new(DIRECTION.EAST));
        elseif command == 'left' then
            player:setAction(WalkAction.new(DIRECTION.WEST));
        end
    end

    return self;
end

return Game;
