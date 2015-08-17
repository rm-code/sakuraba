local BaseAction = {};

function BaseAction.new()
    local self = {};

    local actor;

    function self:bind(nactor)
        actor = nactor;
    end

    function self:getActor()
        return actor;
    end

    return self;
end

return BaseAction;
