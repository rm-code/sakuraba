local BaseAction = require('src.actors.actions.BaseAction');
local OpenDoor = require('src.actors.actions.OpenDoor');
local Attack   = require('src.actors.actions.Attack');

local Walk = {};

function Walk.new(target)
    local self = BaseAction.new();

    function self:perform()
        local actor = self:getActor();
        actor:action():clearAction();

        if not target:isPassable() then
            return OpenDoor.new(target);
        elseif target:isOccupied() then
            return Attack.new(target);
        elseif target:isPassable() and not target:isOccupied() then
            -- Remove the actor from the old tile, add it to the new one and
            -- give it a reference to the new tile.
            actor:getTile():removeActor();
            target:setActor(actor);
            actor:setTile(target);
            return true;
        end
        return false;
    end

    return self;
end

return Walk;
