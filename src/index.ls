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

function build-unit-inputs($el, {name, made}:unit, state)
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
      with el 'span'
        ..inner-HTML = '&#1421;'
        ..onclick = ->
          merge unit
          render state

  for $els
    $el.append-child .. if ..

function build-unit-table(state)
  is-active = -> not state.search or it.to-lower-case!includes state.search.to-lower-case!

  container = el 'table'
  for color, units of ALL-UNITS.group-by \color
    line = el 'tr'
    for let {name}:unit in units
      cnt = if bank[name] > 0 then bank[name] else ""

      line.append-child <| el 'td'
        ..inner-HTML = "#name #cnt"
        ..style.background-color = RARITIES[color] if is-active name
        build-unit-inputs .., unit, state
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

function build-info({info-mode: name}:state)
  return unless name
  $el = el 'div'
  unit = find-unit name
  return unless unit
  $els =
    with el 'h1'
      ..inner-HTML = name
    with el 'img'
      image-name = unit.image-name || name
      ..src = "../images/#{normalize-name image-name}.png"
    if unit.made
      with el 'div'
        $title = el 'span' text: 'Made from:'
        ..append-child $title

        $list = el 'ul'
        for made-name, cnt of unit.made
          unit-made = find-unit made-name
          made-desc =
            * made-name
            * cnt > 1 and "(x#cnt)"
            * " (got #that)" if bank[made-name]
          $made-el = el 'li' text: made-desc * ' '
          build-unit-inputs $made-el, unit-made, state 
          $list.append-child $made-el
        ..append-child $list

  for $els
    $el.append-child .. if ..
  $el

function render(state)
  $search-field = build-search-field state
  $container = build-unit-table state
  $info-container = build-info state

  # clear and redraw
  $el.inner-HTML = ""
  $el.append-child $container
  $el.append-child that if $info-container
  $search-field.focus!