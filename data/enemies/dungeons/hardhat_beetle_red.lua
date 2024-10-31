local enemy = ...

-- Red Hardhat Beetle.

function enemy:on_created()

  enemy:set_life(8)
  enemy:set_damage(6)
  enemy:create_sprite("enemies/" .. enemy:get_breed())
end

local function go_hero()

  local sprite = enemy:get_sprite()
  sprite:set_animation("walking")
  movement:set_speed(min_speed)
  movement:start(enemy)
end

function movement:on_changed()
  if(speed < max_speed and not speed_change) then
    speed_change = true -- Pour éviter plusieurs modifications simultanées
    sol.timer.start(enemy, 1500/(max_speed - min_speed), function() -- Temps d'accélération fixé à 1500ms
      speed = speed + 1      
      movement:set_speed(speed)
      movement:start(enemy)
      return speed < max_speed
    end)
  end

end

function enemy:on_restarted()

  local map = enemy:get_map()
  local hero = map:get_hero()
  speed = min_speed
  speed_change = false
  go_hero()

end