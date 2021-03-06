local BaseAction = require('src.actors.actions.BaseAction');

local CloseDoor = {};

function CloseDoor.new(target)
    local self = BaseAction.new();

    function self:perform()
        if target:getType() == 'door' and target:isPassable() then
            target:close();
            return true;
        end
        return false;
    end

    return self;
end

return CloseDoor;
