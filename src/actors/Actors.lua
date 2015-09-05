local ActorConstants = require('src.constants.ActorConstants');
local Player = require('src.actors.Player');
local Enemy = require('src.actors.Enemy');

-- ------------------------------------------------
-- Constants
-- ------------------------------------------------

local ACTOR_TYPES = ActorConstants.ACTOR_TYPES;

-- ------------------------------------------------
-- Module
-- ------------------------------------------------

local Actors = {};

function Actors.new(map)
    local self = {};

    local player;
    local actors;

    local function createPlayer(map)
        local spawnX, spawnY = map:getRandomRoom():getCenter();
        return Player.new(ACTOR_TYPES.PLAYER, map:getTileAt(spawnX, spawnY));
    end

    local function spawnActors(map, player)
        local actors = { player };
        local count  = 0;
        local tiles  = map:getTiles();

        for x = 1, #tiles do
            for y = 1, #tiles[x] do
                local tile = tiles[x][y];
                if tile:getType() == 'floor' and not tile:isOccupied() then
                    if love.math.random(1, 100) == 100 then
                        actors[#actors + 1] = Enemy.new(ACTOR_TYPES.DOG, tile);
                        count = count + 1;
                    end
                end
            end
        end

        return actors;
    end

    function self:init()
        player = createPlayer(map);
        actors = spawnActors(map, player);
    end

    ---
    -- Removes all dead actors from the game.
    -- We iterate from the top so that we can remove the actor and shift keys
    -- without breaking the iteration. Besides removing each actor from the list
    -- of actors we also have to remove its reference from the tile it last
    -- occupied.
    function self:removeDeadActors()
        for i = #actors, 1, -1 do
            local actor = actors[i];
            if actor:health():isDead() then
                actor:getTile():removeActor();
                table.remove(actors, i);
            end
        end
    end

    function self:getActors()
        return actors;
    end

    function self:getPlayer()
        return player;
    end

    return self;
end

return Actors;
