# Need to be after the "Full Bleed" script and all the other many battle scripts
class Scene_Battle < Scene_Base
  alias original_478_show_animation show_animation
  def show_animation(targets, animation_id)
    bust = Busty::Bust.new(@status_window.z)
    if show_bust?
      @status_window.hide
      bust.draw(character_name, -60, 60, @subject.face_name, @subject.face_index)
    end

    original_478_show_animation(targets, animation_id)

    bust.erase
    bust.dispose
    @status_window.show
  end

  def show_bust?
    # Only for party members, not enemies
    return false unless @subject.is_a?(Game_Actor)

    Busty::has_bust?(character_name)
  end

  def character_name
    character_name = Busty::character_from_face(@subject.face_name)
  end
end
