local Tile = require('src.map.tiles.Tile');

local Door = {};

function Door.new(x, y)
    local self = Tile.new(x, y, 'door');

    function self:open()
        self:setPassable(true);
        self:setSprite('O');
    end

    function self:close()
        self:setPassable(false);
        self:setSprite('/');
    end

    return self;
end

return Door;
