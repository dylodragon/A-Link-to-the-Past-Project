local map = ...
local game = map:get_game()

function chest_boomerang:on_opened()
  if game:get_value("get_boomerang_1") then
    hero:start_treasure("consumables/arrow_refill",1,"after_boomerang_arrow")
  else
    hero:start_treasure("inventory/boomerang",1,"get_boomerang_1")
  end
end

function weak_door_1:on_opened() sol.audio.play_sound("secret") end