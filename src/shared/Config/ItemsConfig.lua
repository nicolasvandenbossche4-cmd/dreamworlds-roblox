-- ItemsConfig.lua
-- Complete catalog of buildable items

local ItemsConfig = {}

-- Item template structure:
-- {
--   ItemId = unique_id,
--   Name = display_name,
--   Category = category_name,
--   Price = dreamcoins_cost,
--   Level = minimum_level_required,
--   Rarity = rarity_level,
--   Description = item_description,
--   Model = template_or_part_name,
-- }

ItemsConfig.Items = {}

-- WALLS & STRUCTURES
ItemsConfig.Items.wall_basic_1x1 = {
    ItemId = "wall_basic_1x1",
    Name = "Basic Wall",
    Category = "Walls",
    Price = 50,
    Level = 1,
    Rarity = "Common",
    Description = "A simple 1x1 wall block",
    Size = Vector3.new(1, 1, 1),
    Model = nil, -- Will use Part with dimensions
}

ItemsConfig.Items.wall_brick_1x2 = {
    ItemId = "wall_brick_1x2",
    Name = "Brick Wall",
    Category = "Walls",
    Price = 75,
    Level = 1,
    Rarity = "Common",
    Description = "A brick textured wall 1x2",
    Size = Vector3.new(1, 1, 2),
    Model = nil,
}

-- FLOORS
ItemsConfig.Items.floor_wood_2x2 = {
    ItemId = "floor_wood_2x2",
    Name = "Wooden Floor",
    Category = "Floors",
    Price = 100,
    Level = 1,
    Rarity = "Common",
    Description = "A wooden floor tile 2x2",
    Size = Vector3.new(2, 0.2, 2),
    Model = nil,
}

-- DOORS
ItemsConfig.Items.door_basic = {
    ItemId = "door_basic",
    Name = "Basic Door",
    Category = "Doors",
    Price = 150,
    Level = 2,
    Rarity = "Common",
    Description = "A simple wooden door",
    Size = Vector3.new(1, 2, 0.2),
    Model = nil,
}

-- FURNITURE
ItemsConfig.Items.chair_basic = {
    ItemId = "chair_basic",
    Name = "Simple Chair",
    Category = "Furniture",
    Price = 80,
    Level = 1,
    Rarity = "Common",
    Description = "A basic wooden chair",
    Size = Vector3.new(0.8, 1, 0.8),
    Model = nil,
}

ItemsConfig.Items.table_basic = {
    ItemId = "table_basic",
    Name = "Simple Table",
    Category = "Furniture",
    Price = 120,
    Level = 1,
    Rarity = "Common",
    Description = "A basic wooden table",
    Size = Vector3.new(1.5, 0.8, 1.5),
    Model = nil,
}

ItemsConfig.Items.bed_basic = {
    ItemId = "bed_basic",
    Name = "Simple Bed",
    Category = "Furniture",
    Price = 200,
    Level = 2,
    Rarity = "Common",
    Description = "A basic bed",
    Size = Vector3.new(2, 1, 3),
    Model = nil,
}

-- WINDOWS
ItemsConfig.Items.window_basic = {
    ItemId = "window_basic",
    Name = "Basic Window",
    Category = "Windows",
    Price = 100,
    Level = 2,
    Rarity = "Common",
    Description = "A simple window",
    Size = Vector3.new(1, 1, 0.1),
    Model = nil,
}

-- DECORATIONS
ItemsConfig.Items.plant_small = {
    ItemId = "plant_small",
    Name = "Small Plant",
    Category = "Decorations",
    Price = 50,
    Level = 1,
    Rarity = "Common",
    Description = "A small decorative plant",
    Size = Vector3.new(0.5, 1, 0.5),
    Model = nil,
}

ItemsConfig.Items.lamp_basic = {
    ItemId = "lamp_basic",
    Name = "Basic Lamp",
    Category = "Lighting",
    Price = 75,
    Level = 1,
    Rarity = "Common",
    Description = "A basic lamp that can emit light",
    Size = Vector3.new(0.5, 1.5, 0.5),
    Model = nil,
}

-- STAIRS
ItemsConfig.Items.stairs_basic = {
    ItemId = "stairs_basic",
    Name = "Basic Stairs",
    Category = "Stairs",
    Price = 250,
    Level = 3,
    Rarity = "Uncommon",
    Description = "A set of basic stairs",
    Size = Vector3.new(1.5, 2, 3),
    Model = nil,
}

-- ROOFS
ItemsConfig.Items.roof_basic = {
    ItemId = "roof_basic",
    Name = "Basic Roof",
    Category = "Roofs",
    Price = 300,
    Level = 3,
    Rarity = "Uncommon",
    Description = "A basic roof tile",
    Size = Vector3.new(2, 0.5, 2),
    Model = nil,
}

-- Helper function to get item by ID
function ItemsConfig:GetItem(itemId)
    return self.Items[itemId]
end

-- Helper function to get items by category
function ItemsConfig:GetItemsByCategory(category)
    local categoryItems = {}
    for id, item in pairs(self.Items) do
        if item.Category == category then
            table.insert(categoryItems, item)
        end
    end
    return categoryItems
end

-- Helper function to get all categories
function ItemsConfig:GetCategories()
    local categories = {}
    local seen = {}
    for id, item in pairs(self.Items) do
        if not seen[item.Category] then
            table.insert(categories, item.Category)
            seen[item.Category] = true
        end
    end
    return categories
end

return ItemsConfig
