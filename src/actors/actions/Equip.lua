local Equip = {};

function Equip.new(item)
    local self = {};

    local actor;

    function self:bind(nactor)
        actor = nactor;
    end

    function self:perform()
        actor:action():clearAction();

        actor:inventory():equipItem(item);
        actor:inventory():removeItem(item);
        return true;
    end

    return self;
end

return Equip;
