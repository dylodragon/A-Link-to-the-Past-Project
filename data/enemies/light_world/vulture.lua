local enemy = ...

-- A vulture that sleeps until the hero gets close.

local behavior = require("enemies/library/waiting_for_hero")

local properties = {
  sprite = "enemies/" .. enemy:get_breed(),
  life = 3,
  damage = 4,
  normal_speed = 64,
  faster_speed = 64,
  ignore_obstacles = true,
  obstacle_behavior = "flying",
  waking_distance = 150,
}

behavior:create(enemy, properties)
enemy:set_attack_consequence("thrown_item",4)

enemy:set_layer_independent_collisions(true)
