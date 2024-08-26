Busty::BATTLE_CONFIG.merge!({
  "Yarra" => {
    "Attack" => {
      picture: "BattlePortraits_Yarra_attack",
    },
    "Ice Whip" => {
      picture: "BattlePortraits_Yarra_attack-ice",
    },
    "Lightning Whip" => {
      picture: "BattlePortraits_Yarra_attack-lightning",
    },
    "Succubus Kiss" => {
      picture: "BattlePortraits_Yarra_Kiss",
    },
    # Note: Code will stop at the first option that matches, so order can be relevant
    conditionals: [
      {
        condition: 'is_any_masturbation_skill',
        picture: "BattlePortraits_Yarra_M",
      },
      {
        condition: 'is_item',
        picture: "BattlePortraits_Yarra_item",
      },
      {
        condition: 'uses_tp',
        picture: "BattlePortraits_Yarra_spell",
      },
    ],
    fallback: {
      face_name: "Yarra emo",
      face_index: 0,
    },
  },
})

Busty::BATTLE_CONFIG.merge!({
  "Aka" => {
    "Forceful Lunge" => {
      face_name: "Aka emo",
      face_index: 2,
    },
    conditionals: [
      {
        condition: 'is_debuff',
        face_name: "Aka emo",
        face_index: 0,
      }
    ],
  },
  "Carina" => {
    "Shield of Purity" => {
      face_name: "Carina emo",
      face_index: 5,
    },
    "Smite" => {
      face_name: "Carina emo",
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
    "SS heal component" => {
      face_name: "face002b",
      face_index: 5,
    },
    conditionals: [
      {
        condition: 'is_simon_support_skill',
        face_name: "face002b dark2",
        face_index: 6,
      },
    ],
  },
})

# Custom conditions, in addition to the generic ones defined in Battle Bust
module SkillHelper
  class << self
    def is_simon_support_skill(move)
      ["Support Allies", "Support Servants", "Support Slaves"].include?(move.name)
    end

    def is_any_masturbation_skill(move)
      move.name.include?("Masturbate") || move.name.include?("Masturbation")
    end
  end
end

# Duplicates configuration for characters with alternate forms
Busty.duplicate_battle_config({
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
  "Nalili emo1" => "Nalili emo3",
  "Nalili emo2" => "Nalili emo4",

  "Robin blond" => "Robin grey",
  "Robin blond emo" => "Robin grey emo",

  "Uyae" => "Uyae God Flip",
  "Uyae emo" => "Uyae emo2d",
})
