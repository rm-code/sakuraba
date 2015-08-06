local SwitchPositions = require('src.actors.actions.SwitchPositions');

local Attack = {};

function Attack.new(direction)
    local self = {};

    local actor;

    -- ------------------------------------------------
    -- Local Functions
    -- ------------------------------------------------

    local function doesHit(ar, dr)
        -- Roll 3d6.
        local rnd = 3 * love.math.random(1, 6);
        if ar < dr * 0.5 then
            return rnd > 14;
        elseif ar < dr then
            return rnd > 11;
        elseif ar == dr then
            return rnd > 8;
        elseif ar > dr then
            return rnd > 4;
        end
    end

    local function calculateOutcome(attacker, defender)
        local ar = attacker:getAttackRating();
        local dr = defender:getDefenseRating();

        if doesHit(ar, dr) then
            defender:damage(4);
            print(attacker:getType() .. ' hits ' .. defender:getType());
            return;
        end
        print(attacker:getType() .. ' misses ' .. defender:getType());
        return;
    end

    -- ------------------------------------------------
    -- Public Functions
    -- ------------------------------------------------

    function self:bind(nactor)
        actor = nactor;
    end

    function self:perform()
        actor:clearAction();

        local neighbours = actor:getTile():getNeighbours();
        local target = neighbours[direction];
        if target:isOccupied() then
            local opponent = target:getActor();
            if opponent:getFaction() ~= actor:getFaction() then
                calculateOutcome(actor, opponent);
                return true;
            else
                return SwitchPositions.new(direction);
            end
        end
        return false;
    end

    return self;
end

return Attack;
