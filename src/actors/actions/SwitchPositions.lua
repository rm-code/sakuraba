local BaseAction = require('src.actors.actions.BaseAction');

local SwitchPositions = {};

function SwitchPositions.new(target)
    local self = BaseAction.new();

    local function moveToTile(tile, actor)
        tile:removeActor();
        tile:setActor(actor);
        actor:setTile(tile);
    end

    function self:perform()
        local actor = self:getActor();
        actor:action():clearAction();

        local currentTile = actor:getTile();
        local targetTile = target;

        if targetTile:isOccupied() then
            local targetActor = targetTile:getActor();
            if targetActor:attributes():getFaction() == actor:attributes():getFaction() then
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
