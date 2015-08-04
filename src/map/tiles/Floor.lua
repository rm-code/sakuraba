local Tile = require('src.map.tiles.Tile');

local Floor = {};

function Floor.new(x, y)
    local self = Tile.new(x, y, 'floor');

    return self;
end

return Floor;
