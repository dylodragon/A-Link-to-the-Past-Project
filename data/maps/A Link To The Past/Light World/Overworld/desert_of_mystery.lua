-- Lua script of map Non_Playable Zone/desert_of_mystery.
-- This script is executed every time the hero enters this map.

-- Feel free to modify the code below.
-- You can add more events and remove the ones you don't need.

-- See the Solarus Lua API documentation:
-- http://www.solarus-games.org/doc/latest

local map = ...
local game = map:get_game()

local statue_moved = false

-- Event called at initialization time, as soon as this map is loaded.
function map:on_started()
  -- You can initialize the movement and sprites of various
  -- map entities here. if destination == dest_dungeon_eastern_ruins_0 then
      if game:get_value("demo_part_3_dialog_ok") then return end
      if game:get_value("get_pendant_of_power") then
      local dialog_box = game:get_dialog_box()
        dialog_box:set_style("empty")
        game:start_dialog("demo.part_three",function() dialog_box:set_style("box") game:set_value("demo_part_3_dialog_ok",true) end)
  end
end

-- Event called after the opening transition effect of the map,
-- that is, when the player takes control of the hero.
function map:on_opening_transition_finished()

end

function crypted_stone_desert_of_mystery_0:on_interaction()
  if game:has_item("equipment/book_of_mudora") and not statue_moved then
    game:start_dialog("uncrypted.desert_stone", function()
      hero:freeze()
      sol.audio.play_music("sanctuary")
      hero:set_animation("brandish")

      sol.timer.start(2000, function()
        sol.audio.play_sound("enemy_awake")
        sol.audio.play_sound("quake")

        for statue in map:get_entities_by_type("dynamic_tile") do
          local mov_statue = sol.movement.create("straight")
          mov_statue:set_speed(22)            
          mov_statue:set_angle(0)
          mov_statue:set_ignore_obstacles()
          mov_statue:set_max_distance(28)

          mov_statue:start(statue, function()
            hero:unfreeze()
            sol.audio.play_sound("secret")
            sol.audio.play_music("overworld")
            statue_moved = true
          end)
        end
      end)
    end)
  else
      game:start_dialog("crypted.desert_stone")
  end  
end