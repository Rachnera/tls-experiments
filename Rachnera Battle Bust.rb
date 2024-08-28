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

  def self.show_enemy_face_window(bitmap, offset_x = 0, offset_y = 0)
    unless defined?(@@enemy_face_window) && @@enemy_face_window
      @@enemy_face_window = Enemy_Face_Window.new
    end
    @@enemy_face_window.set_bitmap(bitmap, offset_x, offset_y)
    @@enemy_face_window.show
  end

  def self.hide_enemy_face_window
    return unless defined?(@@enemy_face_window) && @@enemy_face_window

    @@enemy_face_window.clear_bitmap
    @@enemy_face_window.hide
  end

  def self.dispose_enemy_face_window
    return unless defined?(@@enemy_face_window) && @@enemy_face_window

    @@enemy_face_window.dispose
    @@enemy_face_window = nil
  end

  class Enemy_Face_Window < Window_Base
    def initialize
      super(0, Graphics.height - window_height, window_width, window_height)

      @enemy_pic = Sprite.new
      @enemy_pic.z = z + 1
      @enemy_pic.visible = true
    end

    def set_bitmap(bitmap, offset_x = 0, offset_y = 0)
      @enemy_pic.x = x + 12 + 4 + offset_x # +4 because not a perfect square, cf window_width
      @enemy_pic.y = y + 12 + offset_y
      @enemy_pic.bitmap = bitmap
    end

    def clear_bitmap
      @enemy_pic.bitmap.dispose if @enemy_pic.bitmap
    end

    def dispose
      # Might be overkill; but better safe than sorry
      clear_bitmap
      @enemy_pic.dispose
      @enemy_pic = nil

      super
    end

    def window_height
      96 + 12*2
    end

    def window_width
      window_height + 4*2
    end
  end
end

module SkillHelper
  class << self
    # A move can be either an instance of https://www.rubydoc.info/gems/rpg-maker-rgss3/RPG/Skill or of https://www.rubydoc.info/gems/rpg-maker-rgss3/RPG/Item
    # In all cases, it has access to all properties of their common parent: https://www.rubydoc.info/gems/rpg-maker-rgss3/RPG/UsableItem

    def is_debuff(move)
      move.effects.any? do |effect|
        effect.code == Game_Battler::EFFECT_ADD_DEBUFF
      end
    end

    def is_item(move)
      move.is_a?(RPG::Item)
    end

    def is_skill(move)
      move.is_a?(RPG::Skill)
    end

    def uses_tp(move)
      is_skill(move) && move.tp_cost > 0
    end
  end
end

