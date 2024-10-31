-- Initializes enemy helper functions.

local enemy_meta = sol.main.get_metatable("enemy")

function enemy_meta:receive_attack_consequence(attack, reaction, enemy_sprite)

  if type(reaction) == "number" then
    self:hurt(reaction)
  elseif reaction == "immobilized" then
    self:immobilize()
  elseif reaction == "protected" then
    sol.audio.play_sound("sword_tapping")
  elseif reaction == "custom" then
    if self.on_custom_attack_received ~= nil then
      self:on_custom_attack_received(attack, enemy_sprite)
    end
  end

end
