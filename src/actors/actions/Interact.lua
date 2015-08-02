local OpenDoor = require('src.actors.actions.OpenDoor');

local Interact = {};

function Interact.new()
    local self = {};

    local actor;

    function self:bind(nactor)
        actor = nactor;
    end

    function self:perform()
        local neighbours = actor:getTile():getNeighbours();

        for direction, tile in pairs(neighbours) do
            if tile:getId() == 'door' then
                return OpenDoor.new(direction);
            end
        end

        return false;
    end

    return self;
end

return Interact;
