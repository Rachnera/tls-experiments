# Need to be after the "Full Bleed" script and all the other many battle scripts
module Busty
  BATTLE_CONFIG = {
    "Simon2" => {
      "Commanding Presence" => {
        face_name: "1 Simon dark eyes",
        face_index: 0,
      },
    },
    "Yarra" => {
      "Succubus Kiss" => {
        face_name: "Yarra emo2",
        face_index: 6,
      },
    },
  }
end
class Scene_Battle < Scene_Base
  alias original_478_show_animation show_animation
  def show_animation(targets, animation_id)
    bust = Busty::Bust.new(999)
    if show_bust?
      # TODO Replace hardcoded x/y with configurable ones
      bust.draw(character_name, -64, 64, bust_face[:face_name], bust_face[:face_index])
    end

    original_478_show_animation(targets, animation_id)

    bust.erase
    bust.dispose
  end

  def show_bust?
    # Only for party members, not enemies
    return false unless @subject.is_a?(Game_Actor)

    Busty::has_bust?(character_name)
  end

  def bust_face
    if Busty::BATTLE_CONFIG[character_name] and Busty::BATTLE_CONFIG[character_name][@subject.current_action.item.name]
      return Busty::BATTLE_CONFIG[character_name][@subject.current_action.item.name]
    end

    { face_name: @subject.face_name, face_index: @subject.face_index }
  end

  def character_name
    character_name = Busty::character_from_face(@subject.face_name)
  end
end
