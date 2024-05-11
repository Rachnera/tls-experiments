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
        bust_offset_x,
        bust_offset_y,
        $game_message.face_name,
        $game_message.face_index,
        max_width = (new_line_x + bust_extra_x)
      )
    else
      @bust.erase
    end
    @bust.update
  end

  # How much of the standard padding between image and text the bust is allowed to overflow into
  def bust_extra_x
    0.5*standard_padding
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

    # Don't display bust if the message box isn't at the bottom of the screen
    return false if self.y + self.height != Graphics.height

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
    bust_config[:bust_offset_x] || -60
  end

  def bust_offset_y
    bust_config[:bust_offset_y] || 0
  end

  def bust_config
    Busty::MESSAGE_CONFIG[character_name] || {}
  end

  # Very experimental attempt at eating a big of the right padding to give more space to the bust at "no cost"
  # To be deleted withou a second thought if it turns to be a problem
  alias original_591_new_line_x new_line_x
  def new_line_x
    original_591_new_line_x + text_extra_indent
  end
  alias original_591_maatsf_total_line_width maatsf_total_line_width
  def maatsf_total_line_width(y = 0)
    original_591_maatsf_total_line_width(y) + text_extra_indent
  end
  def text_extra_indent
    return 0.75*standard_padding if valid_context?
    0
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
