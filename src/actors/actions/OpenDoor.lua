local OpenDoor = {};

function OpenDoor.new(direction)
    local self = {};

    local actor;

    function self:bind(nactor)
        actor = nactor;
    end

    function self:perform()
        actor:action():clearAction();

        local neighbours = actor:getTile():getNeighbours();
        local target = neighbours[direction];
        if target:getType() == 'door' and not target:isPassable() then
            target:open();
            return true;
        end
        return false;
    end

    return self;
end

return OpenDoor;
