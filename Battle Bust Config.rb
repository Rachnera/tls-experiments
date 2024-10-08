Busty::BATTLE_CONFIG.merge!({
  "Qum D'umpe" => {
    "Arousing Kiss" => "QumKissArousingKiss",
    "Arousing Aura" => "QumKissArousingAura",
    "Attack" => {
      picture: "QumSpellFlail",
      move_in: true,
      move_out: true,
    },
    "Cleansing Wink" => "QumSpellWink",
    "Cumdump" => "QumHugAura",
    "Guard" => "QumHugWince",
    "Happy Tingles" => "QumMSparkles",
    "Healing Kiss" => "QumKiss",
    "Illusory Orgy" => "QumSpellCloud",
    "Little Death" => "QumSpellSerious",
    "Mass Kiss" => {
      picture: "QumKissMasskiss",
    },
    "Orgasmic Thoughts" => "QumOohCloud",
    "Protective Hug" => "QumHug",
    "Sealing Tech" => "QumSpell",
    "Shiny Thoughts" => "QumOohSparkle",
    conditionals: [
      {
        condition: 'is_any_masturbation_skill',
        picture: "QumM",
      },
      {
        condition: 'is_item',
        picture: "QumOohItem",
      },
    ],
    fallback: "QumSpell",
  },
  "Yarra" => {
    "Appreciate Harem" => "YarraMAppreciateHarem",
    "Attack" => {
      picture: "YarraAttack",
      move_in: true,
      move_out: true,
    },
    "Bonded Fantasy" => "YarraKiss",
    "First Slut" => "YarraM",
    "Flirt" => "YarraKiss",
    "Guard" => "YarraGuard",
    "Harem Mistress" => nil,
    "Ice Whip" => {
      picture: "YarraAttackIce",
      move_in: true,
      move_out: true,
    },
    "Incubus King's Emissary" => "YarraSpellEmissary",
    "Sexual Mana" => "YarraMSexualMana",
    "Shared Fantasy" => "YarraKissSharedFantasy",
    "Succubus Kiss" => "YarraKiss",
    conditionals: [
      {
        condition: 'is_any_masturbation_skill',
        picture: "YarraM",
      },
      {
        condition: 'is_item',
        picture: "YarraItem",
      },
    ],
    fallback: "YarraSpell",
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
