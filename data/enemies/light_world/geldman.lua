local enemy = ...

local behavior = require("enemies/library/waiting_for_hero")

local properties = {
  sprite = "enemies/" .. enemy:get_breed(),
  life = 2,
  damage = 4,
  normal_speed = 64,
  faster_speed = 64,
  waking_distance = 80,
}

behavior:create(enemy, properties)
enemy:set_attack_consequence("thrown_item",4)
