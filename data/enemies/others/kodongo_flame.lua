-- Flame shot by Kodongo.

local enemy = ...

function enemy:on_created()

  enemy:set_life(1)
  enemy:set_damage(4)
  enemy:create_sprite("enemies/" .. enemy:get_breed())
  enemy:set_invincible()
  enemy:set_obstacle_behavior("flying")
  enemy:set_property("is_major","true")
  enemy:set_minimum_shield_needed(3) -- Miror shield.
end

function enemy:on_obstacle_reached()
  enemy:stop_movement()
  enemy:get_sprite():set_animation("stare")
  sol.timer.start(self, 1500, function()
    self:get_sprite():set_animation("disapear",function() 
      enemy:remove()
    end)
  end)
end

function enemy:go(direction4)

  local angle = direction4 * math.pi / 2
  local movement = sol.movement.create("straight")
  movement:set_speed(96)
  movement:set_angle(angle)
  movement:set_smooth(false)
  movement:start(enemy)

  enemy:get_sprite():set_direction(direction4)
end