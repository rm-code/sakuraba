local Item = require('src.items.Item');

local Weapon = {};

function Weapon.new( name, slot, weaponType, damage, range )
    local self = Item.new( name, slot ):addInstance( 'Weapon' );

    function self:getDamage()
        return love.math.random( damage[1], damage[2] );
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
