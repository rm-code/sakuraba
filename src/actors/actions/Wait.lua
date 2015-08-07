local Wait = {};

function Wait.new()
    local self = {};

    local actor;

    function self:bind(nactor)
        actor = nactor;
    end

    function self:perform()
        actor:action():clearAction();
        actor:health():heal(love.math.random(1, 3));
        return true;
    end

    return self;
end

return Wait;
