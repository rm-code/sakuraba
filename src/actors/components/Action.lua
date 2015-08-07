local Action = {};

function Action.new(actor)
    local self = {};

    local action;

    function self:clearAction()
        action = nil;
    end

    function self:setAction(naction)
        if naction then
            action = naction;
            action:bind(actor);
            return;
        end
    end

    function self:getAction()
        return action;
    end

    function self:hasAction()
        return action ~= nil;
    end

    return self;
end

return Action;
