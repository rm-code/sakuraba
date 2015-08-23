local DEFAULT_NAME = 'DefaultName';
local DEFAULT_TYPE = 'DefaultType';

local Item = {};

function Item.new(name, type)
    local self = {};

    local equipped = false;

    function self:setEquipped(nequipped)
        equipped = nequipped;
    end

    function self:getName()
        return name or DEFAULT_NAME;
    end

    function self:getType()
        return type or DEFAULT_TYPE;
    end

    function self:isEquipped()
        return equipped;
    end

    return self;
end

return Item;
