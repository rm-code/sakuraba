local Attributes = {};

function Attributes.new(faction, stats, skills)
    local self = {};

    function self:getDexterity()
        return stats.dexterity;
    end

    function self:getMeleeSkill()
        return skills.melee;
    end

    function self:getRangedSkill()
        return skills.ranged;
    end

    function self:getStrength()
        return stats.strength;
    end

    function self:getFaction()
        return faction;
    end

    return self;
end

return Attributes;
