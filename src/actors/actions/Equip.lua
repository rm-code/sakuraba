local Equip = {};

function Equip.new(item)
    local self = {};

    local actor;

    function self:bind(nactor)
        actor = nactor;
    end

    function self:perform()
        actor:action():clearAction();

        if not item:isEquipped() then
            actor:inventory():equipItem(item);
            item:setEquipped(true);
            return true;
        end
        return false;
    end

    return self;
end

return Equip;
