local Body = {};

function Body.new( nparts )
    local self = {};

    local bodyParts = nparts;

    function self:hasBodyPart( part )
        bodyParts[#bodyParts + 1] = part;
    end

    function self:getRandomBodyPart()
        return bodyParts[love.math.random( 1, #bodyParts )];
    end

    return self;
end

return Body;
