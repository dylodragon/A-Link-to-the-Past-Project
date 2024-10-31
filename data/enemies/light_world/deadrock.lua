-- Lua script of enemy deadrock.

-- A deadrock who walk randomly.
-- Transform into stone for few seconds when hitted

local enemy = ...
local game = enemy:get_game()
local map = enemy:get_map()
local hero = map:get_hero()
local sprite
local movement

-- Event called when the enemy is initialized.
enemy:register_event("on_created", function(enemy)

  -- Initialize the properties of your enemy here,
  -- like the sprite, the life and the damage.
  sprite = enemy:create_sprite("enemies/" .. enemy:get_breed())
  enemy:set_life(1)
  enemy:set_damage(2)
  enemy:set_size(16, 16)
  enemy:set_origin(8, 13)
  enemy:set_attacking_collision_mode("overlapping")
end)

-- Event called when the enemy should start or restart its movements.
-- This is called for example after the enemy is created or after
-- it was hurt or immobilized.
enemy:register_event("on_restarted", function(enemy)

  enemy:set_traversable(true)
  enemy:set_attack_consequence("sword", "immobilized")
  enemy:set_attack_consequence("thrown_item", "immobilized")
  enemy:set_attack_consequence("explosion", "immobilized")
  enemy:set_attack_consequence("arrow", "immobilized")
  enemy:set_attack_consequence("hookshot", "immobilized")
  enemy:set_attack_consequence("boomerang", "immobilized")
  enemy:set_attack_consequence("fire", "immobilized")
  enemy:set_hammer_reaction(1)

  local m = sol.movement.create("straight")
  m:set_speed(0)
  m:start(enemy)
  local direction4 = math.random(4) - 1
  enemy:go(direction4)
end)

-- Event called when the enemy is immobilized
enemy:register_event("on_immobilized", function(enemy)
  enemy:set_traversable(false)
  enemy:set_attack_consequence("sword", "protected")
  enemy:set_attack_consequence("thrown_item", "protected")
  enemy:set_attack_consequence("explosion", "protected")
  enemy:set_attack_consequence("arrow", "protected")
  enemy:set_attack_consequence("hookshot", "protected")
  enemy:set_attack_consequence("boomerang", "protected")
  enemy:set_attack_consequence("fire", "protected")
  enemy:set_hammer_reaction("protected")
end)

-- An obstacle is reached: go to the opposite direction.
enemy:register_event("on_obstacle_reached", function(enemy, movement)
  enemy:go((movement:get_direction4() + math.random(1, 3)) % 4)
end)

-- The movement is finished: stop for a while, looking to a next direction.
enemy:register_event("on_movement_finished", function(enemy, movement)
  -- stop for a while
  local animation = sprite:get_animation()
  if animation == "walking" then
    sprite:set_animation("stopped")
    sol.timer.start(enemy, math.random(500, 2500), function()
      enemy:go(math.random(4)-1)
    end)
  end
end)

-- Makes the soldier walk towards a direction.
function enemy:go(direction4)

  -- Set the sprite.
  sprite:set_animation("walking")
  sprite:set_direction(direction4)

  -- Set the movement.
  local m = enemy:get_movement()
  local max_distance = 8 + math.random(96)
  m:set_max_distance(max_distance)
  m:set_smooth(true)
  m:set_speed(110)
  m:set_angle(direction4 * math.pi / 2)
end

