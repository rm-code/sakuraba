local OpenDoor = require('src.actors.actions.OpenDoor');
local CloseDoor = require('src.actors.actions.CloseDoor');

local Interact = {};

function Interact.new(target)
    local self = {};

    local actor;

    function self:bind(nactor)
        actor = nactor;
    end

    function self:perform()
        actor:action():clearAction();

        if target:getType() == 'door' and not target:isPassable() then
            return OpenDoor.new(target);
        elseif target:getType() == 'door' and target:isPassable() then
            return CloseDoor.new(target);
        end

        return false;
    end

    return self;
end

return Interact;
