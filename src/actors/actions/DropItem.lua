local DropItem = {};

function DropItem.new(item)
    local self = {};

    local actor;

    function self:bind(nactor)
        actor = nactor;
    end

    function self:perform()
        actor:action():clearAction();

        -- Unequip the item if it is currently equipped.
        if item:isEquipped() then
            actor:inventory():unequipItem(item);
            item:setEquipped(false);
        end

        -- Remove the item from the actor's inventory.
        actor:inventory():removeItem(item);
        -- Spawn the item on the tile the actor is standing on.
        actor:getTile():addItem(item);

        return false;
    end

    return self;
end

return DropItem;
