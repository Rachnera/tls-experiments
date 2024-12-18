Busty::BATTLE_CONFIG.merge!({
  "Aka" => {
    "Blinding Stab" => "AkaRedPierceBlinding",
    "Crippling Stab" => "AkaRedPierceCrippling",
    "Piercing Stab" => "AkaRedPiercePiercing",
    "Weakening Stab" => "AkaRedPierceWeakening",
    fallback: "AkaRedAssault",
    proc: ->(move) {
      aka_transformed = $game_switches[908]
      aka_confident = $game_switches[217]

      if move.name == "Guard"
        return aka_transformed ? "AkaBlueDefend" : aka_confident ? "AkaRedCoolGuard" : "AkaRedNervousGuard"
      end

      if move.name == "Disabling Assault"
        return aka_transformed ? "AkaBlueAssaultDisabling" : "AkaRedAssault"
      end

      if SkillHelper::is_item(move)
        return aka_transformed ? "AkaBlueItem" : aka_confident ? "AkaRedCoolItem" : "AkaRedNervousItem"
      end

      {
        "Attack" => "Stab",
        "Deathblow" => "StabDeathblow",
        "Forceful Lunge" => "StabForce",
        "Poisoned Blade" => "StabPoison",
      }.each do |move_name, file_name|
        if move.name == move_name
          return "Aka" + (aka_transformed ? "BlueCool" : aka_confident ? "RedCool": "RedNervous") + file_name
        end
      end

      nil
    },
  },
  "Altina" => {
    "Arcane Fire" => "AltinaStormFire",
    "Arcane Ice" => "AltinaStormIce",
    "Arcane Lightning" => "AltinaStormLightning",
    "Atmospheric Jolt" => "AltinaStaffJolt",
    "Earth Lance" => "AltinaLanceEarth",
    "Forest Lance" => "AltinaLanceForest",
    "Fire Storm" => "AltinaStormFire",
    "Gathered Healing" => "AltinaHeal",
    "Guard" => "AltinaGuard",
    "Heal" => "AltinaHeal",
    "Ice Storm" => "AltinaStormIce",
    "Item" => "AltinaItem",
    "Light of Hope" => "AltinaStaffHope",
    "Lightning Storm" => "AltinaStormLightning",
    "Poison Storm" => "AltinaStormPoison",
    "Quake" => "AltinaStormEarth",
    proc: ->(move) {
      altina_confident = $game_switches[1954]

      if move.name == "Attack"
        return altina_confident ? "AltinaStaffSerious" : "AltinaStaffClumsy"
      end

      ["Fire", "Ice", "Lightning", "Poison"].each do |move_name|
        if move.name == move_name
          return "AltinaSpell" + (altina_confident ? "Confident": "Nervous") + move_name
        end
      end

      nil
    },
    fallback: "AltinaStaffSerious",
  },
  "Hilstara" => {
    "Active Defense" => "HilstaraNormalDef2",
    "Aegis Assault" => "HilstaraNormalAegis2",
    "Attack" => "HilstaraNormalAxe",
    "Bash" => "HilstaraNormalAxeBash",
    "Item" => "HilstaraNormalItem",
    "Mighty Bash" => "HilstaraNormalAxeMightyBash",
    "Powerful Blow" => "HilstaraNormalAxeBlow",
    "Vanguard" => "HilstaraNormalDef2",
    proc: ->(move) {
      serious_hilstara = $game_switches[1961]
      general_hilstara = $game_switches[3361]

      {
        "Arcane Shieldwall" => "Def1NeutralArcane",
        "Guard" => "Def1Neutral",
        "Holy Shieldwall" => "Def1NeutralHoly",
        "Indomitable Will" => "Def1NeutralAura",
        "Shieldwall" => "Def1NeutralShieldwall",
      }.each do |move_name, file_name|
        if move.name == move_name
          return "HilstaraNormal" + (serious_hilstara ? file_name.sub("Neutral", "Serious") : file_name)
        end
      end

      if move.name == "Tactical Eye"
        return general_hilstara ? "HilstaraNormalBuffGeneralEye" : "HilstaraNormalBuffEye"
      end

      if move.name == "Sexy Encouragement"
        return general_hilstara ? "HilstaraNormalBuffGeneralSexy" : "HilstaraNormalBuffSexy"
      end

      if ["Encourage", "Hold the Line!"].include?(move.name)
        return general_hilstara ? "HilstaraNormalBuffGeneral" : "HilstaraNormalBuff"
      end

      nil
    },
  },
  "MainActor1-3" => { # Chosen
    "Attack" => "ChosenAttack",
    "Guard" => "ChosenGuard",
    "Heroic Assault" => "ChosenSpecial",
    "Heroic Aura" => "ChosenGuardAura",
    "Heroic Blow" => "ChosenAttackShout",
    "Item" => "ChosenItem",
    fallback: "ChosenSpecial",
  },
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
    "Item" => "QumOohItem",
    "Little Death" => "QumSpellSerious",
    "Mass Kiss" => "QumKissMasskiss",
    "Orgasmic Thoughts" => "QumOohCloud",
    "Protective Hug" => "QumHug",
    "Sealing Tech" => "QumSpell",
    "Shiny Thoughts" => "QumOohSparkle",
    conditionals: [
      {
        condition: 'is_any_masturbation_skill',
        picture: "QumM",
      },
    ],
    fallback: "QumSpell",
  },
  "Simon1" => {
    "Attack" => "SimonGreenSwing",
    "Battlefield Medicine" => "SimonGreenBattleMedicine",
    "Blinding Strike" => "SimonGreenThrustBlinding",
    "Command" => nil,
    "Commanding Presence" => "SimonGreenStanceCommandingPresence",
    "Corrupt" => "SimonGreenDom",
    "Dominate" => "SimonGreenDom",
    "Guard" => "SimonGreenDef",
    "Heroic Imitation" => "SimonGreenSwingHeroic",
    "Item" => "SimonGreenItem",
    "Lust Renewal" => "SimonGreenDefLustRenewal",
    "Precise Strike" => "SimonGreenThrustPrecise",
    "Rebuke" => "SimonGreenStanceRebuke",
    "Silencing Strike" => "SimonGreenThrustSilencing",
    "SS heal component" => "SimonGreenHealHealing",
    "Stunning Strike" => "SimonGreenThrustStunning",
    "Suppress Lust" => "SimonGreenDefSurpressLust",
    "Unified Strike" => "SimonGreenThrustUnified",
    conditionals: [
      {
        condition: 'is_simon_support_skill',
        picture: "SimonGreenHeal",
        chained: true,
      },
    ],
    fallback: "SimonGreenStance",
  },
  "Yarra" => {
    "Appreciate Harem" => "YarraMAppreciateHarem",
    "Attack" => {
      picture: "YarraAttack",
      move_in: true,
      move_out: true,
    },
    "Bonded Fantasy" => "YarraKiss",
    "Combat Fantasy" => "YarraCombatFantasy",
    "Combat Flirt" => "YarraCombatFlirt",
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
    "Item" => "YarraItem",
    "Sexual Mana" => "YarraMSexualMana",
    "Shared Fantasy" => "YarraKissSharedFantasy",
    "Succubus Kiss" => "YarraKiss",
    conditionals: [
      {
        condition: 'is_any_masturbation_skill',
        picture: "YarraM",
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
Busty.duplicate_battle_config([
  {
    base_character: "Aka",
    evolved_character: "Aka2",
    search_and_replace: {
      "AkaRed" => "AkaBlue",
    },
  },
  {
    base_character: "Simon1",
    evolved_character: "Simon2",
    search_and_replace: {
      "SimonGreen" => "SimonBlack",
    },
  },
  {
    base_character: "Hilstara",
    evolved_character: "HilstaraKnight",
    search_and_replace: {
      "HilstaraNormal" => "HilstaraHero",
    },
  },
])

# Moves exclusive to transformed Aka
Busty::BATTLE_CONFIG["Aka2"].merge!({
  "Bloody Ecstatic Strike" => "AkaBlueAssaultBloody",
  "Ecstatic Strike" => "AkaBlueAssaultEcstatic",
  "Lethal Intent" => "AkaBlueLethalIntent",
  "Sexual Stab" => "AkaBlueSexualStab",
  "Unite the Harem" => "AkaBlueStanceUnite",
})

# Moves exclusive to Simon the Black
Busty::BATTLE_CONFIG["Simon2"].merge!({
  "Incubus Assault" => "SimonBlackSwingIncubusAssault",
  "Incubus Presence" => "SimonBlackStanceIncubusPresence",
  "Incubus Strike" => "SimonBlackThrustIncubus",
  "King's Aura" => "SimonBlackHealKingsAura",
  "King's Rebuke" => "SimonBlackStanceKingsRebuke",
})

# Config specific to Hilstara the White
Busty::BATTLE_CONFIG["HilstaraKnight"].merge!({
  "Guard" => "HilstaraHeroDef2",
  "Wall of Silence" => "HilstaraHeroDef1SeriousSilence",
})
