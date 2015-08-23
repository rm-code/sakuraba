local Object = {};

function Object.new()
    local self = {
        __instances = { 'Object' };
    };

    function self:addInstance(str)
        self.__instances[#self.__instances + 1] = str;
        return self;
    end

    return self;
end

return Object;
