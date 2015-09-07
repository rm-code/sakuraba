local BaseAction = require('src.actors.actions.BaseAction');

local Grab = {};

function Grab.new()
    local self = BaseAction.new();

    function self:perform()
        local actor = self:getActor();

        local tile = actor:getTile();
        local items = tile:getItems();

        if #items == 0 then
            return false;
        end

        for i = #items, 1, -1 do
            actor:inventory():add(items[i]);
            tile:removeItem(i);
        end

        return true;
    end

    return self;
end

return Grab;
