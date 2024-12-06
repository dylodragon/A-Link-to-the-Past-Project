-- Lua script of map Non_Playable Zone/death_mountain_west.
-- This script is executed every time the hero enters this map.

-- Feel free to modify the code below.
-- You can add more events and remove the ones you don't need.

-- See the Solarus Lua API documentation:
-- http://www.solarus-games.org/doc/latest

local map = ...
local game = map:get_game()

-- Event called at initialization time, as soon as this map is loaded.
function map:on_started(destination)
  if destination == dest_dungeon_death_mountain_west_0 then
    if game:get_value("demo_part_4_dialog_ok") then return end
    if game:get_value("get_pendant_of_wisdom") then
    local dialog_box = game:get_dialog_box()
      dialog_box:set_style("empty")
      game:start_dialog("demo.part_four",function() dialog_box:set_style("box") game:set_value("demo_part_4_dialog_ok",true) end)
    end
  end
end

-- Event called after the opening transition effect of the map,
-- that is, when the player takes control of the hero.
function map:on_opening_transition_finished(destination)
  if map:get_tileset() == "out/outside_darkworld_main" then
    death_mountain_warp_0:set_enabled(false)
    sol.audio.play_music("rabbit")

    sol.video.set_shader(sol.shader.create("fr_to_normal_colors"))    

    for dynamic_tile in map:get_entities_by_type("dynamic_tile") do
      if dynamic_tile:get_name() ~= nil then
        dynamic_tile:set_enabled(true)
      else
        dynamic_tile:set_enabled(false)
      end
    end
    for jumper in map:get_entities_by_type("jumper") do
      jumper:set_enabled(false)
    end

  tp_cave_death_mountain_west_0:set_enabled(false)

  elseif map:get_tileset() == "out/outside_lightworld_main" then
    for sensor_mirror_warp_protect in map:get_entities("mirror_warp_protect_") do
      if sensor_mirror_warp_protect:overlaps(hero) then
          if destination == nil then
            map:set_tileset("out/outside_darkworld_main") 
            hero:teleport(map:get_id(), "_same")           
          end
        return
      end
    end
    sol.audio.play_music("overworld")

    sol.video.set_shader(nil)

    death_mountain_warp_0:set_enabled(true)    
    tp_cave_death_mountain_west_0:set_enabled(true)

    for dynamic_tile in map:get_entities_by_type("dynamic_tile") do
      if dynamic_tile:get_name() ~= nil then
        dynamic_tile:set_enabled(false)
      else
        dynamic_tile:set_enabled(true)
      end
    end    
    for jumper in map:get_entities_by_type("jumper") do
      jumper:set_enabled(true)
    end

  end
end

function death_mountain_warp_0:on_activated()  
  map:set_tileset("out/outside_darkworld_main")  
end

function map:on_finished()
  if sol.video.get_shader ~= nil then
    sol.video.set_shader(nil)
  end
end