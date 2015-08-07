local OpenDoor = require('src.actors.actions.OpenDoor');
local CloseDoor = require('src.actors.actions.CloseDoor');

local Interact = {};

function Interact.new()
    local self = {};

    local actor;

    function self:bind(nactor)
        actor = nactor;
    end

    function self:perform()
        actor:action():clearAction();
        local neighbours = actor:getTile():getNeighbours();

        for direction, tile in pairs(neighbours) do
            if tile:getType() == 'door' and not tile:isPassable() then
                return OpenDoor.new(direction);
            elseif tile:getType() == 'door' and tile:isPassable() then
                return CloseDoor.new(direction);
            end
        end

        return false;
    end

    return self;
end

return Interact;
