local enemy = ...

local behavior = require("enemies/library/towards_hero")

local properties = {
  sprite = "enemies/" .. enemy:get_breed(),
  life = 4,
  damage = 2,
  normal_speed = 40,
  faster_speed = 40,
}

behavior:create(enemy, properties)
