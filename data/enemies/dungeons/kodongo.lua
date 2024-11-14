-- Kodongo: shoots fire.

local enemy = ...

local can_shoot = true

function enemy:on_created()

  enemy:set_life(1)
  enemy:set_damage(4)
  enemy:create_sprite("enemies/" .. enemy:get_breed())
end

local function go_hero()

  local sprite = enemy:get_sprite()
  sprite:set_animation("walking")
  local movement = sol.movement.create("random_path")
  movement:set_speed(40)
  movement:start(enemy)
end

local function shoot()

  local map = enemy:get_map()
  local hero = map:get_hero()
  if not enemy:is_in_same_region(hero) then
    return true  -- Repeat the timer.
  end

  local sprite = enemy:get_sprite()
  local x, y, layer = enemy:get_position()
  local direction = sprite:get_direction()

  -- Where to create the projectile.
  local dxy = {
    {  8,  -4 },
    {  0, -13 },
    { -8,  -4 },
    {  0,   0 },
  }
  local i = 0

  sprite:set_animation("shooting")
  enemy:stop_movement()
  sol.timer.start(enemy, 300, function()
      sol.timer.start(300,function()
        i = i + 1
        if enemy:get_sprite():get_animation() == "hurt" then return end
        sol.audio.play_sound("lantern")
        local fire = enemy:create_enemy({
          breed = "others/kodongo_flame",
          x = dxy[direction + 1][1],
          y = dxy[direction + 1][2],
        })
        fire:go(direction)

        if i == 3 then i = 0 else return true end
      end)

    sol.timer.start(enemy, 1200, go_hero)
  end)
end

function enemy:on_restarted()

  local map = enemy:get_map()
  local hero = map:get_hero()

  go_hero()

  can_shoot = true

  sol.timer.start(enemy, 100, function()

    local hero_x, hero_y = hero:get_position()
    local x, y = enemy:get_center_position()

    if can_shoot then
      local aligned = (math.abs(hero_x - x) < 16 or math.abs(hero_y - y) < 16) 
      if aligned and enemy:get_distance(hero) < 200 then
        shoot()
        can_shoot = false
        sol.timer.start(enemy, 1500 + 1500, function() -- l'animation prend 1.5s environ
          can_shoot = true
        end)
      end
    end
    return true  -- Repeat the timer.
  end)
end

function enemy:on_movement_changed(movement)

  local direction4 = movement:get_direction4()
  local sprite = self:get_sprite()
  sprite:set_direction(direction4)
end