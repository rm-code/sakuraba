local Tile = require('src.map.tiles.Tile');

local Wall = {};

function Wall.new(x, y)
    local self = Tile.new(x, y, 'wall');

    return self;
end

return Wall;
