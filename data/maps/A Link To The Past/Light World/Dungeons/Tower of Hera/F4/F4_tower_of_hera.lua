local map = ...
local game = map:get_game()

local door_manager = require("scripts/maps/door_manager")
door_manager:manage_map(map)
local chest_manager = require("scripts/maps/chest_manager")
chest_manager:manage_map(map)
local separator_manager = require("scripts/maps/separator_manager")
separator_manager:manage_map(map)


function map:on_started(destination)

  local ground=game:get_value("tp_ground")
  if ground=="hole" then
    hero:set_visible(false)
  else
    hero:set_visible()
  end

  -- Initialisation Switches Etoiles
  switch_hole_A_1:set_activated(true)

  switch_hole_B_4:set_visible(false)

end

-- SWITCHES ETOILES ET TROUS
for switch in map:get_entities("switch_hole_B_") do
  function switch:on_activated()
    sol.audio.play_sound("secret")
    map:set_entities_enabled("hole_B_", true)
    map:set_entities_enabled("hole_A_", false)
    for switch in map:get_entities("switch_hole_A_") do switch:set_activated(false) end
    for switch in map:get_entities("switch_hole_B_") do switch:set_activated(true) end
  end
end
for switch in map:get_entities("switch_hole_A_") do
  function switch:on_activated()
    sol.audio.play_sound("secret")
    map:set_entities_enabled("hole_A_", true)
    map:set_entities_enabled("hole_B_", false)
    for switch in map:get_entities("switch_hole_B_") do switch:set_activated(false) end
    for switch in map:get_entities("switch_hole_A_") do switch:set_activated(true) end
  end
end