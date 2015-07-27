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
        local target = neighbours[direction];
        if target and target:isPassable() and not target:isOccupied() then
            -- Remove the entity from the old tile, add it to the new one and
            -- give it a reference to the new tile.
            entity:getTile():removeEntity();
            target:setEntity(entity);
            entity:setTile(target);
            return true;
        end
        return false;
    end

    return self;
end

return WalkAction;
