meta:
  id: personal
  file-extension: bin
  endian: le
  bit-endian: le
seq:
  - id: entry
    size: 0xB0
    type: entry
    repeat: eos

types:
  entry:
    seq:
      - id: base_stats
        type: base_stats
      - id: type_1
        type: u1
        enum: types
      - id: type_2
        type: u1
        enum: types
      - id: catch_rate
        type: u1
      - id: evo_stage
        type: u1
      - id: effort_yield
        type: effort_yield
        size: 2
      - id: items
        type: u2
        repeat: expr
        repeat-expr: 3
      - id: gender
        type: u1
      - id: hatch_cycles
        type: u1
      - id: base_friendship
        type: u1
      - id: exp_growth
        type: u1
      - id: egg_groups
        type: u1
        enum: egg_group
        repeat: expr
        repeat-expr: 2
      - id: abilities
        type: u2
        enum: ability
        repeat: expr
        repeat-expr: 3
      - id: form_data
        type: form_data
      - id: base_exp
        type: u2
      - id: height
        type: u2
      - id: weight
        type: u2
      - id: tms
        type: b1
        repeat: expr
        repeat-expr: 128
      - id: movetutors
        type: b1
        repeat: expr
        repeat-expr: 32
      - id: trs
        type: b1
        repeat: expr
        repeat-expr: 128
      - id: model_id
        type: u4
      - id: z_item
        type: u2
      - id: z_base_move
        type: u2
      - id: z_special_move
        type: u2
      - id: evo_line
        type: u2
      - id: ingame_form_count
        type: u2
      - id: galar_flags
        type: galar_flags
      - id: pokedex_id
        type: u2
      - id: form_id
        type: u2
      - id: quantized_floats
        type: u2
        repeat: expr
        repeat-expr: 5
      - id: bytes_0
        size: 10
      - id: bytes_1
        size: 10
      - id: bytes_2
        size: 5
      - id: bytes_3
        size: 5
      - id: bytes_4
        size: 5
      - id: bytes_5
        size: 5
      - id: shorts
        type: u2
        repeat: expr
        repeat-expr: 10
      - id: reserved
        type: u2
      - id: armor_tutor_data
        type: b1
        repeat: expr
        repeat-expr: 32
      - id: armor_dex_id
        type: u2
      - id: tundra_dex_id
        type: u2

    types:
      base_stats:
        seq:
        - id: hp
          type: u1
        - id: attack
          type: u1
        - id: defense
          type: u1
        - id: speed
          type: u1
        - id: special_attack
          type: u1
        - id: special_defense
          type: u1
      effort_yield:
        seq:
        - id: effort_hp
          type: b2
        - id: effort_attack
          type: b2
        - id: effort_defense
          type: b2
        - id: effort_speed
          type: b2
        - id: effort_special_attack
          type: b2
        - id: effort_special_defense
          type: b2
      form_data:
        seq:
        - id: forme_stat_index
          type: u2
        - id: forme_count
          type: u1
        - id: color
          type: b6
          enum: colors
        - id: is_present
          type: b1
        - id: is_forme
          type: b1
      galar_flags:
        seq:
        - id: flag_has_regional
          type: b2
        - id: flag_not_gmax
          type: b2
        - id: flag_unknown
          type: b4
        - id: flags_reserved
          type: u1

