local Inventory = {};

function Inventory.new(actor)
    local self = {};

    local items = {};
    local equippedItems = {};

    function self:equipItem(item)
        equippedItems[#equippedItems + 1] = item;
    end

    function self:removeItem(item)
        local toRemove;
        for i = 1, #items do
            if items[i] == item then
                toRemove = i;
                break;
            end
        end
        table.remove(items, toRemove);
    end

    function self:getItems()
        return items;
    end

    function self:addItem(item)
        items[#items + 1] = item;
    end

    function self:getEquippedItems()
        return equippedItems;
    end

    return self;
end

return Inventory;
