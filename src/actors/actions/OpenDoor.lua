local OpenDoor = {};

function OpenDoor.new(target)
    local self = {};

    local actor;

    function self:bind(nactor)
        actor = nactor;
    end

    function self:perform()
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
