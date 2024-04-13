# Inspired by https://forums.rpgmakerweb.com/index.php?threads/simple-message-busts.45897/
module Busty
  # See the "Bust Config" file for actual config values

  # Make the face fits right on the body
  BASE_CONFIG = {}
  # Optional. Shift the position of the bust compared to the message box.
  # Useful to move to the left bulky characters that would otherwise cover text (ex: Hilstara) or make small characters appear small (ex: Sarai)
  MESSAGE_CONFIG = {}

  # For characters whose naming convention of their faces isn't consistent with the name of their bust
  FACE_TO_BUST = {
    "Aka emo2" => "Aka2",
    "1 Simon dark eyes" => "Simon2",
    "1 Simon dark eyes2" => "Simon2",
    "1 Simon dark" => "Simon2",
    "1 Simon dark2" => "Simon2",
    "1 Simon distress3" => "Simon2",
    "1 Simon distress4" => "Simon2",
    "face002b" => "Simon1",
    "face002b2" => "Simon1",
    "face002b dark" => "Simon1",
    "face002b dark2" => "Simon1",
    "MainActor1-3fs" => "MainActor1-3", # Chosen
  }

  def self.has_bust?(character_name)
    BASE_CONFIG.has_key?(character_name)
  end

  def self.character_from_face(face_name)
    return nil if face_name.empty?

    return FACE_TO_BUST[face_name] if FACE_TO_BUST.has_key?(face_name)

    face_name.gsub(/\s+emo.*/, '')
  end

  def self.rescale_bitmap(bitmap, scale)
    width = bitmap.width * scale
    height = bitmap.height * scale
    new_bitmap = Bitmap.new(width, height)
    src_rect = Rect.new(0, 0, bitmap.width, bitmap.height)
    dest_rect = Rect.new(0, 0, width, height)
    # Ref: https://www.rubydoc.info/gems/openrgss/Bitmap#stretch_blt-instance_method
    new_bitmap.stretch_blt(dest_rect, bitmap, src_rect)
    bitmap.dispose
    new_bitmap
  end

  class Bust
    def initialize(z)
      @bust = Sprite.new
      @bust.visible = true
      @bust.z = z + 1

      @bust_face = Sprite.new
      @bust_face.visible = true
      @bust_face.z = @bust.z + 1
    end

    def draw(character_name, x, y, face_name, face_index)
      @character_name = character_name

      @bust.bitmap = bust_bitmap
      @bust.x = x
      @bust.y = Graphics.height - @bust.height + y # A little unorthodox, but busts are snapped to the _lower_ left corner when y=0

      bitmap = Cache.face(face_name)
      rect = Rect.new(face_index % 4 * 96, face_index / 4 * 96, 96, 96)
      face_bitmap = Bitmap.new(96, 96)
      face_bitmap.blt(0, 0, bitmap, rect)
      @bust_face.bitmap = face_bitmap
      @bust_face.x = @bust.x + face_offset_x
      @bust_face.y = @bust.y + face_offset_y
    end

    def erase
      @bust.bitmap = nil
      @bust_face.bitmap = nil
    end

    def update
      @bust.update
      @bust_face.update
    end

    def dispose
      @bust.dispose
      @bust.bitmap.dispose if !@bust.bitmap.nil?

      @bust_face.dispose
      @bust_face.bitmap.dispose unless @bust_face.bitmap.nil?
    end

    def bust_bitmap
      #TODO Very basic pseudo cache, can likely be improved (or at least cleaned up)
      @busts = {} if @busts.nil?
      return @busts[character_name] if @busts.has_key?(character_name)

      begin
        @busts[character_name] = Cache.picture('busts/' + character_name)
      rescue
        @busts[character_name] = Busty::rescale_bitmap(Cache.picture(character_name), bust_scale)
      end

      @busts[character_name]
    end

    def character_name
      @character_name
    end

    def bust_scale
      bust_config[:bust_scale] || 0.75
    end

    def face_offset_x
      bust_config[:face_offset_x] || 60
    end

    def face_offset_y
      bust_config[:face_offset_y] || 40
    end

    def bust_config
      Busty::BASE_CONFIG[character_name] || {}
    end
  end
end

class Window_Message < Window_Base
  alias hmb_window_message_create_back_bitmap create_back_bitmap
  def create_back_bitmap
    @bust = Busty::Bust.new(z) if @bust.nil?

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
    if show_bust?
      @bust.draw(
        character_name,
        bust_offset_x,
        bust_offset_y,
        $game_message.face_name,
        $game_message.face_index
      )
    else
      @bust.erase
    end
    @bust.update
  end

  alias original_591_new_line_x new_line_x
  def new_line_x
    return text_indent_if_bust if show_bust?

    original_591_new_line_x
  end

  def show_bust?
    return false if $game_message.face_name.empty?

    # Don't display bust if the message box isn't at the bottom of the screen
    return false if self.y + self.height != Graphics.height

    # Display Yarra's "faces" that are actually her breasts as are
    return false if $game_message.face_name == "Yarra emo2" and [2, 3].include?($game_message.face_index)

    Busty::has_bust?(character_name)
  end

  def character_name
    Busty::character_from_face($game_message.face_name)
  end

  alias original_591_draw_face draw_face
  def draw_face(face_name, face_index, x, y, enabled = true)
    return if show_bust?
    original_591_draw_face(face_name, face_index, x, y, enabled)
  end

  def text_indent_if_bust
    125
  end

  def bust_offset_x
    # 51 = 1/4 of 75% of 272
    bust_config[:bust_offset_x] || -51
  end

  def bust_offset_y
    bust_config[:bust_offset_y] || 0
  end

  def bust_config
    Busty::MESSAGE_CONFIG[character_name] || {}
  end
end
