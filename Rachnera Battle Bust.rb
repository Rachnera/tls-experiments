module Busty
  BATTLE_CONFIG = {} # Placeholder, actual values in "Battle Bust Config"

  # TODO Rework so it also works for characters with alternative full images rather than composite faces/busts
  # TODO Find a way to deal with busts displayed with synergy?
  def self.duplicate_battle_config(equivalence)
    equivalence.each do |original, copy|
      next unless BATTLE_CONFIG[original]

      BATTLE_CONFIG[copy] = Marshal.load(Marshal.dump(BATTLE_CONFIG[original])) # Deep copy
      BATTLE_CONFIG[copy].each do |move, config|
        if config.is_a?(Array)
          config.each_with_index do |cf, i|
            if equivalence[cf[:face_name]]
              BATTLE_CONFIG[copy][move][i][:face_name] = equivalence[cf[:face_name]]
            end
          end
        else
          if equivalence[config[:face_name]]
            BATTLE_CONFIG[copy][move][:face_name] = equivalence[config[:face_name]]
          end
        end
      end
    end
  end
end

module SkillHelper
end

class Scene_Battle < Scene_Base
  # See Yanfly Engine Ace - Ace Battle Engine
  # Note: TLS does not apparently use any of YEA-CastAnimations, YEA-LunaticObjects, YEA-TargetManager. Left their code in nonetheless for simpler diff  with original.
  alias original_478_use_item use_item
  def use_item
    return original_478_use_item if bust_feature_disabled?

    ## Original, no change
    item = @subject.current_action.item
    @log_window.display_use_item(@subject, item)
    @subject.use_item(item)
    status_redraw_target(@subject)
    if $imported["YEA-LunaticObjects"]
      lunatic_object_effect(:before, item, @subject, @subject)
    end
    process_casting_animation if $imported["YEA-CastAnimations"]
    targets = @subject.current_action.make_targets.compact rescue []

    # New
    display_bust if show_bust?

    # Original, no change, second part
    show_animation(targets, item.animation_id) if show_all_animation?(item)
    targets.each {|target|
    if $imported["YEA-TargetManager"]
      target = alive_random_target(target, item) if item.for_random?
    end
    item.repeats.times { invoke_item(target, item) } }
    if $imported["YEA-LunaticObjects"]
      lunatic_object_effect(:after, item, @subject, @subject)
    end

    # New
    # Is a noop if animations are enabled (everything is already cleaned) or if they weren't any bust shown in the first place
    cleanup_bust
  end

  alias original_478_show_animation show_animation
  def show_animation(targets, animation_id)
    original_478_show_animation(targets, animation_id)
    cleanup_bust
  end

  def display_bust
    if move_config[:picture] # If there's a dedicated picture, take precedence over everything else
      @bust_picture = Sprite.new
      @bust_picture.bitmap = Cache.picture('battle/' + move_config[:picture])
      @bust_picture.visible = true
      @bust_picture.z = 999
      @bust_picture.x = bust_offset_x
      @bust_picture.y = Graphics.height - @bust_picture.height + bust_offset_y
    else
      @bust = Busty::Bust.new(999) if @bust.nil?
      @bust.draw(
        bust_offset_x,
        bust_offset_y,
        move_config[:face_name],
        move_config[:face_index]
      )

      if move_config[:synergy]
        synergy_offset = 32
        @synergy_bust = Busty::Bust.new(1001)
        @synergy_bust.draw(
          move_config[:synergy][:bust_offset_x] || (bust_offset_x - 32),
          move_config[:synergy][:bust_offset_y] || 64,
          move_config[:synergy][:face_name],
          move_config[:synergy][:face_index]
        )
      end
    end
  end

  def cleanup_bust
    if @bust_picture
      @bust_picture.dispose
      @bust_picture.bitmap.dispose
      @bust_picture = nil
    end

    if @synergy_bust
      @synergy_bust.erase
      @synergy_bust.dispose
      @synergy_bust = nil
    end

    if @bust
      # FIXME Hack that likely won't work anymore with pictures
      # Simon's Support skill is actually two skills, and the cleanup should only happen after the second one
      return if is_simon_support_skill?

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

    return false unless current_move_name

    Busty::has_bust?(character_name)
  end

  def is_simon_support_skill?
    ["Support Slaves", "Support Servants", "Support Allies"].include?(current_move_name)
  end

  def move_config
    # If nothing else is configured, will default to the face that shows up at the bottom of the screen
    final_fallback = { face_name: @subject.face_name, face_index: @subject.face_index }

    return final_fallback if character_name.nil? or current_move_name.nil? or Busty::BATTLE_CONFIG[character_name].nil?

    character_config = Busty::BATTLE_CONFIG[character_name]

    (character_config[:procs] || []).each do |f|
      proc_config = f.call(@subject.current_action.item)
      return proc_config if proc_config
    end

    return character_config[current_move_name] if character_config[current_move_name]

    conditional_config = (character_config[:conditionals] || []).find do |cf|
      SkillHelper.send(cf[:condition], @subject.current_action.item)
    end
    return conditional_config if conditional_config

    return character_config[:fallback] if character_config[:fallback]

    final_fallback
  end

  def current_move_name
    return nil unless @subject.current_action && @subject.current_action.item

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
