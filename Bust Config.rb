Busty::FACE_TO_BUST = {
  "1 Simon dark eyes" => "Simon2",
  "1 Simon dark eyes2" => "Simon2",
  "1 Simon dark" => "Simon2",
  "1 Simon dark2" => "Simon2",
  "1 Simon distress1" => "Simon2D",
  "1 Simon distress2" => "Simon2D",
  "1 Simon distress3" => "Simon2",
  "1 Simon distress4" => "Simon2",
  "Alanon emo" => "Alonon",
  "darksorceress" => "Riala",
  "Dheria emo1" => "Dheria2", # grey tunic, red eyes
  "Dheria emo2" => "Dheria1", # blue tunic, green eyes
  "face002b" => "Simon1",
  "face002b2" => "Simon1",
  "face002b dark" => "Simon1",
  "face002b dark2" => "Simon1",
  "face002b_Wedding" => "Simon suit wedding",
  "Fucklord emo" => "Incubus Emperor",
  "MainActor1-1fs" => "Altina",
  "MainActor1-3fs" => "MainActor1-3", # Chosen
  "Min emo2" => "Min2",
  "Prologue emo" => "Ivala",
  "Riala emo2" => "Riala2",
  "Sabitha H emo" => "SabithaH",
  "Ulrissa emo3" => "Ulrissa2",
  "Z Andra emo" => nil, # To only allow face 4, see below
  "Z Andra emoN" => nil, # No bust for no robe Andra
  "Z Orcent" => "Orcent1",
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
    character_name: "Ivala Golden",
    face_name: "Ivala emo",
    face_indexes: [7],
  },
  {
    character_name: "Ivala Golden",
    face_name: "Prologue emo",
    face_indexes: [7],
  },
  {
    character_name: "Orcent1",
    face_name: "Orcent",
    face_indexes: [0, 1]
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
    character_name: "Incubus Emperor",
    face_name: "Monster1",
    face_indexes: [7],
  },
  {
    character_name: "Skullcrusher",
    face_name: "Incubus King Emo",
    face_indexes: [0, 1, 2, 3],
  },
  # Stark has no bust yet; but the configuration below will at least ensure he doesn't end up with Implevon's body
  {
    character_name: "Stark",
    face_name: "Z Implevon",
    face_indexes: [0, 1, 2, 3],
  },
  {
    character_name: "Ulrissa2",
    face_name: "Ulrissa emo",
    face_indexes: [6],
  },
  {
    character_name: "Vera",
    face_name: "Y DS_Actor17",
    face_indexes: [7],
  },
  # First half of Vera's faces are actually other characters
  {
    character_name: nil,
    face_name: "Vera emo",
    face_indexes: [0, 1, 2, 3],
  },
  #  Xestris dark faces
  {
    character_name: "Xestris2",
    face_name: "Xestris emo",
    face_indexes: [6, 7],
  },
  {
    character_name: "Xestris2",
    face_name: "Xestris emo2",
    face_indexes: [0],
  },
  # Xestris ear positions
  {
    character_name: "Xestris-ear-up",
    face_name: "Xestris emo2",
    face_indexes: [1],
  },
  {
    character_name: "Xestris-ear-down",
    face_name: "Xestris emo2",
    face_indexes: [2, 5, 6],
  },
  # Yarra boobs
  {
    character_name: "Yarra boobs",
    face_name: "Yarra emo2",
    face_indexes: [2],
  },
  {
    character_name: "Yarra boobs bigger",
    face_name: "Yarra emo2",
    face_indexes: [3],
  },
]
# Special cheats for some characters
class Window_Message < Window_Base
  def custom_bust_display_options
    # Vera has the same expressions on different sheets, but with a different zoom level. Ensure we use the configured one.
    if character_name == 'Vera' && $game_message.face_name != 'Vera emo'
      return [
        nil,
        nil,
        face_name = 'Vera emo'
      ]
    end

    nil
  end
end

