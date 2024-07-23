module Busty
  BATTLE_CONFIG = {
    "Carina" => {
      "Shield of Purity" => {
        face_name: "Carina emo",
        face_index: 5,
      },
    },
    "Simon2" => {
      "Commanding Presence" => {
        face_name: "1 Simon dark eyes",
        face_index: 0,
      },
      "Support Allies" => {
        face_name: "1 Simon dark eyes2",
        face_index: 6,
      },
      "SS heal component" => {
        face_name: "1 Simon dark",
        face_index: 5,
      },
    },
    "Yarra" => {
      "Lightning Whip" => {
        face_name: "Yarra emo",
        face_index: 7,
        synergy: {
          face_name: "Robin blond emo",
          face_index: 5,
        }
      },
      "Succubus Kiss" => {
        face_name: "Yarra emo2",
        face_index: 6,
      },
    },
  }

  # Share config between the three effectively identical variants of Simon's "Support XXX" skill
  BATTLE_CONFIG["Simon2"]["Support Slaves"] = BATTLE_CONFIG["Simon2"]["Support Servants"] = BATTLE_CONFIG["Simon2"]["Support Allies"]
end

class Scene_Battle < Scene_Base
  alias original_478_execute_action execute_action
  def execute_action
    return original_478_execute_action if bust_feature_disabled?

    @bust = Busty::Bust.new(999) if @bust.nil?
    synergy_bust = Busty::Bust.new(1001)

    if show_bust?
      @bust.draw(
        bust_offset_x,
        bust_offset_y,
        move_config[:face_name],
        move_config[:face_index]
      )

      if move_config[:synergy]
        synergy_offset = 32
        synergy_bust.draw(
          move_config[:synergy][:bust_offset_x] || (bust_offset_x - 32),
          move_config[:synergy][:bust_offset_y] || 64,
          move_config[:synergy][:face_name],
          move_config[:synergy][:face_index]
        )
      end
    end

    original_478_execute_action

    synergy_bust.erase
    synergy_bust.dispose

    # Simon's Support skill is actually two skills, and the cleanup should only happen after the second one
    unless is_simon_support_skill?
      @bust.erase
      @bust.dispose
      @bust = nil
    end
  end

  alias original_478_turn_start turn_start
  def turn_start
    return original_478_turn_start if bust_feature_disabled?

    # Compromise value: Keeping the bar perfectly centered doesn't leave enough space for the busts
    # But moving it fully to the right (+16*4) means too much empty space
    @status_window.x = 128+16*2

    original_478_turn_start
  end

  alias original_478_turn_end turn_end
  def turn_end
    return original_478_turn_end if bust_feature_disabled?

    @status_window.x = 128

    original_478_turn_end
  end

  def bust_feature_disabled?
    $game_switches[YEA::SYSTEM::CUSTOM_SWITCHES[:hide_battle_bust][0]]
  end

  def show_bust?
    # Only for party members, not enemies
    return false unless @subject.is_a?(Game_Actor)

    Busty::has_bust?(character_name)
  end

  def is_simon_support_skill?
    ["Support Slaves", "Support Servants", "Support Allies"].include?(current_move_name)
  end

  def move_config
    default = { face_name: @subject.face_name, face_index: @subject.face_index }

    return default unless Busty::BATTLE_CONFIG[character_name]

    Busty::BATTLE_CONFIG[character_name][current_move_name] || default
  end

  def current_move_name
    # Trimming because some moves have invisible spaces in them (ex: "Shield of Purity ")
    @subject.current_action.item.name.strip
  end

  def character_name
    character_name = Busty::character_from_face(@subject.face_name, @subject.face_index)
  end

  def bust_offset_x
    bust_config[:bust_offset_x] || -48
  end

  def bust_offset_y
    bust_config[:bust_offset_y] || 0
  end

  def bust_config
    Busty::BATTLE_CONFIG[character_name] || {}
  end
end

class Game_Actor < Game_Battler
  # Make screen_x relative to status_window.x instead of a hardcoded 128
  def screen_x
    return 0 unless SceneManager.scene_is?(Scene_Battle)
    status_window = SceneManager.scene.status_window
    return 0 if status_window.nil?
    item_rect_width = (status_window.width-24) / $game_party.max_battle_members
    ext = SceneManager.scene.info_viewport.ox
    rect = SceneManager.scene.status_window.item_rect(self.index)
    return SceneManager.scene.status_window.x + 12 + rect.x + item_rect_width / 2 - ext
  end
end

YEA::SYSTEM::CUSTOM_SWITCHES.merge!({
  hide_battle_bust: [
    14, # Switch Number; make sure it's not used for something else
    "Busts in battles",
    "Hide",
    "Show",
    "Show party members in big when they act in battle.",
    true
  ]
})
YEA::SYSTEM::COMMANDS.insert(YEA::SYSTEM::COMMANDS.find_index(:animations)+1, :hide_battle_bust)
class Scene_System < Scene_MenuBase
  alias_method :original_297_command_reset_opts, :command_reset_opts
  def command_reset_opts
    $game_switches[YEA::SYSTEM::CUSTOM_SWITCHES[:hide_battle_bust][0]] = false

    original_297_command_reset_opts
  end
end
