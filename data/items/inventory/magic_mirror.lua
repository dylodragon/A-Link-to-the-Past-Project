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

      hero:teleport(game:get_map():get_id(), "_same")

      map:set_tileset("out/outside_lightworld_main")

      hero:set_tunic_sprite_id("hero/tunic1")
      --game:get_value(savegame_variable)

      sol.video.set_shader(nil)

      map:get_entity("death_mountain_west_warp_0"):set_enabled(true)
      map:get_entity("tp_cave_death_mountain_west_0"):set_enabled(true)
      map:get_entity("pink_ball_death_moutain_west_0"):set_enabled(false)
      map:get_entity("cursed_bully_death_moutain_west_0"):set_enabled(false)  

      if not game:get_value("piece_of_heart_mountain_west_0") then
          map:get_entity("piece_of_heart_mountain_west_0"):set_enabled(true)
      end

      map:get_entity("up_hero"):set_enabled(false)

    for entity_on_screen in map:get_entities_by_type("enemy") do
      if entity_on_screen:get_distance(hero) > 64 then
        entity_on_screen:set_enabled(true)
      end
    end      
      for jumper_dark_world in map:get_entities_by_type("jumper") do
          jumper_dark_world:set_enabled(true)
    end
      for demo_dark_world_tiles in map:get_entities("demo_dark_world_") do
          demo_dark_world_tiles:set_enabled(false)
    end

  else
    sol.audio.play_sound("wrong")
  end

  item:set_finished()
end
