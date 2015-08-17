local BaseAction = require('src.actors.actions.BaseAction');
local SwitchPositions = require('src.actors.actions.SwitchPositions');

local Attack = {};

function Attack.new(target)
    local self = BaseAction.new();

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
        local ar = attacker:attributes():getAttackRating();
        local dr = defender:attributes():getDefenseRating();

        if doesHit(ar, dr) then
            local weapon = attacker:inventory():getWeapon();
            defender:health():damage(weapon:getDamage());

            -- TODO remove
            print(attacker:getType() .. ' hit ' .. defender:getType() .. ' with a ' .. weapon:getName() .. ' for ' .. weapon:getDamage() .. ' dmg.');
        end
    end

    -- ------------------------------------------------
    -- Public Functions
    -- ------------------------------------------------

    function self:perform()
        local actor = self:getActor();

        if target:isOccupied() then
            local opponent = target:getActor();
            if opponent:attributes():getFaction() ~= actor:attributes():getFaction() then
                calculateOutcome(actor, opponent);
                return true;
            else
                return SwitchPositions.new(target);
            end
        end
        return false;
    end

    return self;
end

return Attack;
