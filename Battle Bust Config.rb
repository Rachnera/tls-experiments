Busty::BATTLE_CONFIG.merge!({
  "Aka" => {
    "Disabling Assault" => {
      face_name: "Aka emo",
      face_index: 0,
    },
    "Forceful Lunge" => {
      face_name: "Aka emo",
      face_index: 2,
    },
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
    "Support Allies" => {
      face_name: "face002b dark2",
      face_index: 6,
    },
    "SS heal component" => {
      face_name: "face002b",
      face_index: 5,
    },
  },
  "Uyae" => {
    "Aura of Might" => {
      picture: "Uyae Punch",
    },
  },
  "Yarra" => {
    "Lightning Whip" => {
      face_name: "Yarra emo",
      face_index: 7,
      synergy: {
        face_name: "Robin blond emo",
        face_index: 5,
      }
    },
    "Succubus Kiss" => {
      face_name: "Yarra emo2",
      face_index: 6,
    },
  },
})

# Show the same "animation" for all of Aka's debuff strikes
Busty::BATTLE_CONFIG["Aka"]["Weakening Stab"] = Busty::BATTLE_CONFIG["Aka"]["Crippling Stab"] = Busty::BATTLE_CONFIG["Aka"]["Piercing Stab"] = Busty::BATTLE_CONFIG["Aka"]["Disabling Assault"]
# Share config between the three effectively identical variants of Simon's "Support XXX" skill
Busty::BATTLE_CONFIG["Simon1"]["Support Slaves"] = Busty::BATTLE_CONFIG["Simon1"]["Support Servants"] = Busty::BATTLE_CONFIG["Simon1"]["Support Allies"]

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
