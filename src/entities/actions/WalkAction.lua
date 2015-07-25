local WalkAction = {};

function WalkAction.new(direction)
    local self = {};

    local entity;

    function self:bind(nentity)
        entity = nentity;
    end

    function self:perform()
        entity:clearAction();

        local neighbours = entity:getTile():getNeighbours();
        if neighbours[direction] and neighbours[direction]:isPassable() then
            entity:setTile(neighbours[direction]);
            return true;
        end
        return false;
    end

    return self;
end

return WalkAction;
