local Attributes = {};

function Attributes.new(faction, ar, dr)
    local self = {};

    function self:getAttackRating()
        return ar;
    end

    function self:getDefenseRating()
        return dr;
    end

    function self:getFaction()
        return faction;
    end

    return self;
end

return Attributes;
