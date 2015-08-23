local BaseAction = require('src.actors.actions.BaseAction');

local RangedAttack = {};

function RangedAttack.new(target)
    local self = BaseAction.new();

    -- ------------------------------------------------
    -- Local Functions
    -- ------------------------------------------------

    local function doesHit(attacker, defender)
        local skill = attacker:attributes():getRangedSkill();
        local dex = attacker:attributes():getDexterity();

        local ax, ay = attacker:getTile():getPosition();
        local bx, by = defender:getTile():getPosition();
        local dx, dy = ax - bx, ay - by;
        local distance = math.sqrt(dx * dx + dy * dy);

        -- Forumla: BaseSkill - (30% of BaseSkill) + (8% for each point of (dexterity / 2)) - (2% per distance).
        local attackRating = skill - (skill * 0.3) + (dex * 0.5 * 8) - (distance * 2);
        attackRating = math.floor(attackRating + 0.5);

        local rnd = love.math.random(1, 100);
        if rnd < attackRating then
            return true;
        end
        return false;
    end

    local function calculateDamage(attacker, defender)
        local baseDamage = attacker:inventory():getWeapon():getDamage();
        local bodyPart = defender:inventory():getRandomBodyPart();
        local dmgResistance = defender:inventory():getArmor(bodyPart):getDamageResistance();

        local adjustedDamage = baseDamage - (baseDamage * (dmgResistance * 0.01));

        return math.max(1, math.floor(adjustedDamage + 0.5));
    end

    local function calculateOutcome(attacker, defender)
        if doesHit(attacker, defender) then
            defender:health():damage(calculateDamage(attacker, defender));
        end
    end

    -- ------------------------------------------------
    -- Public Functions
    -- ------------------------------------------------

    function self:perform()
        local actor = self:getActor();

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
