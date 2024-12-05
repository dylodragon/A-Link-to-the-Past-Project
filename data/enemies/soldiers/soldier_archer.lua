-- Lua script of enemy Soldier Archer.
local enemy = ...

local game = enemy:get_game()
local map = enemy:get_map()
local hero = map:get_hero()
local sprite = {}
local x, y = enemy:get_position()
local speed = 6
local projectile_speed = 96
local projectile_damage = 2

local view_distance = 88
local targeted_hero = false
local target_cooldown = 0

 -- radians to degrees
-- for the opposite, use "math.rad" for degrees to radian
local function get_degrees(radians)
  return radians*(180/math.pi)
end

function enemy:on_created()

  -- apparence
  sprite[0] = enemy:create_sprite("enemies/" .. enemy:get_breed())
  sprite[1] = enemy:create_sprite("enemies/" .. enemy:get_breed() .. "_head")
  -- statistique
  projectile_speed = 255
  enemy:set_life(3)
  enemy:set_damage(2)
  enemy:set_attack_consequence("boomerang", "immobilized")
  enemy:set_attack_consequence("sword", 1)
  enemy:set_attack_consequence("thrown_item", 4)
  enemy:set_attack_consequence("arrow", 4)
  enemy:set_attack_consequence("hookshot", "immobilized")
  enemy:set_attack_consequence("explosion", 4)
 -- Silver Arrow = 100
 --enemy:set_magic_powder_reaction("ignored") -- buguee, a corriger car ils ont oubliee d'ajouter du code pour le faire fonctionner.
  enemy:set_attack_consequence("fire", 253) -- Fire rod, not Lamp
  enemy:set_ice_reaction(254)
 -- Medallion Bombos = 253
 -- Medallion Ether = 254
 -- Medallion Quake = 250

  enemy:set_size(16, 16)
  enemy:set_origin(8, 13)
  enemy:set_attacking_collision_mode("overlapping")
  local stupid_function = sprite[0]
  function stupid_function:on_direction_changed(animation, direction)
    if direction == 0 then
      sprite[1]:set_xy(0, 4)
    elseif direction == 1 then
      sprite[1]:set_xy(0, 4)
    elseif direction == 2 then
      sprite[1]:set_xy(0, 4)
    elseif direction == 3 then
      sprite[1]:set_xy(0, 4)
    else
      sprite[1]:set_xy(0, 4)
    end
  end
  if direction == 0 then
    sprite[1]:set_xy(0, 4)
  elseif direction == 1 then
    sprite[1]:set_xy(0, 4)
  elseif direction == 2 then
    sprite[1]:set_xy(0, 4)
  elseif direction == 3 then
    sprite[1]:set_xy(0, 4)
  else
    sprite[1]:set_xy(0, 4)
  end
end

function enemy:seen_hero()
  targeted_hero = true
  target_cooldown = 100
end

