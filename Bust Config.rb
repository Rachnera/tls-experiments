Busty::FACE_TO_BUST = {
  "1 Simon dark eyes" => "Simon2",
  "1 Simon dark eyes2" => "Simon2",
  "1 Simon dark" => "Simon2",
  "1 Simon dark2" => "Simon2",
  # FIXME There are actually two distinct distress busts (2B and 2D) and I have no idea which one should be used with which faces
  "1 Simon distress1" => "Simon2D",
  "1 Simon distress2" => "Simon2D",
  "1 Simon distress3" => "Simon2",
  "1 Simon distress4" => "Simon2",
  "Aka emo2" => "Aka2",
  "Alanon emo" => "Alonon",
  "darksorceress" => "Riala",
  "Dheria emo2" => "Dheria2",
  "face002b" => "Simon1",
  "face002b2" => "Simon1",
  "face002b dark" => "Simon1",
  "face002b dark2" => "Simon1",
  "face002b_Wedding" => "Simon suit wedding",
  "Fucklord emo" => "Incubus Emperor",
  "Fuzkao emo" => "Fuzkao no hand",
  "Grynyth emo" => "Grynyth full",
  "Grynyth emo2" => "Grynyth full",
  "Ivala emo" => nil, # To remove unsupported furious Ivala (different color)
  "Janine emo2" => "Janine 1",
  "Janine emo3" => "Janine 1",
  "Janine emo2B" => "Janine Bride",
  "Janine emo3B" => "Janine Bride",
  "Lilith emo3" => "Lilith grey",
  "MainActor1-1fs" => "Altina",
  "MainActor1-3fs" => "MainActor1-3", # Chosen
  "Min emo2" => "Min2",
  "Mithyn emo" => "Mithyn full",
  "Mithyn emo2" => "Mithyn full",
  "Mithyn emo3 blush" => "Mithyn full",
  "Riala emo2" => "Riala2",
  "Sabitha H emo" => "SabithaH",
  "Tanurak emoX" => nil, # Disable "glitch" Tanurak
  "Tertia emo" => "TertiaH", # Two Tertia bust files, the H is the one with the same ratio as most others
  "Xestris emo" => nil, # Exclude Xestris "dark" faces
  "Xestris emo2" => nil,
  "Yarra emo2" => nil, # To exclude "faces" 2/3
  "Z Andra emo" => nil, # To only allow face 4
  "Z Andra emoN" => nil, # No bust for no robe Andra
  "Z Grubbak" => "Grubbak",
  # "Z Orcent" => "Orcent1", # FIXME Temporary disable of some of Orcent's faces (bust mismatch)
  "Z Ralke" => "Ralke",
}

