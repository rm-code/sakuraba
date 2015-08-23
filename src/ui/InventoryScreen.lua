local Constants = require('src.constants.Constants');

local COLORS = Constants.COLORS;

local InventoryScreen = {};

function InventoryScreen.new(game)
    local self = {};

    local inventory = game:getPlayer():inventory():getItems();
    local equipment = game:getPlayer():inventory():getEquippedItems();

    local selection;

    function self:draw()
        love.graphics.print('Inventory', love.graphics.getWidth() - 200, 10);
        for i = 1, #inventory do
            if i == selection then
                love.graphics.setColor(COLORS.GREEN);
            elseif inventory[i]:isEquipped() then
                love.graphics.setColor(COLORS.PURPLE);
            end
            love.graphics.print(inventory[i]:getName(), love.graphics.getWidth() - 200, i * 20 + 20);
            love.graphics.setColor(COLORS.WHITE);
        end

        love.graphics.print('Weapon: ' .. (equipment.weapon and equipment.weapon:getName()), love.graphics.getWidth() - 200, 200);
    end

    function self:setInventorySelection(nselection)
        selection = nselection;
    end

    return self;
end

return InventoryScreen;
