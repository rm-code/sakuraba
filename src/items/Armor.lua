local Item = require('src.items.Item');
local Constants = require('src.constants.Constants');

local ITEM_TYPES = Constants.ITEM_TYPES;
local BODY_PARTS = Constants.BODY_PARTS;

-- TODO move to external files
local ARMOR = {
    cap = {
        name = 'Baseball Cap',
        type = BODY_PARTS.HEAD,
        armorRating = 0,
        damageResistance = 1,
    },
    gloves = {
        name = 'Leathergloves',
        type = BODY_PARTS.HANDS,
        armorRating = 0,
        damageResistance = 3,
    },
    pullover = {
        name = 'Pullover',
        type = BODY_PARTS.TORSO,
        armorRating = 1,
        damageResistance = 2,
    },
    jeans = {
        name = 'Jeans',
        type = BODY_PARTS.LEGS,
        armorRating = 1,
        damageResistance = 3,
    },
    boots = {
        name = 'Hiking Boots',
        type = BODY_PARTS.FEET,
        armorRating = 1,
        damageResistance = 3,
    }
}

local Armor = {};

function Armor.new(id)
    local self = Item.new(ARMOR[id].name, ARMOR[id].type):addInstance('Armor');

    local armorRating = ARMOR[id].armorRating;
    local armorType   = ARMOR[id].type;
    local damageResistance = ARMOR[id].damageResistance;

    function self:getArmorRating()
        return armorRating;
    end

    function self:getArmorType()
        return armorType;
    end

    function self:getDamageResistance()
        return damageResistance;
    end

    return self;
end

return Armor;
