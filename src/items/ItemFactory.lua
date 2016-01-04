local Armor = require('src.items.Armor');
local Weapon = require('src.items.Weapon');

-- ------------------------------------------------
-- Constants
-- ------------------------------------------------

local PATH_ARMOR = 'res/data/items/armor';
local PATH_WEAPONS = 'res/data/items/weapons';

-- ------------------------------------------------
-- Module
-- ------------------------------------------------

local ItemFactory = {};

-- ------------------------------------------------
-- Local Variables
-- ------------------------------------------------

-- Holds the templates for all of the game's items.
local templates = {};

-- ------------------------------------------------
-- Private Functions
-- ------------------------------------------------

---
-- Loads all template files from a specific path and stores them in the
-- templates table. It will report an error if two items have the same ID.
-- @param path - The path from which to load the template files.
-- @param templates - The table in which to store each loaded template.
--
local function loadTemplates( path, templates )
    local files = love.filesystem.getDirectoryItems( path );
    for i = 1, #files  do
        -- Load the lua file and execute it so that the table is returned.
        local template = love.filesystem.load( path .. '/' .. files[i] )();
        assert( not templates[template.id], string.format('Duplicate item ID: %s - Item IDs must be unique!', template.id ));
        templates[template.id] = template;
    end
end

---
-- Creates an armor item from a template.
-- @param template - The template to use for creating the item.
--
local function createArmorItem( template )
    return Armor.new( template.name, template.slot, template.armorRating, template.damageResistance );
end

---
-- Creates a weapon item from a template.
-- @param template - The template to use for creating the item.
--
local function createWeaponItem( template )
    return Weapon.new( template.name, template.slot, template.weaponType, template.damage, template.range );
end

-- ------------------------------------------------
-- Public Functions
-- ------------------------------------------------

---
-- Loads the template files from.
--
function ItemFactory.loadItemTemplates()
    loadTemplates( PATH_ARMOR,   templates );
    loadTemplates( PATH_WEAPONS, templates );
end

---
-- Creates an item by selecting a template based on the id. Will throw an error
-- if the ID can't be found in the templates table or if something went wrong
-- during the creation of the item.
-- @param id - The ID of the item to build.
--
function ItemFactory.createItem( id )
    assert( templates[id], string.format( 'Can\'t find template for ID: %s!', id ));

    local template = templates[id];
    local newItem;
    if template.itemType == 'armor' then
        newItem = createArmorItem( template );
    elseif template.itemType == 'weapon' then
        newItem = createWeaponItem( template );
    end

    assert( newItem, string.format( 'Can\'t create item with ID: %s!', id ));
    return newItem;
end

return ItemFactory;
