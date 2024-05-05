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
    "Alanon emo" => "Alonon",
    "Z Andra emo" => nil, # To only allow face 4
    "Z Andra emoN" => nil, # No bust for no robe Andra
    "Yarra emo2" => nil, # To exclude "faces" 2/3
  }

  # For busts matching with only some of the faces of a facesheet
  SUBSET_TO_BUST = [
    {
      character_name: "Andra",
      face_name: "Z Andra emo",
      face_indexes: [4],
    },
    {
      character_name: "Luanell",
      face_name: "Z Givini emo",
      face_indexes: [1],
    },
    {
      character_name: "Yarra",
      face_name: "Yarra emo2",
      face_indexes: [0, 1, 4, 5, 6, 7],
    },
  ]

  def self.has_bust?(character_name)
    BASE_CONFIG.has_key?(character_name)
  end

  def self.character_from_face(face_name, face_index)
    return nil if face_name.empty?

    special = SUBSET_TO_BUST.find do |cf|
      cf[:face_name] == face_name && cf[:face_indexes].include?(face_index)
    end
    return special[:character_name] if special

    return FACE_TO_BUST[face_name] if FACE_TO_BUST.has_key?(face_name)

    matches = /\A([a-zA-Z]\s+)?(.+)\s+emo(.*)?\Z/.match(face_name)

    return nil unless matches

    matches[2]
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

    def draw(character_name, x, y, face_name, face_index, max_width = nil)
      @character_name = character_name

      bitmap = bust_bitmap
      if max_width
        max_width = max_width-x if x < 0 # Ignore offscreen overflow

        new_bitmap = Bitmap.new(max_width, bust_bitmap.height)
        rect = Rect.new(0, 0, max_width, bust_bitmap.height)
        new_bitmap.blt(0, 0, bust_bitmap, rect)
        bitmap = new_bitmap
      end

      @bust.bitmap = bitmap
      @bust.x = x
      @bust.y = Graphics.height - @bust.height + y # A little unorthodox, but busts are snapped to the _lower_ left corner when y=0

      # Shave border of face image if need be
      border_width = face_border_width

      bitmap = Cache.face(face_name)
      rect = Rect.new(face_index % 4 * 96 + border_width, face_index / 4 * 96 + border_width, 96 - 2*border_width, 96 - 2*border_width)
      face_bitmap = Bitmap.new(96 - 2*border_width, 96 - 2*border_width)
      face_bitmap.blt(0, 0, bitmap, rect)
      @bust_face.bitmap = face_bitmap
      @bust_face.x = @bust.x + border_width + face_offset_x
      @bust_face.y = @bust.y + border_width + face_offset_y
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

    def face_border_width
      bust_config[:face_border_width] || 0
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
        $game_message.face_index,
        max_width = (text_indent_if_bust + 5)
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
    return false if $game_switches[YEA::SYSTEM::CUSTOM_SWITCHES[:hide_dialog_bust][0]]

    return false if $game_message.face_name.empty?

    # Don't display bust if the message box isn't at the bottom of the screen
    return false if self.y + self.height != Graphics.height

    Busty::has_bust?(character_name)
  end

  def character_name
    Busty::character_from_face($game_message.face_name, $game_message.face_index)
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

YEA::SYSTEM::CUSTOM_SWITCHES.merge!({
  hide_dialog_bust: [
    13, # Switch Number; make sure it's not used for something else
    "Full busts in dialogues",
    "Hide",
    "Show",
    "Show main characters in full when they talk.",
    true
  ]
})
YEA::SYSTEM::COMMANDS.insert(YEA::SYSTEM::COMMANDS.find_index(:hide_nsfw), :hide_dialog_bust)
class Scene_System < Scene_MenuBase
  alias_method :original_421_command_reset_opts, :command_reset_opts
  def command_reset_opts
    $game_switches[YEA::SYSTEM::CUSTOM_SWITCHES[:hide_dialog_bust][0]] = false

    original_421_command_reset_opts
  end
end
