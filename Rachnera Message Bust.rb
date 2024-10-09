module Busty
  # All actual configuration "CONSTANTS" can be found in the "Bust Config" file. Just dropping empty shells here for reference.
  CONFIG = {} # Make the face fits right on the body and the body fit right on the screen
  FACE_TO_BUST = {} # For characters whose naming convention of their faces isn't consistent with the name of their bust
  SUBSET_TO_BUST = [] # For busts matching with only some of the faces of a facesheet

  # Add conditions that must be checked for some busts to be shown when characters talk
  MESSAGE_AUTODISPLAY_SPECIAL = {}

  # Coordinates of where the lower left corner of the face should be, relative to the lower left corner of the screen
  MESSAGE_FACE_POSITION = [24, 72]

  # Ambiance images, to be ignored when checking if busts should be displayed
  AMBIENT_PICTURES = ['beam1_ani1', 'wallofivala1', 'wallofivala2', 'wallofivala3', 'title0']

  def self.has_bust?(character_name)
    return false unless CONFIG.has_key?(character_name)

    config = CONFIG[character_name]
    valid_config = (config[:face_offset_x] && config[:face_offset_y]) || config[:hide_original_face]

    valid_config && has_bust_bitmap?(character_name)
  end

  def self.bust_bitmap(character_name)
    Cache.picture('busts/' + character_name)
  end

  def self.has_bust_bitmap?(character_name)
    begin
      bust_bitmap(character_name)
      true
    rescue Errno::ENOENT
      false
    end
  end

  def self.character_from_face(face_name, face_index)
    return nil if face_name.empty?

    special = SUBSET_TO_BUST.find do |cf|
      cf[:face_name] == face_name && cf[:face_indexes].include?(face_index)
    end
    return special[:character_name] if special

    return FACE_TO_BUST[face_name] if FACE_TO_BUST.has_key?(face_name)

    matches = /\A([a-zA-Z]\s+)?(.+)\s+emo(.*)?\Z/.match(face_name)
    return matches[2] if matches

    /\A([a-zA-Z]\s+)?(.+)\Z/.match(face_name)[2] # Will effectively return the name in full if nothing else works
  end

  def self.replicate_config_for_alternate_forms(equivalences)
    equivalences.each do |cf|
      Busty::CONFIG[cf[:bust]] = Busty::CONFIG[cf[:original]].clone
      cf[:faces].each do |face|
        Busty::FACE_TO_BUST[face] = cf[:bust]
      end
    end
  end

  class Bust
    attr_reader :face_config

    def initialize(z, gradient_length = 0)
      @bust = Sprite.new
      @bust.visible = true
      @bust.z = z

      @bust_face = Sprite.new

      @bust_overflow = Sprite.new
      @bust_overflow.visible = true
      @bust_overflow.z = @bust.z

      @fade_sprites = []
      gradient_length.times do |i|
        sprite = Sprite.new
        sprite.visible = true
        sprite.z = @bust.z - 1

        # Have a effectively go from "0.1 to 0.9"
        # Since we're already sandwiched between full opacity (the normal bust) and full transparency (padding on the right)
        # Plus that makes positioning more consistent with disabled fade
        a = 1.0 * (i+1) / (gradient_length+1)
        sprite.opacity = 255 * (1 - Gradient.ease_in(a))

        @fade_sprites.push(sprite)
      end
    end

    def draw(x, y, face_name, face_index, deadzone_x = nil, deadzone_h = nil, fade_right = false)
      character_name = Busty::character_from_face(face_name, face_index)
      @character_name = character_name

      bitmap = bust_bitmap

      max_width = nil
      if deadzone_x
        max_width = deadzone_x
        max_width -= x if x < 0 # Ignore offscreen overflow
        max_width -= gradient_length if fade_right # Effectively thiner by the length of the gradient

        new_bitmap = Bitmap.new(max_width, bust_bitmap.height)
        rect = Rect.new(0, 0, max_width, bust_bitmap.height)
        new_bitmap.blt(0, 0, bust_bitmap, rect)
        bitmap = new_bitmap
      end

      @bust.bitmap = bitmap
      @bust.x = x
      @bust.y = Graphics.height - @bust.height + y # A little unorthodox, but busts are snapped to the _lower_ left corner when y=0

      @bust_overflow.bitmap = nil
      if deadzone_x && deadzone_h
        extra_width = bust_bitmap.width - @bust.width
        extra_height = Graphics.height - deadzone_h - @bust.y

        if extra_width > 0 && extra_height > 0
          extra_bitmap = Bitmap.new(extra_width, extra_height)
          extra_rect = Rect.new(@bust.width, 0, extra_width, extra_height)
          extra_bitmap.blt(0, 0, bust_bitmap, extra_rect)

          @bust_overflow.x = @bust.x + @bust.width
          @bust_overflow.y = @bust.y
          @bust_overflow.bitmap = extra_bitmap
        end
      end

      draw_face(face_name, face_index)

      @fade_sprites.each { |sprite| sprite.bitmap = nil }
      if fade_right && max_width && gradient_length > 0
        @fade_sprites.each.with_index do |sprite, i|
          bitmap = Bitmap.new(1, @bust.height)
          rect = Rect.new(max_width + i, 0, 1, @bust.height)
          bitmap.blt(0, 0, bust_bitmap, rect)

          sprite.x = @bust.x + @bust.width + i
          sprite.y = @bust.y
          sprite.bitmap = bitmap
        end
      end
    end

    def draw_face(face_name, face_index)
      @face_config = [face_name, face_index]

      if bust_config[:hide_original_face]
        @bust_face.visible = false
        return
      end

      @bust_face.visible = true

      # Shave border of face image if need be
      face_width = 96 - face_border_width_left - face_border_width_right
      face_height = 96 - face_border_width_top - face_border_width_bottom

      bitmap = Cache.face(face_name)
      rect = Rect.new(
        face_index % 4 * 96 + face_border_width_left,
        face_index / 4 * 96 + face_border_width_top,
        face_width,
        face_height
      )
      face_bitmap = Bitmap.new(face_width, face_height)
      face_bitmap.blt(0, 0, bitmap, rect)
      @bust_face.bitmap = face_bitmap
      @bust_face.x = @bust.x + face_border_width_left + face_offset_x
      @bust_face.y = @bust.y + face_border_width_top + face_offset_y
      @bust_face.z = @bust.z + face_z
    end

    def erase
      @character_name = nil
      @face_config = nil

      sprites_list.each { |sprite| sprite.bitmap = nil }
    end

    def dispose
      sprites_list.each do |sprite|
        sprite.dispose
        sprite.bitmap.dispose if !sprite.bitmap.nil?
      end
    end

    def bust_bitmap
      Busty::bust_bitmap(character_name)
    end

    def character_name
      @character_name
    end

    def gradient_length
      @fade_sprites.length
    end

    def face_offset_x
      bust_config[:face_offset_x]
    end

    def face_offset_y
      bust_config[:face_offset_y]
    end

    def face_border_width
      w = bust_config[:face_border_width]

      return w if w.kind_of?(Array)

      return [0, 0, 0, 0] if w.nil?

      [w, w, w, w]
    end

    def face_border_width_top
      face_border_width[0]
    end

    def face_border_width_right
      face_border_width[1]
    end

    def face_border_width_bottom
      face_border_width[2]
    end

    def face_border_width_left
      face_border_width[3]
    end

    def face_z
      bust_config[:face_z] || +1
    end

    def bust_config
      Busty::CONFIG[character_name] || {}
    end

    def sprites_list
      [@bust, @bust_face, @bust_overflow] + @fade_sprites
    end
  end