# You can disable a character from that feature by passing "CharacterName" => "never" here
Busty::MESSAGE_AUTODISPLAY_SPECIAL = {
  "Feremina" => "stenai_princess_chosen",
  "Simon1" => "show_simon_the_green",

  # Luanall shares her face with nameless NPC, and there's not really a good way to differentiate them right now
  "Luanell" => "never",
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

    def stenai_princess_chosen
      $game_switches[2893]
    end

    def never
      false
    end
  end
end

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
  "Aka" => {
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
  "Bhakan" => {
    bust_scale: 0.80,
    face_offset_x: 59,
    face_offset_y: 46,
    face_z: -1,
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
  "Dheria1" => { # blue tunic, green eyes
    bust_scale: 0.75,
    face_offset_x: 68,
    face_offset_y: 34,
  },
  "Dheria2" => { # grey tunic, red eyes
    bust_scale: 0.75,
    face_offset_x: 68,
    face_offset_y: 34,
    face_border_width: [0, 0, 18, 0], # clothing colour mismatch
  },
  "Dio" => { # Lustlord
    bust_scale: 0.75,
    face_offset_x: 26,
    face_offset_y: 36,
  },
  "Donovan" => {
    bust_scale: 0.75,
    face_offset_x: 63,
    face_offset_y: 58,
    face_z: -1,
  },
  "Doomed King" => {
    bust_scale: 0.76,
    face_offset_x: 37,
    face_offset_y: 57,
    hide_original_face: true,
  },
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
  "Farnan" => {
    bust_scale: 0.73,
    face_offset_x: 57,
    face_offset_y: 46,
    face_z: -1,
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
  "Fuzkao" => {
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
  "Ghanth" => {
    bust_scale: 0.75,
    face_offset_x: 54,
    face_offset_y: 45,
    face_border_width: [16, 15, 23, 29],
  },
  "Ginasta" => {
    bust_scale: 0.73,
    face_offset_x: 60,
    face_offset_y: 42,
  },
  "Grynyth" => {
    bust_scale: 0.76,
    face_offset_x: 64,
    face_offset_y: 24,
    hide_original_face: true,
  },
  "Herin" => {
    bust_scale: 0.75,
    face_offset_x: 54,
    face_offset_y: 58,
    face_z: -1,
  },
  "Hester" => {
    bust_scale: 0.73,
    face_offset_x: 68,
    face_offset_y: 47,
    face_z: -1,
  },
  "Hilstara" => {
    bust_scale: 0.75,
    face_offset_x: 64,
    face_offset_y: 40,
  },
  "Ignias" => {
    bust_scale: 0.71,
    face_offset_x: 49,
    face_offset_y: 54,
    face_z: -1,
    face_border_width: [9, 0, 0, 0],
  },
  "Implevon" => {
    bust_scale: 0.63,
    face_offset_x: 45,
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
  "Janine" => {
    bust_scale: 0.75,
    face_offset_x: 52,
    face_offset_y: 34,
  },
  "Jhenno" => {
    bust_scale: 0.75,
    face_offset_x: 83,
    face_offset_y: 31,
    face_z: -1,
    face_border_width: [9, 0, 0, 0],
  },
  "Kalant" => {
    bust_scale: 0.82,
    face_offset_x: 79,
    face_offset_y: 40,
    face_border_width: 3,
    face_z: -1,
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
    face_offset_y: 40,
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
  "Mithyn" => {
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
    face_offset_x: 56,
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
  "Palina" => {
    bust_scale: 0.75,
    face_offset_x: 44,
    face_offset_y: 43,
  },
  "Qum D'umpe" => {
    bust_scale: 0.75,
    face_offset_x: 62,
    face_offset_y: 40,
    face_border_width: [0, 0, 0, 12],
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
  "soulmage" => {
    bust_scale: 0.71,
    face_offset_x: 55,
    face_offset_y: 29,
    face_z: -1,
  },
  "Tanurak" => {
    bust_scale: 0.75,
    face_offset_x: 73,
    face_offset_y: 42,
  },
  "Tertia" => {
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
    face_border_width: [0, 0, 21, 0],
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
    bust_scale: 0.727272,
    face_offset_x: 61,
    face_offset_y: 18,
  },
  "Orcent merchant" => {
    bust_scale: 0.727272,
    face_offset_x: 61,
    face_offset_y: 18,
  },
  "Orcent priest" => {
    bust_scale: 0.727272,
    face_offset_x: 61,
    face_offset_y: 18,
  },
  "Orcent slave" => {
    bust_scale: 0.727272,
    face_offset_x: 61,
    face_offset_y: 18,
  },
  "Orcent1" => {
    bust_scale: 0.727272,
    face_offset_x: 61,
    face_offset_y: 18,
  },
  "Orcent2" => {
    bust_scale: 0.727272,
    face_offset_x: 35,
    face_offset_y: 31,
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
  "Simon suit wedding" => {
    bust_scale: 0.815,
    face_offset_x: 64,
    face_offset_y: 45,
  },
  "Simon1" => {
    bust_scale: 0.75,
    face_offset_x: 63,
    face_offset_y: 34,
  },
  "Simon2" => {
    bust_scale: 0.75,
    face_offset_x: 67,
    face_offset_y: 32,
  },
  "Simon2D" => {
    bust_scale: 0.75,
    face_offset_x: 67,
    face_offset_y: 32,
  },
})

# adjustments to display characters at the right position
# - most characters -> middle of nose level with top of text box
# - halflings, dwarren -> short
# - Tertia, Doom King -> tall
# also some X axis adjustments for centering
Busty::MESSAGE_CONFIG.merge!({
  "Aka" => {
    bust_offset_y: 5,
  },
  "Antiala" => {
    bust_offset_y: 15,
    bust_offset_x: -40,
  },
  "Balia" => {
    bust_offset_x: -25,
    bust_offset_y: 15,
  },
  "Carina" => {
    bust_offset_y: 15,
  },
  "Dari1" => {
    bust_offset_x: -27,
    bust_offset_y: 0,
  },
  "Dheria1" => {
    bust_offset_x: -40,
  },
  "Dheria2" => {
    bust_offset_x: -40,
  },
  "Dio" => {
    bust_offset_x: -10,
    bust_offset_y: 15,
  },
  "Doomed King" => {
    bust_offset_x: -15,
    bust_offset_y: 0,
  },
  "Elleani" => {
    bust_offset_y: 25,
  },
  "Esmera" => {
    bust_offset_x: -40,
    bust_offset_y: 15,
  },
  "Esthera" => {
    bust_offset_y: 35,
  },
  "Fheliel" => {
    bust_offset_x: -40,
  },
  "Galvia" => {
    bust_offset_y: 20,
  },
  "Grynyth" => {
    bust_offset_x: -33,
    bust_offset_y: 25,
  },
  "Herin" => {
    bust_offset_y: 5,
  },
  "Hilstara" => {
    bust_offset_x: -45,
    bust_offset_y: 15,
  },
  "Incubus Emperor" => {
    bust_offset_x: -20,
    bust_offset_y: 35,
  },
  "Janine" => {
    bust_offset_y: 25,
  },
  "Kalant" => {
    bust_offset_y: 40,
  },
  "Kaskia" => {
    bust_offset_x: -30,
  },
  "Lilith" => {
    bust_offset_x: -40,
  },
  "Lynine" => {
    bust_offset_y: 10,
  },
  "MainActor1-3" => { # Chosen
    bust_offset_y: 55,
  },
  "Megail" => {
    bust_offset_y: 20,
  },
  "Melymyn" => {
    bust_offset_y: 8,
  },
  "Mestan" => {
    bust_offset_y: -5,
  },
  "Mithyn" => {
    bust_offset_x: -145,
  },
  "Nabith" => {
    bust_offset_x: -25,
  },
  "Neranda" => {
    bust_offset_y: 15,
  },
  "Nyst" => {
    bust_offset_y: 30,
  },
  "Palina" => {
    bust_offset_x: -15,
  },
  "Qum D'umpe" => {
    bust_offset_y: 20,
  },
  "Robin blond" => {
    bust_offset_x: -43,
    bust_offset_y: 5,
  },
  "Sage" => {
    bust_offset_y: 45,
  },
  "Sarai" => {
    bust_offset_y: 30,
  },
  "Tanurak" => {
    bust_offset_y: 15,
  },
  "Tertia" => {
    bust_offset_x: -65,
    bust_offset_y: 27,
  },
  "Tyna" => {
    bust_offset_y: 5,
  },
  "Uyae" => {
    bust_offset_x: -20,
  },
  "Varia" => {
    bust_offset_y: 10,
  },
  "Vhala" => {
    bust_offset_y: 12,
  },
  "Wynn" => {
    bust_offset_x: -30,
    bust_offset_y: 22,
  },
  "Bhakan" => {
    bust_offset_y: 25,
  },
  "Donovan" => {
    bust_offset_y: 5,
  },
  "Farnan" => {
    bust_offset_y: 5,
  },
  "Ghanth" => {
    bust_offset_y: 15,
  },
  "Jhenno" => {
    bust_offset_y: 28,
  },
  "Biyue" => {
    bust_offset_y: 15,
  },
  "Grubbak" => {
    bust_offset_x: -39,
    bust_offset_y: 31,
  },
  "Impaler" => {
    bust_offset_y: 30,
  },
  "Yarra" => {
    bust_offset_x: -55,
  },
  "Dari1" => {
    bust_offset_x: -30,
  },
  "Iris" => {
    bust_offset_x: -30,
  },
  "Xerces" => {
    bust_offset_x: -42,
  },
  "Mestan" => {
    bust_offset_x: -24,
  },
  "Riala" => {
    bust_offset_x: -30,
  },
})

# Configuring super modes and co
# They are close enough from normal modes we can just duplicate the original values
Busty::replicate_config_for_alternate_forms([
  # Carina does not need anything specific as only her eyes change
  {
    original: "Aka",
    faces: ["Aka emo2"],
    bust: "Aka2",
  },
  {
    original: "Dari1",
    faces: ["Dari2 emo"],
    bust: "Dari2",
  },
  {
    original: "Hilstara",
    faces: ["Hilstara emo3"],
    bust: "HilstaraKnight",
  },
  {
    original: "Janine",
    faces: ["Janine emo2B", "Janine emo3B"],
    bust: "Janine Bride",
  },
  {
    original: "Lilith",
    faces: ["Lilith emo3"],
    bust: "Lilith grey",
  },
  {
    original: "Megail",
    faces: ["Megail emo2g"],
    bust: "MegailGold",
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
    original: "Robin blond",
    faces: ["Robin grey emo"],
    bust: "Robin grey",
  },
  {
    original: "Tanurak",
    faces: ["Tanurak emoX"],
    bust: "TanurakX",
  },
  {
    original: "MainActor1-3",
    faces: ["MainActor1-3fsx"], # Corrupted Chosen
    bust: "MainActor1-3x",
  },
  {
    original: "Qum D'umpe",
    faces: ["Qum D'umpe emo2"],
    bust: "Qum D'umpe2",
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
])

# Dealing with Yarra's boobs
Busty::BASE_CONFIG.merge!({
  "Yarra boobs" => {
    hide_original_face: true,
  },
  "Yarra boobs bigger" => {
    hide_original_face: true,
  },
})
Busty::MESSAGE_CONFIG.merge!({
  "Yarra boobs" => {
    bust_offset_x: -48,
  },
  "Yarra boobs bigger" => {
    bust_offset_x: -6,
  },
})
# Ulrissa hidden behind wolf mask
Busty::BASE_CONFIG["Ulrissa2"] = Busty::BASE_CONFIG["Ulrissa"]
Busty::MESSAGE_CONFIG["Ulrissa2"] = Busty::MESSAGE_CONFIG["Ulrissa"]
# Dark Xestris
Busty::BASE_CONFIG["Xestris2"] = Busty::BASE_CONFIG["Xestris"]
Busty::MESSAGE_CONFIG["Xestris2"] = Busty::MESSAGE_CONFIG["Xestris"]
# Xestris ear positions
Busty::BASE_CONFIG["Xestris-ear-up"] = Busty::BASE_CONFIG["Xestris"]
Busty::MESSAGE_CONFIG["Xestris-ear-up"] = Busty::MESSAGE_CONFIG["Xestris"]
Busty::BASE_CONFIG["Xestris-ear-down"] = Busty::BASE_CONFIG["Xestris"]
Busty::MESSAGE_CONFIG["Xestris-ear-down"] = Busty::MESSAGE_CONFIG["Xestris"]
# Grynyth needs separate images for every face because her semi-transparent
# elements and moving eyebrow thingies make overlays a total nightmare
(1..2).each do |i|
  (0..7).each do |j|
    name = "Grynyth#{i}-#{j}"
    Busty::SUBSET_TO_BUST.insert(-1, { character_name: name, face_name: "Grynyth emo#{i > 1 ? i : ''}", face_indexes: [j] })
    Busty::BASE_CONFIG[name] = Busty::BASE_CONFIG["Grynyth"]
    Busty::MESSAGE_CONFIG[name] = Busty::MESSAGE_CONFIG["Grynyth"]
  end
end
# Doom King has various armour colours - simplest just to use one bust image for each
(0..7).each do |j|
  name = "Doomed King #{j}"
  Busty::SUBSET_TO_BUST.insert(-1, { character_name: name, face_name: "Doomed King emo", face_indexes: [j] })
  Busty::BASE_CONFIG[name] = Busty::BASE_CONFIG["Doomed King"]
  Busty::MESSAGE_CONFIG[name] = Busty::MESSAGE_CONFIG["Doomed King"]
end
# Ivala
# Explicit config so we can easily duplicate it
Busty::MESSAGE_CONFIG.merge!({
  "Ivala" => {
    bust_offset_x: -35,
    bust_offset_y: 10,
  },
})
Busty::BASE_CONFIG.merge!({
  "Ivala Golden" => {
    hide_original_face: true,
  },
})
Busty::MESSAGE_CONFIG["Ivala Golden"] = Busty::MESSAGE_CONFIG["Ivala"]
