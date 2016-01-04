local Object = require('src.Object');

local Item = {};

function Item.new( name, slot )
    local self = Object.new():addInstance( 'Item' );

    local equipped = false;

    function self:setEquipped( nequipped )
        equipped = nequipped;
    end

    function self:getName()
        return name;
    end

    function self:getSlot()
        return slot;
    end

    function self:isEquipped()
        return equipped;
    end

    return self;
end

return Item;
