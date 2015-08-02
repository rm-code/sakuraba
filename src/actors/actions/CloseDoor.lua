local CloseDoor = {};

function CloseDoor.new(direction)
    local self = {};

    local actor;

    function self:bind(nactor)
        actor = nactor;
    end

    function self:perform()
        actor:clearAction();

        local neighbours = actor:getTile():getNeighbours();
        local target = neighbours[direction];
        if target:getId() == 'door' and target:isPassable() then
            target:close();
            return true;
        end
        return false;
    end

    return self;
end

return CloseDoor;