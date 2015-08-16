local BaseItem = {};

function BaseItem.new()
    local self = {};

    function self:getWeight()
        return 1.0;
    end

    function self:getType()
        return 'Dummy';
    end

    return self;
end

return BaseItem;
