module Busty
  # Make the face fits right on the body
  BASE_CONFIG = {}

  # For characters whose naming convention of their faces isn't consistent with the name of their bust
  FACE_TO_BUST = {
    "Aka emo2" => "Aka2",
    "1 Simon dark eyes" => "Simon2",
    "1 Simon dark eyes2" => "Simon2",
    "1 Simon dark" => "Simon2",
    "1 Simon dark2" => "Simon2",
    "1 Simon distress3" => "Simon2",
    "1 Simon distress4" => "Simon2",
    "Alanon emo" => "Alonon",
    "darksorceress" => "Riala",
    "Dheria emo2" => "Dheria2",
    "face002b" => "Simon1",
    "face002b2" => "Simon1",
    "face002b dark" => "Simon1",
    "face002b dark2" => "Simon1",
    "Fuzkao emo" => "Fuzkao no hand",
    "Grynyth emo" => "Grynyth full",
    "Grynyth emo2" => "Grynyth full",
    "Ivala emo" => nil, # To remove unsupported furious Ivala (different color)
    "Janine emo2" => "Janine 1",
    "Janine emo3" => "Janine 1",
    "Janine emo2B" => "Janine Bride",
    "Janine emo3B" => "Janine Bride",
    "Lilith emo3" => "Lilith grey",
    "MainActor1-3fs" => "MainActor1-3", # Chosen
    "Min emo2" => "Min2",
    "Riala emo2" => "Riala2",
    "Sabitha H emo" => "SabithaH",
    "Tanurak emoX" => nil, # Disable "glitch" Tanurak
    "Tertia emo" => "TertiaH", # Two Tertia bust files, the H is the one with the same ratio as most others
    "Xestris emo" => nil, # Exclude Xestris "dark" faces
    "Xestris emo2" => nil,
    "Yarra emo2" => nil, # To exclude "faces" 2/3
    "Z Andra emo" => nil, # To only allow face 4
    "Z Andra emoN" => nil, # No bust for no robe Andra
  }

  # For busts matching with only some of the faces of a facesheet
  SUBSET_TO_BUST = [
    {
      character_name: "Andra",
      face_name: "Z Andra emo",
      face_indexes: [4],
    },
    {
      character_name: "Ivala",
      face_name: "Ivala emo",
      face_indexes: [0, 1, 2, 3, 4, 5, 6],
    },
    {
      character_name: "Luanell",
      face_name: "Z Givini emo",
      face_indexes: [1],
    },
    {
      character_name: "Xestris",
      face_name: "Xestris emo",
      face_indexes: [0, 1, 2, 3, 4, 5],
    },
    {
      character_name: "Xestris",
      face_name: "Xestris emo2",
      face_indexes: [1, 2, 3, 4, 5, 6, 7],
    },
    {
      character_name: "Yarra",
      face_name: "Yarra emo2",
      face_indexes: [0, 1, 4, 5, 6, 7],
    },
  ]

  # Optional. Shift the position of the bust compared to the message box.
  # Useful to move to the left bulky characters that would otherwise cover text (ex: Hilstara) or make small characters appear small (ex: Sarai)
  MESSAGE_CONFIG = {}
end

# Rachnera
Busty::BASE_CONFIG.merge!({
  "Andra" => {
    bust_scale: 0.75,
    face_offset_x: 68,
    face_offset_y: 47,
  },
  "Luanell" => {
    bust_scale: 0.81,
    face_offset_x: 59,
    face_offset_y: 51,
  }
})
Busty::MESSAGE_CONFIG.merge!({
  "Altina" => {
    bust_offset_x: -30,
  },
  "Balia" => {
    bust_offset_x: -30,
  },
  "Bertricia" => {
    bust_offset_x: -36,
  },
  "Feremina" => {
    bust_offset_x: 0,
  },
  "Galvia" => {
    bust_offset_x: -36,
  },
  "Hilstara" => {
    bust_offset_x: -70,
  },
  "Lynine" => {
    bust_offset_x: -36,
  },
  "MainActor1-3" => { # Chosen
    bust_offset_x: -60,
    bust_offset_y: 75,
  },
  "Mestan" => {
    bust_offset_x: -36,
  },
  "Min" => {
    bust_offset_x: -36,
  },
  "Min2" => {
    bust_offset_x: -36,
  },
  "Nalili" => {
    bust_offset_y: 25,
  },
  "Sarai" => {
    bust_offset_x: -20,
    bust_offset_y: 25,
  },
  "TertiaH" => {
    bust_offset_x: -72,
  },
})

