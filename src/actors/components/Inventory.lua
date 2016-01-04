local Constants = require('src.constants.Constants');
local ItemFactory = require('src.items.ItemFactory');

local ITEM_TYPES = Constants.ITEM_TYPES;

local Inventory = {};

function Inventory.new(default)
    local self = {};

    local items = {};

    -- TODO Find a better way to create and assign default items.
    local defaultItems = {
        [ITEM_TYPES.WEAPON] = ItemFactory.createItem( default[ITEM_TYPES.WEAPON] );
    };

    -- TODO Find a better way to create and assign default items.
    local equippedItems = {
        [ITEM_TYPES.WEAPON] = defaultItems[ITEM_TYPES.WEAPON]
    };

    local armorRating = 0;

    function self:equip( item )
        local slot = item:getSlot();

        if item:isInstanceOf( 'Armor' ) then
            armorRating = armorRating + item:getArmorRating();
        end

        -- Unequip item if the slot is already taken.
        if equippedItems[slot] then
            self:unequip(equippedItems[slot]);
        end

        equippedItems[slot] = item;
        item:setEquipped(true);
    end

    function self:unequip(item)
        if item:isInstanceOf( 'Armor' ) then
            armorRating = armorRating - item:getArmorRating();
        end

        local slot = item:getSlot();
        equippedItems[slot] = defaultItems[slot];
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

    function self:getArmor(bodypart)
        return equippedItems[bodypart];
    end

    function self:getArmorRating()
        return armorRating;
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
