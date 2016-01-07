local ItemFactory = require('src.items.ItemFactory');

local Inventory = {};

function Inventory.new( args )
    local self = {};

    local items = {};

    local default = {
        armor   = {},
        weapons = {}
    };

    -- Initialise the default armor.
    for _, slot in ipairs( args.armor ) do
        default.armor[slot.id] = ItemFactory.createItem( slot.armor );
    end

    -- Initialise default weapon.
    for _, slot in ipairs( args.weapons ) do
        default.weapons[slot.id] = ItemFactory.createItem( slot.weapon );
    end

    local equipped = {
        armor   = {},
        weapons = {}
    };

    -- ------------------------------------------------
    -- Private Functions
    -- ------------------------------------------------

    ---
    -- Equips an item. Before the item is equipped, any item in the same slot
    -- is unequipped.
    -- @param itemSlots - The table to use when equipping.
    -- @param item - The item to equip.
    --
    local function equipItem( itemSlots, item )
        local slot = item:getSlot();

        -- Unequip item if the slot is already taken.
        if itemSlots[slot] then
            self:unequip( itemSlots[slot] );
        end

        -- Equip the new item.
        itemSlots[slot] = item;
        item:setEquipped( true );
    end

    ---
    -- Unequips an item.
    -- @param itemSlots - The table to use when unequipping.
    -- @param item - The item to unequip.
    --
    local function unequipItem( itemSlots, item )
        local slot = item:getSlot();
        itemSlots[slot] = nil;
        item:setEquipped( false );
    end

    ---
    -- Equips an armor item.
    -- @param armor - The armor item to equip.
    --
    local function equipArmor( armor )
        equipItem( equipped.armor, armor );
    end

    ---
    -- Unequips an armor item.
    -- @param armor - The armor item to unequip.
    --
    local function unequipArmor( armor )
        unequipItem( equipped.armor, armor );
    end

    ---
    -- Equips a weapon item.
    -- @param weapon - The weapon item to equip.
    --
    local function equipWeapon( weapon )
        equipItem( equipped.weapons, weapon );
    end

    ---
    -- Unequips a weapon item.
    -- @param weapon - The weapon item to unequip.
    --
    local function unequipWeapon( weapon )
        unequipItem( equipped.weapons, weapon );
    end

    -- ------------------------------------------------
    -- Public Functions
    -- ------------------------------------------------

    ---
    -- Equips an item.
    -- @param item - The item to equip.
    --
    function self:equip( item )
        if item:isInstanceOf( 'Armor' ) then
            equipArmor( item );
        elseif item:isInstanceOf( 'Weapon' ) then
            equipWeapon( item );
        end
    end

    ---
    -- Unequips an item.
    -- @param item - The item to unequip.
    --
    function self:unequip( item )
        if item:isInstanceOf( 'Armor' ) then
            unequipArmor( item );
        elseif item:isInstanceOf( 'Weapon' ) then
            unequipWeapon( item );
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

    function self:getArmor( bodypart )
        return equipped.armor[bodypart] or default.armor[bodypart];
    end

    function self:getArmorRating()
        local rating = 0;
        for slot, defaultArmor in pairs( default.armor ) do
            local equippedArmor = equipped.armor[slot];
            if equippedArmor then
                rating = rating + equippedArmor:getArmorRating();
            else
                rating = defaultArmor:getArmorRating();
            end
        end
        return rating;
    end

    function self:getItems()
        return items;
    end

    function self:getEquippedItems()
        return equipped;
    end

    function self:getWeapon()
        -- TODO Add way to select which Weapon to use for attack.
        for _, v in pairs( equipped.weapons ) do
            if v then
                return v;
            end
        end
        for _, v in pairs( default.weapons ) do
            if v then
                return v;
            end
        end
    end

    return self;
end

return Inventory;
