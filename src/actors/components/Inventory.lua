local Inventory = {};

function Inventory.new(actor)
    local self = {};

    local items = {};

    function self:getItems()
        return items;
    end

    function self:addItem(item)
        items[#items + 1] = item;
    end

    return self;
end

return Inventory;
