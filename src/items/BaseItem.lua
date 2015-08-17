local BaseItem = {};

function BaseItem.new()
    local self = {};

    local equipped = false;

    function self:setEquipped(nequipped)
        equipped = nequipped;
    end

    function self:getWeight()
        return 1.0;
    end

    function self:getType()
        return 'Dummy';
    end

    function self:isEquipped()
        return equipped;
    end

    return self;
end

return BaseItem;
