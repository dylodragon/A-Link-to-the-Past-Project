local enemy = ...

-- Spark: an invincible enemy that moves in horizontal or vertical direction
-- and that runs along the walls

local last_direction4 = 0


-- The enemy appears: set its properties.
function enemy:on_created()

  self:set_life(1)
  self:create_sprite("enemies/" .. enemy:get_breed())
  self:set_can_hurt_hero_running(true)
  self:set_invincible()
  self:set_obstacle_behavior("swimming")

end

-- The enemy was stopped for some reason and should restart.
function enemy:on_restarted()

  local sprite = enemy:get_sprite()
  local direction4 = sprite:get_direction()
  self:go(direction4)

end

function enemy:on_obstacle_reached()
  self:go((last_direction4 + 1) % 4)       
end

function enemy:on_position_changed()
  self:go_if_traversable((last_direction4 - 1) % 4)
 end

function enemy:go_if_traversable(direction4)

    local dxy = {
                { x =  1, y =  0},
                { x =  0, y = -1},
                { x = -1, y =  0},
                { x =  0, y =  1}
              }
    if not self:test_obstacles(dxy[direction4 + 1].x, dxy[direction4 + 1].y) then
        self:go(direction4)
    end

end


-- Makes the Fireball go towards a horizontal or vertical direction.
function enemy:go(direction4)

  local m = sol.movement.create("straight")
  m:set_speed(64)
  m:set_smooth(false)
  m:set_angle(direction4 * math.pi / 2)
  m:start(self)
  
  last_direction4 = direction4

end

function enemy:on_attacking_hero(hero)
  local game = enemy:get_game()
	game:remove_life(3)
  hero:start_hurt(enemy, 1)
end