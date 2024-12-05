-- Lua script of map Non_Playable Zone/death_mountain_west.
-- This script is executed every time the hero enters this map.

-- Feel free to modify the code below.
-- You can add more events and remove the ones you don't need.

-- See the Solarus Lua API documentation:
-- http://www.solarus-games.org/doc/latest

local map = ...
local game = map:get_game()
local hero = map:get_hero()

local grandpa = map:create_npc({ 
  ["name"] = "grandpa", 
  ["layer"] = 0,
  ["x"] = 0,
  ["y"] = 0, 
  ["direction"] = 0,
  ["subtype"] = 1,
  ["sprite"] = "npc/lost_old_man" })

local function rabbit_transformation()
  if not game:has_item("equipment/moon_pearl") then  

    local rabbit_link = sol.state.create("rabbit_link")
      
    rabbit_link:set_can_control_direction(true)
    rabbit_link:set_can_control_movement(true)
    rabbit_link:set_can_interact(true)
    rabbit_link:set_can_use_sword(false) 
    rabbit_link:set_can_use_shield(false)
    rabbit_link:set_can_grab(false)
    rabbit_link:set_can_use_item(false)
    rabbit_link:set_can_use_item("inventory/magic_mirror", true)
    rabbit_link:set_can_push(false)

    game:set_ability("shield", 0)

    hero:start_state(rabbit_link)

    sol.audio.play_music("rabbit")
    hero:set_tunic_sprite_id("hero/bunny")
  end
end

local function warp_on_dark_world()  
  hero:teleport(game:get_map():get_id(), "_same")

  map:set_tileset("out/outside_darkworld_main")
  rabbit_transformation()
  
  death_mountain_west_warp_0:set_enabled(false)

  shader_to_dark = sol.shader.create("fr_to_normal_colors")
  sol.video.set_shader(shader_to_dark)

  sol.audio.play_music("dark_mountain")

  up_hero:set_enabled(true)
  tp_cave_death_mountain_west_0:set_enabled(false)
  pink_ball_death_moutain_west_0:set_enabled(true)
  cursed_bully_death_moutain_west_0:set_enabled(true)
  if not game:get_value("piece_of_heart_mountain_west_0") then
    piece_of_heart_mountain_west_0:set_enabled(false)
  end

  for entity_on_screen in map:get_entities_by_type("enemy") do
    entity_on_screen:set_enabled(false)
  end     
  for jumper_dark_world in map:get_entities_by_type("jumper") do
    jumper_dark_world:set_enabled(false)
  end
  for demo_dark_world_tiles in map:get_entities("demo_dark_world_") do
    demo_dark_world_tiles:set_enabled(true)
  end
end

function up_hero:on_activated()
  hero:set_layer(1)
end

-- Event called at initialization time, as soon as this map is loaded.
function map:on_started()  
if not game:has_item("inventory/magic_mirror") then
    grandpa_follower:set_enabled(true)
    grandpa_follower:set_position(hero:get_position())
  end
end

function grandpa_dialog_arrived:on_activated()
  if grandpa_follower:is_enabled() then
    self:set_enabled(false)
    game:start_dialog("npc.grandpa.arrived", function() 
      hero:start_treasure("inventory/magic_mirror", 1, "possession_magic_mirror", function()
        hero:freeze()

        local mov_grandpa_go_at_home = sol.movement.create("target")

        mov_grandpa_go_at_home:set_target(dest_house_death_mountain_west_0)
        mov_grandpa_go_at_home:set_speed(33)
        mov_grandpa_go_at_home:set_ignore_obstacles(true)
        
        grandpa:set_position(grandpa_follower:get_position())

        --Remplace le Follower par un NPC pour qu'il puisse reach sa target
        grandpa_follower:remove()        

        mov_grandpa_go_at_home:start(grandpa, function()
          grandpa:remove()
          hero:unfreeze()
        end)
      end)
    end)
  end
end

function death_mountain_west_warp_0:on_activated()  
  sol.audio.play_sound("world_warp")
  warp_on_dark_world()
end

-- Event called after the opening transition effect of the map,
-- that is, when the player takes control of the hero.
function map:on_opening_transition_finished(destination)
  if map:get_id() == "A Link To The Past/Light World/Overworld/death_mountain_west" then    
    if destination == nil then
      if map:get_tileset() == "out/outside_lightworld_main" then 
        sol.audio.play_music("overworld")
        game:set_ability("shield", 1)  
        -- Vérifie si le Héros est sur un Obstacle, si oui, il revient dans le Dark World
        if hero:test_obstacles() then       
          local x_hero, y_hero, layer_hero = hero:get_position()
          local tmp_ground_type = map:get_ground(x_hero, y_hero, layer_hero)
          if not (tmp_ground_type == "traversable") then
            warp_on_dark_world()
          end
        end
      end
    end
  end
end

function map:on_finished()  
  sol.video.set_shader(nil)
end

function cursed_bully_death_moutain_west_0:on_interaction()  
  if not game:has_item("equipment/moon_pearl") then  
    game:start_dialog("npc.cursed_bully.meeting")
  else
    game:start_dialog("npc.cursed_bully.moon_pearl")
  end
end

function pink_ball_death_moutain_west_0:on_interaction()  
  if not game:has_item("equipment/moon_pearl") then  
    game:start_dialog("npc.pink_ball.meeting")
  else
    game:start_dialog("npc.pink_ball.moon_pearl")
  end
end