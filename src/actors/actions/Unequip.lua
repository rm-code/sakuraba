local BaseAction = require('src.actors.actions.BaseAction');

local Unequip = {};

function Unequip.new(item)
    local self = BaseAction.new();

    function self:perform()
        local actor = self:getActor();

        if item:isEquipped() then
            actor:getComponent( 'inventory' ):unequip(item);
            return true;
        end
        return false;
    end

    return self;
end

return Unequip;
