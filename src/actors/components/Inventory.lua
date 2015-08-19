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
        local type = item:getType();

        -- Unequip item if the slot is already taken.
        if equippedItems[type] then
            self:unequip(equippedItems[type]);
        end

        -- Equip the item and set its equipped flag to true.
        equippedItems[type] = item;
        item:setEquipped(true);
    end

    function self:unequip(item)
        equippedItems[item:getType()] = nil;
        item:setEquipped(false);
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
