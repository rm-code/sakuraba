local Room = {};

function Room.new(map, x, y, w, h)
    local self = {};

    local cx = x + math.floor(w * 0.5);
    local cy = y + math.floor(h * 0.5);

    for ix = x, x + w do
        for iy = y, y + h do
            local tile = map:getTileAt(ix, iy);
            tile:setType('floor');
            tile:setPassable(true);
        end
    end

    function self:getCenter()
        return cx, cy;
    end

    return self;
end

return Room;
