local Item = require('src.items.Item');

local Armor = {};

function Armor.new( name, slot, armorRating, damageResistance )
    local self = Item.new( name, slot ):addInstance( 'Armor' );

    function self:getArmorRating()
        return armorRating;
    end

    function self:getDamageResistance()
        return damageResistance;
    end

    return self;
end

return Armor;
