local Grab = {};

function Grab.new()
    local self = {};

    local actor;

    function self:bind(nactor)
        actor = nactor;
    end

    function self:perform()
        actor:action():clearAction();

        local tile = actor:getTile();
        local items = tile:getItems();
        for i = #items, 1, -1 do
            actor:inventory():addItem(items[i]);
            tile:removeItem(i);
        end

        return true;
    end

    return self;
end

return Grab;
