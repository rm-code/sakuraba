local SwitchPositions = {};

function SwitchPositions.new(direction)
    local self = {};

    local actor;

    local function moveToTile(tile, actor)
        tile:removeActor();
        tile:setActor(actor);
        actor:setTile(tile);
    end

    function self:bind(nactor)
        actor = nactor;
    end

    function self:perform()
        actor:clearAction();

        local currentTile = actor:getTile();
        local neighbours = currentTile:getNeighbours();
        local targetTile = neighbours[direction];

        if targetTile:isOccupied() then
            local targetActor = targetTile:getActor();
            if targetActor:getFaction() == actor:getFaction() then
                -- Remove the target actor and move the performing actor to the new tile.
                moveToTile(targetTile, actor);

                -- Remove the performing actor and move the target actor to the old tile.
                moveToTile(currentTile, targetActor);
                return true;
            end
        end
        return false;
    end

    return self;
end

return SwitchPositions;
