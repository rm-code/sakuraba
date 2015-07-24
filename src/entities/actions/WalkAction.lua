local WalkAction = {};

function WalkAction.new(direction)
    local self = {};

    local entity;

    function self:bind(nentity)
        entity = nentity;
    end

    function self:perform()
        local tile = entity:getTile();
        local neighbours = tile:getNeighbours();
        if neighbours[direction] and neighbours[direction]:isPassable() then
            entity:setTile(neighbours[direction]);
        end
        entity:setAction(nil);
    end

    return self;
end

return WalkAction;
