-- Lua script of enemy bosses/agahnim_projo_1.
local enemy = ...
local map = enemy:get_map()
local hero = map:get_hero()
local sprite

local bounced = false

function enemy:on_created()
  sprite = enemy:create_sprite("enemies/" .. enemy:get_breed())
  enemy:set_invincible()
  enemy:set_life(1)
  enemy:set_damage(4)
  enemy:set_size(16, 16)
  enemy:set_origin(8, 8)
  enemy:set_obstacle_behavior("flying")
  enemy:set_attack_consequence("sword", "custom")
  enemy:set_attacking_collision_mode("overlapping")
end

function enemy:on_restarted()
  local hero_x, hero_y = hero:get_center_position()
  local angle = enemy:get_angle(hero_x, hero_y)
  enemy:go(angle, 140)
  sprite:set_animation("walking")
  sprite:set_direction(2)
  sol.timer.start(enemy, 90, function()
    local x, y, layer = enemy:get_position()
    local particule = enemy:get_map():create_custom_entity({
      layer = layer,
      x = x,
      y = y,
      direction = 2,
      width = 8,
      height = 8,
      sprite = "enemies/bosses/agahnim_projo_1",
    })
    local sprite_particule = particule:get_sprite()
    sprite_particule:set_animation(sprite_particule:get_animation(), function()
      particule:remove()
    end)
    sol.timer.start(particule, 90, function()
      if particule:get_direction() > 0 then
        particule:set_direction(particule:get_direction()-1)
        return true
      else
        particule:remove()
      end
    end)
    return true
  end)
end

function enemy:go(angle, speed)
  local movement = sol.movement.create("straight")
  movement:set_speed(speed)
  movement:set_angle(angle)
  movement:set_smooth(false)
  movement:set_max_distance(400)
  movement:start(enemy)
end

function enemy:on_obstacle_reached()
  enemy:remove()
end

function enemy:on_custom_attack_received(attack, sprite)
  if attack == "sword" then
    local movement = enemy:get_movement()
    if movement == nil then
      return
    end
    local old_angle = movement:get_angle()
    local angle
    local hero_direction = hero:get_direction()
    if hero_direction == 0 or hero_direction == 2 then
      angle = math.pi - old_angle
    else
      angle = 2 * math.pi - old_angle
    end
    enemy:go(angle, 180)
    sol.audio.play_sound("sword_tapping")
    sol.audio.play_sound("boss_fireball")
    bounced = true
    -- The trailing fireballs are now on the hero: don't attack temporarily
    enemy:set_can_attack(false)
    sol.timer.start(enemy, 500, function()
      enemy:set_can_attack(true)
    end)
  end
end

function enemy:on_collision_enemy(other_enemy)
  if bounced then
    if other_enemy.receive_bounced_projectile ~= nil then
      other_enemy:receive_bounced_projectile(enemy)
    end
  end
end
