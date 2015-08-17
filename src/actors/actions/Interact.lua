local BaseAction = require('src.actors.actions.BaseAction');
local OpenDoor = require('src.actors.actions.OpenDoor');
local CloseDoor = require('src.actors.actions.CloseDoor');

local Interact = {};

function Interact.new(target)
    local self = BaseAction.new();

    function self:perform()
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
