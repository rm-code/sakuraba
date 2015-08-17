local BaseAction = require('src.actors.actions.BaseAction');

local Wait = {};

function Wait.new()
    local self = BaseAction.new();

    function self:perform()
        self:getActor():health():heal(love.math.random(1, 3));
        return true;
    end

    return self;
end

return Wait;
