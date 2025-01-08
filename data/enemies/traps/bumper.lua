-- Lua script of enemy traps/bumper.

local enemy = ...
local game = enemy:get_game()
local map = enemy:get_map()
local hero = map:get_hero()
local sprite = enemy:create_sprite("enemies/" .. enemy:get_breed())
local sprite_collision = enemy:create_sprite("enemies/" .. enemy:get_breed())
local var_bounce = 0
local actual_direction4 = -1

local check_mode = enemy:get_property("on_move")
if check_mode == nil then
  check_mode = false
elseif check_mode ~= true then
  check_mode = false
end

function enemy:on_created()
  enemy:set_invincible()
  enemy:set_life(1)
  enemy:set_damage(0)
  sprite_collision:set_opacity(0)
  sprite:set_xy(0, -5)
  enemy:set_can_hurt_hero_running(true)
end

function enemy:on_restarted()
  if actual_direction4 == -1 then
    actual_direction4 = enemy:get_sprite():get_direction()
  end

  sol.timer.start(enemy, 25, function()
    local x_move, y_move = 1, 0
    if actual_direction4 == 1 then
      x_move, y_move = 0, -1
    elseif actual_direction4 == 2 then
      x_move, y_move = -1, 0
    elseif actual_direction4 == 3 then
      x_move, y_move = 0, 1
    end
    if not enemy:test_obstacles(x_move, y_move) then
      local x, y = enemy:get_position()
      if check_mode then enemy:set_position(x+x_move, y+y_move) end
      enemy:restart()
    else
      actual_direction4 = (actual_direction4+1)%4
      enemy:restart()
    end
  end)

  if var_bounce > 0 then
    sol.timer.start(enemy, 10, function()
      if var_bounce > 0 then
        var_bounce = var_bounce-1
        return true
      else
        var_bounce = 0
      end
    end)
  end
end

function enemy:on_attacking_hero(hero, enemy_sprite)
  if enemy_sprite == sprite then return end
  local x, y = enemy:get_position()
  local temp_angle = -sol.main.get_angle(x, y, hero:get_position())
  local bounce_power = (sol.main.get_distance(x, y, hero:get_position()))/6

  local posi_x_add, posi_y_add = math.cos(temp_angle)*bounce_power, math.sin(temp_angle)*bounce_power
  local timer_repeat = 12
  if var_bounce <= 20 then
    sol.audio.play_sound("bounce")

    var_bounce = 25
    hero:freeze()
    sol.timer.start(hero, 25, function()
      if hero:get_animation() == "stopped" or hero:get_animation() == "stopped_with_shield" then
        local h_x, h_y  = hero:get_position()
        if not hero:test_obstacles(posi_x_add, posi_y_add) then
          hero:set_position(h_x+posi_x_add, h_y+posi_y_add)
        else
          if not hero:test_obstacles(posi_x_add, 0) then
            hero:set_position(h_x+posi_x_add, h_y)
          end
          if not hero:test_obstacles(0, posi_y_add) then
            hero:set_position(h_x, h_y+posi_y_add)
          end
        end
        timer_repeat = timer_repeat-1
      else 
        timer_repeat = 0      
      end
      if timer_repeat <= 0 then 
        hero:unfreeze()
      end
      return timer_repeat > 0
    end)
  end
end

function enemy:on_pre_draw()
  sprite:set_opacity(255)
  sprite:set_rotation( (sol.main.get_elapsed_time()/1024)%(math.pi*2) )

  sprite:set_direction(7)
  map:draw_visual(sprite, enemy:get_position())
  for i = 0, 3 do
    if i == 0 then
      sprite:set_scale(1, 1)
    elseif i == 1 then
      sprite:set_scale(1, -1)
    elseif i == 2 then
      sprite:set_scale(-1, 1)
    else
      sprite:set_scale(-1, -1)
    end
    local scale_x, scale_y = sprite:get_scale()

    local recalcul_1 = (math.sin( (var_bounce/3)*var_bounce )/12)+1
    sprite:set_scale(scale_x*recalcul_1, scale_y*recalcul_1)

    sprite:set_direction(6)
    map:draw_visual(sprite, enemy:get_position())
    sprite:set_direction(5)
    map:draw_visual(sprite, enemy:get_position())

    sprite:set_direction(4)
    map:draw_visual(sprite, enemy:get_position())

    sprite:set_scale(scale_x, scale_y)
  end
  sprite:set_opacity(0)
end
