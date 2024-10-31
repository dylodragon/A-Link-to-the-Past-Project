-- Bone projectile, mainly used by the red skeleton enemy.

local enemy = ...

-- Global variables
local sprite = enemy:create_sprite("enemies/" .. enemy:get_breed())

-- Start going to the hero.
local function go(angle)

  local movement = sol.movement.create("straight")
  movement:set_speed(96)
  movement:set_angle(angle)
  movement:set_smooth(false)

  function movement:on_obstacle_reached()
    enemy:remove()
  end

  movement:start(enemy)
end

-- Initialization.
enemy:register_event("on_created", function(enemy)

  enemy:set_life(1)
  enemy:set_size(16, 16)
  enemy:set_origin(8, 8)
  enemy:set_damage(2)
  enemy:set_obstacle_behavior("flying")
  enemy:set_can_hurt_hero_running(true)
  enemy:set_layer_independent_collisions(true)
  enemy:set_minimum_shield_needed(1)
  enemy:set_invincible()
end)

-- Restart settings.
enemy:register_event("on_restarted", function(enemy)
  local hero = enemy:get_map():get_hero()
  local angle = enemy:get_angle(hero:get_center_position())
  sprite:set_animation("walking")
  go(angle)
end)