local Constants = require('src.Constants');
local Map = require('src.map.Map');
local Player = require('src.actors.Player');
local Enemy = require('src.actors.Enemy');
local Ally = require('src.actors.Ally');
local Walk = require('src.actors.actions.Walk');
local Wait = require('src.actors.actions.Wait');
local Interact = require('src.actors.actions.Interact');

-- ------------------------------------------------
-- Constants
-- ------------------------------------------------

local DIRECTION = Constants.DIRECTION;
local ACTOR_TYPES = Constants.ACTOR_TYPES;

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

    -- ------------------------------------------------
    -- Private Functions
    -- ------------------------------------------------

    ---
    -- Removes all dead actors from the game.
    -- We iterate from the top so that we can remove the actor and shift keys
    -- without breaking the iteration. Besides removing each actor from the list
    -- of actors we also have to remove its reference from the tile it last
    -- occupied.
    local function removeDeadActors(actors)
        for i = #actors, 1, -1 do
            local actor = actors[i];
            if actor:health():isDead() then
                actor:getTile():removeActor();
                table.remove(actors, i);
            end
        end
    end

    -- ------------------------------------------------
    -- Public Functions
    -- ------------------------------------------------

    function self:init()
        love.keyboard.setKeyRepeat(true);

        map = Map.new();
        map:init();

        player = Player.new(ACTOR_TYPES.PLAYER, map:getTileAt(26, 2));

        actors = {};
        actors[#actors + 1] =  player;
        actors[#actors + 1] =  Ally.new(ACTOR_TYPES.CAT,     map:getTileAt(26,  6));
        actors[#actors + 1] = Enemy.new(ACTOR_TYPES.GOBLIN,  map:getTileAt( 8,  2));
        actors[#actors + 1] = Enemy.new(ACTOR_TYPES.TROLL,   map:getTileAt( 8,  8));
        actors[#actors + 1] = Enemy.new(ACTOR_TYPES.TURTLE,  map:getTileAt(10, 10));
        actors[#actors + 1] = Enemy.new(ACTOR_TYPES.VAMPIRE, map:getTileAt(12, 12));
        actors[#actors + 1] = Enemy.new(ACTOR_TYPES.TURTLE,  map:getTileAt(18, 18));
        actors[#actors + 1] = Enemy.new(ACTOR_TYPES.GOBLIN,  map:getTileAt(18,  2));

        turns = 0;

        map:calculateVisibility(player:getTile());
    end

    function self:update(dt)
        return;
    end

    function self:processTurn()
        if player:health():isDead() then
            return;
        end

        -- Process turns until the currently pending action of the player is
        -- correctly performed or cancelled.
        while player:action():hasAction() do
            for i, actor in ipairs(actors) do
                if not actor:health():isDead() then
                    actor:update(dt);
                    actor:energy():grantEnergy();

                    if actor:action():hasAction() and actor:energy():canPerform() then
                        actor:energy():drainEnergy();
                        while true do
                            local success = actor:action():getAction():perform();

                            -- If the action is invalid we cancel the rest of the turn.
                            -- This will only be done for the player's actions.
                            if not success and actor == player then
                                return;
                            end

                            -- If the action returned an alternative we set it as the
                            -- next action and restart the loop.
                            if type(success) ~= 'boolean' then
                                actor:action():setAction(success);
                            else
                                break;
                            end
                        end
                    end
                end
            end
            map:resetVisibility();
            map:calculateVisibility(player:getTile());
            turns = turns + 1;
        end

        -- Remove actors which have died during this turn from the game.
        removeDeadActors(actors);
    end

    function self:handleInput(command)
        if command == 'up' then
            player:action():setAction(Walk.new(DIRECTION.NORTH));
        elseif command == 'down' then
            player:action():setAction(Walk.new(DIRECTION.SOUTH));
        end
        if command == 'right' then
            player:action():setAction(Walk.new(DIRECTION.EAST));
        elseif command == 'left' then
            player:action():setAction(Walk.new(DIRECTION.WEST));
        end
        if command == 'return' then
            player:action():setAction(Wait.new());
        end
        if command == 'e' then
            player:action():setAction(Interact.new());
        end
    end

    function self:getMap()
        return map;
    end

    function self:getActors()
        return actors;
    end

    function self:getTurns()
        return turns;
    end

    return self;
end

return Game;
