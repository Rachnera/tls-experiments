Busty::BATTLE_CONFIG.merge!({
  "Aka" => {
    "Blinding Stab" => "AkaRedPierceBlinding",
    "Crippling Stab" => "AkaRedPierceCrippling",
    "Piercing Stab" => "AkaRedPiercePiercing",
    "Weakening Stab" => "AkaRedPierceWeakening",
    proc: ->(move) {
      aka_transformed = $game_switches[908]
      # In a normal playthrough, 908 cannot be enabled without 217.
      # So taking for granted 908 on means we should behave like 217 is on even if the save is in a weird (hacked?) state.
      aka_confident = $game_switches[217] || aka_transformed

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
          return "Aka" + (aka_confident ? "RedCool": "RedNervous") + file_name
        end
      end

      if move.c_name == "Healing Hilt"
        return "AkaBlueDefHeal#{Busty::uyae_clothes_version}"
      end

      if move.c_name == "Ferocious Flurry"
        return "AkaBlueAssaultFlurry#{Busty::uyae_clothes_version}"
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
  "Carina" => {
    "Anti-Toxin" => "CarinaHealAntiToxin",
    "Attack" => "CarinaAttack",
    "Calm" => "CarinahealCompassionateCureLust",
    "Calming Aura" => "CarinaMassCureLust",
    "Channeled Smite" => "CarinaOffenseSmite",
    "Cleanse" => "CarinahealCompassionateCure",
    "Cleansing Aura" => "CarinaMassCure",
    "Divine Intervention" => "CarinaMassDivineIntervention",
    "Divine Touch" => "CarinaBuffDvineTouch",
    "Divine Wrath" => "CarinaOffenseWrath",
    "Guard" => "CarinaDefend",
    "Holy Burst" => "CarinaOffense",
    "Mass Heal" => "CarinaMassHeal",
    "Revive" => "CarinaMassRevive",
    "Shining Banner" => "CarinaBuffShiningBanner",
    "Smite" => "CarinaOffenseSmite",
    proc: ->(move) {
      carina_serious = $game_switches[3281]

      if SkillHelper::is_item(move)
        return "CarinaItem#{carina_serious ? "Serious" : "Benevolent"}"
      end

      if move.c_name == "Heal"
        return "Carinaheal#{carina_serious ? "Serious" : "Concerned"}Heal"
      end

      if move.c_name == "Shield of Purity"
        return "CarinaBuff#{carina_serious ? "Serious" : "Benevolent"}"
      end

      nil
    },
  },
  "Hilstara" => {
    "Active Defense" => "HilstaraNormalDef2",
    "Aegis Assault" => "HilstaraNormalAegis2",
    "Attack" => "HilstaraNormalAxe",
    "Bash" => "HilstaraNormalAxeBash",
    # TODO Enable after an animation is configured for the skill
    # "Harem Tactics" => "HilstaraNormalBuffHaremTactics",
    "Item" => "HilstaraNormalItem",
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

      if move.c_name == "Mighty Bash"
        return "HilstaraNormalAxeMightyBash#{Busty::uyae_clothes_version}"
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
  "Nalili" => {
    "Bash" => "NaliliBackBash",
    "Blade of Lust" => "NaliliBackBladeOfLust",
    "Cautious Swipes" => "NaliliBackCautiousSwipes",
    "Cleavage" => "NaliliOverheadCleavage",
    "Flaming Thrust" => "NaliliThrustFlamingStab",
    "Guard" => "NaliliBackDefend",
    "Healing Masturbation" => "NaliliMHealing",
    "Hip Check"=> "NaliliHipSlam",
    "Item" => "NaliliHipItem",
    "Kiss of Steel" => "NaliliThrustKissOfSteel",
    "Martial Masturbation" => "NaliliMMartial",
    "Mother's Lust" => "NaliliMMothersLust",
    "Orgasmic Strike" => "NaliliOverheadOrgasmicStrike",
    "Orgy of Blows" => "NaliliThrustOrgyOfBlows",
    "Piercing Stab" => "NaliliThrustPierce",
    "Sealing Tech" => "NaliliHipPinkRock",
    "Sex Appeal" => "NaliliSexAppeal",
    "Sexual Aegis" => "NaliliBackSexualAegis",
    "Swift Stab" => "NaliliThrustSwiftStab",
    "True Cleavage" => "NaliliOverheadTrueCleavage",
    "Wild Blow" => "NaliliOverheadWildBlow",
    proc: ->(move) {
      mature_nalili = $game_switches[857]

      if move.c_name == "Attack"
        return mature_nalili ? "NaliliThrustAttackMature" : "NaliliThrustAttackSilly"
      end

      if ["Combat Masturbation", "Masturbate+"].include?(move.c_name)
        return mature_nalili ? "NaliliMMature" : "NaliliMSilly"
      end

      if move.c_name == "Desperate Masturbation"
        return Busty::varia_dominated? ? "NaliliMDesperateDominated" : "NaliliMDesperateReformed"
      end

      nil
    },
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
  "Riala" => {
    "Attack" => "RialaSpellLust",
    "Aura Masturbation" => "RialaMAura",
    "Bolt of Lust" => "RialaStormLust",
    "Combat Teleport" => "RialaSpellCompatTeleport",
    "Cyclical Fire" => "RialaLanceFire",
    "Fire" => "RialaSpellFire",
    "Fire Storm" => "RialaStormFire",
    "Fires of Lust" => "RialaStormLust",
    "Guard" => "RialaPalmGuard",
    "Heal" => "RialaSpellHeal",
    "Ice" => "RialaSpellIce",
    "Ice Storm" => "RialaStormIce",
    "Inspire" => "RialaPalmInspire",
    "Item" => "RialaPalmItem",
    "Lance of Fury" => "RialaLanceFury",
    "Lightning" => "RialaSpellLightning",
    "Lightning Storm" => "RialaStormLightning",
    "Mana Masturbation" => "RialaMMana",
    "Masturbate+" => "RialaM",
    "Patient Lust" => "RialaMPatient",
    "Sealing Tech" => "RialaPalmPinkRock",
    "Sexual Lance" => "RialaLanceLust",
    "Sexual Torment" => "RialaSpellLust",
    "Storm of Lust" => "RialaStormLust",
    "Succubus Kiss" => "RialaSpellKiss",
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
  "Varia Reshaped" => {
    "Attack" => "VariaStabReformed",
    "Blade Dance" => "VariaAssaultReformedBladeDance",
    "Blood Strike" => "VariaStabReformedBlood",
    "Channeled Luck" => "VariaChanneledLuck",
    "Crippling Stab" => "VariStabReformedFCrippling",
    "Defender's Frenzy" => "VariaFrenzyReformedDefender",
    "Destined Blood" => "VariaBuffReformed",
    "Destined Endurance" => "VariaBuffReformed",
    "Encourage" => "VariaBuffReformed",
    "Forceful Lunge" => "VariaStabReformedForceful",
    "Frenzy" => "VariaFrenzyReformed",
    "Furious Strikes" => "VariaAssaultReformedFurious",
    "Guard" => "VariaBuffReformed",
    "Item" => "VariaReformedItem",
    "Powerful Blow" => "VariaStabReformedPowerful",
    "Wild Blow" => "VariaStabReformedWild",
  },
  "Vhala" => {
    "Anak's Rain" => "VhalaRainAnak",
    "Arrow of Abstinence" => "VhalaAttackAbstinence",
    "Arrow of Ice" => "VhalaAttackIce",
    "Arrow of Lust" => "VhalaAttackLust",
    "Arrow of Purity" => "VhalaAttackPurity",
    "Attack" => "VhalaAttack",
    "Balanced Nature" => "VhalaGuardBalancedNature",
    "Blinding Rain" => "VhalaRainBlinding",
    "Defensive Rain" => "VhalaRainOffensive",
    "Guard" => "VhalaGuard",
    "Item" => "VhalaSupportItem",
    "Offensive Rain" => "VhalaRainOffensive",
    "Targeted Shot" => "VhalaAttackTarget",
    "Triple Shot" => "VhalaAttackTriple",
    "Unhand" => "VhalaHandUnhand",
    proc: ->(move) {
      if move.c_name == "Unperson Aura"
        improved_version = move.id === 68
        return improved_version ? "VhalaHandAuraKind" : "VhalaHandAuraSerious"
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
    "First Slut" => "YarraMFirstSlut",
    "Flirt" => "YarraKiss",
    "Guard" => "YarraGuard",
    "Haze of Sex" => "YarraSpell",
    "Ice Whip" => "YarraAttackIce",
    "Incubus King's Emissary" => "YarraSpellEmissary",
    "Item" => "YarraItem",
    "Lash of Torment" => "YarraAttackSexualEnergy",
    "Lustful Emissaries" => "YarraSpellEmissary",
    "Masturbate" => "YarraM",
    "Masturbate+" => "YarraM",
    "Pure Whip" => "YarraAttackPure",
    "Sealing Tech" => "YarraSpellPinkRock",
    "Sexual Mana" => "YarraMSexualMana",
    "Sexual Torment" => "YarraSpell",
    "Shared Fantasy" => "YarraKissSharedFantasy",
    "Succubus Kiss" => "YarraKiss",
    "Wild Lashing" => "YarraAttackWildLashing",
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
    base_character: "Hilstara",
    evolved_character: "HilstaraKnight",
    search_and_replace: {
      "HilstaraNormal" => "HilstaraHero",
    },
  },
  {
    base_character: "Nalili",
    evolved_character: "Nalili2",
    search_and_replace: {}, # No changes
  },
  {
    base_character: "Robin blond",
    evolved_character: "Robin grey",
    search_and_replace: {}, # Robin only has a few skills that vary between forms, updated by hand below
  },
  {
    base_character: "Simon1",
    evolved_character: "Simon2",
    search_and_replace: {
      "SimonGreen" => "SimonBlack",
    },
  },
  {
    base_character: "Varia Reshaped",
    evolved_character: "Varia Dominated",
    search_and_replace: {
      "Reformed" => "Dominated",
    },
  },
])

# Moves exclusive to transformed Aka
Busty::BATTLE_CONFIG["Aka2"].merge!({
  "Bloody Ecstatic Strike" => "AkaBlueAssaultBloody",
  "Ecstatic Strike" => "AkaBlueAssaultEcstatic",
  "Lethal Intent" => "AkaBlueLethalIntent",
  "Pure Stab" => "AkaBlueCoolStabPure",
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
  "Mighty Bash" => "HilstaraHeroAxeMightyBash",
  "Wall of Silence" => "HilstaraHeroDef1SeriousSilence",
})

# Robin the Grey
Busty::BATTLE_CONFIG["Robin grey"].merge!({
  "Ambient Mana" => "RobinDarkAmbientMana",
})

Busty::BATTLE_CONFIG["Varia Dominated"].merge!({
  "Earth Bomb" => "VariaThrowDom",
  "Slave's Frenzy" => "VariaFrenzyDominatedSlave",
})
Busty::BATTLE_CONFIG["Varia Reshaped"].merge!({
  "Earth Bomb" => "VariaThrowRef",
  "Servant's Frenzy" => "VariaFrenzyReformedServant",
})

class Scene_Battle < Scene_Base
  alias original_busty_character_name character_name
  def character_name
    character_name = original_busty_character_name

    # Varia variant hack
    if character_name == "Varia"
      return Busty::varia_dominated? ? "Varia Dominated" : "Varia Reshaped"
    end

    character_name
  end
end

# Helpful functions I didn't know where to put
module Busty
  class << self
    # Most in-game code is already of the form "if dominated else"
    # So not bothering with the explicit switch for reshaped (264)
    def varia_dominated?
      $game_switches[263]
    end

    def uyae_clothes_version
      # Boob Window
      return 3 if $game_switches[2081]

      # Clean
      return 2 if $game_switches[1481]

      # Tattered
      1
    end
  end
end
