local item = ...
local game = item:get_game()
  
function item:on_started()
  item:set_savegame_variable("possession_magic_mirror")
  item:set_assignable(true)
end

function item:on_using()
  local hero = game:get_hero()
  local map = game:get_map()
  if game:get_dungeon() then
    -- Teleport.
    sol.audio.play_sound("warp")
    hero:teleport(game:get_starting_location())
  elseif map:get_id() == "A Link To The Past/Light World/Overworld/death_mountain_west" and map:get_tileset() == "out/outside_darkworld_main" then
      sol.audio.play_sound("world_warp")

      hero:teleport(map:get_id(), "_same")

      map:set_tileset("out/outside_lightworld_main")

      for dynamic_tile in map:get_entities_by_type("dynamic_tile") do
        dynamic_tile:set_enabled(true)
      end
  else
    sol.audio.play_sound("wrong")
  end
  item:set_finished()
end

