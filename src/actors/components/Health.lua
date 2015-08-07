local Health = {};

function Health.new(maxHealth)
    local self = {};

    local maxHealth = maxHealth;
    local health = maxHealth;

    function self:damage(dval)
        health = health - dval;
    end

    function self:heal(dval)
        health = health + dval > maxHealth and maxHealth or health + dval;
    end

    function self:isDead()
        return health <= 0;
    end

    function self:getHealth()
        return health;
    end

    return self;
end

return Health;