Busty::SUBSET_TO_BUST = [
  {
    character_name: "Andra",
    face_name: "Z Andra emo",
    face_indexes: [4],
  },
  {
    character_name: "Impaler",
    face_name: "Z orc emo",
    face_indexes: [6],
  },
  {
    character_name: "Ivala",
    face_name: "Ivala emo",
    face_indexes: [0, 1, 2, 3, 4, 5, 6],
  },
  {
    character_name: "Orcent1",
    face_name: "Orcent",
    # face_indexes: [0, 1], # FIXME Mismatch for face 0 as of now
    face_indexes: [1],
  },
  {
    character_name: "Orcent2",
    face_name: "Orcent",
    face_indexes: [2],
  },
  {
    character_name: "Orcent priest",
    face_name: "Orcent",
    face_indexes: [3],
  },
  {
    character_name: "Orcent slave",
    face_name: "Orcent",
    face_indexes: [4],
  },
  {
    character_name: "Orcent IK",
    face_name: "Orcent",
    face_indexes: [5],
  },
  {
    character_name: "Orcent merchant",
    face_name: "Orcent",
    face_indexes: [7],
  },
  {
    character_name: "Lord of Blood",
    face_name: "Incubus King Emo",
    face_indexes: [4, 5, 6, 7],
  },
  {
    character_name: "Luanell",
    face_name: "Z Givini emo",
    face_indexes: [1],
  },
  {
    character_name: "Skullcrusher",
    face_name: "Incubus King Emo",
    face_indexes: [0, 1, 2, 3],
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

# You can disable a character from that feature by passing "CharacterName" => "never" here
Busty::MESSAGE_AUTODISPLAY_SPECIAL = {
  "Simon1" => "show_simon_the_green",

  # Temporary disable characters in need of a bust fix
  "Hester" => "never",
  "Robin grey" => "never",
  "Simon2D" => "never",
  "Ulrissa" => "never",
}
module Busty
  class << self
    def show_simon_the_green
      # True protagonist revealed
      # No switch that I'm aware of tracking that; so checking if Kai's quests are active instead
      return false if $game_party.quests.revealed?(5)

      # Simon is using his almost naked sprite
      return false if $game_actors[2].character_index == 2

      true
    end

    def never
      false
    end
  end
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
  },
})
Busty::MESSAGE_CONFIG.merge!({
  "Altina" => {
    bust_offset_x: -30,
  },
  "Alonon" => {
    bust_offset_x: -24,
  },
  "Balia" => {
    bust_offset_x: -30,
  },
  "Bertricia" => {
    bust_offset_x: -36,
  },
  "Dio" => { # Lustlord
    bust_offset_x: -36,
  },
  "Esthera" => {
    bust_offset_x: -72,
  },
  "Feremina" => {
    bust_offset_x: 0,
  },
  "Galvia" => {
    bust_offset_x: -36,
  },
  "Lynine" => {
    bust_offset_x: -36,
  },
  "MainActor1-3" => { # Chosen
    bust_offset_x: -60,
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
  "Mithyn full" => {
    bust_offset_x: -180,
  },
  "Nalili" => {
    bust_offset_y: 25,
  },
  "Neranda" => {
    bust_offset_x: -36,
  },
  "Orcent2" => {
    bust_offset_x: -24,
  },
  "Ralke" => {
    bust_offset_x: -36,
  },
  "Sarai" => {
    bust_offset_x: -20,
    bust_offset_y: 25,
  },
  "TertiaH" => {
    bust_offset_x: -72,
  },
  "Uyae" => {
    bust_offset_x: -36,
  },
  "Vera" => {
    bust_offset_x: -36,
  },
  "Wendis blond" => {
    bust_offset_x: -36,
  },
 "Wendis blondT" => {
    bust_offset_x: -36,
  },
 "Wendis grey" => {
    bust_offset_x: -36,
  },
 "Wendis greyT" => {
    bust_offset_x: -36,
  },
  "Wynn" => {
    bust_offset_y: 24,
  },
})

# Decarabia
Busty::BASE_CONFIG.merge!({
  "Aka" => {
    bust_scale: 0.80,
    face_offset_x: 61,
    face_offset_y: 66,
  },
  # FIXME Minor. For her bust I increased brightness by -5 due to differences in tan between her bust and faceset. Also had to increase brightness on her bust's hair
  "Aka2" => {
    bust_scale: 0.80,
    face_offset_x: 61,
    face_offset_y: 66,
  },
  "Alonon" => {
    bust_scale: 0.71,
    face_offset_x: 45,
    face_offset_y: 26,
    face_border_width: 4,
    face_z: -1,
  },
  "Altina" => {
    bust_scale: 0.78,
    face_offset_x: 39,
    face_offset_y: 30,
    face_border_width: 1,
  },
  "Annah" => {
    bust_scale: 0.77,
    face_offset_x: 61,
    face_offset_y: 44,
    face_border_width: 4,
    face_z: -1,
  },
  "Antarion" => {
    bust_scale: 0.79,
    face_offset_x: 73,
    face_offset_y: 28,
    face_border_width: 1,
  },
  "Antiala" => {
    bust_scale: 0.75,
    face_offset_x: 69,
    face_offset_y: 50,
  },
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
  # FIXME. Minor. Needs to adjust bust to match color of face's hair and clothes
  "Dio" => { # Lustlord
    bust_scale: 0.75,
    face_offset_x: 26,
    face_offset_y: 36,
  },
  # FIXME Minor. Needs to adjust hair color to match
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
    face_border_width: 1,
  },
  "Ginasta" => {
    bust_scale: 0.73,
    face_offset_x: 60,
    face_offset_y: 42,
  },
  # cut some parts of the bust to try and fix the transparency overlay issue between the two images.
  "Grynyth full" => {
    bust_scale: 0.76,
    face_offset_x: 64,
    face_offset_y: 24,
    face_border_width: 1,
  },
  "Herin" => {
    bust_scale: 0.75,
    face_offset_x: 54,
    face_offset_y: 50,
  },
  # FIXME Major.
  # DIFFERENT BUST AND FACESET
  "Hester" => {
    bust_scale: 0.75,
    face_offset_x: 71,
    face_offset_y: 48,
  },
  # FIXME Minor. bust color hair edited to match faceset
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
  "MainActor1-3" => {
    bust_scale: 0.82,
    face_offset_x: 79,
    face_offset_y: 40,
    face_border_width: 1,
  },
  "Megail" => {
    bust_scale: 0.80,
    face_offset_x: 60,
    face_offset_y: 39,
    face_z: -1,
  },
  "Melymyn" => {
    bust_scale: 0.72,
    face_offset_x: 51,
    face_offset_y: 28,
  },
  "Mestan" => {
    bust_scale: 0.66,
    face_offset_x: 52,
    face_offset_y: 41,
    face_z: -1,
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
  "Mithyn full" => {
    bust_scale: 0.75,
    face_offset_x: 175,
    face_offset_y: 53,
    face_border_width: 1,
  },
  "Nabith" => {
    bust_scale: 0.72,
    face_offset_x: 45,
    face_offset_y: 48,
  },
  "Nalili" => {
    bust_scale: 0.73,
    face_offset_x: 55,
    face_offset_y: 28,
    face_z: -1,
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
  # FIXME Minor. NEEDS COLOR ADJUSTMENT
  "Palina" => {
    bust_scale: 0.75,
    face_offset_x: 44,
    face_offset_y: 43,
  },
  # FIXME Minor. NEEDS COLOR ADJUSTMENT
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
  # FIXME Major. Wrong hue of grey?
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
  "SabithaH" => {
    bust_scale: 0.75,
    face_offset_x: 53,
    face_offset_y: 58,
    face_border_width: 5,
    face_z: -1,
  },
  "Sage" => {
    bust_scale: 0.79,
    face_offset_x: 37,
    face_offset_y: 25,
  },
  "Sarai" => {
    bust_scale: 0.77,
    face_offset_x: 26,
    face_offset_y: 50,
    face_z: -1,
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
  # FIXME Major. Need a variant of the bust where the wolf head is up to cover all possible faces.
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
  "Vunne" => {
    bust_scale: 0.78,
    face_offset_x: 68,
    face_offset_y: 65,
    face_z: -1,
  },
  "Wendis blond" => {
    bust_scale: 0.70,
    face_offset_x: 48,
    face_offset_y: 40,
    face_z: -1,
    face_border_width: [0, 0, 21, 0]
  },
 "Wendis blondT" => {
    bust_scale: 0.69,
    face_offset_x: 47,
    face_offset_y: 38,
    face_z: -1,
    face_border_width: [0, 0, 21, 0]
  },
 "Wendis grey" => {
    bust_scale: 0.70,
    face_offset_x: 48,
    face_offset_y: 40,
    face_z: -1,
    face_border_width: [0, 0, 21, 0],
  },
 "Wendis greyT" => {
    bust_scale: 0.69,
    face_offset_x: 47,
    face_offset_y: 38,
    face_z: -1,
  },
 "Wynn" => {
    bust_scale: 0.79,
    face_offset_x: 59,
    face_offset_y: 50,
    face_border_width: 1,
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
  # FIXME Minor. BUST COLOR EDITING NECESSARY
 "Zelica" => {
    bust_scale: 0.75,
    face_offset_x: 78,
    face_offset_y: 66,
  },
  "Incubus Emperor" => {
    bust_scale: 0.75,
    face_offset_x: 41,
    face_offset_y: 23,
    face_border_width: 1,
  },
  "Lord of Blood" => {
    bust_scale: 0.78,
    face_offset_x: 69,
    face_offset_y: 21,
    face_z: -1,
  },
  "Skullcrusher" => {
    bust_scale: 0.78,
    face_offset_x: 70,
    face_offset_y: 35,
  },
  "Biyue" => {
    bust_scale: 0.77,
    face_offset_x: 64,
    face_offset_y: 37,
  },
  "Fuani" => {
    bust_scale: 0.70,
    face_offset_x: 46,
    face_offset_y: 61,
    face_border_width: 1,
  },
  "Orcent IK" => {
    bust_scale: 0.73,
    face_offset_x: 62,
    face_offset_y: 19,
  },
  "Orcent merchant" => {
    bust_scale: 0.73,
    face_offset_x: 62,
    face_offset_y: 18,
    face_border_width: 5,
  },
  "Orcent priest" => {
    bust_scale: 0.73,
    face_offset_x: 62,
    face_offset_y: 19,
  },
  "Orcent slave" => {
    bust_scale: 0.74,
    face_offset_x: 64,
    face_offset_y: 19,
  },
  # FIXME Minor. Coloring issue for the no eyepatch face
  "Orcent1" => {
    bust_scale: 0.73,
    face_offset_x: 62,
    face_offset_y: 19,
  },
  "Orcent2" => {
    bust_scale: 0.74,
    face_offset_x: 36,
    face_offset_y: 26,
    face_border_width: [0, 0, 20, 15],
  },
  "Grubbak" => {
    bust_scale: 0.73,
    face_offset_x: 67,
    face_offset_y: 24,
    face_border_width: 1
  },
  "Impaler" => {
    bust_scale: 0.80,
    face_offset_x: 69,
    face_offset_y: 42,
  },
  "Ralke" => {
    bust_scale: 0.70,
    face_offset_x: 57,
    face_offset_y: 54,
  },
  # FIXME Major. Still some issues with the beard?
  "Simon suit wedding" => {
    bust_scale: 0.81,
    face_offset_x: 64,
    face_offset_y: 45,
    face_border_width: [0, 13, 19, 28],
  },
  "Simon1" => {
    bust_scale: 0.75,
    face_offset_x: 63,
    face_offset_y: 34,
    face_z: -1,
  },
  "Simon2" => {
    bust_scale: 0.75,
    face_offset_x: 67,
    face_offset_y: 32,
    face_border_width: [0, 0, 24, 0],
  },
  "Simon2B" => {
    bust_scale: 0.75,
    face_offset_x: 67,
    face_offset_y: 32,
    face_border_width: [0, 0, 24, 0],
  },
  "Simon2D" => {
    bust_scale: 0.75,
    face_offset_x: 67,
    face_offset_y: 32,
    face_border_width: [0, 0, 24, 0],
  },
})

# Rachnera
# Configuring super modes
# They are close enough from normal modes we can just duplicate the original values
[
  # Carina does not need anything specific as only her eyes change
  {
    original: "Hilstara",
    faces: ["Hilstara emo3"],
    bust: "HilstaraKnight",
  },
  {
    original: "Nalili",
    faces: ["Nalili emo3", "Nalili emo4"],
    bust: "Nalili2",
  },
  {
    original: "Neranda",
    faces: ["Neranda emo3", "Neranda emo4"],
    bust: "NerandaAvatar",
  },
  {
    original: "Trin",
    faces: ["Trin emo3", "Trin emo4"],
    bust: "Trin-diadem-portrait",
  },
  {
    original: "Uyae",
    faces: ["Uyae emo2d"],
    bust: "Uyae God Flip",
  },
].each do |cf|
  Busty::BASE_CONFIG[cf[:bust]] = Busty::BASE_CONFIG[cf[:original]].clone
  Busty::MESSAGE_CONFIG[cf[:bust]] = Busty::MESSAGE_CONFIG[cf[:original]].clone if Busty::MESSAGE_CONFIG[cf[:original]]
  cf[:faces].each do |face|
    Busty::FACE_TO_BUST[face] = cf[:bust]
  end
end

# Nalili is being difficult and needs to be extra adjusted manually.
# Decarabia
Busty::BASE_CONFIG["Nalili2"] = {
  bust_scale: 0.73,
  face_offset_x: 56,
  face_offset_y: 28,
  face_z: -1,
}
