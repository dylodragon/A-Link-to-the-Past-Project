-- Lua script of custom entity big_stone_white.
-- This script is executed every time a custom entity with this model is created.

-- Feel free to modify the code below.
-- You can add more events and remove the ones you don't need.

-- See the Solarus Lua API documentation for the full specification
-- of types, events and methods:
-- http://www.solarus-games.org/doc/latest

local stone_exploded = ...
local game = stone_exploded:get_game()
local map = stone_exploded:get_map()
local hero = map:get_hero()

local already_launched = false

-- Event called when the custom entity is initialized.
function stone_exploded:on_created()
  self:set_traversable_by(false)
  self:set_drawn_in_y_order(true)
  self:set_weight(-1)
end

local function detroy_explode_stone()
  if game:has_item("equipment/pegasus_shoes") then
    --sol.audio.play_sound("explosion")  

  print("heu")
    explode_stone_sprite = stone_exploded:get_sprite()
    explode_stone_sprite:set_animation("destroy", function()
      stone_exploded:remove()
    end)
  end
end

-- Hero hit Stone_Explode.
stone_exploded:add_collision_test("touching", function(stone_exploded, entity)
  if entity:get_type() == "hero" then
    if hero:get_facing_entity() ~= nil then
      if hero:get_state() == "running" and hero:get_facing_entity():get_name() == stone_exploded:get_name() and hero:get_distance(hero:get_facing_entity()) <= 42 then
        if not already_launched then
          already_launched = true
          detroy_explode_stone()
        end
      end
    end
  end
end)