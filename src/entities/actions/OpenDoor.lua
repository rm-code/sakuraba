local OpenDoor = {};

function OpenDoor.new(direction)
    local self = {};

    local entity;

    function self:bind(nentity)
        entity = nentity;
    end

    function self:perform()
        entity:clearAction();

        local neighbours = entity:getTile():getNeighbours();
        local target = neighbours[direction];
        if target:getId() == 'door' and not target:isPassable() then
            target:open();
            return true;
        end
        return false;
    end

    return self;
end

return OpenDoor;
