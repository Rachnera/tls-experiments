module Busty
  # Actual values are in "Bust Config". Only empty shells for reference here.

  # Shift the position of the bust. See bust_offset_x/bust_offset_y for default values if this is not set.
  # Useful to recenter characters that are too thin or wide (ex: Mithyn) or make small characters appear small (ex: Sarai)
  MESSAGE_CONFIG = {}

  # Add conditions that must be checked for some busts to be shown when characters talk
  MESSAGE_AUTODISPLAY_SPECIAL = {}
end

class Window_Message < Window_Base
  alias hmb_window_message_create_back_bitmap create_back_bitmap
  def create_back_bitmap
    @bust = Busty::Bust.new(z+1) if @bust.nil?
    @choice_window.z = z + 2 if @choice_window.z < z + 2

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
        bust_offset_x,
        bust_offset_y,
        $game_message.face_name,
        $game_message.face_index,
        max_width = (new_line_x + bust_extra_x),
        above_height = height - 4
      )
    else
      @bust.erase
    end
    @bust.update
  end

  # Define how much the bust is allowed to overflow into the padding between image and text
  def bust_extra_x
    6
  end

  def show_bust?
    return false unless valid_context?

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
    Busty::character_from_face($game_message.face_name, $game_message.face_index)
  end

  alias original_591_draw_face draw_face
  def draw_face(face_name, face_index, x, y, enabled = true)
    return if show_bust?
    original_591_draw_face(face_name, face_index, x, y, enabled)
  end

  def bust_offset_x
    bust_config[:bust_offset_x] || -48
  end

  def bust_offset_y
    bust_config[:bust_offset_y] || 0
  end

  def bust_config
    Busty::MESSAGE_CONFIG[character_name] || {}
  end

  # Very experimental attempt at eating a big of the right padding to give more space to the bust at "no cost"
  # To be deleted without a second thought if it turns to be a problem
  alias original_591_new_line_x new_line_x
  def new_line_x
    original_591_new_line_x + text_extra_indent
  end
  alias original_591_maatsf_total_line_width maatsf_total_line_width
  def maatsf_total_line_width(y = 0)
    original_591_maatsf_total_line_width(y) + text_extra_indent
  end
  def text_extra_indent
    return 8 if valid_context?
    0
  end

  # Experiment within the experiment to cheat the vertical borders
  # Ready to be burned down on sight
  def bust_extra_x
    6-standard_padding
  end
  def maatsf_total_line_width(y = 0)
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
  def draw_face(face_name, face_index, x, y, enabled = true)
    return if show_bust?
    return original_591_draw_face(face_name, face_index, x + 2*standard_padding, y, enabled) if valid_context?
    original_591_draw_face(face_name, face_index, x, y, enabled)
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
