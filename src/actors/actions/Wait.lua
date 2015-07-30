local Wait = {};

function Wait.new()
    local self = {};

    local actor;

    function self:bind(nactor)
        actor = nactor;
    end

    function self:perform()
        actor:clearAction();
        return true;
    end

    return self;
end

return Wait;
