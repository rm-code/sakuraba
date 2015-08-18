local BaseItem = require('src.items.BaseItem');
local Constants = require('src.constants.Constants');

local ITEM_TYPES = Constants.ITEM_TYPES;

-- TODO move to external files
local WEAPONS = {
    claw = {
        name = 'Claw',
        type = 'melee',
        dmg = 3,
        range = 1,
    },
    knife = {
        name = 'Knife',
        type = 'melee',
        dmg = 4,
        range = 1,
    },
    sword = {
        name = 'Sword',
        type = 'melee',
        dmg = 5,
        range = 1,
    },
    bow = {
        name = 'Bow',
        type = 'ranged',
        dmg = 3,
        range = 8,
    },
    crossbow = {
        name = 'Crossbow',
        type = 'ranged',
        dmg = 5,
        range = 10,
    }
}

local Weapon = {};

function Weapon.new(id)
    local self = BaseItem.new(WEAPONS[id].name, ITEM_TYPES.WEAPON);

    local weaponType = WEAPONS[id].type;
    local damage = WEAPONS[id].dmg;
    local range = WEAPONS[id].range;

    function self:getDamage()
        return damage;
    end

    function self:getRange()
        return range;
    end

    function self:getWeaponType()
        return weaponType;
    end

    return self;
end

return Weapon;
