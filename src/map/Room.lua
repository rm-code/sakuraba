local Room = {};

function Room.new(x, y, w, h)
    local self = {};

    local cx = x + math.floor(w * 0.5);
    local cy = y + math.floor(h * 0.5);

    function self:getCenter()
        return cx, cy;
    end

    function self:getDimensions()
        return w, h;
    end

    function self:getPosition()
        return x, y;
    end

    return self;
end

return Room;
