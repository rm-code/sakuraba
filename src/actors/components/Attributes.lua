local Attributes = {};

function Attributes.new(faction, stats, skills)
    local self = {};

    function self:getAttackRating()
        return skills.melee;
    end

    function self:getDefenseRating()
        return skills.melee;
    end

    function self:getFaction()
        return faction;
    end

    return self;
end

return Attributes;
