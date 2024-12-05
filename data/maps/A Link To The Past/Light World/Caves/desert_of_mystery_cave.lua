-- Lua script of map A Link To The Past/Light World/Caves/desert_of_mistery_cave.
-- This script is executed every time the hero enters this map.

-- Feel free to modify the code below.
-- You can add more events and remove the ones you don't need.

-- See the Solarus Lua API documentation:
-- http://www.solarus-games.org/doc/latest

local map = ...
local game = map:get_game()

local already_meet = false

-- Event called at initialization time, as soon as this map is loaded.
function map:on_started()

  -- You can initialize the movement and sprites of various
  -- map entities here.
end

-- Event called after the opening transition effect of the map,
-- that is, when the player takes control of the hero.
function map:on_opening_transition_finished()

end

function wiseman:on_interaction()
  if game:get_value("already_meet") and game:has_item("quest/pendant_of_power") then
    game:start_dialog("npc.wiseman.after_pendant")
  elseif game:get_value("already_meet") and game:has_item("equipment/book_of_mudora") then
    game:start_dialog("npc.wiseman.book_of_mudora")
  else
    game:start_dialog("npc.wiseman.first_meeting")
       game:set_value("already_meet", true)
  end
end