local Unequip = {};

function Unequip.new(item)
    local self = {};

    local actor;

    function self:bind(nactor)
        actor = nactor;
    end

    function self:perform()
        actor:action():clearAction();

        if item:isEquipped() then
            actor:inventory():unequipItem(item);
            item:setEquipped(false);
            return true;
        end
        return false;
    end

    return self;
end

return Unequip;
