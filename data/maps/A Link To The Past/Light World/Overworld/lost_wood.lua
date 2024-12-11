-- Lua script of map A Link To The Past/Light World/Overworld/Zone/lost_wood.
-- This script is executed every time the hero enters this map.

-- Feel free to modify the code below.
-- You can add more events and remove the ones you don't need.

-- See the Solarus Lua API documentation:
-- http://www.solarus-games.org/doc/latest

local map = ...
local game = map:get_game()

-- Event called at initialization time, as soon as this map is loaded.
function map:on_started(destination)    
  if destination == dest_map_lost_wood_0 then
    if game:get_value("demo_part_4_dialog_ok") then return end
    if game:get_value("get_master_sword") then
      local dialog_box = game:get_dialog_box()
      dialog_box:set_style("empty")
      game:start_dialog("demo.part_four",function() dialog_box:set_style("box") game:set_value("demo_part_4_dialog_ok",true) end)
    end
  end

  if game:get_item("equipment/sword"):has_variant(2) then
    for mist in map:get_entities("mist_lost_wood_") do
      mist:set_enabled(false)
    end
      light_lost_wood_0:set_enabled(true)
  else
    sol.audio.play_music("lost_woods")
  end
end

-- Event called after the opening transition effect of the map,
-- that is, when the player takes control of the hero.
function map:on_opening_transition_finished()

end