# Decarabia
Busty::BASE_CONFIG.merge!({
  "Aka" => {
    bust_scale: 0.80,
    face_offset_x: 61,
    face_offset_y: 66,
  },
  # For her bust I increased brightness by -5 due to differences in tan between her bust and faceset. Also had to increase brightness on her bust's hair
  "Aka2" => {
    bust_scale: 0.80,
    face_offset_x: 61,
    face_offset_y: 66,
  },
  # EDIT
  "Alonon" => {
    bust_scale: 0.72,
    face_offset_x: 87,
    face_offset_y: 53,
  },
  "Altina" => {
    bust_scale: 0.78,
    face_offset_x: 39,
    face_offset_y: 30,
    face_border_width: 1,
  },
  # EDIT
  "Annah" => {
    bust_scale: 0.77,
    face_offset_x: 61,
    face_offset_y: 44,
  },
  "Antarion" => {
    bust_scale: 0.79,
    face_offset_x: 73,
    face_offset_y: 28,
  },
  "Antiala" => {
    bust_scale: 0.75,
    face_offset_x: 69,
    face_offset_y: 50,
  },
  # further edit necessary?
  "Balia" => {
    bust_scale: 0.75,
    face_offset_x: 53,
    face_offset_y: 38,
  },
  "Bertricia" => {
    bust_scale: 0.70,
    face_offset_x: 44,
    face_offset_y: 37,
  },
  "Carina" => {
    bust_scale: 0.75,
    face_offset_x: 69,
    face_offset_y: 47,
  },
  "Dari1" => {
    bust_scale: 0.71,
    face_offset_x: 47,
    face_offset_y: 30,
  },
  "Dari1" => {
    bust_scale: 0.71,
    face_offset_x: 47,
    face_offset_y: 30,
  },
  "Dari2" => {
    bust_scale: 0.71,
    face_offset_x: 48,
    face_offset_y: 30,
  },
  "Dheria2" => {
    bust_scale: 0.75,
    face_offset_x: 68,
    face_offset_y: 34,
  },
  # Needs to adjust bust to match color of face's hair and clothes
  "Dio" => {
    bust_scale: 0.75,
    face_offset_x: 26,
    face_offset_y: 36,
  },
  # Needs to adjust hair color to match
  "Elleani" => {
    bust_scale: 0.80,
    face_offset_x: 79,
    face_offset_y: 31,
  },
  "Esmera" => {
    bust_scale: 0.77,
    face_offset_x: 67,
    face_offset_y: 49,
  },
  "Estaven" => {
    bust_scale: 0.84,
    face_offset_x: 70,
    face_offset_y: 54,
  },
  "Esthera" => {
    bust_scale: 0.85,
    face_offset_x: 82,
    face_offset_y: 39,
  },
  "Etuanun" => {
    bust_scale: 0.84,
    face_offset_x: 66,
    face_offset_y: 62,
  },
  "Eytria" => {
    bust_scale: 0.75,
    face_offset_x: 60,
    face_offset_y: 34,
  },
  "Feremina" => {
    bust_scale: 0.70,
    face_offset_x: 16,
    face_offset_y: 22,
  },
  "Fheliel" => {
    bust_scale: 0.70,
    face_offset_x: 59,
    face_offset_y: 37,
  },
  "Fuzkao no hand" => {
    bust_scale: 0.70,
    face_offset_x: 82,
    face_offset_y: 25,
  },
  "Galvia" => {
    bust_scale: 0.73,
    face_offset_x: 41,
    face_offset_y: 59,
    face_border_width: 1
  },
  "Ginasta" => {
    bust_scale: 0.73,
    face_offset_x: 60,
    face_offset_y: 42,
  },
  # cut some parts of the bust to try and fix the transparency overlay issue between the two images. might need more edits
  "Grynyth full" => {
    bust_scale: 0.76,
    face_offset_x: 64,
    face_offset_y: 24,
    face_border_width: 1
  },
  "Herin" => {
    bust_scale: 0.75,
    face_offset_x: 54,
    face_offset_y: 50,
  },
# DIFFERENT BUST AND FACESET
#  "Hester" => {
#    bust_scale: 0.75,
#    face_offset_x: 71,
#    face_offset_y: 48,
#  },
  # bust color hair edited to match faceset
  "Hilstara" => {
    bust_scale: 0.75,
    face_offset_x: 64,
    face_offset_y: 40,
  },
  "Iris" => {
    bust_scale: 0.75,
    face_offset_x: 50,
    face_offset_y: 47,
  },
  "Ivala" => {
    bust_scale: 0.77,
    face_offset_x: 57,
    face_offset_y: 50,
  },
  "Janine 1" => {
    bust_scale: 0.75,
    face_offset_x: 52,
    face_offset_y: 34,
  },
  "Janine Bride" => {
    bust_scale: 0.75,
    face_offset_x: 52,
    face_offset_y: 34,
  },
  "Kaskia" => {
    bust_scale: 0.71,
    face_offset_x: 54,
    face_offset_y: 47,
  },
  "Kerannii" => {
    bust_scale: 0.75,
    face_offset_x: 68,
    face_offset_y: 39,
  },
  "Lilith grey" => {
    bust_scale: 0.75,
    face_offset_x: 69,
    face_offset_y: 69,
  },
  "Lilith" => {
    bust_scale: 0.75,
    face_offset_x: 69,
    face_offset_y: 69,
  },
  "Lynine" => {
    bust_scale: 0.70,
    face_offset_x: 46,
    face_offset_y: 16,
  },
  # further testing might be needed
  "MainActor1-3" => {
    bust_scale: 0.82,
    face_offset_x: 79,
    face_offset_y: 40,
    face_border_width: 1
  },
  # NEEDS BUST EDITING. different clothes
  "Megail" => {
    bust_scale: 0.82,
    face_offset_x: 60,
    face_offset_y: 39,
    face_border_width: 1
  },
  "Melymyn" => {
    bust_scale: 0.72,
    face_offset_x: 51,
    face_offset_y: 28,
  },
  # NEEDS BUST EDITING. closes I got is not good enough
  "Mestan" => {
    bust_scale: 0.66,
    face_offset_x: 51,
    face_offset_y: 41,
  },
  "Min" => {
    bust_scale: 0.70,
    face_offset_x: 51,
    face_offset_y: 55,
  },
  "Min2" => {
    bust_scale: 0.70,
    face_offset_x: 51,
    face_offset_y: 55,
  },
  "Mithyn" => {
    bust_scale: 0.75,
    face_offset_x: 52,
    face_offset_y: 46,
    face_border_width: 1
  },
  "Nabith" => {
    bust_scale: 0.72,
    face_offset_x: 45,
    face_offset_y: 48,
  },
  # edits to the bust necessary to make it perfect
  "Nalili" => {
    bust_scale: 0.72,
    face_offset_x: 55,
    face_offset_y: 28,
  },
  "Neranda" => {
    bust_scale: 0.75,
    face_offset_x: 42,
    face_offset_y: 52,
  },
  "Nyst" => {
    bust_scale: 0.75,
    face_offset_x: 42,
    face_offset_y: 21,
  },
  "Orilise" => {
    bust_scale: 0.72,
    face_offset_x: 59,
    face_offset_y: 35,
  },
  # NEEDS COLOR ADJUSTMENT
  "Palina" => {
    bust_scale: 0.75,
    face_offset_x: 44,
    face_offset_y: 43,
  },
  # NEEDS COLOR ADJUSTMENT
  "Qum D'umpe" => {
    bust_scale: 0.75,
    face_offset_x: 62,
    face_offset_y: 40,
  },
  "Riala" => {
    bust_scale: 0.75,
    face_offset_x: 52,
    face_offset_y: 49,
  },
  "Riala2" => {
    bust_scale: 0.70,
    face_offset_x: 50,
    face_offset_y: 43,
  },
  "Robin blond" => {
    bust_scale: 0.75,
    face_offset_x: 63,
    face_offset_y: 53,
  },
  # Wrong hue of grey?
  "Robin grey" => {
    bust_scale: 0.75,
    face_offset_x: 63,
    face_offset_y: 53,
  },
  "Sabitha" => {
    bust_scale: 0.75,
    face_offset_x: 53,
    face_offset_y: 58,
  },
  # NEEDS BUST EDITING, mostly the horn on the left
  "SabithaH" => {
    bust_scale: 0.75,
    face_offset_x: 53,
    face_offset_y: 58,
  },
  "Sage" => {
    bust_scale: 0.79,
    face_offset_x: 37,
    face_offset_y: 25,
  },
  # NEEDS BUST EDITING!
  "Sarai" => {
    bust_scale: 0.77,
    face_offset_x: 26,
    face_offset_y: 50,
  },
  "Sage" => {
    bust_scale: 0.79,
    face_offset_x: 37,
    face_offset_y: 25,
  },
  "Tanurak" => {
    bust_scale: 0.75,
    face_offset_x: 73,
    face_offset_y: 42,
  },
  "TertiaH" => {
    bust_scale: 0.96,
    face_offset_x: 84,
    face_offset_y: 50,
  },
  "Trin" => {
    bust_scale: 0.75,
    face_offset_x: 52,
    face_offset_y: 54,
  },
  "Tyna" => {
    bust_scale: 0.74,
    face_offset_x: 57,
    face_offset_y: 36,
  },
  # NEEDS BUST EDITING!
  "Ulrissa" => {
    bust_scale: 0.75,
    face_offset_x: 64,
    face_offset_y: 48,
  },
 "Uneanun" => {
    bust_scale: 0.84,
    face_offset_x: 66,
    face_offset_y: 62,
  },
 "Uyae" => {
    bust_scale: 0.70,
    face_offset_x: 52,
    face_offset_y: 42,
  },
 "Varia" => {
    bust_scale: 0.70,
    face_offset_x: 62,
    face_offset_y: 48,
  },
 "Vera" => {
    bust_scale: 0.69,
    face_offset_x: 40,
    face_offset_y: 23,
  },
 "Vhala" => {
    bust_scale: 0.75,
    face_offset_x: 72,
    face_offset_y: 41,
  },
  # not perfect, might need light bust editing on the lower left part of hair
 "Vunne" => {
    bust_scale: 0.78,
    face_offset_x: 68,
    face_offset_y: 65,
  },
#   # HEAVY BUST EDITING. Neck is different.
#  "Wendis blond" => {
#     bust_scale: ?,
#     face_offset_x: ?,
#     face_offset_y: ?,
#   },
#   # HEAVY BUST EDITING. Neck is different.
#  "Wendis blondT" => {
#     bust_scale: ?,
#     face_offset_x: ?,
#     face_offset_y: ?,
#   },
#   # HEAVY BUST EDITING. Neck is different.
#  "Wendis grey" => {
#     bust_scale: ?,
#     face_offset_x: ?,
#     face_offset_y: ?,
#   },
#   # HEAVY BUST EDITING. Neck is different.
#  "Wendis greyT" => {
#     bust_scale: ?,
#     face_offset_x: ?,
#     face_offset_y: ?,
#   },
 "Wynn" => {
    bust_scale: 0.79,
    face_offset_x: 59,
    face_offset_y: 50,
    face_border_width: 1
  },
 "Xerces" => {
    bust_scale: 0.75,
    face_offset_x: 60,
    face_offset_y: 25,
  },
 "Xestris" => {
    bust_scale: 0.74,
    face_offset_x: 59,
    face_offset_y: 27,
  },
 "Yarra" => {
    bust_scale: 0.70,
    face_offset_x: 83,
    face_offset_y: 20,
  },
 "Yelarel" => {
    bust_scale: 0.91,
    face_offset_x: 56,
    face_offset_y: 39,
  },
  # BUST COLOR EDITING NECESSARY
 "Zelica" => {
    bust_scale: 0.75,
    face_offset_x: 78,
    face_offset_y: 66,
  },
})
