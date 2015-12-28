local BaseAction = require('src.actors.actions.BaseAction');
local SwitchPositions = require('src.actors.actions.SwitchPositions');

local Attack = {};

function Attack.new(target)
    local self = BaseAction.new();

    -- ------------------------------------------------
    -- Local Functions
    -- ------------------------------------------------

    local function doesHit(attacker, defender)
        local skill = attacker:attributes():getMeleeSkill();
        local armorRating = defender:attributes():getDexterity() + defender:inventory():getArmorRating();

        local rnd = love.math.random(1, 100);
        if rnd > 95 then
            return false
        elseif rnd <= (skill - armorRating) then
            return true;
        end
        return false;
    end

    local function calculateDamage(attacker, defender)
        local baseDamage = attacker:inventory():getWeapon():getDamage() + attacker:attributes():getStrength() * 0.5;

        -- Reduce damage based on the defender's armor.
        local bodyPart = defender:body():getRandomBodyPart();
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
