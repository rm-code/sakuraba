local BaseItem = require('src.items.BaseItem');
local Constants = require('src.constants.Constants');

local ITEM_TYPES = Constants.ITEM_TYPES;

-- TODO move to external files
local WEAPONS = {
    claw = {
        name = 'Claw',
        type = 'melee',
        dmg = 3,
    },
    knife = {
        name = 'Knife',
        type = 'melee',
        dmg = 4,
    },
    sword = {
        name = 'Sword',
        type = 'melee',
        dmg = 5,
    },
}

local Weapon = {};

function Weapon.new(id)
    local self = BaseItem.new(WEAPONS[id].name, ITEM_TYPES.WEAPON);

    local weaponType = WEAPONS[id].type;
    local damage = WEAPONS[id].dmg;

    function self:getDamage()
        return damage;
    end

    function self:getWeaponType()
        return weaponType;
    end

    return self;
end

return Weapon;
