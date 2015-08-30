local Room = require('src.map.Room');

local Partition = {};

function Partition.new(map, x, y, w, h)
    local self = {};

    local childOne;
    local childTwo;

    local room;

    function self:split()
        if childOne or childTwo then
            return false;
        end

        local dir;
        if w / h > 1.25 then
            dir = 1;
        elseif h / w > 1.25 then
            dir = 0;
        else
            dir = love.math.random(0, 1);
        end

        local size = love.math.random(30, 70) / 100; -- Determine size 30-70%

        if dir == 0 then -- Horizontal
            local split = math.floor(h * size);
            childOne = Partition.new(map, x, y        , w,     split);
            childTwo = Partition.new(map, x, y + split, w, h - split);
        else
            local split = math.floor(w * size);
            childOne = Partition.new(map, x,         y,     split, h);
            childTwo = Partition.new(map, x + split, y, w - split, h);
        end
        return childOne, childTwo;
    end

    function self:spawnRooms()
        if childOne and childTwo then
            childOne:spawnRooms();
            childTwo:spawnRooms();
        elseif love.math.random(1, 3) > 1 then
            local rw, rh = w - 2, h - 2;
            -- Randomize the size of each room.
            local rndSize = love.math.random(70, 100) / 100;
            rw = math.floor(rw * rndSize);
            rh = math.floor(rh * rndSize);

            local rx, ry = x + math.floor((w - rw) * 0.5), y + math.floor((h - rh) * 0.5);
            room = Room.new(map, rx, ry, rw, rh);
        end
    end

    function self:getChildOne()
        return childOne;
    end

    function self:getChildTwo()
        return childTwo;
    end

    function self:getX()
        return x;
    end

    function self:getY()
        return y;
    end

    function self:getWidth()
        return w;
    end

    function self:getHeight()
        return h;
    end

    function self:getRoom()
        return room;
    end

    return self;
end

return Partition;
