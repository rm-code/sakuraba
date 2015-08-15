local RangedAttack = {};

function RangedAttack.new(target)
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
        local ar = attacker:attributes():getAttackRating();
        local dr = defender:attributes():getDefenseRating();

        if doesHit(ar, dr) then
            defender:health():damage(4);
            return;
        end
        return;
    end

    -- ------------------------------------------------
    -- Public Functions
    -- ------------------------------------------------

    function self:bind(nactor)
        actor = nactor;
    end

    function self:perform()
        actor:action():clearAction();

         -- Get the actor standing on the target tile.
        if target:isOccupied() then
            local opponent = target:getActor();
            if opponent:attributes():getFaction() ~= actor:attributes():getFaction() then
                calculateOutcome(actor, opponent);
                return true;
            end
        end
        return false;
    end

    return self;
end

return RangedAttack;
