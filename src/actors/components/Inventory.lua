local Constants = require('src.constants.Constants');

local ITEM_TYPES = Constants.ITEM_TYPES;

local Inventory = {};

function Inventory.new(actor)
    local self = {};

    local items = {};
    local equippedItems = {
        [ITEM_TYPES.WEAPON] = nil,
    };

    function self:equip(item)
        if item:getType() == ITEM_TYPES.WEAPON then
            equippedItems[ITEM_TYPES.WEAPON] = item;
            item:setEquipped(true);
        end
    end

    function self:unequip(item)
        if item:getType() == ITEM_TYPES.WEAPON then
            equippedItems[ITEM_TYPES.WEAPON] = nil;
            item:setEquipped(false);
        end
    end

    function self:add(item)
        items[#items + 1] = item;
    end

    function self:remove(item)
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

    function self:getEquippedItems()
        return equippedItems;
    end

    function self:getWeapon()
        return equippedItems[ITEM_TYPES.WEAPON];
    end


    return self;
end

return Inventory;
