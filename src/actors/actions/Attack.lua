local SwitchPositions = require('src.actors.actions.SwitchPositions');

local Attack = {};

function Attack.new(direction)
    local self = {};

    local actor;

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
                opponent:setDead(true);
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