function enemy:on_restarted()

  x, y = enemy:get_position()
  local distance_h_and_m = sol.main.get_distance(x, y, hero:get_position())
  local angle_m_and_h = math.abs( get_degrees(sol.main.get_angle(x, y, hero:get_position())) )

  if target_cooldown <= 0 then
    targeted_hero = false
  end

  if targeted_hero then -- IA lorsque joueur ciblee
    sprite[0]:set_animation("walking")
    local attack_frequency = 100
    sol.timer.start(enemy, 10, function()
      local previous_x, previous_y = x, y
      attack_frequency = attack_frequency-1
      distance_h_and_m = sol.main.get_distance(x, y, hero:get_position())
      angle_m_and_h = sol.main.get_angle(x, y, hero:get_position())
      if distance_h_and_m > view_distance then
        target_cooldown = target_cooldown-1
      end
      if attack_frequency == 0 then
        sprite[0]:set_animation("attack")
        sol.timer.start(enemy, 200/(speed/8), function()
          local beam = enemy:create_enemy({
            breed = "soldiers/soldier_archer_projectile",
          })
          beam:set_speed(projectile_speed)
          beam:set_damage(projectile_damage)
          beam:go(sprite[0]:get_direction())
          enemy:restart()
        end)
      else
        for k, v in pairs(sprite) do
          v:set_direction(  enemy:get_direction4_to(hero:get_position())  )
        end
        local calcul_angle = random_angle
        if distance_h_and_m < 48 then -- Si heros trop proche, enemy s eloigne
          calcul_angle = angle_m_and_h-math.pi
        elseif distance_h_and_m > 88 then -- si heros trop loin, enemy s approche
          calcul_angle = angle_m_and_h
        else -- si la distance entre hero et enemy est correct, il essaie daller a la position hori ou verti parfait
          local temp_1, temp_2 = hero:get_position()
          local temp_x = {}
          local temp_y = {}
          local distance_prio = 5000
          local dir_prioritize
          temp_x[0], temp_y[0] = temp_1+64, temp_2
          temp_x[1], temp_y[1] = temp_1, temp_2-64
          temp_x[2], temp_y[2] = temp_1-64, temp_2
          temp_x[3], temp_y[3] = temp_1, temp_2+80
          for i = 0, 3 do
            if distance_prio > sol.main.get_distance(x, y, temp_x[i], temp_y[i]) then
              distance_prio = sol.main.get_distance(x, y, temp_x[i], temp_y[i])
              dir_prioritize = i
            end
          end
          if sol.main.get_distance(x, y, temp_x[dir_prioritize], temp_y[dir_prioritize]) <= 4 then
            return true
          end
          calcul_angle = sol.main.get_angle(x, y, temp_x[dir_prioritize], temp_y[dir_prioritize])
        end
        local calcul_speed = speed/8
        if not enemy:test_obstacles(math.cos(calcul_angle)*calcul_speed, -math.sin(calcul_angle)*calcul_speed) then
          x, y = x+(math.cos(calcul_angle)*calcul_speed), y-(math.sin(calcul_angle)*calcul_speed)
        elseif not enemy:test_obstacles(0, -math.sin(calcul_angle)*calcul_speed) then
          y = y-(math.sin(calcul_angle)*calcul_speed)
        elseif not enemy:test_obstacles(math.cos(calcul_angle)*speed, 0) then
          x = x+(math.cos(calcul_angle)*calcul_speed)
        end
        enemy:set_position(x, y)
        if enemy:test_obstacles(0, 0) then
          x, y = previous_x, previous_y
          enemy:set_position(previous_x, previous_y)
        end
        return true
      end
    end)

  else -- IA lorsque le monstre ne poursuit plus le joueur
    local random_distance = math.random(0,1000)
    local choose_direction = math.ceil(math.random(0,3))
    local temp_x, temp_y = 0, 0
    local look_to_left, look_to_right = 0, 0
    if choose_direction == 0 then
      temp_x = 1
      look_to_left = 1
      look_to_right = 3
    elseif choose_direction == 1 then
      temp_y = -1
      look_to_left = 2
      look_to_right = 0
    elseif choose_direction == 2 then
      temp_x = -1
      look_to_left = 3
      look_to_right = 1
    else
      temp_y = 1
      look_to_left = 0
      look_to_right = 2
    end
    local timer_repeat = 0
    for k, v in pairs(sprite) do
      v:set_direction(  choose_direction  )
    end
    sol.timer.start(enemy, 10, function()
      local previous_x, previous_y = x, y
      timer_repeat = timer_repeat+1
      distance_h_and_m = sol.main.get_distance(x, y, hero:get_position())
      angle_m_and_h = math.abs( get_degrees(sol.main.get_angle(x, y, hero:get_position())) )
      if distance_h_and_m <= view_distance then 
        if angle_m_and_h > 45 and angle_m_and_h <= 135 then
          -- Haut
          if sprite[1]:get_direction() == 1 then
            enemy:seen_hero()
            enemy:restart()
          end
        elseif angle_m_and_h > 135 and angle_m_and_h <= 225 then
          -- Gauche
          if sprite[1]:get_direction() == 2 then
            enemy:seen_hero()
            enemy:restart()
          end
        elseif angle_m_and_h > 225 and angle_m_and_h <= 315 then
          -- Bas
          if sprite[1]:get_direction() == 3 then
            enemy:seen_hero()
            enemy:restart()
          end
        else
          -- Droite
          if sprite[1]:get_direction() == 0 then
            enemy:seen_hero()
            enemy:restart()
          end
        end
      end
      if timer_repeat <= 100+random_distance and timer_repeat%4 == 0 then
        if sprite[0]:get_animation() ~= "walking" then sprite[0]:set_animation("walking") end
        if sprite[1]:get_animation() ~= "walking" then sprite[1]:set_animation("walking") end
        if not enemy:test_obstacles(0+(temp_x*(speed/8)), 0+(temp_y*(speed/8))) then
          x, y = x+(temp_x*(speed/8)), y+(temp_y*(speed/8))
        elseif not enemy:test_obstacles(0+(temp_x), 0+(temp_y)) then
          x, y = x+(temp_x), y+(temp_y)
        end
      elseif timer_repeat > 100+random_distance and timer_repeat <= 150+random_distance then
        if sprite[0]:get_animation() ~= "stopped" then sprite[0]:set_animation("stopped") end
        if sprite[1]:get_animation() ~= "stopped" then sprite[1]:set_animation("stopped") end
      elseif timer_repeat > 150+random_distance and timer_repeat <= 200+random_distance then
        sprite[1]:set_direction(look_to_left)
      elseif timer_repeat > 200+random_distance and timer_repeat <= 250+random_distance then
        sprite[1]:set_direction(sprite[0]:get_direction())
      elseif timer_repeat > 250+random_distance and timer_repeat <= 300+random_distance then
        sprite[1]:set_direction(look_to_right)
      elseif timer_repeat > 300+random_distance and timer_repeat <= 350+random_distance then
        sprite[1]:set_direction(sprite[0]:get_direction())
      elseif timer_repeat > 450+random_distance then
        enemy:restart()
      end
      enemy:set_position(x, y)
      if enemy:test_obstacles(0, 0) then
        random_distance = 0
        x, y = previous_x, previous_y
        enemy:set_position(previous_x, previous_y)
      end
      return true
    end)

  end
end

function enemy:on_immobilized(hero, enemy_sprite)
  enemy:seen_hero()
end

function enemy:on_hurt(hero, enemy_sprite)
  enemy:seen_hero()
end