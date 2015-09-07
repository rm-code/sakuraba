local Map = require('src.map.Map');
local Actors = require('src.actors.Actors');
local Walk = require('src.actors.actions.Walk');
local Wait = require('src.actors.actions.Wait');
local Interact = require('src.actors.actions.Interact');
local Attack = require('src.actors.actions.Attack');
local RangedAttack = require('src.actors.actions.RangedAttack');
local Grab = require('src.actors.actions.Grab');
local Equip = require('src.actors.actions.Equip');
local Unequip = require('src.actors.actions.Unequip');
local DropItem = require('src.actors.actions.DropItem');
local Weapon = require('src.items.Weapon');

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
    local actors;
    local turns;

    -- ------------------------------------------------
    -- Private Functions
    -- ------------------------------------------------

    ---
    -- Create items on the tiles actors have died on during the turn.
    --
    local function spawnItems(actors)
        for i = 1, #actors do
            local actor = actors[i];
            if actor:health():isDead() then
                -- TODO replace with proper loot system
                local loot = { 'knife', 'sword', 'bow', 'crossbow' };
                local rnd = loot[love.math.random(1, #loot)];
                actor:getTile():addItem(Weapon.new(rnd));
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

        actors = Actors.new(map);
        actors:init();

        turns = 0;

        map:calculateVisibility(actors:getPlayer():getTile());
    end

    function self:processTurn()
        local player = actors:getPlayer();

        -- Process turns until the currently pending action of the player is
        -- correctly performed or cancelled.
        while player:action():hasAction() and not player:health():isDead() do
            for i, actor in ipairs(actors:getActors()) do
                if not actor:health():isDead() then
                    actor:processTurn();
                    actor:energy():grantEnergy();

                    if actor:action():hasAction() and actor:energy():canPerform() then
                        actor:energy():drainEnergy();
                        while true do
                            local success = actor:action():getAction():perform();
                            actor:action():clearAction();

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

        actors:checkPathfinding();

        -- Spawn items where actors have died.
        spawnItems(actors:getActors());

        -- Remove actors which have died during this turn from the game.
        actors:removeDeadActors();
    end

    function self:control(msg, arg)
        local player = actors:getPlayer();

        if msg == 'walk' then
            player:action():setAction(Walk.new(player:getTile():getNeighbours()[arg]));
        elseif msg == 'wait' then
            player:action():setAction(Wait.new());
        elseif msg == 'interact' then
            player:action():setAction(Interact.new(arg));
        elseif msg == 'attack' then
            player:action():setAction(Attack.new(arg));
        elseif msg == 'rangedattack' then
            player:action():setAction(RangedAttack.new(arg));
        elseif msg == 'grab' then
            player:action():setAction(Grab.new());
        elseif msg == 'equip' then
            player:action():setAction(Equip.new(arg));
        elseif msg == 'unequip' then
            player:action():setAction(Unequip.new(arg));
        elseif msg == 'drop' then
            player:action():setAction(DropItem.new(arg));
        end

        -- Process the next turn and return control back to the player at the end.
        self:processTurn();
    end

    function self:getMap()
        return map;
    end

    function self:getActors()
        return actors:getActors();
    end

    function self:getPlayer()
        return actors:getPlayer();
    end

    function self:getTurns()
        return turns;
    end

    return self;
end

return Game;
