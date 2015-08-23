local Constants = require('src.constants.Constants');

local ITEM_TYPES = Constants.ITEM_TYPES;
local BODY_PARTS = Constants.BODY_PARTS;

-- Storing body parts as array makes picking a random body part simpler.
local RND_BODY_PARTS = {
    BODY_PARTS.HEAD,
    BODY_PARTS.HANDS,
    BODY_PARTS.TORSO,
    BODY_PARTS.LEGS,
    BODY_PARTS.FEET,
};

local Inventory = {};

function Inventory.new(actor)
    local self = {};

    local items = {};
    local equippedItems = {
        [ITEM_TYPES.WEAPON] = nil,
        [BODY_PARTS.HEAD]  = nil,
        [BODY_PARTS.HANDS] = nil,
        [BODY_PARTS.TORSO] = nil,
        [BODY_PARTS.LEGS]  = nil,
        [BODY_PARTS.FEET]  = nil,
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

    function self:getArmorRating()
        local rating = 0;
        rating = rating + equippedItems[BODY_PARTS.HEAD]:getArmorRating();
        rating = rating + equippedItems[BODY_PARTS.HANDS]:getArmorRating();
        rating = rating + equippedItems[BODY_PARTS.TORSO]:getArmorRating();
        rating = rating + equippedItems[BODY_PARTS.LEGS]:getArmorRating();
        rating = rating + equippedItems[BODY_PARTS.FEET]:getArmorRating();
        return rating;
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

    function self:getArmor(bodypart)
        return equippedItems[bodypart];
    end

    function self:getRandomBodyPart()
        return RND_BODY_PARTS[love.math.random(1, #RND_BODY_PARTS)];
    end

    return self;
end

return Inventory;
