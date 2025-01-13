Busty::BATTLE_CONFIG.merge!({
  "Aka" => {
    "Blinding Stab" => "AkaRedPierceBlinding",
    "Crippling Stab" => "AkaRedPierceCrippling",
    "Piercing Stab" => "AkaRedPiercePiercing",
    "Weakening Stab" => "AkaRedPierceWeakening",
    proc: ->(move) {
      aka_transformed = $game_switches[908]
      aka_confident = $game_switches[217]

      if move.c_name == "Guard"
        return aka_transformed ? "AkaBlueDefend" : aka_confident ? "AkaRedCoolGuard" : "AkaRedNervousGuard"
      end

      if move.c_name == "Disabling Assault"
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
        if move.c_name == move_name
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

      if move.c_name == "Attack"
        return altina_confident ? "AltinaStaffSerious" : "AltinaStaffClumsy"
      end

      ["Fire", "Ice", "Lightning", "Poison"].each do |move_name|
        if move.c_name == move_name
          return "AltinaSpell" + (altina_confident ? "Confident": "Nervous") + move_name
        end
      end

      nil
    },
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
        if move.c_name == move_name
          return "HilstaraNormal" + (serious_hilstara ? file_name.sub("Neutral", "Serious") : file_name)
        end
      end

      if move.c_name == "Tactical Eye"
        return general_hilstara ? "HilstaraNormalBuffGeneralEye" : "HilstaraNormalBuffEye"
      end

      if move.c_name == "Sexy Encouragement"
        return general_hilstara ? "HilstaraNormalBuffGeneralSexy" : "HilstaraNormalBuffSexy"
      end

      if ["Encourage", "Hold the Line!"].include?(move.c_name)
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
  },
  "Qum D'umpe" => {
    "Arousing Kiss" => "QumKissArousingKiss",
    "Arousing Aura" => "QumKissArousingAura",
    "Attack" => "QumSpellFlail",
    "Cleansing Wink" => "QumSpellWink",
    "Cumdump" => "QumHugAura",
    "Guard" => "QumHugWince",
    "Happy Tingles" => "QumMSparkles",
    "Healing Kiss" => "QumKiss",
    "Illusory Orgy" => "QumSpellCloud",
    "Item" => "QumOohItem",
    "Little Death" => "QumSpellSerious",
    "Mass Kiss" => "QumKissMasskiss",
    "Masturbate" => "QumM",
    "Masturbate+" => "QumM",
    "Orgasmic Thoughts" => "QumOohCloud",
    "Protective Hug" => "QumHug",
    "Sealing Tech" => "QumSpell",
    "Shiny Thoughts" => "QumOohSparkle",
  },
  "Robin blond" => {
    "Ambient Mana" => "RobinAmbientMana",
    "Cure" => "RobinCure",
    "Dark Lance" => "RobinDarkLance",
    "Disrupt" => "RobinSpellDisrupt",
    "Guard" => "RobinGuardShield",
    "Heal" => "RobinHeal",
    "Healing Lance" => "RobinHealLance",
    "Item" => "RobinItem",
    "Silent Dark" => "RobinDarkClaspSilent",
    proc: ->(move) {
      robin_confident = $game_switches[1564]

      if move.c_name == "Attack"
        return robin_confident ? "RobinSpellConfidentGeneric" : "RobinSpellNervousGeneric"
      end

      ["Fire", "Ice", "Lightning"].each do |move_name|
        if move.c_name == move_name
          return "RobinSpell" + (robin_confident ? "Confident": "Nervous") + move_name
        end
        if move.c_name == move_name + " Lance"
          return "RobinLance" + (robin_confident ? "Composed": "Startled") + move_name
        end
      end

      nil
    },
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
    "SS heal component" => {
      picture: "SimonGreenHealHealing",
      instant_gray: true,
    },
    "Stunning Strike" => "SimonGreenThrustStunning",
    "Suppress Lust" => "SimonGreenDefSurpressLust",
    "Unified Strike" => "SimonGreenThrustUnified",
    proc: ->(move) {
      if ["Support Allies", "Support Servants", "Support Slaves"].include?(move.c_name)
        return  {
          picture: "SimonGreenHealHealing",
          chained: true,
        }
      end

      nil
    },
  },
  "Yarra" => {
    "Appreciate Harem" => "YarraMAppreciateHarem",
    "Attack" => "YarraAttack",
    "Bonded Fantasy" => "YarraKiss",
    "Combat Fantasy" => "YarraCombatFantasy",
    "Combat Flirt" => "YarraCombatFlirt",
    "First Slut" => "YarraM",
    "Flirt" => "YarraKiss",
    "Guard" => "YarraGuard",
    "Harem Mistress" => nil,
    "Haze of Sex" => "YarraSpell",
    "Ice Whip" => "YarraAttackIce",
    "Incubus King's Emissary" => "YarraSpellEmissary",
    "Item" => "YarraItem",
    "Masturbate" => "YarraM",
    "Masturbate+" => "YarraM",
    "Sealing Tech" => "YarraSpell",
    "Sexual Mana" => "YarraMSexualMana",
    "Sexual Torment" => "YarraSpell",
    "Shared Fantasy" => "YarraKissSharedFantasy",
    "Succubus Kiss" => "YarraKiss",
    proc: ->(move) {
      if move.c_name == "Piercing Whip"
        return "YarraAttackPiercing-#{Busty::varia_dominated? ? "dom" : "resh" }"
      end

      nil
    },
  },
})

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
  {
    base_character: "Robin blond",
    evolved_character: "Robin grey",
    search_and_replace: {}, # Robin only has a few skills that vary between forms, updated by hand below
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

# Robin the Grey
Busty::BATTLE_CONFIG["Robin grey"].merge!({
  "Ambient Mana" => "RobinDarkAmbientMana",
})

# Helpful functions I didn't know where to put
module Busty
  class << self
    # Most in-game code is already of the form "if dominated else"
    # So not bothering with the explicit switch for reshaped (268)
    def varia_dominated?
      $game_switches[263]
    end
  end
end
