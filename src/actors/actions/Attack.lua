local BaseAction = require('src.actors.actions.BaseAction');
local SwitchPositions = require('src.actors.actions.SwitchPositions');

local Attack = {};

function Attack.new(target)
    local self = BaseAction.new();

    -- ------------------------------------------------
    -- Local Functions
    -- ------------------------------------------------

    local function doesHit(attacker, defender)
        local skill = attacker:getComponent( 'attributes' ):getMeleeSkill();
        local armorRating = defender:getComponent( 'attributes' ):getDexterity() + defender:getComponent( 'inventory' ):getArmorRating();

        local rnd = love.math.random(1, 100);
        if rnd > 95 then
            return false
        elseif rnd <= (skill - armorRating) then
            return true;
        end
        return false;
    end

    local function calculateDamage(attacker, defender)
        local baseDamage = attacker:getComponent( 'inventory' ):getWeapon():getDamage() + attacker:getComponent( 'attributes' ):getStrength() * 0.5;

        -- Reduce damage based on the defender's armor.
        local bodyPart = defender:getComponent( 'body' ):getRandomBodyPart();
        local dmgResistance = defender:getComponent( 'inventory' ):getArmor(bodyPart):getDamageResistance();
        local adjustedDamage = baseDamage - (baseDamage * (dmgResistance * 0.01));

        return math.max(1, math.floor(adjustedDamage + 0.5));
    end

    local function calculateOutcome(attacker, defender)
        if doesHit(attacker, defender) then
            defender:getComponent( 'body' ):damage(calculateDamage(attacker, defender));
        end
    end

    -- ------------------------------------------------
    -- Public Functions
    -- ------------------------------------------------

    function self:perform()
        local actor = self:getActor();

        if target:isOccupied() then
            local opponent = target:getActor();
            if opponent:getComponent( 'attributes' ):getFaction() ~= actor:getComponent( 'attributes' ):getFaction() then
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