enums:
  colors:
    0: red
    1: blue
    2: yellow
    3: green
    4: black
    5: brown
    6: purple
    7: gray
    8: white
    9: pink

  types:
    0: normal
    1: fight
    2: flying
    3: poison
    4: ground
    5: rock
    6: bug
    7: ghost
    8: steel
    9: fire
    10: water
    11: grass
    12: electric
    13: psychic
    14: ice
    15: dragon
    16: dark
    17: fairy

  egg_group:
    1: monster
    2: water1
    3: bug
    4: flying
    5: field
    6: fairy
    7: grass
    8: biped
    9: water3
    10: mineral
    11: amorphous
    12: water2
    13: ditto
    14: dragon
    15: undiscovered
  
  ability:
    1: stench
    2: drizzle
    3: speed_boost
    4: battle_armor
    5: sturdy
    6: damp
    7: limber
    8: sand_veil
    9: static
    10: volt_absorb
    11: water_absorb
    12: oblivious
    13: cloud_nine
    14: compound_eyes
    15: insomnia
    16: color_change
    17: immunity
    18: flash_fire
    19: shield_dust
    20: own_tempo
    21: suction_cups
    22: intimidate
    23: shadow_tag
    24: rough_skin
    25: wonder_guard
    26: levitate
    27: effect_spore
    28: synchronize
    29: clear_body
    30: natural_cure
    31: lightning_rod
    32: serene_grace
    33: swift_swim
    34: chlorophyll
    35: illuminate
    36: trace
    37: huge_power
    38: poison_point
    39: inner_focus
    40: magma_armor
    41: water_veil
    42: magnet_pull
    43: soundproof
    44: rain_dish
    45: sand_stream
    46: pressure
    47: thick_fat
    48: early_bird
    49: flame_body
    50: run_away
    51: keen_eye
    52: hyper_cutter
    53: pickup
    54: truant
    55: hustle
    56: cute_charm
    57: plus
    58: minus
    59: forecast
    60: sticky_hold
    61: shed_skin
    62: guts
    63: marvel_scale
    64: liquid_ooze
    65: overgrow
    66: blaze
    67: torrent
    68: swarm
    69: rock_head
    70: drought
    71: arena_trap
    72: vital_spirit
    73: white_smoke
    74: pure_power
    75: shell_armor
    76: air_lock
    77: tangled_feet
    78: motor_drive
    79: rivalry
    80: steadfast
    81: snow_cloak
    82: gluttony
    83: anger_point
    84: unburden
    85: heatproof
    86: simple
    87: dry_skin
    88: download
    89: iron_fist
    90: poison_heal
    91: adaptability
    92: skill_link
    93: hydration
    94: solar_power
    95: quick_feet
    96: normalize
    97: sniper
    98: magic_guard
    99: no_guard
    100: stall
    101: technician
    102: leaf_guard
    103: klutz
    104: mold_breaker
    105: super_luck
    106: aftermath
    107: anticipation
    108: forewarn
    109: unaware
    110: tinted_lens
    111: filter
    112: slow_start
    113: scrappy
    114: storm_drain
    115: ice_body
    116: solid_rock
    117: snow_warning
    118: honey_gather
    119: frisk
    120: reckless
    121: multitype
    122: flower_gift
    123: bad_dreams
    124: pickpocket
    125: sheer_force
    126: contrary
    127: unnerve
    128: defiant
    129: defeatist
    130: cursed_body
    131: healer
    132: friend_guard
    133: weak_armor
    134: heavy_metal
    135: light_metal
    136: multiscale
    137: toxic_boost
    138: flare_boost
    139: harvest
    140: telepathy
    141: moody
    142: overcoat
    143: poison_touch
    144: regenerator
    145: big_pecks
    146: sand_rush
    147: wonder_skin
    148: analytic
    149: illusion
    150: imposter
    151: infiltrator
    152: mummy
    153: moxie
    154: justified
    155: rattled
    156: magic_bounce
    157: sap_sipper
    158: prankster
    159: sand_force
    160: iron_barbs
    161: zen_mode
    162: victory_star
    163: turboblaze
    164: teravolt
    165: aroma_veil
    166: flower_veil
    167: cheek_pouch
    168: protean
    169: fur_coat
    170: magician
    171: bulletproof
    172: competitive
    173: strong_jaw
    174: refrigerate
    175: sweet_veil
    176: stance_change
    177: gale_wings
    178: mega_launcher
    179: grass_pelt
    180: symbiosis
    181: tough_claws
    182: pixilate
    183: gooey
    184: aerilate
    185: parental_bond
    186: dark_aura
    187: fairy_aura
    188: aura_break
    189: primordial_sea
    190: desolate_land
    191: delta_stream
    192: stamina
    193: wimp_out
    194: emergency_exit
    195: water_compaction
    196: merciless
    197: shields_down
    198: stakeout
    199: water_bubble
    200: steelworker
    201: berserk
    202: slush_rush
    203: long_reach
    204: liquid_voice
    205: triage
    206: galvanize
    207: surge_surfer
    208: schooling
    209: disguise
    210: battle_bond
    211: power_construct
    212: corrosion
    213: comatose
    214: queenly_majesty
    215: innards_out
    216: dancer
    217: battery
    218: fluffy
    219: dazzling
    220: soul_heart
    221: tangling_hair
    222: receiver
    223: power_of_alchemy
    224: beast_boost
    225: rks_system
    226: electric_surge
    227: psychic_surge
    228: misty_surge
    229: grassy_surge
    230: full_metal_body
    231: shadow_shield
    232: prism_armor
    233: neuroforce
    234: intrepid_sword
    235: dauntless_shield
    236: libero
    237: ball_fetch
    238: cotton_down
    239: propeller_tail
    240: mirror_armor
    241: gulp_missile
    242: stalwart
    243: steam_engine
    244: punk_rock
    245: sand_spit
    246: ice_scales
    247: ripen
    248: ice_face
    249: power_spot
    250: mimicry
    251: screen_cleaner
    252: steely_spirit
    253: perish_body
    254: wandering_spirit
    255: gorilla_tactics
    256: neutralizing_gas
    257: pastel_veil
    258: hunger_switch
