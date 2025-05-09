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
  "Prologue emo" => "Ivala",
  "Riala emo2" => "Riala2",
  "Sabitha H emo" => "SabithaH",
  "Simon 3 1" => "Simon2",
  "Simon 3 2" => "Simon2",
  "Ulrissa emo3" => "Ulrissa2",
  "Uyae emo2d" => "Uyae God Flip",
  "Z Andra emo" => nil, # To only allow face 4, see below
  "Z Andra emoN" => "AndraN", # post-debauchment
  "Z Orcent" => "Orcent1",
  "Z Commander Geoff emo" => "Commander Geoff",
  "Z Elven ambassador" => "Elven Ambassador",
  "Z Zirantian ambassador" => "Uolian",
}

Busty::SUBSET_TO_BUST = [
  {
    character_name: "Andra",
    face_name: "Z Andra emo",
    face_indexes: [4],
  },
  {
    character_name: "Ardan Ambassador",
    face_name: "People3",
    face_indexes: [2],
  },
  {
    character_name: "Ardan Steward",
    face_name: "People3",
    face_indexes: [3],
  },
  {
    character_name: "Dwarren Ambassador",
    face_name: "Actor3",
    face_indexes: [6],
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
    character_name: "Reval",
    face_name: "Actor3",
    face_indexes: [0],
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
  {
    character_name: "Aramite Ambassador",
    face_name: "Y Aram4",
    face_indexes: [2],
  },
  {
    character_name: "Yhilini Ambassador",
    face_name: "Y DS_Actor04",
    face_indexes: [3],
  },
  {
    character_name: "Bartholomew",
    face_name: "Y soldier alts emo",
    face_indexes: [1,5],
  },
]

# map from clothed Simon facesets to corresponding topless Simon
Busty::TOPLESS_SIMON_MAP = {
  "face002b" => "face002b_topless",
  "1 Simon dark" => "face002b_topless",
  "face002b2" => "face002b_topless2",
  "1 Simon dark2" => "face002b_topless2",
  "face002b dark" => "face002b_topless dark",
  "1 Simon dark eyes" => "face002b_topless dark",
  "face002b dark2" => "face002b_topless dark2",
  "1 Simon dark eyes2" => "face002b_topless dark2",
}
Busty::TOPLESS_SIMON_MAP.values.uniq.each do |value|
  Busty::FACE_TO_BUST[value] = "Simon topless"
end
# young Simon does not support disrobing
Busty::SIMON_YOUNG_FACES = ["face002b","face002b dark"]

# Automatically swap certain facesets depending on certain conditions.
# NB this comes before face-to-bust mapping in character_from_face.
class Window_Message < Window_Base
  def bust_face_name
    # if Simon is using his almost-naked sprite, override with topless faceset, unless it's young Simon
    topless_simon_face = Busty::TOPLESS_SIMON_MAP[$game_message.face_name]
    if topless_simon_face && $game_actors[2].character_index == 2 && 
        !($game_message.face_index == 7 && Busty::SIMON_YOUNG_FACES.include?($game_message.face_name))
      return topless_simon_face
    end
    
    # fix up Uyae's clothes after returning from first Zirantia trip
    # see also character_from_face below
    if $game_message.face_name == 'Uyae emo' && $game_switches[1481] # YHILIN III
      return 'Uyae2 emo'
    end
    
    # Vera has the same expressions on different sheets, but with a different zoom level. Ensure we use the configured one.
    if $game_message.face_name == 'Y DS_Actor17' && $game_message.face_index == 7
      return 'Vera emo'
    end

    # Simon in Incubus prison, after the Flickering Path (second zone or more) and before the ritual to summon him back
    # Second boundary chosen so that Simon still uses his tired face when interacting with Tanurak
    if $game_switches[4364] && !$game_switches[4534]
      max_weariness = $game_switches[4367] # After the Gentle Path

      if $game_message.face_name == '1 Simon dark'
        return max_weariness ? 'Simon 4 1' : 'Simon 3 1'
      end

      if $game_message.face_name == '1 Simon dark2'
        return max_weariness ? 'Simon 4 2' : 'Simon 3 2'
      end

      if $game_message.face_name == '1 Simon dark eyes'
        return max_weariness ? 'Simon 4 3' : 'Simon 3 3'
      end

      if $game_message.face_name == '1 Simon dark eyes2'
        return max_weariness ? 'Simon 4 4' : 'Simon 3 4'
      end
    end

    $game_message.face_name
  end
end

# Automatically swap busts depending on certain conditions.
# NB this step comes after faceset swapping in bust_face_name.
module Busty
  class << self
    alias original_character_from_face character_from_face
    def character_from_face(face_name, face_index)
      if face_name == 'Uyae2 emo' && $game_switches[2081] # HOME BASE
        # reinstate Uyae's boob window after travelling the world between ch3-4
        return 'Uyae3'
      end

      original_character_from_face(face_name, face_index)
    end
  end
end

# You can disable a character from that feature by passing "CharacterName" => "never" here
Busty::MESSAGE_AUTODISPLAY_SPECIAL = {
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

      true
    end

    def never
      false
    end
  end
end

Busty::CONFIG.merge!({
  "Andra" => {
    face_offset_x: 68,
    face_offset_y: 63,
  },
  "AndraN" => { # post-debauchment
    face_offset_x: 68,
    face_offset_y: 46,
  },
  "Luanell" => {
    face_offset_x: 59,
    face_offset_y: 51,
  },
  "Aka" => {
    face_offset_x: 61,
    face_offset_y: 66,

    bust_offset_y: 5,
    fade: false,
  },
  "Alonon" => {
    face_offset_x: 45,
    face_offset_y: 26,
    face_border_width: 4,
    face_z: -1,
  },
  "Altina" => {
    face_offset_x: 39,
    face_offset_y: 30,
    face_border_width: 1,
  },
  "Annah" => {
    face_offset_x: 61,
    face_offset_y: 44,
    face_border_width: 4,
    face_z: -1,
  },
  "Antarion" => {
    face_offset_x: 73,
    face_offset_y: 28,
    face_border_width: 1,
  },
  "Antiala" => {
    face_offset_x: 69,
    face_offset_y: 66,

    bust_offset_y: 15,
    bust_offset_x: -40,
  },
  "Aramite Ambassador" => {
    face_offset_x: 66,
    face_offset_y: 30,
  },
  "Ardan Steward" => {
    face_offset_x: 66,
    face_offset_y: 36,
    bust_offset_y: 30,
  },
  "Ardan Ambassador" => {
    face_offset_x: 66,
    face_offset_y: 53,
    bust_offset_x: -36,
    bust_offset_y: 14,
  },
  "Bartholomew" => {
    face_offset_x: 35,
    face_offset_y: 35,

    bust_offset_y: 18,
    bust_offset_x: -18,
  },
  "Balia" => {
    face_offset_x: 53,
    face_offset_y: 38,
    bust_offset_x: -25,
    bust_offset_y: 15,
    overflow_behind_text: false, # doesn't play nice with fade and semitransparent bits
  },
  "Bertricia" => {
    face_offset_x: 44,
    face_offset_y: 37,

    fade: false,
  },
  "Bhakan" => {
    face_offset_x: 59,
    face_offset_y: 46,
    face_z: -1,

    bust_offset_y: 25,
  },
  "Carina" => {
    face_offset_x: 69,
    face_offset_y: 47,

    bust_offset_y: 15,
  },
  "Commander Geoff" => {
    face_offset_x: 51,
    face_offset_y: 26,

    bust_offset_x: -33,
  },
  "Death" => {
    face_offset_x: 56,
    face_offset_y: 32,
    
    bust_offset_x: -25,
    bust_offset_y: 30,
    fade: false,
  },
  "Dari1" => {
    face_offset_x: 47,
    face_offset_y: 30,

    bust_offset_x: -30,
    bust_offset_y: 0,
    fade: false,
  },
  "Dheria1" => { # blue tunic, green eyes
    face_offset_x: 68,
    face_offset_y: 34,

    bust_offset_x: -40,
  },
  "Dheria2" => { # grey tunic, red eyes
    face_offset_x: 68,
    face_offset_y: 34,
    face_border_width: [0, 0, 18, 0], # clothing colour mismatch

    bust_offset_x: -40,
  },
  "Dio" => { # Lustlord
    face_offset_x: 26,
    face_offset_y: 52,

    bust_offset_x: -10,
    bust_offset_y: 15,
  },
  "Donovan" => {
    face_offset_x: 63,
    face_offset_y: 58,
    face_z: -1,

    bust_offset_y: 5,
  },
  "Doomed King" => {
    face_offset_x: 37,
    face_offset_y: 57,
    hide_original_face: true,

    bust_offset_x: -15,
    bust_offset_y: 0,
  },
  "Dwarren Ambassador" => {
    face_offset_x: 41,
    face_offset_y: 49,
    bust_offset_y: 15,
  },
  "Elleani" => {
    face_offset_x: 79,
    face_offset_y: 31,

    bust_offset_y: 25,
    fade: false,
  },
  "Elven Ambassador" => {
    face_offset_x: 59,
    face_offset_y: 63,
  },
  "Entila" => {
    face_offset_x: 56,
    face_offset_y: 42,
    
    bust_offset_x: -35,
    fade: false,
  },
  "Esmera" => {
    face_offset_x: 67,
    face_offset_y: 49,

    bust_offset_x: -40,
    bust_offset_y: 15,
  },
  "Estaven" => {
    face_offset_x: 70,
    face_offset_y: 54,
  },
  "Esthera" => {
    face_offset_x: 82,
    face_offset_y: 39,

    bust_offset_y: 35,
  },
  "Etuanun" => {
    face_offset_x: 66,
    face_offset_y: 62,
  },
  "Eytria" => {
    face_offset_x: 60,
    face_offset_y: 34,
  },
  "Farnan" => {
    face_offset_x: 57,
    face_offset_y: 46,
    face_z: -1,

    bust_offset_y: 5,
    fade: false,
  },
  "Feremina" => {
    face_offset_x: 16,
    face_offset_y: 22,

    fade: false,
  },
  "Fheliel" => {
    face_offset_x: 59,
    face_offset_y: 37,

    bust_offset_x: -40,
  },
  "Fuzkao" => {
    face_offset_x: 82,
    face_offset_y: 25,

    fade: false,
  },
  "Galvia" => {
    face_offset_x: 41,
    face_offset_y: 59,
    face_border_width: 1,

    bust_offset_y: 20,
  },
  "Ghanth" => {
    face_offset_x: 54,
    face_offset_y: 45,
    face_border_width: [16, 15, 23, 29],

    bust_offset_y: 15,
  },
  "Ginasta" => {
    face_offset_x: 60,
    face_offset_y: 42,
  },
  "Grynyth" => {
    face_offset_x: 64,
    face_offset_y: 24,
    hide_original_face: true,

    bust_offset_x: -33,
    bust_offset_y: 25,
  },
  "Herin" => {
    face_offset_x: 54,
    face_offset_y: 74,
    face_z: -1,

    bust_offset_y: 5,
  },
  "Hester" => {
    face_offset_x: 68,
    face_offset_y: 47,
    face_z: -1,
  },
  "Hilstara" => {
    face_offset_x: 64,
    face_offset_y: 40,

    bust_offset_x: -45,
    bust_offset_y: 15,
  },
  "Ignias" => {
    face_offset_x: 49,
    face_offset_y: 54,
    face_z: -1,
    face_border_width: [9, 0, 0, 0],
  },
  "Implevon" => {
    face_offset_x: 45,
    face_offset_y: 40,

    fade: false,
  },
  "Iris" => {
    face_offset_x: 50,
    face_offset_y: 47,

    bust_offset_x: -30,
  },
  "Ivala" => {
    face_offset_x: 57,
    face_offset_y: 50,

    bust_offset_x: -35,
    bust_offset_y: 10,
  },
  "Janine" => {
    face_offset_x: 52,
    face_offset_y: 34,

    bust_offset_y: 25,
  },
  "Jhenno" => {
    face_offset_x: 83,
    face_offset_y: 31,
    face_z: -1,
    face_border_width: [9, 0, 0, 0],

    bust_offset_y: 28,
    fade: false,
  },
  "Kalant" => {
    face_offset_x: 79,
    face_offset_y: 40,
    face_border_width: 3,
    face_z: -1,

    bust_offset_y: 40,
  },
  "Kaskia" => {
    face_offset_x: 54,
    face_offset_y: 47,

    bust_offset_x: -30,
    fade: false,
  },
  "Kerannii" => {
    face_offset_x: 68,
    face_offset_y: 39,
  },
  "Lilith" => {
    face_offset_x: 69,
    face_offset_y: 69,

    bust_offset_x: -40,
  },
  "Lynine" => {
    face_offset_x: 46,
    face_offset_y: 16,

    bust_offset_y: 10,
    fade: false,
  },
  "MainActor1-3" => { # Chosen
    face_offset_x: 79,
    face_offset_y: 40,
    face_border_width: 1,

    bust_offset_y: 55,
  },
  "Megail" => {
    face_offset_x: 60,
    face_offset_y: 40,
    face_z: -1,

    bust_offset_y: 20,
  },
  "Melymyn" => {
    face_offset_x: 51,
    face_offset_y: 28,

    bust_offset_y: 8,
  },
  "Mestan" => {
    face_offset_x: 50,
    face_offset_y: 61,

    bust_offset_x: -24,
  },
  "Min" => {
    face_offset_x: 51,
    face_offset_y: 55,

    fade: false,
  },
  "Mithyn" => {
    face_offset_x: 175,
    face_offset_y: 53,
    face_border_width: 1,

    bust_offset_x: -145,
  },
  "Nabith" => {
    face_offset_x: 45,
    face_offset_y: 48,

    bust_offset_x: -25,
  },
  "Nalili" => {
    face_offset_x: 56,
    face_offset_y: 28,
    face_z: -1,
  },
  "Neranda" => {
    face_offset_x: 42,
    face_offset_y: 52,

    bust_offset_y: 15,
  },
  "Nyst" => {
    face_offset_x: 42,
    face_offset_y: 21,

    bust_offset_y: 30,
  },
  "Orilise" => {
    face_offset_x: 59,
    face_offset_y: 35,

    fade: false,
  },
  "Palina" => {
    face_offset_x: 44,
    face_offset_y: 43,

    bust_offset_x: -15,
  },
  "Qum D'umpe" => {
    face_offset_x: 62,
    face_offset_y: 40,
    face_border_width: [0, 0, 0, 12],

    bust_offset_y: 20,
  },
  "Reletima" => {
    face_offset_x: 72,
    face_offset_y: 47,
    bust_offset_y: 20,
  },
  "Reval" => {
    face_offset_x: 54,
    face_offset_y: 30,
    bust_offset_x: -35,
  },
  "Riala" => {
    face_offset_x: 52,
    face_offset_y: 49,

    bust_offset_x: -30,
    fade: false,
  },
  "Riala2" => {
    face_offset_x: 50,
    face_offset_y: 43,

    bust_offset_x: -30,
    fade: false,
  },
  "Robin blond" => {
    face_offset_x: 63,
    face_offset_y: 53,

    bust_offset_x: -43,
    bust_offset_y: 5,
  },
  "Sabitha" => {
    face_offset_x: 53,
    face_offset_y: 58,

    fade: false,
  },
  "SabithaH" => {
    face_offset_x: 53,
    face_offset_y: 58,
    face_border_width: 5,
    face_z: -1,

    fade: false,
  },
  "Sage" => {
    face_offset_x: 37,
    face_offset_y: 25,

    bust_offset_y: 45,
  },
  "Sarai" => {
    face_offset_x: 26,
    face_offset_y: 50,
    face_z: -1,

    bust_offset_y: 30,
    fade: false,
  },
  "soulmage" => {
    face_offset_x: 55,
    face_offset_y: 29,
    face_z: -1,
  },
  "Tanurak" => {
    face_offset_x: 73,
    face_offset_y: 42,

    bust_offset_y: 15,
  },
  "Tertia" => {
    face_offset_x: 84,
    face_offset_y: 50,

    bust_offset_x: -65,
    bust_offset_y: 27,
  },
  "Trin" => {
    face_offset_x: 52,
    face_offset_y: 54,
  },
  "Tyna" => {
    face_offset_x: 57,
    face_offset_y: 36,

    bust_offset_y: 5,
  },
  "Ulrissa" => {
    face_offset_x: 64,
    face_offset_y: 48,

    fade: false,
  },
  "Uneanun" => {
    face_offset_x: 66,
    face_offset_y: 62,
  },
  "Uolian" => {
    face_offset_x: 54,
    face_offset_y: 27,
    bust_offset_x: -35,
  },
  "Uyae" => {
    face_offset_x: 52,
    face_offset_y: 42,
    bust_offset_x: -20,
    fade: false,
  },
  "Uyae God Flip" => {
    face_offset_x: 52,
    face_offset_y: 42,

    bust_offset_x: -20,
  },
  "Varia" => {
    face_offset_x: 62,
    face_offset_y: 48,

    bust_offset_y: 10,
  },
  "Vera" => {
    face_offset_x: 40,
    face_offset_y: 23,
  },
  "Vhala" => {
    face_offset_x: 72,
    face_offset_y: 41,

    bust_offset_y: 12,
  },
  "Vunne" => {
    face_offset_x: 68,
    face_offset_y: 65,
    face_z: -1,

    fade: false,
  },
  "Wendis blond" => {
    face_offset_x: 48,
    face_offset_y: 40,
    face_z: -1,
    face_border_width: [0, 0, 21, 0],

    fade: false,
  },
  "Wendis blondT" => {
    face_offset_x: 47,
    face_offset_y: 38,
    face_z: -1,
    face_border_width: [0, 0, 21, 0],

    fade: false,
  },
  "Wendis grey" => {
    face_offset_x: 48,
    face_offset_y: 40,
    face_z: -1,
    face_border_width: [0, 0, 21, 0],

    fade: false,
  },
  "Wendis greyT" => {
    face_offset_x: 47,
    face_offset_y: 38,
    face_z: -1,
    face_border_width: [0, 0, 21, 0],

    fade: false,
  },
  "Wynn" => {
    face_offset_x: 59,
    face_offset_y: 50,
    face_border_width: 1,

    bust_offset_x: -30,
    bust_offset_y: 22,
  },
  "Xerces" => {
    face_offset_x: 60,
    face_offset_y: 25,

    bust_offset_x: -42,
  },
  "Xestris" => {
    face_offset_x: 59,
    face_offset_y: 27,
  },
  "Yarra" => {
    face_offset_x: 83,
    face_offset_y: 20,

    bust_offset_x: -55,
    bust_offset_y: 10,
    fade: false,
  },
  "Yelarel" => {
    face_offset_x: 56,
    face_offset_y: 39,
  },
  "Yhilini Ambassador" => {
    face_offset_x: 60,
    face_offset_y: 28,
    bust_offset_y: 0,
  },
  "Zelica" => {
    face_offset_x: 77,
    face_offset_y: 106,
  },
  "Incubus Emperor" => {
    face_offset_x: 41,
    face_offset_y: 39,
    face_border_width: 1,

    bust_offset_x: -20,
    bust_offset_y: 35,
  },
  "Lord of Blood" => {
    face_offset_x: 69,
    face_offset_y: 21,
    face_z: -1,

    fade: false,
  },
  "Skullcrusher" => {
    face_offset_x: 70,
    face_offset_y: 35,
  },
  "Biyue" => {
    face_offset_x: 64,
    face_offset_y: 37,

    bust_offset_y: 15,
  },
  "Fuani" => {
    face_offset_x: 46,
    face_offset_y: 61,
    face_border_width: 1,
    bust_offset_x: -12,
    fade: false,
  },
  "Orcent IK" => {
    face_offset_x: 61,
    face_offset_y: 18,
  },
  "Orcent merchant" => {
    face_offset_x: 61,
    face_offset_y: 18,
  },
  "Orcent priest" => {
    face_offset_x: 61,
    face_offset_y: 34,
  },
  "Orcent slave" => {
    face_offset_x: 61,
    face_offset_y: 18,
  },
  "Orcent1" => {
    face_offset_x: 61,
    face_offset_y: 18,
  },
  "Orcent2" => {
    face_offset_x: 35,
    face_offset_y: 31,
  },
  "Grubbak" => {
    face_offset_x: 67,
    face_offset_y: 24,
    face_border_width: 1,

    bust_offset_x: -39,
    bust_offset_y: 31,
  },
  "Impaler" => {
    face_offset_x: 69,
    face_offset_y: 42,

    bust_offset_y: 30,
  },
  "Ralke" => {
    face_offset_x: 57,
    face_offset_y: 54,

    fade: false,
  },
  "Simon suit wedding" => {
    face_offset_x: 64,
    face_offset_y: 45,
  },
  "Simon topless" => {
    face_offset_x: 64,
    face_offset_y: 30,
  },
  "Simon1" => {
    face_offset_x: 63,
    face_offset_y: 34,
  },
  "Simon2" => {
    face_offset_x: 67,
    face_offset_y: 32,
  },
  "Simon2D" => {
    face_offset_x: 67,
    face_offset_y: 32,
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
    original: "Simon2",
    faces: ["Simon 3 1", "Simon 3 2", "Simon 3 3", "Simon 3 4"],
    bust: "Simon3",
  },
  {
    original: "Simon2",
    faces: ["Simon 4 1", "Simon 4 2", "Simon 4 3", "Simon 4 4"],
    bust: "Simon4",
  },
  {
    original: "Trin",
    faces: ["Trin emo3", "Trin emo4"],
    bust: "Trin-diadem-portrait",
  },
  {
    original: "Min",
    faces: ["Min emo2"],
    bust: "Min2",
  },
])

# Dealing with Yarra's boobs
Busty::CONFIG.merge!({
  "Yarra boobs" => {
    hide_original_face: true,
    bust_offset_x: -48,
  },
  "Yarra boobs bigger" => {
    hide_original_face: true,
    bust_offset_x: -6,
  },
})
# Ulrissa hidden behind wolf mask
Busty::CONFIG["Ulrissa2"] = Busty::CONFIG["Ulrissa"]
# Uyae with fixed clothes
Busty::CONFIG["Uyae2"] = Busty::CONFIG["Uyae"]
Busty::CONFIG["Uyae3"] = Busty::CONFIG["Uyae"]
# Tertia with "fixed" clothes (according to Yarra, anyway)
Busty::CONFIG["TertiaN"] = Busty::CONFIG["Tertia"]
# Dark Xestris
Busty::CONFIG["Xestris2"] = Busty::CONFIG["Xestris"]
# Xestris ear positions
Busty::CONFIG["Xestris-ear-up"] = Busty::CONFIG["Xestris"]
Busty::CONFIG["Xestris-ear-down"] = Busty::CONFIG["Xestris"]
# Grynyth needs separate images for every face because her semi-transparent
# elements and moving eyebrow thingies make overlays a total nightmare
(1..2).each do |i|
  (0..7).each do |j|
    name = "Grynyth#{i}-#{j}"
    Busty::SUBSET_TO_BUST.insert(-1, { character_name: name, face_name: "Grynyth emo#{i > 1 ? i : ''}", face_indexes: [j] })
    Busty::CONFIG[name] = Busty::CONFIG["Grynyth"]
  end
end
# Doom King has various armour colours - simplest just to use one bust image for each
(0..7).each do |j|
  name = "Doomed King #{j}"
  Busty::SUBSET_TO_BUST.insert(-1, { character_name: name, face_name: "Doomed King emo", face_indexes: [j] })
  Busty::CONFIG[name] = Busty::CONFIG["Doomed King"]
end
# Radiant Ivala
Busty::CONFIG["Ivala Golden"] = Busty::CONFIG["Ivala"].clone.merge({
  hide_original_face: true,
})
