RACE_ZERG = 0
RACE_TBIO = 1
RACE_TMEC = 2
RACE_PBIO = 3
RACE_PMEC = 4
RACE_HYBR = 5
RACE_NEUT = 6

RARITY_WHI = 0
RARITY_BLU = 1
RARITY_YEL = 2
RARITY_ORA = 3
RARITY_RED = 4
RARITY_PIN = 5
RARITY_GRE = 6
RARITY_PUR = 7

RARITIES =
  (RARITY_WHI): \lightgrey
  (RARITY_BLU): \lightblue
  (RARITY_YEL): \lightyellow
  (RARITY_ORA): \orange
  (RARITY_RED): \red
  (RARITY_PIN): \pink
  (RARITY_GRE): \green
  (RARITY_PUR): \purple

ALL-UNITS =
  * race: RACE_TBIO
    name: \Marine
    color: RARITY_WHI
  * race: RACE_TMEC
    name: \Vulture
    color: RARITY_WHI
  * race: RACE_PBIO
    name: \Zealot
    color: RARITY_WHI
  * race: RACE_PMEC
    name: \Sentry
    color: RARITY_WHI
  * race: RACE_PMEC
    name: \Immortal
    color: RARITY_WHI
  * race: RACE_ZERG
    name: \Roach
    color: RARITY_WHI

  * race: RACE_TBIO
    name: \Warmonger
    color: RARITY_BLU
    made: <[2Marine]>
  * race: RACE_TBIO
    name: 'Hammer Securities'
    color: RARITY_BLU
  * race: RACE_TMEC
    name: \Diamondback
    color: RARITY_BLU
    made: <[2Vulture]>
  * race: RACE_TMEC
    name: 'Siege Breaker'
    color: RARITY_BLU
  * race: RACE_PBIO
    name: 'Dark Zealot'
    color: RARITY_BLU
    made: <[2Zealot]>
  * race: RACE_PBIO
    name: 'Dark Archon'
    color: RARITY_BLU
  * race: RACE_PMEC
    name: 'Dark Sentry'
    color: RARITY_BLU
    made: <[2Sentry]>
  * race: RACE_PMEC
    name: 'Dark Immortal'
    color: RARITY_BLU
    image-name: \Immortal
    made: <[3Immortal]>
    give: 2 # gives two at once
  * race: RACE_ZERG
    name: 'Roach(Blue)'
    color: RARITY_BLU
    made: <[2Roach]>
  * race: RACE_ZERG
    name: 'Hydralisk(Blue)'
    color: RARITY_BLU

  * race: RACE_TBIO
    name: 'Death Head'
    made: ['Warmonger' 'Hammer Securities']
    color: RARITY_YEL
  * race: RACE_TMEC
    name: \ARES
    made: ['Diamondback' 'Siege Breaker']
    color: RARITY_YEL
  * race: RACE_PBIO
    name: 'Stone Zealot'
    made: ['Dark Zealot' 'Dark Archon']
    color: RARITY_YEL
  * race: RACE_PMEC
    name: \Havoc
    made: ['Dark Sentry' 'Dark Immortal']
    color: RARITY_YEL
  * race: RACE_ZERG
    name: \Ravasaur
    made: ['Roach(Blue)' 'Hydralisk(Blue)']
    color: RARITY_YEL

for {made}:unit in ALL-UNITS when made
  o = {}
  for made
    m = .. is /^(\d+)?(.+)$/
    o[m.2] = +m.1 or 1
  unit.made = o