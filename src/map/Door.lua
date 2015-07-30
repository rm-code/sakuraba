local Tile = require('src.map.Tile');

local Door = {};

function Door.new(x, y)
    local self = Tile.new(x, y, 'door');

    function self:open()
        self:setPassable(true);
        self:setSprite('O');
    end

    return self;
end

return Door;