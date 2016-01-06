local Body = {};

function Body.new( nparts, maxHealth )
    local self = {};

    local bodyParts = nparts;
    local maxHealth = maxHealth;
    local health    = maxHealth;

    function self:hasBodyPart( part )
        bodyParts[#bodyParts + 1] = part;
    end

    function self:getRandomBodyPart()
        return bodyParts[love.math.random( 1, #bodyParts )];
    end

    function self:damage( damage )
        health = health - damage;
    end

    function self:heal( healthPoints )
        health = math.min( health + healthPoints, maxHealth );
    end

    function self:isDead()
        return health <= 0;
    end

    function self:getHealth()
        return health;
    end

    return self;
end

return Body;
