local door_meta=sol.main.get_metatable("door")

door_meta:register_event("on_opened", function(door)

  local hero = door:get_map():get_hero()
  local game = door:get_game()
  local map = door:get_map()
  local name = door:get_name()

  if name == nil then
    return
  end

  -- Murs fissurés: Son de secret
  if name:match("^weak_door") then
    sol.audio.play_sound("secret")
  end

end)