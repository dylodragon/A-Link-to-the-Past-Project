local item = ...
local game = item:get_game()

-- Event called when the game is initialized.
function item:on_started()
  item:set_savegame_variable("possession_moon_pearl")
  item:set_assignable(false)
end