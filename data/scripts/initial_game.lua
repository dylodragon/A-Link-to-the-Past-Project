-- This script initializes game values for a new savegame file.
-- You should modify the initialize_new_savegame() function below
-- to set values like the initial life and equipment
-- as well as the starting location.
--
-- Usage:
-- local initial_game = require("scripts/initial_game")
-- initial_game:initialize_new_savegame(game)

local initial_game = {}

-- Sets initial values to a new savegame file.
function initial_game:initialize_new_savegame(game)

  -- You can modify this function to set the initial life and equipment
  -- and the starting location.
  game:set_starting_location("A Link To The Past/Light World/Houses/link_house", "newgame")

  game:set_max_life(12)
  game:set_life(game:get_max_life())
  game:set_max_money(999)
  game:set_ability("lift", 0)
  game:get_item("equipment/tunic"):set_variant(1)
  game:get_item("equipment/piece_of_heart_counter"):set_variant(1)
  game:get_item("equipment/bomb_bag"):set_variant(1)
  
  -- default command binding
  game:set_value("keyboard_save", "escape")
  game:set_value("joypad_save", "button 8")

  game:set_value("time_played", 0)
  game:set_value("death_counter", 0)
end

return initial_game
