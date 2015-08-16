local CloseDoor = {};

function CloseDoor.new(target)
    local self = {};

    local actor;

    function self:bind(nactor)
        actor = nactor;
    end

    function self:perform()
        actor:action():clearAction();

        if target:getType() == 'door' and target:isPassable() then
            target:close();
            return true;
        end
        return false;
    end

    return self;
end

return CloseDoor;
