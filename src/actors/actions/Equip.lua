local BaseAction = require('src.actors.actions.BaseAction');

local Equip = {};

function Equip.new(item)
    local self = BaseAction.new();

    function self:perform()
        local actor = self:getActor();

        if not item:isEquipped() then
            actor:inventory():equipItem(item);
            return true;
        end
        return false;
    end

    return self;
end

return Equip;
