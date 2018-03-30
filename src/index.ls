#TODO expand "2Vulture Tank" into {Tank: 1, Vulture: 2}

$el = document.getElementById 'content'

bank = {}
add-unit = (name, cnt = 1) !->
  bank[name] ?= 0
  bank[name] += cnt

unit-count = ->
  bank[it] ? 0

has-units = ->
  for name, count of it
    if (unit-count name) < count
      return false
  return true

merge = !->
  {made, give, name} = it
  return unless has-units made
  for made-name, count of made
    bank[made-name] -= count
  add-unit name, give ? 1

find-unit = ->
  ALL-UNITS.find name: it

function build-merge-button(state, unit)
  with el 'span'
    ..inner-HTML = '&#1421;'
    ..onclick = ->
      merge unit
      render state

function build-unit-inputs(state, {name, made}:unit)
  $els =
    with el 'span'
      ..inner-HTML = '&#8505;' # info
      ..onclick = ->
        render {...state, info-mode: name}
    with el 'span'
      ..inner-HTML = '+' # plus
      ..onclick = ->
        add-unit name
        render state
    if made and has-units made
      build-merge-button(state, unit)
  append-all el(\div), $els

function build-unit-table(state)
  is-active = -> not state.search or it.to-lower-case!includes state.search.to-lower-case!

  container = el 'table'
  for color, units of ALL-UNITS.group-by \color
    line = el 'tr'
    for let {name}:unit in units
      cnt = if bank[name] > 0 then bank[name] else ""

      icon = unit-icon(unit)
      icon.onclick = !->
        add-unit name
        render state

      line.append-child <| el 'td'
        ..style.background-color = RARITIES[color] if is-active name
        ..append-child icon
        ..append-child el(\span text: cnt)
        ..append-child build-unit-inputs state, unit
    container.append-child line
  container

$search-input = document.getElementById 'search-input'
function build-search-field(state)
  $search-input
    ..placeholder = "Search"
    ..value = that if state.search
    ..onkeyup = ->
      return if it.alt-key or it.ctrl-key or it.key is "Control"
      render {...state, search: ..value}
      false

function unit-icon(unit, given-opts = {})
  opts = {size: \big} <<< given-opts

  with el 'img'
    image-name = unit.image-name || name
    ..src = "../images/#{normalize-name image-name}.png"
    ..alt = unit.name
    ..class-list.add "unit-icon-#{opts.size}"

function build-info({info-mode: name}:state)
  return unless name
  $el = el 'div'
  unit = find-unit name
  return unless unit

  $header = el \div
    ..append-child unit-icon unit # build icon
    ..append-child <| el 'h1' do # build name
      text: name
      class: 'inline-title'

  $els =
    $header

    if has-units unit.made
      build-merge-button(state, unit)

    if unit.made # build unit recipe
      with el 'div'
        $title = el 'span' text: 'Made from:'
        ..append-child $title

        $list = el 'ul'
        for made-name, cnt of unit.made
          unit-made = find-unit made-name

          made-desc = # the description for each recipe
            * made-name
            * cnt > 1 and "(x#cnt)"
            * " (got #that)" if bank[made-name]

          $made-el = el 'li' text: made-desc * ' '
          prepend-child $made-el, unit-icon(unit, size: \small) # prepend icon
          $made-el.append-child build-unit-inputs(state, unit-made)

          $list.append-child $made-el

        ..append-child $list

  append-all $el, $els

function render(state)
  $search-field = build-search-field state
  $container = build-unit-table state
  $info-container = build-info state

  # clear and redraw
  $el.inner-HTML = ""
  $el.append-child $container
  $el.append-child that if $info-container
  $search-field.focus!
