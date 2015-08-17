local BaseAction = require('src.actors.actions.BaseAction');

local OpenDoor = {};

function OpenDoor.new(target)
    local self = BaseAction.new();

    function self:perform()
        local actor = self:getActor();
        actor:action():clearAction();

        if target:getType() == 'door' and not target:isPassable() then
            target:open();
            return true;
        end
        return false;
    end

    return self;
end

return OpenDoor;
