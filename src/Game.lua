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
local ItemFactory = require('src.items.ItemFactory');

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
            if actor:getComponent( 'body' ):isDead() then
                -- TODO replace with proper loot system
                local loot = { 'club', 'knife', 'pistol' };
                local rnd = loot[love.math.random( 1, #loot )];
                actor:getTile():addItem( ItemFactory.createItem( rnd ) );
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

        ItemFactory.loadItemTemplates();

        actors = Actors.new(map);
        actors:init();

        turns = 0;

        map:calculateVisibility(actors:getPlayer():getTile());
    end

    function self:processTurn()
        local player = actors:getPlayer();

        -- Process turns until the currently pending action of the player is
        -- correctly performed or cancelled.
        while player:getComponent( 'action' ):hasAction() and not player:getComponent( 'body' ):isDead() do
            for i, actor in ipairs(actors:getActors()) do
                if not actor:getComponent( 'body' ):isDead() then
                    actor:processTurn();
                    actor:getComponent( 'energy' ):grantEnergy();

                    if actor:getComponent( 'action' ):hasAction() and actor:getComponent( 'energy' ):canPerform() then
                        actor:getComponent( 'energy' ):drainEnergy();
                        while true do
                            local success = actor:getComponent( 'action' ):getAction():perform();
                            actor:getComponent( 'action' ):clearAction();

                            -- If the action is invalid we cancel the rest of the turn.
                            -- This will only be done for the player's actions.
                            if not success and actor == player then
                                return;
                            end

                            -- If the action returned an alternative we set it as the
                            -- next action and restart the loop.
                            if type(success) ~= 'boolean' then
                                actor:getComponent( 'action' ):setAction(success);
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
            player:getComponent( 'action' ):setAction(Walk.new(player:getTile():getNeighbours()[arg]));
        elseif msg == 'wait' then
            player:getComponent( 'action' ):setAction(Wait.new());
        elseif msg == 'interact' then
            player:getComponent( 'action' ):setAction(Interact.new(arg));
        elseif msg == 'attack' then
            player:getComponent( 'action' ):setAction(Attack.new(arg));
        elseif msg == 'rangedattack' then
            player:getComponent( 'action' ):setAction(RangedAttack.new(arg));
        elseif msg == 'grab' then
            player:getComponent( 'action' ):setAction(Grab.new());
        elseif msg == 'equip' then
            player:getComponent( 'action' ):setAction(Equip.new(arg));
        elseif msg == 'unequip' then
            player:getComponent( 'action' ):setAction(Unequip.new(arg));
        elseif msg == 'drop' then
            player:getComponent( 'action' ):setAction(DropItem.new(arg));
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
