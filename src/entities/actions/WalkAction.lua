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
            -- Remove the entity from the old tile, add it to the new one and
            -- give it a reference to the new tile.
            entity:getTile():removeEntity();
            neighbours[direction]:setEntity(entity);
            entity:setTile(neighbours[direction]);
            return true;
        end
        return false;
    end

    return self;
end

return WalkAction;