end

module Gradient
  class << self
    def linear(x)
      x
    end

    # https://easings.net/#easeInSine
    def ease_in(x)
      1 - Math.cos(x * (Math::PI / 2))
    end
  end
end

class Window_Message < Window_Base
  alias hmb_window_message_create_back_bitmap create_back_bitmap
  def create_back_bitmap
    @bust = Busty::Bust.new(z+5, gradient_length = 12) if @bust.nil?
    @choice_window.z = z + 10 if @choice_window.z < z + 10

    hmb_window_message_create_back_bitmap
  end

  alias hmb_window_message_dispose dispose
  def dispose
    hmb_window_message_dispose
    dispose_bust
  end

  def dispose_bust
    @bust.dispose if !@bust.nil?
  end

  alias hmb_window_message_update_back_sprite update_back_sprite
  def update_back_sprite
    hmb_window_message_update_back_sprite
    update_bust if openness > 0
  end

  def update_bust
    if !show_bust?
      @bust.erase
      return
    end

    if @bust.character_name == character_name
      if @bust.face_config == bust_face_config
        # Nothing to do, is already displayed right
        return
      end

      # Just redraw the face, nothing else has changed (same character)
      @bust.draw_face(*bust_face_config)
      return
    end

    @bust.draw(
      bust_offset_x,
      bust_offset_y,
      *bust_face_config,
      bust_deadzone_x,
      bust_deadzone_h,
      bust_should_fade?
    )
  end

  # Allow faces to be overridden in certain circumstances; see Bust Config for implementation.
  # This applies both when displaying busts and when just displaying faces.
  def bust_face_name
    $game_message.face_name
  end

  def bust_face_index
    $game_message.face_index
  end

  def bust_face_config
    [
      bust_face_name,
      bust_face_index,
    ]
  end

  def show_bust?
    return false unless valid_context?

    if $game_map
      [$game_map.screen.pictures, $game_map.screen.pictures_extra_viewport].each do |pictures|
        return false unless pictures.empty?(ignore = Busty::AMBIENT_PICTURES)
      end
    end

    if !$game_message.choices.empty?
      return false if @choice_window.max_choice_width > 0.66 * Graphics.width
    end

    # Check for potential special conditions on characters
    if Busty::MESSAGE_AUTODISPLAY_SPECIAL.has_key?(character_name)
      return false unless Busty.send(Busty::MESSAGE_AUTODISPLAY_SPECIAL[character_name])
    end

    Busty::has_bust?(character_name)
  end

  def valid_context?
    return false if $game_switches[YEA::SYSTEM::CUSTOM_SWITCHES[:hide_dialog_bust][0]]

    return false if $game_message.face_name.empty?

    return false if !self.visible

    # Don't display bust if the message box isn't at the bottom of the screen
    return false if self.y + self.height != Graphics.height

    # Don't display bust if message box is abnormally tall
    return false if self.height > Graphics.height / 2

    true
  end

  def character_name
    Busty::character_from_face(*bust_face_config)
  end

  def bust_offset_x
    # Taking for granted the image is already tailor made to fit in the corner
    return bust_config[:bust_offset_x] || 0 if bust_face_hidden?

    bust_config[:bust_offset_x] || Busty::MESSAGE_FACE_POSITION[0] - bust_config[:face_offset_x]
  end

  def bust_offset_y
    # Cf similar exception in bust_offset_x
    return bust_config[:bust_offset_y] || 0 if bust_face_hidden?

    return bust_config[:bust_offset_y] if bust_config[:bust_offset_y]

    maybe_y = 96 + bust_config[:face_offset_y] - bust_height + Busty::MESSAGE_FACE_POSITION[1]
    return -1*maybe_y if maybe_y < 0 # Actual y-axis is oriented from top to bottom

    0
  end

  def bust_config
    Busty::CONFIG[character_name] || {}
  end

  def bust_face_hidden?
    bust_config[:hide_original_face]
  end

  def bust_deadzone_x
    new_line_x + bust_extra_x
  end

  def bust_deadzone_h
    height # Full height of the message box
  end

  def bust_should_fade?
    return true if bust_config[:fade].nil?

    bust_config[:fade]
  end

  def bust_height
    Cache.picture('busts/' + character_name).height
  end

  # Define how much the bust is allowed to overflow into the padding between image and text
  def bust_overflow_x
    10
  end

  # Cheat with paddings and borders to leave more breathing room to busts
  def bust_extra_x
    bust_overflow_x - standard_padding
  end
  alias original_591_draw_face draw_face
  def draw_face(face_name, face_index, x, y, enabled = true)
    return if show_bust?
    return original_591_draw_face(*bust_face_config, x + 2*standard_padding, y, enabled) if valid_context?
    original_591_draw_face(*bust_face_config, x, y, enabled)
  end
  alias original_591_new_line_x new_line_x
  def new_line_x
    original_591_new_line_x + text_extra_indent
  end
  alias original_591_maatsf_total_line_width maatsf_total_line_width
  def maatsf_total_line_width(y = 0)
    return original_591_maatsf_total_line_width(y) unless valid_context?
    original_591_maatsf_total_line_width(y) - standard_padding*2 + text_extra_indent
  end
  def text_extra_indent
    return 16+standard_padding if valid_context?
    0
  end
  alias original_591_new_page new_page
  def new_page(*args, &block)
    if valid_context? and self.width == Graphics.width
      self.width = Graphics.width + 2*standard_padding
      self.x = -standard_padding
      create_contents
    end
    original_591_new_page(*args, &block)
  end
end

class Game_Pictures
  def empty?(ignore = [])
    @data.compact.reject { |picture| picture.name.empty? || ignore.include?(picture.name) }.empty?
  end
end

YEA::SYSTEM::CUSTOM_SWITCHES.merge!({
  hide_dialog_bust: [
    13, # Switch Number; make sure it's not used for something else
    "Busts in dialogues",
    "Hide",
    "Show",
    "Show main characters in full when they talk.",
    true
  ]
})
YEA::SYSTEM::COMMANDS.insert(YEA::SYSTEM::COMMANDS.find_index(:instantmsg)+1, :hide_dialog_bust)
class Scene_System < Scene_MenuBase
  alias_method :original_421_command_reset_opts, :command_reset_opts
  def command_reset_opts
    $game_switches[YEA::SYSTEM::CUSTOM_SWITCHES[:hide_dialog_bust][0]] = false

    original_421_command_reset_opts
  end
end
