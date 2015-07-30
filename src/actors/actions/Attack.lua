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
            target:getActor():kill();
            return true;
        end
        return false;
    end

    return self;
end

return Attack;