class Scene_Battle < Scene_Base
  # See Yanfly Engine Ace - Ace Battle Engine
  # Note: TLS does not apparently use any of YEA-CastAnimations, YEA-LunaticObjects, YEA-TargetManager. Left their code in nonetheless for simpler diff  with original.
  alias original_478_use_item use_item
  def use_item
    return original_478_use_item if bust_feature_disabled?

    # New (move message window)
    reload_log_window_position
    save_log_window_position
    if @subject.is_a?(Game_Enemy)
      move_log_window(
        0,
        Graphics.height - (96 + 12*2 + 38)
      )
    end

    # Original, no change
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
    if can_and_should_adjust_x?(@subject.current_action.item, targets)
      @status_window.hide
    else
      @status_window.show
    end
    if show_bust?
      @bust_target_x = nil
      display_bust
      if @bust_picture && can_and_should_adjust_x?(@subject.current_action.item, targets)
        adj_x = adjusted_bust_x(targets[0])
        if adj_x > 0
          @bust_picture.x = 0
          @bust_target_x = adj_x
        else
          @bust_picture.x = adj_x
        end
      end
    else
      display_enemy_bust if @subject.is_a?(Game_Enemy)
      display_npc_face if @subject.is_a?(Game_Actor)
    end

    # Original, no change
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
    # Is a noop if everything was already cleaned in show_animation
    cleanup_bust
  end

  alias original_478_show_animation show_animation
  def show_animation(targets, animation_id)
    original_478_show_animation(targets, animation_id)

    return if bust_feature_disabled?

    # Deliberately wait for the end of the "sweeper car" clean-up for the less obstrusive small images
    if show_bust?
      # Attempt at making player actions slightly more readable with animations disabled
      # The idea is that we wait a bit longer before removing the image
      # But we move it further into the background and gray it out so it's not as obtrusive
      if !$game_system.animations? && @bust_picture
        @bust_picture.z = 2
        @bust_picture.tone.red = -64
        @bust_picture.tone.green = -64
        @bust_picture.tone.blue = -64
        @bust_picture.tone.gray = 128
        return
      end

      cleanup_bust
    end
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

  def display_enemy_bust
    rescaled_enemy_bitmap = enemy_bitmap_96_x_96

    if rescaled_enemy_bitmap.height < 96 # No crop, but recenter
      Busty::show_enemy_face_window(
        rescaled_enemy_bitmap,
        (96 - rescaled_enemy_bitmap.width) / 2,
        (96 - rescaled_enemy_bitmap.height) / 2
      )
    else # Crop
      rescaled_and_cropped_enemy_bitmap = Bitmap.new(rescaled_enemy_bitmap.width, 96 + 6) # Allow to touch the bottom border
      rescaled_and_cropped_enemy_bitmap.blt(0, 0, rescaled_enemy_bitmap, Rect.new(0, 0, rescaled_enemy_bitmap.width, 96 + 6))
      rescaled_enemy_bitmap.dispose

      Busty::show_enemy_face_window(
        rescaled_and_cropped_enemy_bitmap,
        (96 - rescaled_and_cropped_enemy_bitmap.width) / 2,
        0
      )
    end
  end

  def enemy_bitmap_96_x_96
    enemy_bitmap = Cache.battler(@subject.battler_name, @subject.battler_hue)

    return enemy_bitmap.clone if enemy_bitmap.width <= 96

    rescaled_enemy_bitmap = Bitmap.new(96, (96.0 / enemy_bitmap.width) * enemy_bitmap.height)
    src_rect = Rect.new(0, 0, enemy_bitmap.width, enemy_bitmap.height)
    dest_rect = Rect.new(0, 0, rescaled_enemy_bitmap.width, rescaled_enemy_bitmap.height)
    rescaled_enemy_bitmap.stretch_blt(dest_rect, enemy_bitmap, src_rect)

    rescaled_enemy_bitmap
  end

  def display_npc_face
    # Effectively works like an enemy, but with the NPC face instead of a resized battler
    bitmap = Cache.face(@subject.face_name)
    rect = Rect.new(
      @subject.face_index % 4 * 96,
      @subject.face_index / 4 * 96,
      96,
      96
    )
    face_bitmap = Bitmap.new(96, 96)
    face_bitmap.blt(0, 0, bitmap, rect)

    Busty::show_enemy_face_window(face_bitmap)
  end

  def cleanup_bust
    Busty::hide_enemy_face_window

    if @bust_picture
      @bust_picture.dispose
      @bust_picture.bitmap.dispose
      @bust_picture = nil
    end
    @bust_target_x = nil

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
    @status_window.x = 128+16*4

    save_log_window_position

    original_478_turn_start
  end

  alias original_478_turn_end turn_end
  def turn_end
    return original_478_turn_end if bust_feature_disabled?

    @status_window.show
    @status_window.x = 128

    reload_log_window_position

    original_478_turn_end
  end

  alias original_478_terminate terminate
  def terminate
    Busty::dispose_enemy_face_window

    original_478_terminate
  end

  def wait_for_animation
    update_for_wait
    while @spriteset.animation? do
      move_in_bust_picture # Only addition compared to Scene_Battle#wait_for_animation
      update_for_wait
    end
  end

  def move_in_bust_picture
    return unless @bust_picture && @bust_target_x

    step = @bust_target_x / 8
    if @bust_picture.x + step  >= @bust_target_x
      @bust_picture.x = @bust_target_x
      @bust_target_x = nil
    else
      @bust_picture.x += step
    end
  end

  def move_log_window(x, y)
    @log_window.x = x
    @log_window.y = y
  end

  def save_log_window_position
    @old_log_window_x = @log_window.x
    @old_log_window_y = @log_window.y
  end

  def reload_log_window_position
    @log_window.x = @old_log_window_x
    @log_window.y = @old_log_window_y
  end

  def bust_feature_disabled?
    $game_switches[YEA::SYSTEM::CUSTOM_SWITCHES[:hide_battle_bust][0]]
  end

  def show_bust?
    # Only for party members, not enemies
    return false unless @subject.is_a?(Game_Actor)

    return false unless current_move_name

    # Commit to the bit by showing Simon as a NPC at first (25 is the "Window Break" switch)
    return false if character_name == "Simon1" and not $game_switches[25]

    # TODO Remove the second condition eventually?
    Busty::BATTLE_CONFIG[character_name] || Busty::has_bust?(character_name)
  end

  def can_and_should_adjust_x?(move, targets)
    return false unless show_bust?

    return false unless $game_system.animations?

    # Is an explicitly configured move with a single enemy target
    move_config[:adjust_x] && SkillHelper::is_skill(move) && move.for_opponent? && targets.count == 1
  end

  def adjusted_bust_x(target)
    [target.screen_x - @bust_picture.width, -0.25 * @bust_picture.width].max
  end

  def is_simon_support_skill?
    ["Support Slaves", "Support Servants", "Support Allies"].include?(current_move_name)
  end

  def move_config
    # If nothing else is configured, will default to the face that shows up at the bottom of the screen
    final_fallback = { face_name: @subject.face_name, face_index: @subject.face_index }

    return final_fallback if character_name.nil? or current_move_name.nil? or Busty::BATTLE_CONFIG[character_name].nil?

    character_config = Busty::BATTLE_CONFIG[character_name]

    proc_config = (character_config[:proc] || ->(move) { nil }).call(@subject.current_action.item)
    return proc_config if proc_config

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

class Window_BattleLog < Window_Selectable
  # Keep background in sync with window position
  alias original_478_update update
  def update
    original_478_update

    @back_sprite.x = x
    @back_sprite.y = y
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
