module Busty
  BATTLE_CONFIG = {
    "Aka" => {
      "Disabling Assault" => {
        face_name: "Aka emo",
        face_index: 0,
      },
      "Forceful Lunge" => {
        # face_name is actually optional for characters with a single faceset
        face_index: 2,
      },
    },
    "Carina" => {
      "Shield of Purity" => {
        face_index: 5,
      },
      "Smite" => {
        face_index: 7,
        # While this option is named synergy, it can be actually be used to display any bust for any move
        synergy: {
          face_name: "Ivala emo",
          face_index: 3,
          bust_offset_x: 360,
          bust_offset_y: 0,
        }
      }
    },
    "Simon1" => {
      "Commanding Presence" => {
        face_name: "face002b dark",
        face_index: 0,
      },
      "Support Allies" => {
        face_name: "face002b dark2",
        face_index: 6,
      },
      "SS heal component" => {
        face_name: "face002b",
        face_index: 5,
      },
    },
    "Uyae" => {
      "Aura of Might" => {
        picture: "busts/Uyae Punch",
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

  # Show the same "animation" for all of Aka's debuff strikes
  BATTLE_CONFIG["Aka"]["Weakening Stab"] = BATTLE_CONFIG["Aka"]["Crippling Stab"] = BATTLE_CONFIG["Aka"]["Piercing Stab"] = BATTLE_CONFIG["Aka"]["Disabling Assault"]
  # Share config between the three effectively identical variants of Simon's "Support XXX" skill
  BATTLE_CONFIG["Simon1"]["Support Slaves"] = BATTLE_CONFIG["Simon1"]["Support Servants"] = BATTLE_CONFIG["Simon1"]["Support Allies"]

  # Configure alternative forms
  DUPLICATE_MOVESETS = {
    "Aka" => "Aka2",
    "Aka emo" => "Aka emo2",
    "Simon1" => "Simon2",
    "face002b" => "1 Simon dark",
    "face002b2" => "1 Simon dark2",
    "face002b dark" => "1 Simon dark eyes",
    "face002b dark2" => "1 Simon dark eyes2",
    "Hilstara" => "HilstaraKnight",
    "Hilstara emo" => "Hilstara emo3",
    "Nalili" => "Nalili2",
    "Neranda emo1" => "Neranda emo3",
    "Neranda emo2" => "Neranda emo4",
    "Robin blond" => "Robin grey",
    "Robin blond emo" => "Robin grey emo",
    "Uyae" => "Uyae God Flip",
    "Uyae emo" => "Uyae emo2d",
  }

  DUPLICATE_MOVESETS.each do |original, copy|
    next unless BATTLE_CONFIG[original]

    BATTLE_CONFIG[copy] = Marshal.load(Marshal.dump(BATTLE_CONFIG[original])) # Deep copy
    BATTLE_CONFIG[copy].each do |move, config|
      face_name = BATTLE_CONFIG[copy][move][:face_name]
      if DUPLICATE_MOVESETS[face_name]
        BATTLE_CONFIG[copy][move][:face_name] = DUPLICATE_MOVESETS[face_name]
      end
    end
  end
  # TODO
  # Currently, busts showed through synergy aren't automagically updated. Might be a problem with super modes at the end.
end

class Scene_Battle < Scene_Base
  alias original_478_execute_action execute_action
  def execute_action
    return original_478_execute_action if bust_feature_disabled?

    @bust = Busty::Bust.new(999) if @bust.nil?
    synergy_bust = Busty::Bust.new(1001)
    picture = Sprite.new

    if show_bust?
      if move_config[:picture] # If there's a dedicated picture, take precedence over everything else
        picture.bitmap = Cache.picture(move_config[:picture])
        picture.visible = true
        picture.z = 999
        picture.x = bust_offset_x
        picture.y = Graphics.height - picture.height + bust_offset_y
      else
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
    end

    original_478_execute_action

    picture.dispose
    picture.bitmap.dispose unless picture.bitmap.nil?
    picture = nil

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

    default.merge(Busty::BATTLE_CONFIG[character_name][current_move_name] || {})
  end

  def current_move_name
    # Trimming because some moves have invisible spaces in them (ex: "Shield of Purity ")
    @subject.current_action.item.name.strip
  end

  def character_name
    character_name = Busty::character_from_face(@subject.face_name, @subject.face_index)
  end

  def bust_offset_x
    # If using a custom picture, assume it's designed to fit in just right and thus no offset is needed by default
    default = move_config[:picture] ? 0 : -48

    move_config[:bust_offset_x] || bust_config[:bust_offset_x] || default
  end

  def bust_offset_y
    move_config[:bust_offset_y] || bust_config[:bust_offset_y] || 0
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
