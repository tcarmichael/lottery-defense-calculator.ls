Sugar.extend true

set-prop = (el, k, v) !-> switch
| k in <[content text]>
  el.inner-HTML = v
| k is \class
  el.class-list.add v
| k is \classes
  for v
    el.class-list.add ..
| _
  el[k] = v

el = (tag, props) ->
  $el = document.create-element tag
  if props
    for key, val of props
      set-prop $el, key, val
  $el

normalize-name = ->
  it.replace ' ' '-' .to-lower-case!

prepend-child = (container, el) ->
  if container.firstChild
    container.insertBefore el, that
  else
    container.append-child el

append-all = (el, els) ->
  for els
    el.append-child .. if ..
  el

export {el, normalize-name, prepend-child, append-all}
